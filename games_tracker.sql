--Create table "Platforms" 
CREATE TABLE Platforms (
PlatformID		INT				Primary Key,
PlatformName	NVARCHAR(50)	NOT NULL); 

--Create table "Games"
CREATE TABLE Games(
GameID			INT				Primary Key,
Title			NVARCHAR(200)	NOT NULL,
Developer		NVARCHAR(100)	NOT NULL,
ReleaseYear		INT				NOT NULL,
Genre			NVARCHAR(50));

--Create table "OwnedGames"
CREATE TABLE OwnedGames(
OwnedID			INT				Primary Key,
GameID			INT				NOT NULL FOREIGN KEY REFERENCES Games(GameID),
PlatformID		INT				NOT NULL FOREIGN KEY REFERENCES Platforms(PlatformID),
GameFormat		VARCHAR(10)		NOT NULL CHECK (GameFormat IN ('Physical', 'Digital')),
GameStatus		VARCHAR(10)		NOT NULL CHECK (GameStatus IN ('Unplayed', 'Playing', 'Completed', 'Dropped')),
Rating			Decimal(2,1)	Check ((Rating BETWEEN 0.5 AND 5) AND (Rating * 2 = FLOOR(Rating * 2))));

/*
===== ORIGINAL DESIGN (removed 2026-10-13) =====
Developers had its own table, and Games linked to it
with a foreign key.

CREATE TABLE Developers(
DeveloperID     INT             Primary Key,
DeveloperName   NVARCHAR(100)   NOT NULL,
Country         CHAR(3));       -- ISO 3-letter code, e.g. USA, JPN

CREATE TABLE Games(
GameID          INT             Primary Key,
Title           NVARCHAR(200)   NOT NULL,
DeveloperID     INT             NOT NULL FOREIGN KEY REFERENCES Developers(DeveloperID),
ReleaseYear     INT             NOT NULL,
Genre           NVARCHAR(50));
*/

--Data insert into Platform table
INSERT INTO Platforms (PlatformID, PlatformName) VALUES
(1, 'PC'),
(2, 'PS5'),
(3, 'PS4'),
(4, 'PS3'),
(5, 'PS2'),
(6, 'PS1'),
(7, 'Xbox Series'),
(8, 'Xbox 360'),
(9, 'Xbox'),
(10, 'Switch'),
(11, 'GameCube'),
(12, 'N64'),
(13, 'SNES'),
(14, 'NES');

--Data insert into Games table
INSERT INTO Games (GameID, Title, Developer, ReleaseYear, Genre) VALUES
(1,	'Skyrim',	'Bethesda',	2011,	'RPG'),
(2,	'Elden Ring',	'FromSoftware',	2022,	'Action RPG'),
(3,	'Red Dead Redemption 2',	'Rockstar Games',	2018,	'Action-Adventure'),
(4,	'Final Fantasy VII',	'Square Enix',	1997,	'RPG'),
(5,	'Resident Evil 4',	'Capcom',	2005,	'Survival Horror'),
(6,	'Portal 2',	'Valve',	2011,	'Puzzle'),
(7,	'The Witcher 3: Wild Hunt',	'CD Projekt Red',	2015,	'RPG'),
(8,	'Final Fantasy VII Remake',	'Square Enix',	2020,	'Action RPG'),
(9,	'The Last of Us',	'Naughty Dog',	2013,	'Action-Adventure'),
(10,'Minecraft',	'Mojang Studios',	2011,	'Sandbox'),
(11,'Super Mario 64',	'Nintendo',	1996,	'Platformer'),
(12,'Resident Evil 4',	'Capcom',	2023,	'Survival Horror'),
(13,'The Last of Us Part II',	'Naughty Dog',	2020,	'Action-Adventure'),
(14,'Hades',	'Supergiant Games',	2020,	'Roguelike'),
(15,'Baldur''s Gate 3',	'Larian Studios',	2023,	'RPG'),
(16, 'Dark Souls', 'FromSoftware', 2011, 'Action RPG'),
(17, 'God of War', 'Santa Monica Studio', 2005, 'Action-Adventure'),
(18, 'God of War', 'Santa Monica Studio', 2018, 'Action-Adventure'),
(19, 'Marvel''s Spider-Man', 'Insomniac Games', 2018, 'Action-Adventure'),
(20, 'Marvel''s Spider-Man 2', 'Insomniac Games', 2023, 'Action-Adventure'),
(21, 'Hollow Knight', 'Team Cherry', 2017, 'Metroidvania'),
(22, 'Stardew Valley', 'ConcernedApe', 2016, 'Simulation'),
(23, 'Cyberpunk 2077', 'CD Projekt Red', 2020, 'Action RPG'),
(24, 'Mass Effect', 'BioWare', 2007, 'RPG'),
(25, 'Mass Effect 2', 'BioWare', 2010, 'RPG'),
(26, 'Halo: Combat Evolved', 'Bungie', 2001, 'Shooter'),
(27, 'Ghost of Tsushima', 'Sucker Punch Productions', 2020, 'Action-Adventure'),
(28, 'Super Mario Sunshine', 'Nintendo', 2002, 'Platformer'),
(29, 'The Legend of Zelda: Breath of the Wild', 'Nintendo', 2017, 'Action-Adventure'),
(30, 'The Legend of Zelda: Tears of the Kingdom', 'Nintendo', 2023, 'Action-Adventure'),
(31, 'Super Mario Odyssey', 'Nintendo', 2017, 'Platformer'),
(32, 'Super Mario Galaxy', 'Nintendo', 2007, 'Platformer'),
(33, 'Super Mario Bros.', 'Nintendo', 1985, 'Platformer'),
(34, 'Super Mario World', 'Nintendo', 1990, 'Platformer'),
(35, 'Super Mario Kart', 'Nintendo', 1992, 'Racing'),
(36, 'Mario Kart 8 Deluxe', 'Nintendo', 2017, 'Racing'),
(37, 'Mario Kart Wii', 'Nintendo', 2008, 'Racing');

--Data insert into OwnedGames table
INSERT INTO OwnedGames(OwnedID, GameID, PlatformID, GameFormat, GameStatus, Rating) VALUES
(1,  1,  8,  'Physical', 'Completed', 5.0),
(2,  1,  3,  'Physical', 'Completed', 5.0),
(3,  1,  1,  'Digital',  'Completed', 5.0),
(4,  2,  2,  'Physical', 'Dropped',   NULL),
(5,  3,  7,  'Physical', 'Completed', 5.0),
(6,  3,  3,  'Physical', 'Completed', 5.0),
(7,  4,  6,  'Physical', 'Completed', 5.0),
(8,  5,  11, 'Physical', 'Completed', 4.5),
(9, 5,  5,  'Physical', 'Dropped',   3.0),
(10, 6,  1,  'Digital',  'Completed', 4.5),
(11, 7,  1,  'Digital',  'Playing',   NULL),
(12, 7,  10, 'Digital',  'Dropped',   2.5),
(13, 8,  2,  'Digital',  'Completed', 4.0),
(14, 9,  4,  'Physical', 'Completed', 5.0),
(15, 10, 1,  'Digital',  'Completed', 4.0),
(16, 10, 10, 'Digital',  'Playing',   NULL),
(17, 11, 12, 'Physical', 'Completed', 4.5),
(18, 12, 2,  'Digital',  'Completed', 4.5),
(19, 13, 3,  'Physical', 'Dropped',   2.0),
(20, 14, 10, 'Digital',  'Completed', 5.0),
(21, 14, 1,  'Digital',  'Unplayed',  NULL),
(22, 16, 4,  'Physical', 'Completed', 4.5),
(23, 17, 5,  'Physical', 'Dropped',   2.0),
(24, 18, 3,  'Physical', 'Completed', 5.0),
(25, 19, 3,  'Physical', 'Completed', 4.5),
(26, 19, 2,  'Digital',  'Completed', 4.5),
(27, 20, 2,  'Digital',  'Playing',   NULL),
(28, 21, 10, 'Digital',  'Completed', 5.0),
(29, 21, 1,  'Digital',  'Unplayed',  NULL),
(30, 22, 1,  'Digital',  'Dropped',   1.5),
(31, 22, 10, 'Digital',  'Completed', 4.5),
(32, 23, 1,  'Digital',  'Dropped',   1.0),
(33, 24, 8,  'Physical', 'Dropped',   3.0),
(34, 25, 8,  'Physical', 'Completed', 5.0),
(35, 26, 9,  'Physical', 'Completed', 2.0),
(36, 28, 10, 'Physical', 'Completed', 0.5),
(37, 27, 3, 'Physical', 'Completed', 3.5);

--Create new view of joined tables; Joining table o to table g and then joining table o to table p
ALTER VIEW vw_GameLibrary AS
SELECT o.GameID, g.Title, p.PlatformName, o.GameFormat, o.GameStatus, o.Rating, g.ReleaseYear, g.Genre, g.Developer FROM OwnedGames o
Join Games g ON o.GameID = g.GameID
Join Platforms p ON o.PlatformID = p.PlatformID
