-- Updates a game's status and rating by looking it up by title and platform
CREATE OR ALTER PROCEDURE UpdateGameProgress
    @Title     NVARCHAR(200),             -- game title to look up
    @Platform  NVARCHAR(50),              -- platform the copy is on
    @NewStatus VARCHAR(10),               -- new status to set
    @NewRating DECIMAL(2,1) = NULL        -- optional new rating; NULL keeps the current one
AS
BEGIN
    -- Variables to hold the match count and the ID of the copy to update
    DECLARE @Matches INT, @OwnedID INT;

    -- Count how many owned copies match the title and platform
    SELECT @Matches = COUNT(*)
    FROM OwnedGames o
    JOIN Games g     ON o.GameID = g.GameID
    JOIN Platforms p ON o.PlatformID = p.PlatformID
    WHERE g.Title = @Title AND p.PlatformName = @Platform;

    -- Stop with a message if no copy matches
    IF @Matches = 0
    BEGIN
        PRINT 'No copy of that game found on that platform. Check the spelling.';
        RETURN;
    END

    -- Stop with a message if more than one copy matches
    IF @Matches > 1
    BEGIN
        PRINT 'More than one copy matches. Update it by OwnedID instead.';
        RETURN;
    END

    -- Save the OwnedID of the one matching copy
    SELECT @OwnedID = o.OwnedID
    FROM OwnedGames o
    JOIN Games g     ON o.GameID = g.GameID
    JOIN Platforms p ON o.PlatformID = p.PlatformID
    WHERE g.Title = @Title AND p.PlatformName = @Platform;

    -- Update that one row by its primary key; keep the old rating if no new one was given
    UPDATE OwnedGames
    SET GameStatus = @NewStatus,
        Rating     = ISNULL(@NewRating, Rating)
    WHERE OwnedID = @OwnedID;

    -- Show the updated row to confirm the change
    SELECT Title, PlatformName, GameStatus, Rating
    FROM vw_GameLibrary
    WHERE Title = @Title AND PlatformName = @Platform;
END;
GO

-- Example: mark Witcher 3 on PC as Completed with a 4.5 rating
EXEC UpdateGameProgress @Title = 'The Witcher 3: Wild Hunt', @Platform = 'PC', @NewStatus = 'Completed', @NewRating = 4.5;
