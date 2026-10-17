/*Filters*/
-- Average rating and number of copies per platform
SELECT AVG(Rating) Rating, PlatformName, Count(GameID) Games FROM vw_GameLibrary
GROUP BY PlatformName
 
-- Games released before 2010
SELECT * FROM vw_GameLibrary
WHERE (ReleaseYear < 2010)
 
-- Games with 'Mario' anywhere in the title
SELECT * FROM vw_GameLibrary
WHERE (Title LIKE '%Mario%')
 
-- Games I'm playing or haven't started, sorted by status
SELECT * FROM vw_GameLibrary
WHERE GameStatus IN ('Playing', 'Unplayed')
ORDER BY GameStatus ASC
 
-- Everything I own on PS5
SELECT * FROM vw_GameLibrary
WHERE PLatformName = 'PS5'
 
-- Games I dropped
SELECT * FROM vw_GameLibrary
WHERE GameStatus = 'Dropped'
 
-- Games I haven't rated yet
SELECT * FROM vw_GameLibrary
WHERE Rating IS NULL
 
-- Games rated below 3, lowest first
SELECT * FROM vw_GameLibrary
WHERE (Rating < 3)
ORDER BY Rating ASC
 
-- Games rated a perfect 5
SELECT * FROM vw_GameLibrary
Where Rating = 5
 
/*Count/Group*/
-- Number of copies per platform, most first
SELECT PlatformName, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY PlatformName
ORDER BY COUNT(GameID) DESC
 
-- Number of copies per status, most first
SELECT GameStatus, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY GameStatus
ORDER BY COUNT(GameID) DESC
 
-- Number of physical vs digital copies
SELECT GameFormat, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY GameFormat
 
-- Number of copies per genre, most first
SELECT Genre, Count(GameID) GameCount FROM vw_GameLibrary
GROUP BY Genre
ORDER BY Count(GameID) DESC
 
-- Number of different developers in each genre
SELECT COUNT(Distinct Developer) DeveloperCount, Genre FROM vw_GameLibrary
GROUP BY Genre
 
/*Math*/
-- Overall average rating, rounded to 2 decimal places
SELECT CAST(AVG(Rating) AS DECIMAL(3,2)) AverageRating FROM vw_GameLibrary
 
-- All rated games, lowest rating first
SELECT Rating, Title FROM vw_GameLibrary
WHERE Rating IS NOT NULL
ORDER BY Rating ASC
 
-- Highest rating on each platform
SELECT MAX(Rating) MaxRating, PlatformName FROM vw_GameLibrary
WHERE Rating IS NOT NULL
GROUP BY PlatformName
 
/*Having*/
-- Games I own more than one copy of
SELECT GameID, Title, ReleaseYear, COUNT(GameID) Copies FROM vw_GameLibrary
GROUP BY GameID, Title, ReleaseYear
HAVING COUNT(GameID) > 1
 
-- Games I own more than one copy of, with their developer
SELECT GameID, Developer, COUNT(Developer) Games FROM vw_GameLibrary
GROUP BY GameID, Developer
HAVING COUNT(Developer) > 1
 
-- Titles that appear more than once in the Games table
SELECT Title, COUNT(Title) TitleCount From Games
GROUP BY Title
HAVING Count(Title) > 1
 
/*Joins*/
-- Wishlist: games I don't own a copy of
SELECT Games.GameID, Games.Title FROM Games
LEFT JOIN OwnedGames ON Games.GameID = OwnedGames.GameID
WHERE OwnedGames.GameID IS NULL
 
-- Platforms I don't own any games on
SELECT p.PlatformName, o.OwnedID, o.GameStatus FROM Platforms p
LEFT JOIN OwnedGames o ON p.PlatformID = o.PlatformID
WHERE o.OwnedID IS NULL
 
