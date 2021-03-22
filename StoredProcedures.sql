use Library;

-- a. modify the type of a column;
GO
CREATE OR
ALTER PROCEDURE do1 -- stpChangeAchievNameType
AS
BEGIN
    ALTER TABLE Fees
        ALTER COLUMN Type INT
END
GO

GO
CREATE OR
ALTER PROCEDURE undo1 -- stpRevertChangeAchievNameType
AS
BEGIN
    ALTER TABLE Fees
        ALTER COLUMN Type VARCHAR(50)
END
GO

-- b. add / remove a column;
GO
CREATE OR
ALTER PROCEDURE do2 -- stpAddColumn
AS
BEGIN
    ALTER TABLE Publishers
        ADD Year INT;
END
GO

GO
CREATE OR
ALTER PROCEDURE undo2 -- stpRevertAddColumn
AS
BEGIN
    ALTER TABLE Publishers
        DROP COLUMN Year;
END
GO


-- c. add / remove a DEFAULT constraint;
GO
CREATE OR
ALTER PROCEDURE do3 -- stpAddDefaultConstraint
AS
BEGIN
    ALTER TABLE Libraries
        ADD
            TestDefConstraint INT,
            CONSTRAINT DF_Libraries_TestDefConstraint DEFAULT 1 FOR TestDefConstraint;
END
GO

GO
CREATE OR
ALTER PROCEDURE undo3 -- stpRemoveDefaultConstraint
AS
BEGIN
    ALTER TABLE Libraries
        DROP
            CONSTRAINT DF_Libraries_TestDefConstraint,
            COLUMN TestDefConstraint;
END
GO

-- d. add / remove a primary key;
GO
CREATE OR
ALTER PROCEDURE do4 -- stpAddPrimaryKey
AS
BEGIN
    create table TestAddPK
    (
        Dots int not null
    );
    alter table TestAddPK
        add constraint PK_Dots primary key clustered (Dots);
END
GO

GO
CREATE OR
ALTER PROCEDURE undo4 -- stpRemovePrimaryKey
AS
BEGIN
    alter table TestAddPK
        drop constraint PK_Dots
    drop table TestAddPK
END
GO

-- e. add / remove a candidate key;
GO
CREATE OR
ALTER PROCEDURE do5 -- stpAddCandidateKey
AS
BEGIN
    ALTER TABLE Books
        ADD CONSTRAINT UQ_Book_ID_Title UNIQUE (BID, Title);
END
GO

GO
CREATE OR
ALTER PROCEDURE undo5 -- stpRemoveCandidateKey
AS
BEGIN
    ALTER TABLE Books
        DROP CONSTRAINT UQ_Book_ID_Title;
END
GO

-- f. add / remove a foreign key;
GO
CREATE OR
ALTER PROCEDURE do6 -- stpAddForeginKey
AS
BEGIN
    ALTER TABLE Employees
        ADD TestFKCol INT;

    ALTER TABLE Employees
        ADD CONSTRAINT Employee_TestFKCol_FK FOREIGN KEY (TestFKCol)
            REFERENCES Libraries (PID);
END
GO

GO
CREATE OR
ALTER PROCEDURE undo6 -- stpRemoveForeignKey
AS
BEGIN
    ALTER TABLE Employees
        DROP CONSTRAINT Employee_TestFKCol_FK;

    ALTER TABLE Employees
        DROP COLUMN TestFKCol;
END
GO

-- g. create / remove a table.
CREATE OR
ALTER PROCEDURE do7 -- stpCreateTestTable
AS
BEGIN
    CREATE TABLE TestTable
    (
        testID  INT PRIMARY KEY,
        testCol VARCHAR(100)
    );
END
GO

GO
CREATE OR
ALTER PROCEDURE undo7 -- stpRevertCreateTestTable
AS
BEGIN
    DROP TABLE IF EXISTS TestTable;
END
GO

DROP TABLE IF EXISTS DBVersion
CREATE TABLE DBVersion
(
    id              int IDENTITY (1,1) NOT NULL,
    current_version int,
    CONSTRAINT PK_Version_ID PRIMARY KEY CLUSTERED (id)
);

INSERT INTO DBVersion
VALUES (0);

GO
CREATE OR
ALTER PROCEDURE TakeMeToVersion @versionTo INT
AS
BEGIN
    DECLARE @versionFrom INT

    SET @versionFrom = (SELECT V.current_version
                        FROM DBVersion V)

    DECLARE @query VARCHAR(2000)

    IF @versionTo <= 7 AND @versionTo >= 0
        IF @versionTo > @versionFrom
            BEGIN
                WHILE @versionTo > @versionFrom
                    BEGIN
                        SET @versionFrom = @versionFrom + 1
                        SET @query = 'do' + CAST(@versionFrom AS VARCHAR(5))
                        EXEC @query
                    END
            END
        ELSE
            BEGIN
                WHILE @versionTo < @versionFrom
                    BEGIN
                        IF @versionFrom != 0
                            BEGIN
                                SET @query = 'undo' + CAST(@versionFrom AS VARCHAR(5))
                                EXEC @query
                            END
                        SET @versionFrom = @versionFrom - 1
                    END
            END
    ELSE
        BEGIN
            PRINT 'Version has to be <= 7 and >= 0 !'
            RETURN
        END

    UPDATE DBVersion
    SET current_version = @versionTo
END
GO

EXEC TakeMeToVersion 7;
EXEC TakeMeToVersion 0;

SELECT current_version
FROM DBVersion

SELECT *
FROM Publishers
SELECT *
FROM Books
SELECT *
FROM Employees
