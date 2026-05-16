--This Purpose of this project is to practice Data Cleaning and Analysis of Kickstarter dataset From 2009 until 2018
--Date: 09/05/2026

--Select DB
USE [Kickstarter Project Analysis]

--Query all row from DB
SELECT * FROM kickstarter_project;

--For Testing Purpose
SELECT TOP 1 PERCENT * From kickstarter_project;

--Standardize Date Column
ALTER TABLE kickstarter_project 
ADD Launched_Date DATE,
	Deadline_Date DATE;

UPDATE kickstarter_project
SET Launched_Date = CONVERT(DATE,Launched),
	Deadline_Date = CONVERT(DATE,Deadline);

--Check Duplicate
SELECT ID, Count(*) AS duplicate_count
FROM kickstarter_project
GROUP BY ID
Having Count(*) > 1;


--Analysing Trend
--Check Category by Year
SELECT Category, YEAR(Launched_Date) AS Year, COUNT(*) AS num_of_campaign FROM kickstarter_project
GROUP BY Category, YEAR(Launched_Date)
ORDER BY YEAR(Launched_Date), COUNT(*) DESC;

--Check State by Year
SELECT State,YEAR(Launched_Date) AS Year, COUNT(*) AS num_of_campaign FROM kickstarter_project
GROUP BY State, YEAR(Launched_Date)
ORDER BY YEAR(Launched_Date) ASC, COUNT(*) DESC;

--Check State each Category by Year
SELECT Category, State, YEAR(Launched_Date) AS Year, COUNT(*) as num_of_campaign FROM kickstarter_project
GROUP BY Category, State, YEAR(Launched_Date)
ORDER BY Category, YEAR(Launched_Date) ASC, COUNT(*) DESC;

--Check only Successful and Failed State of Category by Year and calculate success rate
SELECT 
	Category, 
	YEAR(Launched_Date) AS Year,
	SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) AS Successful,
	SUM(CASE WHEN State = 'Failed' THEN 1 ELSE 0 END) AS Failed,
	CAST(100 * SUM(CASE WHEN State = 'Successful' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS Success_Rate
FROM kickstarter_project
WHERE State IN ('Successful','Failed')
GROUP BY Category, YEAR(Launched_Date)
ORDER BY Category, YEAR(Launched_Date) ASC

--Check Pledge, Backers & Goal by category and year
SELECT Category, YEAR(Launched_Date) AS Year, SUM(Pledged) AS Pledged, SUM(Backers) AS Backers, SUM(Goal) AS Goal FROM kickstarter_project
GROUP BY Category, YEAR(Launched_Date)
ORDER BY Category, YEAR(Launched_Date) ASC


