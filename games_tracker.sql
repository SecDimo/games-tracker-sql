--Create table "Platforms" with columns PlatformID (unique identification #) and PlatformName (console name <50 characters, cannot be empty)
CREATE TABLE Platforms (
PlatformID		INT				Primary Key,
PlatformName	NVARCHAR(50)	NOT NULL); 


CREATE TABLE Developers(
DeveloperID		INT				Primary Key,
DeveloperName	NVARCHAR(100)	NOT NULL,
Country			CHAR(3));


CREATE TABLE Games(
GameID			INT				Primary Key,
Title			NVARCHAR(200)	NOT NULL,
DeveloperID		INT				NOT NULL FOREIGN KEY REFERENCES Developers(DeveloperID),
ReleaseYear		INT,
Genre			NVARCHAR(50));

CREATE TABLE OwnedGames(
OwnedID			INT				Primary Key,
GameID			INT				NOT NULL FOREIGN KEY REFERENCES Games(GameID),
PlatformID		INT				NOT NULL FOREIGN KEY REFERENCES Platforms(PlatformID),
GameFormat		VARCHAR(10)		NOT NULL CHECK (GameFormat IN ('Physical', 'Digital')),
GameStatus		VARCHAR(10)		NOT NULL CHECK (GameStatus IN ('Unplayed', 'Playing', 'Completed', 'Dropped')),
Rating			Decimal(2,1)	Check ((Rating BETWEEN 0.5 AND 5) AND (Rating * 2 = FLOOR(Rating * 2))));

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
