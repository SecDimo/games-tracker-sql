<h1 align="center"> Game Library Database</h1>
## About
 
I built this project to learn SQL from the ground up. It covers designing tables, loading data, writing queries, and building views and stored procedures. The database runs on **Azure SQL Database**, and I wrote the scripts in **VS Code** (mssql extension) and **SSMS**.
 
## Contents
 
- [Database Design](#-database-design)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [View](#-view)
- [Stored Procedures](#%EF%B8%8F-stored-procedures)
- [Example Queries](#-example-queries)
- [What I Learned](#-what-i-learned)
- [Next Steps](#-next-steps)

## Database Design
 
![ERD](EntityRelationshipDiagram.png)
 
| Table | Description |
|---|---|
| **Games** | One row per game: title, developer, release year, genre |
| **Platforms** | One row per console or PC (PS5, Switch, Xbox 360, …) |
| **OwnedGames** | One row per copy I own. Links a game to a platform with format, status and rating |
 
**Relationships**
- One game → many owned copies (for example, Skyrim on three platforms)
- One platform → many owned copies
**Data rules (CHECK constraints)**
- `GameFormat`: `Physical` or `Digital`
- `GameStatus`: `Unplayed`, `Playing`, `Completed` or `Dropped`
- `Rating`: 0.5–5.0 in half steps, or `NULL` if not rated yet
---
 
## Project Structure
 
```
game-library-sql/
├── games_tracker.sql   # Creates tables, loads data, and creates vw_GameLibrary
├── procedures.sql      # Stored procedures
├── queries.sql         # Practice queries
├── erd.png             # Entity-relationship diagram
└── README.md
```
 
---
 
## Getting Started
 
1. Create a SQL Server or Azure SQL database.
2. Run the scripts in this order:
```
   games_tracker.sql  →  procedures.sql
```
3. Run any query from `queries.sql`.
---
 
## View
 
| View | Description |
|---|---|
| `vw_GameLibrary` | Joins OwnedGames, Games and Platforms into one readable list, so queries don't need to repeat the joins. Created at the bottom of `games_tracker.sql` |
 
---
 
## Stored Procedures
 
| Procedure | Parameters | Description |
|---|---|---|
| `GetGamesByPlatform` | `@Platform` | Lists the games I own on a platform |
| `GetGamesByStatus` | `@Status` | Lists games by status |
| `AddOwnedGame` | `@GameID`, `@PlatformID`, `@GameFormat`, `@GameStatus`, `@Rating`* | Adds a new owned copy and assigns the next OwnedID automatically |
| `UpdateGameProgress` | `@Title`, `@Platform`, `@NewStatus`, `@NewRating`* | Updates status/rating after checking exactly one copy matches |
 
<sub>* optional</sub>
 
```sql
EXEC GetGamesByPlatform @Platform = 'Switch';
 
EXEC UpdateGameProgress
     @Title = 'Hades', @Platform = 'PC',
     @NewStatus = 'Completed', @NewRating = 5.0;
```
 
---
 
## Example Queries
 
<details>
<summary><b>Games per platform</b></summary>
```sql
SELECT PlatformName, COUNT(GameID) GameCount FROM vw_GameLibrary
GROUP BY PlatformName
ORDER BY COUNT(GameID) DESC
```
</details>
<details>
<summary><b>Wishlist: games with no owned copy (LEFT JOIN)</b></summary>
```sql
SELECT Games.GameID, Games.Title FROM Games
LEFT JOIN OwnedGames ON Games.GameID = OwnedGames.GameID
WHERE OwnedGames.GameID IS NULL
```
</details>
<details>
<summary><b>Games I own more than one copy of (HAVING)</b></summary>
```sql
SELECT GameID, Title, ReleaseYear, COUNT(GameID) Copies FROM vw_GameLibrary
GROUP BY GameID, Title, ReleaseYear
HAVING COUNT(GameID) > 1
```
</details>
<details>
<summary><b>Average rating, rounded to 2 decimals</b></summary>
```sql
SELECT CAST(AVG(Rating) AS DECIMAL(3,2)) AverageRating FROM vw_GameLibrary
```
</details>
---
 
## What I Learned
 
- **Designing tables that relate to each other:** splitting data into separate tables and connecting them with primary and foreign keys, instead of keeping everything in one big table.
- **Protecting data quality at the database level:** using `NOT NULL` and `CHECK` constraints so bad values can't get in, no matter who's entering the data.
- **Joins:** combining tables with `INNER JOIN`, and using `LEFT JOIN` to find what's *missing*, like games with no owned copy.
- **Summarizing data:** `GROUP BY` with `COUNT`, `AVG` and `MAX`, and the difference between filtering rows with `WHERE` and filtering groups with `HAVING`.
- **Views vs stored procedures:** a view is a saved query for reading data, while a stored procedure is saved logic that takes inputs and can change data, the way an app would call it.
- **Working in the cloud:** setting up and connecting to an Azure SQL database, including firewall rules and authentication.
---
 
## Next Steps
 
- [ ] Switch IDs to `IDENTITY` so new rows are numbered automatically
- [ ] Connect the database to Power BI for a simple dashboard
