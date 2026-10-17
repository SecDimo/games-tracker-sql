-- Finds the copy by title + platform, so no IDs needed
CREATE OR ALTER PROCEDURE UpdateGameProgress
    @Title     NVARCHAR(200),
    @Platform  NVARCHAR(50),
    @NewStatus VARCHAR(10),
    @NewRating DECIMAL(2,1) = NULL    -- optional; leave out to keep the current rating
AS
BEGIN
    DECLARE @Matches INT, @OwnedID INT;

    -- Step 1: how many copies match?
    SELECT @Matches = COUNT(*)
    FROM OwnedGames o
    JOIN Games g     ON o.GameID = g.GameID
    JOIN Platforms p ON o.PlatformID = p.PlatformID
    WHERE g.Title = @Title AND p.PlatformName = @Platform;

    -- Step 2: stop if there's nothing to update, or it's unclear which one
    IF @Matches = 0
    BEGIN
        PRINT 'No copy of that game found on that platform. Check the spelling.';
        RETURN;
    END

    IF @Matches > 1
    BEGIN
        PRINT 'More than one copy matches. Update it by OwnedID instead.';
        RETURN;
    END

    -- Step 3: grab the ID of the one matching copy
    SELECT @OwnedID = o.OwnedID
    FROM OwnedGames o
    JOIN Games g     ON o.GameID = g.GameID
    JOIN Platforms p ON o.PlatformID = p.PlatformID
    WHERE g.Title = @Title AND p.PlatformName = @Platform;

    -- Step 4: update it
    UPDATE OwnedGames
    SET GameStatus = @NewStatus,
        Rating     = ISNULL(@NewRating, Rating)   -- keep old rating if none given
    WHERE OwnedID = @OwnedID;

    -- Step 5: show the result so you can confirm it worked
    SELECT Title, PlatformName, GameStatus, Rating
    FROM vw_GameLibrary
    WHERE Title = @Title AND PlatformName = @Platform;
END;
GO

EXEC UpdateGameProgress @Title = 'The Witcher 3: Wild Hunt', @Platform = 'PC', @NewStatus = 'Completed', @NewRating = 4.5;
