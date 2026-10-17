# Game Library Database

A SQL Server database I built to track the video games I own: which platform each copy is on, whether it's physical or digital, how far I've gotten, and how I'd rate it.

I built this to learn SQL from the ground up: designing tables, loading data, writing queries, and creating views and stored procedures. It runs on Azure SQL Database, and I wrote the scripts in VS Code (mssql extension) and SSMS.

Show Image

Tables
Table	What it holds
Games	One row per game: title, developer, release year, genre
Platforms	One row per console/PC (PS5, Switch, Xbox 360, etc.)
OwnedGames	One row per copy I own. Links a game to a platform with format, status and rating

Relationships: one game can have many owned copies (for example, Skyrim on three platforms), and one platform can have many games. OwnedGames connects the two with foreign keys.

Rules built into the table (CHECK constraints):

GameFormat must be Physical or Digital
GameStatus must be Unplayed, Playing, Completed or Dropped
Rating must be 0.5–5.0 in half steps, or NULL if not rated yet
Files
File	What it does
games_tracker.sql	Creates the tables and loads the data
views.sql	Creates the view
queries.sql	Practice queries: filtering, grouping, aggregates, HAVING, LEFT JOINs
procedures.sql	Stored procedures
erd.png	Entity-relationship diagram

To run it: games_tracker.sql → views.sql → procedures.sql, then any query in queries.sql.

View
View	What it does
vw_GameLibrary	Joins OwnedGames, Games and Platforms into one readable list, so queries don't need to repeat the joins
Stored Procedures
Procedure	Inputs	What it does
GetGamesByPlatform	@Platform	Lists the games I own on that platform
GetGamesByStatus	@Status	Lists games by status
AddOwnedGame	@GameID, @PlatformID, @GameFormat, @GameStatus, @Rating (optional)	Adds a new owned copy and picks the next OwnedID automatically
UpdateGameProgress	@Title, @Platform, @NewStatus, @NewRating (optional)	Updates a game's status/rating. Checks that exactly one copy matches before changing anything
sql
EXEC GetGamesByPlatform @Platform = 'Switch';
EXEC UpdateGameProgress @Title = 'Hades', @Platform = 'PC', @NewStatus = 'Completed', @NewRating = 5.0;
Example Queries
sql
-- Games per platform
SELECT PlatformName, COUNT(*) AS GameCount
FROM vw_GameLibrary
GROUP BY PlatformName
ORDER BY GameCount DESC;

-- Wishlist: games in the Games table with no owned copy
SELECT g.Title
FROM Games g
LEFT JOIN OwnedGames o ON g.GameID = o.GameID
WHERE o.OwnedID IS NULL;
What I Learned
Design changes: I started with a separate Developers table, then simplified it into a column on Games. The original design is kept as a comment in games_tracker.sql.
Small typos, big effects: a typo in my view (0.Rating instead of o.Rating) made every rating show as 0. I fixed it with CREATE OR ALTER VIEW.
Grouping by the right column: grouping by Title merged God of War (2005) and God of War (2018) into one row. Grouping by GameID fixed it.
The query can be right while the data is wrong: my wishlist query showed a game I own, because I'd never added an OwnedGames row for it. The fix was the data, not the SQL.
INNER vs LEFT JOIN: the view uses inner joins, so it hides games I don't own. Finding those needed a LEFT JOIN on the base tables.
Next Steps
Switch IDs to IDENTITY so the database numbers new rows automatically
Connect the database to Power BI for a simple dashboard
