-- VIEW OF DATA
SELECT *
FROM project.fortune;

-- DATA CLEANING
-- RENAMING THE NAME AND MARKET VALUE COLUMN--
ALTER TABLE project.fortune
RENAME COLUMN `Name` TO Company_Name,
RENAME COLUMN `Market Value` TO Market_Value;
SELECT *
FROM project.fortune;

-- CHECKING FOR NULL VALUES
SELECT *
FROM project.fortune
WHERE Company_Name is NULL
OR  Country is NULL
OR Sales is NULL
OR Profit is NULL
OR Assets is NULL
OR Market_Value is NULL;

-- CHECKING FOR EMPTY VALUES
SELECT *
FROM project.fortune
WHERE Company_Name = ''
OR  Country  = ''
OR Sales  = ''
OR Profit  = ''
OR Assets  = ''
OR Market_Value  = '';

-- DELETING ROWS OF THE DETECTED MISSING VALUES
DELETE FROM project.fortune
WHERE Assets = '';
-- RE-CHECKING FOR EMPTY VALUES
SELECT *
FROM project.fortune
WHERE Company_Name = ''
OR  Country  = ''
OR Sales  = ''
OR Profit  = ''
OR Assets  = ''
OR Market_Value  = ' ';

-- REMOVING LEADING CURRENCY, Amount Abbreviation(B), AND DELIMITER
-- CONVERTING Amount Abbreviation(M) to (B) By diving by 1000
UPDATE project.fortune
SET Sales = 
	CASE
		WHEN Sales LIKE '%M' THEN REPLACE(REPLACE(REPLACE (Sales, '$',''),',',''),'M','')/1000
		WHEN Sales LIKE '%B' THEN REPLACE(REPLACE(REPLACE (Sales, '$',''),',',''),'B','')
        ELSE Sales
	END,
    Profit = 
	CASE
		WHEN Profit LIKE '%M' THEN REPLACE(REPLACE(REPLACE (Profit, '$',''),',',''),'M','')/1000
        WHEN Profit LIKE '%B' THEN REPLACE(REPLACE(REPLACE (Profit, '$',''),',',''),'B','')
        ELSE Profit
	END,
    Assets = 
    CASE
		WHEN Assets LIKE '%M' THEN REPLACE(REPLACE(REPLACE (Assets, '$',''),',',''),'M','')/1000
		WHEN Assets LIKE '%B' THEN REPLACE(REPLACE(REPLACE (Assets, '$',''),',',''),'B','')
        ELSE Assets
	END,
    Market_Value = 
    CASE
		WHEN Market_Value LIKE '%M' THEN REPLACE(REPLACE(REPLACE (Market_Value, '$',''),',',''),'M','')/1000
		WHEN Market_Value LIKE '%B' THEN REPLACE(REPLACE(REPLACE (Market_Value, '$',''),',',''),'B','')
        ELSE Market_Value
	END;
    SELECT *
    FROM project.fortune;

    -- CONVERTING THE DATATYPES OF THE NEEDED NUMERICAL COLUMNS TO FLOAT --
ALTER TABLE project.fortune
MODIFY COLUMN Sales FLOAT,
MODIFY COLUMN Profit FLOAT,
MODIFY COLUMN Assets FLOAT,
MODIFY COLUMN Market_Value FLOAT;

SELECT *
    FROM project.fortune;