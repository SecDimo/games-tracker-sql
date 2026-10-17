/*Filters*/
--Filtering for average rating and number of games per platform
SELECT AVG(Rating) Rating, PlatformName, Count(GameID) Games FROM vw_GameLibrary
GROUP BY PlatformName

--Filtering for games released before
SELECT * FROM vw_GameLibrary
WHERE (ReleaseYear < 2010)

--Filtering for games where 'Mario' is in the title
SELECT * FROM vw_GameLibrary
WHERE (Title LIKE '%Mario%')

--Filtering for games 
SELECT * FROM vw_GameLibrary
WHERE GameStatus IN ('Playing', 'Unplayed')
ORDER BY GameStatus ASC

SELECT * FROM vw_GameLibrary
WHERE PLatformName = 'PS5'

SELECT * FROM vw_GameLibrary
WHERE GameStatus = 'Dropped'

SELECT * FROM vw_GameLibrary
WHERE Rating IS NULL

SELECT * FROM vw_GameLibrary
WHERE (Rating < 3) 
ORDER BY Rating ASC

SELECT * FROM vw_GameLibrary
Where Rating = 5

/*Count/Group*/
SELECT PlatformName, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY PlatformName
ORDER BY COUNT(GameID) DESC

SELECT GameStatus, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY GameStatus
ORDER BY COUNT(GameID) DESC

SELECT GameFormat, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY GameFormat

SELECT Genre, Count(GameID) GameCount FROM vw_GameLibrary
GROUP BY Genre
ORDER BY Count(GameID) DESC

SELECT COUNT(Distinct Developer) DeveloperCount, Genre FROM vw_GameLibrary
GROUP BY Genre

/*Math*/
SELECT CAST(AVG(Rating) AS DECIMAL(3,2)) AverageRating FROM vw_GameLibrary

SELECT Rating, Title FROM vw_GameLibrary
WHERE Rating IS NOT NULL
ORDER BY Rating ASC

SELECT MAX(Rating) MaxRating, PlatformName FROM vw_GameLibrary
WHERE Rating IS NOT NULL
GROUP BY PlatformName

/*Having*/
SELECT GameID, Title, ReleaseYear, COUNT(GameID) Copies FROM vw_GameLibrary
GROUP BY GameID, Title, ReleaseYear
HAVING COUNT(GameID) > 1

SELECT GameID, Developer, COUNT(Developer) Games FROM vw_GameLibrary
GROUP BY GameID, Developer
HAVING COUNT(Developer) > 1

SELECT Title, COUNT(Title) TitleCount From Games
GROUP BY Title
HAVING Count(Title) > 1

/*Joins*/
SELECT Games.GameID, Games.Title FROM Games
LEFT JOIN OwnedGames ON Games.GameID = OwnedGames.GameID
WHERE OwnedGames.GameID IS NULL

SELECT p.PlatformName, o.OwnedID, o.GameStatus FROM Platforms p
LEFT JOIN OwnedGames o ON p.PlatformID = o.PlatformID
WHERE o.OwnedID IS NULL
