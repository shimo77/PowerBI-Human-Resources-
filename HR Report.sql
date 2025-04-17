/*									Data PreProcessing												*/


--Employee Table Cleaning:

--Get Unique Values FROM Employee TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT DISTINCT(EmployeeID)
FROM Employee 
GROUP BY EmployeeID

--Get Duplicates From Employee Table 
 SELECT EmployeeID
        FROM Employee 
        GROUP BY EmployeeID 
        HAVING COUNT(*)  > 1 


--Remove Duplicates FROM Employee TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
DELETE FROM Employee 
WHERE EmployeeID IN (
        SELECT EmployeeID
        FROM Employee 
        GROUP BY EmployeeID 
        HAVING COUNT(*)  > 1 ) 


--Get NULL Values FROM Employee TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT * FROM Employee
WHERE FirstName IS NULL 
   OR LastName IS NULL 
   OR GENDer IS NULL
   OR Age IS NULL
   OR BusINessTravel IS NULL
   OR Department IS NULL
   OR DIStanceFROMHome_KM IS NULL
   OR State IS NULL
   OR Ethnicity IS NULL
   OR EducatiON IS NULL
   OR EducatiONField IS NULL
   OR JobRole IS NULL
   OR MaritalStatus IS NULL
   OR Salary IS NULL
   OR StockOptiONLevel IS NULL
   OR OverTime IS NULL
   OR HireDate IS NULL
   OR AttritiON IS NULL
   OR YearsAtCompany IS NULL
   OR YearsINMostRecentRole IS NULL
   OR YearsSINceLastPromotiON IS NULL
   OR YearsWithCurrManager IS NULL



--Handling Null Values in Numerical Fields>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--Replace NULL Salary With Average value
UPDATE Employee
SET Salary= (
    SELECT AVG(Salary)
    FROM Employee
    WHERE Salary IS NOT NULL
)
WHERE Salary IS NULL


/*Replace NULL Ages With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET Age = (
			SELECT AVG(Age) FROM Employee
			WHERE Age IS NOT NULL)
WHERE Age IS NULL

/*Replace NULL DistanceFromHome_KM With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET DistanceFromHome_KM = (
			SELECT AVG(DistanceFromHome_KM) FROM Employee
			WHERE DistanceFromHome_KM IS NOT NULL)
WHERE DistanceFromHome_KM IS NULL


/*Replace NULL Education With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET Education = (
			SELECT AVG(Education) FROM Employee
			WHERE Education IS NOT NULL)
WHERE Education IS NULL

 /*Replace NULL Attrition With Average >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
-- Convert BIT to FLOAT to calculate the average
DECLARE @Attrition FLOAT;
SET @Attrition = (SELECT AVG(CAST(Attrition AS FLOAT)) FROM Employee WHERE Attrition IS NOT NULL);

-- Update NULL values with the calculated average (rounded to nearest 0 or 1)
UPDATE Employee
SET Attrition = ROUND(@Attrition, 0)  -- Round to 0 or 1 to keep BIT behavior
WHERE Attrition IS NULL;


/*Replace NULL StockOptionLevel With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET StockOptionLevel = (
			SELECT AVG(StockOptionLevel) FROM Employee
			WHERE StockOptionLevel IS NOT NULL)
WHERE StockOptionLevel IS NULL

/*Replace NULL YearsAtCompany With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET YearsAtCompany = (
			SELECT AVG(YearsAtCompany) FROM Employee
			WHERE YearsAtCompany IS NOT NULL)
WHERE YearsAtCompany IS NULL

/*Replace NULL YearsInMostRecentRole With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET YearsInMostRecentRole = (
			SELECT AVG(YearsInMostRecentRole) FROM Employee
			WHERE YearsInMostRecentRole IS NOT NULL)
WHERE YearsInMostRecentRole IS NULL

/*Replace NULL YearsSinceLastPromotion With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET YearsSinceLastPromotion = (
			SELECT AVG(YearsSinceLastPromotion) FROM Employee
			WHERE YearsSinceLastPromotion IS NOT NULL)
WHERE YearsSinceLastPromotion IS NULL

/*Replace NULL YearsWithCurrManager With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE Employee
SET YearsWithCurrManager = (
			SELECT AVG(YearsWithCurrManager) FROM Employee
			WHERE YearsWithCurrManager IS NOT NULL)
WHERE YearsWithCurrManager IS NULL

 
 --Handling Null Values in Categorical Fields>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 
 /*Replace NULL FirstName With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET FirstName = COALESCE(FirstName, 
    (SELECT TOP 1 FirstName 
     FROM Employee 
     WHERE FirstName IS NOT NULL 
     GROUP BY FirstName 
     ORDER BY COUNT(*) DESC)
);

 /*Replace NULL LastName With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET LastName = COALESCE(LastName, 
    (SELECT TOP 1 LastName 
     FROM Employee 
     WHERE LastName IS NOT NULL 
     GROUP BY LastName 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL Gender With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET Gender = COALESCE(Gender, 
    (SELECT TOP 1 Gender 
     FROM Employee 
     WHERE Gender IS NOT NULL 
     GROUP BY Gender 
     ORDER BY COUNT(*) DESC)
);

 /*Replace NULL BusinessTravel With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET BusinessTravel = COALESCE(BusinessTravel, 
    (SELECT TOP 1 BusinessTravel 
     FROM Employee 
     WHERE BusinessTravel IS NOT NULL 
     GROUP BY BusinessTravel 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL Department With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET Department = COALESCE(Department, 
    (SELECT TOP 1 FirstName 
     FROM Employee 
     WHERE Department IS NOT NULL 
     GROUP BY Department , FirstName 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL State With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET State = COALESCE(State, 
    (SELECT TOP 1 State 
     FROM Employee 
     WHERE State IS NOT NULL 
     GROUP BY State 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL Ethnicity With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET Ethnicity = COALESCE(Ethnicity, 
    (SELECT TOP 1 Ethnicity 
     FROM Employee 
     WHERE Ethnicity IS NOT NULL 
     GROUP BY Ethnicity 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL EducationField With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET EducationField = COALESCE(EducationField, 
    (SELECT TOP 1 EducationField 
     FROM Employee 
     WHERE EducationField IS NOT NULL 
     GROUP BY EducationField 
     ORDER BY COUNT(*) DESC)
);

 /*Replace NULL JobRole With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET JobRole = COALESCE(JobRole, 
    (SELECT TOP 1 JobRole 
     FROM Employee 
     WHERE JobRole IS NOT NULL 
     GROUP BY JobRole 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL MaritalStatus With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET MaritalStatus = COALESCE(MaritalStatus, 
    (SELECT TOP 1 MaritalStatus 
     FROM Employee 
     WHERE MaritalStatus IS NOT NULL 
     GROUP BY MaritalStatus 
     ORDER BY COUNT(*) DESC)
);

 /*Replace NULL OverTime With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET OverTime = COALESCE(OverTime, 
    (SELECT TOP 1 OverTime 
     FROM Employee 
     WHERE OverTime IS NOT NULL 
     GROUP BY OverTime 
     ORDER BY COUNT(*) DESC)
);


 /*Replace NULL HireDate With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE Employee
SET HireDate = COALESCE(HireDate, 
    (SELECT TOP 1 HireDate 
     FROM Employee 
     WHERE HireDate IS NOT NULL 
     GROUP BY HireDate 
     ORDER BY COUNT(*) DESC)
);

--Remove Extra Space FROM Columns IN Employee TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UPDATE Employee
SET 
	EmployeeID = LTRIM(RTRIM(EmployeeID)),
	FirstName = LTRIM(RTRIM(FirstName)),
    LastName = LTRIM(RTRIM(LastName)),
    GENDer = LTRIM(RTRIM(GENDer)),
    Department = LTRIM(RTRIM(Department)),
    State = LTRIM(RTRIM(State)),
    EducatiON = LTRIM(RTRIM(EducatiON)),
    Ethnicity = LTRIM(RTRIM(Ethnicity)),
    JobRole = LTRIM(RTRIM(JobRole)),
    MaritalStatus = LTRIM(RTRIM(MaritalStatus));


--Handle Wrong Age And ADD CHECK CONSTRAINT That Age IS BETWEEN 18 AND 65>>>>>>>>>>>>>>>>>>>>>>
DELETE FROM Employee
WHERE  Age < 18
OR Age > 65

ALTER TABLE Employee
ADD CONSTRAINT Age_CHECK CHECK (Age <= 65)


--Handle Wrong EducationField Value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UPDATE Employee
set EducationField = 'Marketing'
where EducationField = 'Marketing '


--Categorize Ages INto Ranges >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ALTER TABLE Employee
ADD AgeRange VARCHAR(20)

UPDATE Employee
SET AgeRange = CASE 
	WHEN Age >= 18 AND Age <= 30 THEN '18-30'
    WHEN Age > 30 AND Age <= 40 THEN '31-40'
	WHEN Age > 40 AND Age <= 50 THEN '41-50'
ELSE ' Above 50'
END ;



--Categorize Salary Into Levels >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ALTER TABLE Employee
ADD Salary_Level VARCHAR(50)


UPDATE Employee
SET Salary_Level = CASE 
	WHEN Salary <= 50000 THEN 'Very Low'
    WHEN Salary > 50000 AND Salary <= 100000 THEN 'Low'
	WHEN Salary > 100000 AND Salary <= 200000 THEN 'Medium'
	WHEN Salary > 200000 AND Salary <= 300000 THEN 'High'
ELSE 'Very High'
END ;


Select Salary_Level FROM Employee


--Categorize Distance INto Ranges >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ALTER TABLE Employee
ADD DistanceRange VARCHAR(20)

UPDATE Employee
SET DistanceRange = CASE 
	WHEN DistanceFromHome_KM BETWEEN 1 AND 10 THEN '1-10 km'
	WHEN DistanceFromHome_KM BETWEEN 11 AND 20 THEN '11-20 km'
	WHEN DistanceFromHome_KM BETWEEN 21 AND 30 THEN '21-30 km'
	WHEN DistanceFromHome_KM BETWEEN 31 AND 45 THEN '31-40 km'
ELSE 'Above 40 km'
END 


SELECT DistanceFromHome_KM,DistanceRange
FROM Employee



--Correct States Names>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UPDATE Employee
SET State = CASE 
	WHEN State = 'CA' THEN 'California'
	WHEN State = 'IL' THEN 'Illinois'
	WHEN State = 'NY' THEN 'New York'
ELSE State
END

SELECT State from Employee


--Handle Gender Values>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
UPDATE Employee
SET GENDer = 'Other'
WHERE GENDer = 'NON-BINary'
OR GENDer = 'Prefer Not To Say'

select Gender , count(*)
from Employee
GROUP BY Gender

-- Add a constraint to enforce gender values>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ALTER TABLE Employee
ADD CONSTRAINT Check_Gender CHECK (Gender IN ('Male', 'Female', 'Other'));



--Group JobRole By Department
SELECT  Department, JobRole
FROM Employee
GROUP BY Department, JobRole 


--How  many Invaid Entry in Technology Department
SELECT count(EmployeeID), EmployeeID
FROM Employee
WHERE Department = 'Technology' and JobRole = 'Sales Executive' 
GROUP BY EmployeeID



--Hanadle invalid JobRole >>>> Sales Executive must be in Sals Department Not Technology
Update Employee
SET Department = 'Sales'
WHERE Department = 'Technology' and JobRole= 'Sales Executive'



--Check Delete invalid entry
SELECT *
FROM Employee
WHERE Department = 'Technology' and JobRole= 'Sales Executive'



/*	PerformanceRating Table Cleaning

Get Unique Values FROM PerformanceRating Table */
SELECT DISTINCT(PerformanceID)
FROM PerformanceRatINg 
GROUP BY PerformanceID

--Get Duplicates From PerformanceRating Table 
SELECT PerformanceID 
	FROM PerformanceRatINg 
	GROUP BY PerformanceID
	HAVING(COUNT(*)>1)


/*Remove Duplicates FROM PerformanceRating Table>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DELETE FROM PerformanceRatINg
WHERE PerformanceID IN (
	SELECT PerformanceID 
	FROM PerformanceRatINg 
	GROUP BY PerformanceID
	HAVING(COUNT(*)>1))


	
/*Get NULL Values FROM PerformanceRatINg TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT * FROM PerformanceRatINg
WHERE EmployeeID IS NULL 
   OR ReviewDate IS NULL 
   OR EnvirONmentSatISfactiON IS NULL
   OR JobSatISfactiON IS NULL
   OR RelatiONshipSatISfactiON IS NULL
   OR TraININgOpportunitiesTaken IS NULL
   OR TraININgOpportunitiesWithINYear IS NULL
   OR WorkLifeBalance IS NULL
   OR SelfRatINg IS NULL
   OR ManagerRatINg IS NULL




--Handling Null Values in Numerical Fields>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--Replace NULL EnvironmentSatisfaction With Average value
UPDATE PerformanceRating
SET EnvironmentSatisfaction= (
    SELECT AVG(EnvironmentSatisfaction)
    FROM PerformanceRating
    WHERE EnvironmentSatisfaction IS NOT NULL
)
WHERE EnvironmentSatisfaction IS NULL                                                                                                                    IS NULL

-- Replace NULL JobSatisfaction with Average value
DECLARE @AvgJobSatisfaction FLOAT;
SET @AvgJobSatisfaction = (SELECT AVG(JobSatisfaction) FROM PerformanceRating WHERE JobSatisfaction IS NOT NULL);
UPDATE PerformanceRating
SET JobSatisfaction = @AvgJobSatisfaction
WHERE JobSatisfaction IS NULL;

/*Replace NULL RelationshipSatisfaction With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @RelationshipSatisfaction FLOAT;
SET @RelationshipSatisfaction = (SELECT AVG(RelationshipSatisfaction) FROM PerformanceRating WHERE RelationshipSatisfaction IS NOT NULL);
UPDATE PerformanceRating
SET RelationshipSatisfaction = @RelationshipSatisfaction
WHERE RelationshipSatisfaction IS NULL;

/*Replace NULL TrainingOpportunitiesWithinYear With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @TrainingOpportunitiesWithinYear FLOAT;
SET @TrainingOpportunitiesWithinYear = (SELECT AVG(TrainingOpportunitiesWithinYear) FROM PerformanceRating WHERE TrainingOpportunitiesWithinYear IS NOT NULL);
UPDATE PerformanceRating
SET TrainingOpportunitiesWithinYear = @TrainingOpportunitiesWithinYear
WHERE TrainingOpportunitiesWithinYear IS NULL;


/*Replace NULL TrainingOpportunitiesTaken With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @TrainingOpportunitiesTaken  FLOAT;
SET @TrainingOpportunitiesTaken  = (SELECT AVG(TrainingOpportunitiesTaken ) FROM PerformanceRating WHERE TrainingOpportunitiesTaken  IS NOT NULL);
UPDATE PerformanceRating
SET TrainingOpportunitiesTaken  = @TrainingOpportunitiesTaken 
WHERE TrainingOpportunitiesTaken  IS NULL;
 

/*Replace NULL WorkLifeBalance With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @WorkLifeBalance  FLOAT;
SET @WorkLifeBalance  = (SELECT AVG(WorkLifeBalance ) FROM PerformanceRating WHERE WorkLifeBalance  IS NOT NULL);
UPDATE PerformanceRating
SET WorkLifeBalance  = @WorkLifeBalance 
WHERE WorkLifeBalance  IS NULL;



/*Replace NULL SelfRating With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @SelfRating  FLOAT;
SET @SelfRating  = (SELECT AVG(SelfRating ) FROM PerformanceRating WHERE SelfRating  IS NOT NULL);
UPDATE PerformanceRating
SET SelfRating  = @SelfRating
WHERE SelfRating  IS NULL;

/*Replace NULL ManagerRating With Average value>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DECLARE @ManagerRating  FLOAT;
SET @ManagerRating  = (SELECT AVG(ManagerRating ) FROM PerformanceRating WHERE ManagerRating  IS NOT NULL);
UPDATE PerformanceRating
SET ManagerRating  = @ManagerRating
WHERE ManagerRating  IS NULL;
 
 --Handling Null Values in Categorical Fields>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 
 /*Replace NULL EmployeeID With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE PerformanceRating
SET EmployeeID = COALESCE(EmployeeID, 
    (SELECT TOP 1 EmployeeID 
     FROM PerformanceRating 
     WHERE EmployeeID IS NOT NULL 
     GROUP BY EmployeeID 
     ORDER BY COUNT(*) DESC)
);

 /*Replace NULL ReviewDate With Mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
 UPDATE PerformanceRating
SET ReviewDate = COALESCE(ReviewDate, 
    (SELECT TOP 1 ReviewDate 
     FROM PerformanceRating 
     WHERE ReviewDate IS NOT NULL 
     GROUP BY ReviewDate 
     ORDER BY COUNT(*) DESC)
);

/*Check For inconsistent ReviewDate:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Review Date Before HireDate*/
SELECT P.EmployeeID
FROM Employee E
JOIN PerformanceRatINg P
ON E.EmployeeID = P.EmployeeID
WHERE P.ReviewDate <= E.HireDate 


/*Review Date After AttritionDate*/
SELECT P.EmployeeID
FROM Employee E
JOIN PerformanceRatINg P
ON E.EmployeeID = P.EmployeeID
WHERE P.ReviewDate >=DATEADD(Year,YearsAtCompany,HireDate ) AND E.AttritiON = 1



--Remove Inconsistent Review Dates >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*
	DELETE P
	FROM PerformanceRatINg P
	JOIN Employee E
	ON P.EmployeeID = E.EmployeeID
	WHERE 
		-- Condition 1: DELETE for all employees WHERE ReviewDate IS before HireDate
		P.ReviewDate < E.HireDate 

		-- Condition 2: DELETE for AttritiON = 1 WHERE ReviewDate IS after the expected END date
		OR (P.ReviewDate > DATEADD(Year, E.YearsAtCompany, E.HireDate) AND E.AttritiON = 1);





/*RemovINg Extra Space FROM Columns IN Performance TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
UPDATE PerformanceRatINg 
SET 
	PerformanceID= LTRIM(RTRIM(PerformanceID)),
    EmployeeID = LTRIM(RTRIM(EmployeeID)),
    ReviewDate = LTRIM(RTRIM(ReviewDate)),
    EnvirONmentSatISfactiON = LTRIM(RTRIM(EnvirONmentSatISfactiON)),
    JobSatISfactiON = LTRIM(RTRIM(JobSatISfactiON)),
    RelatiONshipSatISfactiON = LTRIM(RTRIM(RelatiONshipSatISfactiON)),
    TraININgOpportunitiesTaken = LTRIM(RTRIM(TraININgOpportunitiesTaken)),
    TraININgOpportunitiesWithINYear = LTRIM(RTRIM(TraININgOpportunitiesWithINYear)),
    WorkLifeBalance = LTRIM(RTRIM(WorkLifeBalance)),
	SelfRatINg = LTRIM(RTRIM(SelfRatINg)),
	ManagerRatINg = LTRIM(RTRIM(ManagerRatINg))

--Get  Duplicates FROM EducatiONLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT EducatiONLevelID 
	FROM EducatiONLevel 
	GROUP BY EducatiONLevelID
	HAVING(COUNT(*)>1)
	
	
	 
/*Remove Duplicates FROM EducatiONLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DELETE FROM EducatiONLevel
WHERE EducatiONLevelID IN (
	SELECT EducatiONLevelID 
	FROM EducatiONLevel 
	GROUP BY EducatiONLevelID
	HAVING(COUNT(*)>1))


--Get Duplicates FROM SatISfiedLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT SatISfactiONID 
	FROM SatISfiedLevel 
	GROUP BY SatISfactiONID
	HAVING(COUNT(*)>1)


/*Remove Duplicates FROM SatISfiedLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DELETE FROM SatISfiedLevel
WHERE SatISfactiONID IN (
	SELECT SatISfactiONID 
	FROM SatISfiedLevel 
	GROUP BY SatISfactiONID
	HAVING(COUNT(*)>1))


/*Get Duplicates FROM RatINgLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
	SELECT RatINgID 
	FROM RatINgLevel 
	GROUP BY RatINgID
	HAVING(COUNT(*)>1)


/*Remove Duplicates FROM RatINgLevel TABLE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
DELETE FROM RatINgLevel
WHERE RatINgID IN (
	SELECT RatINgID 
	FROM RatINgLevel 
	GROUP BY RatINgID
	HAVING(COUNT(*)>1))





/*											Data Modeling Phase


Join Performance Table And Satisfactionlevel And Rating Tables>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT P.PerformanceID,P.EmployeeID,P.ReviewDate ,P.EnvironmentSatisfaction, S_Env.SatisfactionLevel EnvironmentSatisfaction,
P.JobSatisfaction, S_Job.SatisfactionLevel JobSatisfaction , P.RelationshipSatisfaction , S_Rel.SatisfactionLevel RelationshipSatisfaction, 
p.WorkLifeBalance , S_Work.SatisfactionLevel WorkLifeBalance, p.SelfRating , R_Self.RatingLevel SelfRating , 
P.ManagerRating ,R_Mang.RatingLevel ManagerRating,
P.TrainingOpportunitiesWithinYear,P.TrainingOpportunitiesTaken
FROM  PerformanceRating P
 JOIN SatisfiedLevel S_Env
ON p.EnvironmentSatisfaction = S_Env.SatisfactionID
 JOIN SatisfiedLevel S_Job
ON P.JobSatisfaction  =  S_Job.SatisfactionID
 JOIN SatisfiedLevel S_Rel
ON P.RelationshipSatisfaction = S_Rel.SatisfactionID
 JOIN SatisfiedLevel S_Work
ON P.WorkLifeBalance  =  S_Work.SatisfactionID
 JOIN RatingLevel R_Self
ON p.SelfRating = R_Self.RatingID
 JOIN RatingLevel R_Mang
ON p.ManagerRating = R_Mang.RatingID


--Join Employee Table And EducationLevel Table>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT  * 
FROM Employee E
join EducationLevel ED
ON E.Education = ED.EducationLevelID

 
--Get Employees Not Rated Yet FROM Employee Table>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT DISTINCT EmployeeID FROM PerformanceRating

--Get Employees Not Rated Yet FROM Employee Table>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT Distinct(EmployeeID) AS UnratedEmployees , YearsAtCompany
FROM Employee
WHERE EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM PerformanceRating);

--Years At Company For Employees Not Rated>>>>>>>>>>>>(0-1)>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT EmployeeID , YearsAtCompany
FROM Employee 
WHERE EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM PerformanceRating);




/*													Analaysis Phase								*/



/*					OverView DashBoard
Total Employees >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT COUNT(*) AS 'Total Employees'
FROM Employee

SELECT COUNT(DISTINCT EmployeeID) TotalEmployees
FROM Employee;


--Get ttrition Count>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS 'Attrition Count'
FROM Employee;


--Get Active Employees >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
    COUNT(CASE WHEN Attrition = 0 THEN 1 END) AS 'Attrition Count'
FROM Employee;


--Get ttrition Rate>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
    CAST(ROUND(SUM(CASE WHEN Attrition = 1 THEN 1 END) * 100.0 / COUNT(EmployeeID),2) AS DECIMAL(10,2)) AS 'Attrition Rate'
FROM Employee;


--Average Salary>>>>>>>>>>>>>>>>>>>>>(112956 k)>>>>>>>>>>>>>>>>
SELECT AVG(Salary)
FROM Employee


--Average Age>>>>>>>>>>>>>>>>>>>>>(29.0)>>>>>>>>>>>>>>>>
SELECT CAST(AVG(CAST(Age AS FLOAT)) AS DECIMAL(10,1))
FROM Employee


--Average YearsAtCompany>>>>>>>>>>>>>>>>>>>>>(5.0)>>>>>>>>>>>>>>>>
SELECT CAST(AVG(CAST(YearsAtCompany AS FLOAT)) AS DECIMAL(10,0))
FROM Employee


-- OverTime Rate >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
	SUM(CASE WHEN OverTime = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN OverTime = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  


--Employees Distribution Percentage Per EnvironmentSatisfaction
SELECT 
    S.SatisfactionLevel, 
    COUNT(*) AS EmployeeCount, 
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Employee E
JOIN PerformanceRating P ON E.EmployeeID = P.EmployeeID
JOIN SatisfiedLevel S ON S.SatisfactionID = P.EnvironmentSatisfaction
GROUP BY S.SatisfactionLevel


--Employees Distribution Percentage Per JobSatifaction
SELECT 
    S.SatisfactionLevel, 
    COUNT(*) AS EmployeeCount, 
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Employee E
JOIN PerformanceRating P ON E.EmployeeID = P.EmployeeID
JOIN SatisfiedLevel S ON S.SatisfactionID = P.JobSatisfaction
GROUP BY S.SatisfactionLevel


--Employees Distribution Percentage Per RelationshipSatisfaction
SELECT 
	S.SatisfactionLevel, 
	COUNT(*) AS EmployeeCount, 
	ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Employee E
JOIN PerformanceRating P ON E.EmployeeID = P.EmployeeID
JOIN SatisfiedLevel S ON S.SatisfactionID = P.RelationshipSatisfaction
GROUP BY S.SatisfactionLevel


--Employees Distribution Percentage Per WorkLifeBalance
SELECT 
    S.SatisfactionLevel, 
    COUNT(*) AS EmployeeCount, 
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Employee E
JOIN PerformanceRating P ON E.EmployeeID = P.EmployeeID
JOIN SatisfiedLevel S ON S.SatisfactionID = P.WorkLifeBalance
GROUP BY S.SatisfactionLevel


--Employee Per BusinessTravel(Count)
SELECT BusinessTravel , COUNT(*) AS #Employee
FROM Employee
GROUP BY BusinessTravel
ORDER BY #Employee DESC;

--Employee Per AgeRange(Count)
SELECT AgeRange , COUNT(*) AS #Employee
FROM Employee
GROUP BY AgeRange
ORDER BY #Employee DESC;

--Employee Per Gender(Count)
SELECT Gender, COUNT(*) AS #Employee
FROM Employee
GROUP BY Gender
ORDER BY #Employee DESC;

--Hire Count Per Years
SELECT 
    YEAR(HireDate) AS HireYear,
    COUNT(*) AS HireCount
FROM Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear;


--Attrition Count Per Years
SELECT 
    YEAR(DATEADD(YEAR, YearsAtCompany, HireDate)) AS CurrentYear,
    COUNT(*) AS AttritionYesCount
FROM 
    Employee
WHERE 
    Attrition = '1'
GROUP BY 
   YEAR(DATEADD(YEAR, YearsAtCompany, HireDate))
ORDER BY 
    CurrentYear;



/*	Employee DashBoard */

--Employee Per EducationLevel
SELECT ED.EducationLevel , COUNT(*) AS #Employee
FROM Employee E JOIN EducationLevel ED
ON E.Education = ED.EducationLevelID
GROUP BY EducationLevel
ORDER BY #Employee DESC;

--Employee Per EducationField(Count)
SELECT EducationField , COUNT(*) AS #Employee
FROM Employee
GROUP BY EducationField
ORDER BY #Employee DESC;

--Employee Per MaritalStatus(Count)
SELECT MaritalStatus , COUNT(*) AS #Employee
FROM Employee
GROUP BY MaritalStatus
ORDER BY #Employee DESC;

--Employee Per State(Count)
SELECT State , COUNT(*) AS #Employee
FROM Employee
GROUP BY State
ORDER BY #Employee DESC;

--Employee Per Department(Count)
SELECT Department , COUNT(*) AS #Employee
FROM Employee
GROUP BY Department
ORDER BY #Employee DESC;

--Employee Per JobRole(Count)
SELECT JobRole , COUNT(*) AS #Employee
FROM Employee
GROUP BY JobRole
ORDER BY #Employee DESC;



/*						Salary DashBoard
--MAXIMUM And Min And AVG Salary  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT min(Salary) MINIMUM,max(Salary)MAXIMUM ,AVG(Salary) Average
FROM Employee

--Lowest Salary Per AgeRange,Gender >>>>>>>>>>>>>>>>Male(18-30) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT  AgeRange , Gender , AVG(Salary) 'Average Salary'
FROM Employee
GROUP BY AgeRange , Gender
ORDER BY AVG(Salary) ASc

--Highest Salary Per AgeRange,Gender >>>>>>>>>>>>>>>>Male(> 50) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT  AgeRange , Gender , AVG(Salary) 'Average Salary'
FROM Employee
GROUP BY AgeRange , Gender
ORDER BY AVG(Salary) DESC

--Highest Salary Per AgeRange>>>>>>>>>>>>>>>>( > 50)>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT  AgeRange , AVG(Salary) 'Average Salary'
FROM Employee
GROUP BY AgeRange
ORDER BY AVG(Salary) DESC



--Highest Salary Per Department >>>>>>>>>>>>>HR>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT Department , AVG(salary) 'Average Salary'
FROM Employee	
GROUP BY Department
ORDER BY AVG(salary) DESC

--Highest Salary Per JobRole >>>>>>>>>>>>>>>>>>HR Manager>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT JobRole , AVG(salary) 'Average Salary'
FROM Employee	
GROUP BY JobRole
ORDER BY AVG(salary) DESC


--Salary Per EducationLevel
SELECT EducationLevel , AVG(salary) 'Average Salary'
FROM Employee EM JOIN EducationLevel ED
ON EM.Education = ED.EducationLevelID
GROUP BY EducationLevel
ORDER BY AVG(salary) DESC

--Salary Per EducationField
SELECT EducationField , AVG(salary) 'Average Salary'
FROM Employee E JOIN EducationField EF
ON E.Education = EF.EducationLevelID
GROUP BY EducationField
ORDER BY AVG(salary) DESC

--Average Salary Per Years
SELECT  YEAR(HireDate) AS HireYear , AVG(Salary) AS 'Avg.Salary'
FROM Employee
GROUP BY YEAR(HireDate)
ORDER BY YEAR(HireDate) asc



--Employee Per Salary_Level(Count)
SELECT Salary_Level , COUNT(*) AS #Employee
FROM Employee
GROUP BY Salary_Level
ORDER BY #Employee DESC;




/*				Attrition DashBoard
 Attrition per Marital Status >>>>>>>>>>>>>>>>>>>>(Single)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
SELECT MaritalStatus,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY MaritalStatus
ORDER BY YES DESC

--AttritiON Per AgeRange,Gender >>>>>>>>>>>>>>>>male(18-30) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT AgeRange , Gender,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY AgeRange , Gender
ORDER BY YES DESC


--AttritiON Per Gender>>>>>>>>>>>>>>>>Female >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT  COALESCE(Gender,'Total') AS Attrition,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee
GROUP BY Gender
WITH ROLLUP


--AttritiON Per AgeRange>>>>>>>>>>>>>>>>(18-30) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT AgeRange ,
SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY AgeRange
ORDER BY AgeRange


--Attrition per salary Levels>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(YES)>>>>>>>>>>>>>>>>>>>>>>
WITH SalaryGroups AS (
    SELECT 
        EmployeeID,
        Attrition,
        CASE 
            WHEN TRY_CAST(Salary AS INT) < 50000 THEN 'Below 50K'
            WHEN TRY_CAST(Salary AS INT) BETWEEN 50000 AND 100000 THEN '50K-100K'
            WHEN TRY_CAST(Salary AS INT) BETWEEN 100000 AND 150000 THEN '100K-150K'
			WHEN TRY_CAST(Salary AS INT) BETWEEN 150000 AND 300000 THEN '150K-3000K'
            WHEN TRY_CAST(Salary AS INT) > 300000 THEN 'Above 300K'
            ELSE 'Unknown'
        END AS Salary_Range
    FROM Employee
    WHERE TRY_CAST(Salary AS INT) IS NOT NULL  -- Ensuring Salary is a valid numeric value
)
SELECT 
    Salary_Range,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) AS Retention_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS Attrition_Rate
FROM SalaryGroups
WHERE Attrition IN (1, 0)  -- Ensuring only valid attrition values
GROUP BY Salary_Range
ORDER BY Attrition_Rate DESC;

--Attrition Rate VS Salary Level
SELECT 
    Salary_Level,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) AS Retention_Count,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS Attrition_Rate
FROM Employee
WHERE Attrition IN (1, 0)  
GROUP BY Salary_Level
ORDER BY Attrition_Rate DESC;


--Attrition per Department & JobRole VS Average Salary>>>>>>>>>>>>>>>>>>>(Negative Relation Between Attrition And Salary)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 
    Department,JobRole ,AVG(Salary) as 'Average Salary',
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    ROUND(
        (SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS AttritionRate -- Percentage
FROM Employee
GROUP BY Department,JobRole


--AttritiON Per JobRole>>>>>>>>>>>>>>>>Sales Representative >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT JobRole,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY JobRole
ORDER BY YES DESC


--AttritiON Per EducationField>>>>>>>>>>>>>>>>Technical Degree >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT EducationField,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY EducationField
ORDER BY YES DESC


--AttritioN Per BusinessTravel>>>>>>>>>>>>>>>>Frequent Traveller >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT BusinessTravel,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY BusinessTravel
ORDER BY YES DESC


--AttritioN Per EducationLevel>>>>>>>>>>>>>>>>No Formal Qualifications>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT EducationLevel,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee EM JOIN EducationLevel ED
ON EM.Education =ED.EducationLevelID
GROUP BY EducationLevel
ORDER BY YES DESC

------------------------------------------------------
-- Attrition per Years Since Last Promotion >>>>>>>>>>>>>>>>>>(NO)>>>>>>>>>>>>>>>>>>>>
SELECT YearsSinceLastPromotion,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion DESC

--Attrition per YearsWithCurrManager >>>>>>>>>>>>>>>>>>(NO)>>>>>>>>>>>>>>>>>>>>
SELECT YearsWithCurrManager,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY YearsWithCurrManager
ORDER BY YearsWithCurrManager DESC

-- Attrition per OverTime >>>>>>>>>>>>>>>>>>(NO)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT OverTime,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee  
GROUP BY OverTime
ORDER BY YES DESC


--OverTime Per Department>>>>>>>>>>>>>>>>(Sales) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT Department,
	SUM(CASE WHEN OverTime = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN OverTime = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee
GROUP BY Department
ORDER BY YES DESC


--OverTime Per JobRole>>>>>>>>>>>>>>>>(Sales) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT JobRole,
	SUM(CASE WHEN OverTime = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN OverTime = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee
GROUP BY JobRole
ORDER BY YES DESC

--OverTime Per EducationLevel>>>>>>>>>>>>>>>>No Formal Qualifications>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT ED.EducationLevel ,
	SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN Attrition = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee E JOIN EducationLevel ED
ON E.Education = ED.EducationLevelID
GROUP BY EducationLevel
ORDER BY YES DESC


--OverTime Per BusinessTravel>>>>>>>>>>>>>>>>(Frequent Traveller) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT BusinessTravel,
	SUM(CASE WHEN OverTime = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN OverTime = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee
GROUP BY BusinessTravel
ORDER BY YES DESC


--OverTime Per Gender,AgeRange >>>>>>>>>>>>>>>>(Male 18-30) >>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT Gender,AgeRange,
	SUM(CASE WHEN OverTime = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS YES,
	SUM(CASE WHEN OverTime = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NO,
	Count (*) AS Total
FROM Employee
GROUP BY Gender,AgeRange
ORDER BY YES DESC

--Identify Last Year In Data
select Max(P.ReviewDate) as 'last ReviewDate' , Max(E.HireDate) as 'last HireDate'
FROM Employee E
JOIN PerformanceRating P
ON E.EmployeeID = p.EmployeeID

--Identify Employees who will be Retired (Whose Age 65 Years) Per each Year Based on Last Year In Data>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT 2023 + (65 - Age) AS RetirementYear, 
    COUNT(EmployeeID) AS EmployeesCount
FROM Employee
GROUP BY 2023 + (65 - Age)
ORDER BY RetirementYear;





--					Performance Dashboard


--Employees will be promoted due to (AVG Rating > 4.0  and YearsSinceLastPromotion > 4 years )
SELECT  E.JobRole  , COUNT(E.EmployeeID) AS EmployeeCount,
MIN(E.YearsSinceLastPromotion) AS YearsSinceLastPromotion
FROM Employee E
JOIN (
SELECT P.EmployeeID,AVG(CAST(P.ManagerRating AS FLOAT)) AS Avg_ManagerRating
FROM PerformanceRating P
GROUP BY P.EmployeeID) AS AP 
ON E.EmployeeID = AP.EmployeeID
WHERE AP.Avg_ManagerRating > 4.0  
AND E.YearsSinceLastPromotion > 4  
GROUP BY E.JobRole
ORDER BY AVG(AP.Avg_ManagerRating) DESC;


--Employees will be Retrenched Due To (AVG Rating = 2.0 )
SELECT  E.JobRole , COUNT(E.EmployeeID) AS EmployeeCount
FROM Employee E
JOIN (
SELECT P.EmployeeID,AVG(CAST(P.ManagerRating AS FLOAT)) AS Avg_ManagerRating
FROM PerformanceRating P
GROUP BY P.EmployeeID) AS AP 
ON E.EmployeeID = AP.EmployeeID
WHERE AP.Avg_ManagerRating = 2.0
GROUP BY E.JobRole
ORDER BY AVG(AP.Avg_ManagerRating) DESC;



/*Top5 Employees Due To Performance>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
WITH AvgRating AS (
    SELECT 
        PR.EmployeeID,
        AVG(PR.ManagerRating) AS AvgManagerRating
    FROM PerformanceRating PR
    GROUP BY PR.EmployeeID
)
SELECT TOP 5
    E.EmployeeID,
    A.AvgManagerRating
FROM AvgRating A
INNER JOIN Employee E ON A.EmployeeID = E.EmployeeID
ORDER BY A.AvgManagerRating DESC;



--performance per education field
WITH cte AS (
	SELECT 
		e.EducationField, 
		COUNT(*) AS field_total
	FROM
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	GROUP BY
		e.EducationField
)

SELECT
	e.EducationField AS "Field",
	r.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.field_total AS FLOAT)) * 100, 2) AS "Proportion of Field Total"
FROM
	PerformanceRating AS p
INNER JOIN
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN
	RatingLevel AS r ON p.ManagerRating = r.RatingID
INNER JOIN
	cte ON e.EducationField = cte.EducationField
GROUP BY
	e.EducationField,
	r.RatingLevel,
	cte.field_total
ORDER BY
	e.EducationField,
	CASE r.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;

--training taken % vs education field
WITH TrainingData AS (
    SELECT 
        e.EducationField,
        SUM(p.TrainingOpportunitiesTaken) AS TotalTrainingTaken,
        SUM(p.TrainingOpportunitiesWithinYear) AS TotalTrainingWithinYear
    FROM 
        PerformanceRating AS p
    INNER JOIN 
        Employee AS e ON p.EmployeeID = e.EmployeeID
    GROUP BY 
        e.EducationField
)

SELECT 
    EducationField,
    TotalTrainingTaken AS "Total Training Taken",
    TotalTrainingWithinYear AS "Total Training Within Year",
    CASE 
        WHEN TotalTrainingWithinYear = 0 THEN 0  
        ELSE ROUND((CAST(TotalTrainingTaken AS FLOAT) / TotalTrainingWithinYear) * 100, 2)
    END AS "Training Taken (%)"
FROM 
    TrainingData
ORDER BY 
    EducationField;

--performance per education level
WITH cte AS ( 
	SELECT 
		el.EducationLevel, 
		COUNT(*) AS edulevel_total
	FROM
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	INNER JOIN
		EducationLevel AS el ON e.Education = el.EducationLevelID
	GROUP BY
		el.EducationLevel
)

SELECT
	el.EducationLevel AS "Education Level",
	rl.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.edulevel_total AS FLOAT)) * 100, 2) AS "Proportion of Education Level Total"
FROM
	PerformanceRating AS p
INNER JOIN
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN
	EducationLevel AS el ON e.Education = el.EducationLevelID
INNER JOIN
	RatingLevel AS rl ON p.ManagerRating = rl.RatingID
INNER JOIN
	cte ON el.EducationLevel = cte.EducationLevel
GROUP BY
	el.EducationLevel,
	rl.RatingLevel,
	cte.edulevel_total
ORDER BY
	el.EducationLevel,
	CASE rl.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;

	--training taken % vs education level
	WITH TrainingData AS ( 
    SELECT 
        el.EducationLevel,
        SUM(p.TrainingOpportunitiesTaken) AS TotalTrainingTaken,
        SUM(p.TrainingOpportunitiesWithinYear) AS TotalTrainingWithinYear
    FROM 
        PerformanceRating AS p
    INNER JOIN 
        Employee AS e ON p.EmployeeID = e.EmployeeID
    INNER JOIN
        EducationLevel AS el ON e.Education = el.EducationLevelID
    GROUP BY 
        el.EducationLevel
)

SELECT 
    EducationLevel,
    TotalTrainingTaken AS "Total Training Taken",
    TotalTrainingWithinYear AS "Total Training Within Year",
    CASE 
        WHEN TotalTrainingWithinYear = 0 THEN 0  
        ELSE ROUND((CAST(TotalTrainingTaken AS FLOAT) / TotalTrainingWithinYear) * 100, 2)
    END AS "Training Taken (%)"
FROM 
    TrainingData
ORDER BY 
    EducationLevel;

--Performance Per Ethnicity Proportions
	WITH cte AS (
	SELECT 
		e.Ethnicity, 
		COUNT(*) AS ethnicity_total
	FROM
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	GROUP BY
		e.Ethnicity
)

SELECT
	e.Ethnicity AS "Ethnicity",
	rl.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.ethnicity_total AS FLOAT)) * 100, 2) AS "Proportion of Ethnicity Total"
FROM
	PerformanceRating AS p
INNER JOIN
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN
	RatingLevel AS rl ON p.ManagerRating = rl.RatingID
INNER JOIN
	cte ON e.Ethnicity = cte.Ethnicity
GROUP BY
	e.Ethnicity,
	rl.RatingLevel,
	cte.ethnicity_total
ORDER BY
	e.Ethnicity,
	CASE rl.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;

	--performance vs job role
	WITH cte AS (
	SELECT 
		e.JobRole, 
		COUNT(*) AS jobrole_total
	FROM
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	GROUP BY
		e.JobRole
)

SELECT
	e.JobRole AS "Job Role",
	rl.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.jobrole_total AS FLOAT)) * 100, 2) AS "Proportion of Job Role Total"
FROM
	PerformanceRating AS p
INNER JOIN
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN
	RatingLevel AS rl ON p.ManagerRating = rl.RatingID
INNER JOIN
	cte ON e.JobRole = cte.JobRole
GROUP BY
	e.JobRole,
	rl.RatingLevel,
	cte.jobrole_total
ORDER BY
	e.JobRole,
	CASE rl.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;

	-- Training Taken % vs Job Role
WITH TrainingData AS (
    SELECT 
        e.JobRole,
        SUM(p.TrainingOpportunitiesTaken) AS TotalTrainingTaken,
        SUM(p.TrainingOpportunitiesWithinYear) AS TotalTrainingWithinYear
    FROM 
        PerformanceRating AS p
    INNER JOIN 
        Employee AS e ON p.EmployeeID = e.EmployeeID
    GROUP BY 
        e.JobRole
)

SELECT 
    td.JobRole AS "Job Role",
    td.TotalTrainingTaken AS "Total Training Taken",
    td.TotalTrainingWithinYear AS "Total Training Within Year",
    CASE 
        WHEN td.TotalTrainingWithinYear = 0 THEN 0  
        ELSE ROUND((CAST(td.TotalTrainingTaken AS FLOAT) / td.TotalTrainingWithinYear) * 100, 2)
    END AS "Training Taken (%)"
FROM 
    TrainingData td
ORDER BY 
    td.JobRole;

	

	--performance per overtime
	WITH cte AS (
	SELECT
		e.OverTime,
		COUNT(*) AS overtime_total
	FROM 
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	GROUP BY 
		e.OverTime
)

SELECT 
	e.OverTime AS "Overtime",
	rl.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.overtime_total AS FLOAT)) * 100, 2) AS "Proportion of Overtime Total"
FROM 
	PerformanceRating AS p
INNER JOIN 
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN 
	RatingLevel AS rl ON p.ManagerRating = rl.RatingID
INNER JOIN 
	cte ON cte.OverTime = e.OverTime
GROUP BY 
	e.OverTime,
	rl.RatingLevel,
	cte.overtime_total
ORDER BY 
	e.OverTime,
	CASE rl.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;


--performance per attrition
	WITH cte AS (
	SELECT 
		e.Attrition, 
		COUNT(*) AS attrition_total
	FROM
		PerformanceRating AS p
	INNER JOIN
		Employee AS e ON p.EmployeeID = e.EmployeeID
	GROUP BY 
		e.Attrition
)

SELECT
	e.Attrition AS "Attrition",
	rl.RatingLevel AS "Rating",
	ROUND((COUNT(*) / CAST(cte.attrition_total AS FLOAT)) * 100, 2) AS "Proportion of Attrition Total"
FROM 
	PerformanceRating AS p
INNER JOIN 
	Employee AS e ON p.EmployeeID = e.EmployeeID
INNER JOIN 
	RatingLevel AS rl ON p.ManagerRating = rl.RatingID
INNER JOIN 
	cte ON cte.Attrition = e.Attrition
GROUP BY 
	e.Attrition,
	rl.RatingLevel,
	cte.attrition_total
ORDER BY 
	e.Attrition,
	CASE rl.RatingLevel
		WHEN 'Needs Improvement' THEN 1
		WHEN 'Meets Expectation' THEN 2
		WHEN 'Exceeds Expectation' THEN 3
		WHEN 'Above and Beyond' THEN 4
		ELSE 5
	END;


--Weighted Average Approach>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--Performance for JobRole
WITH MinReviewYear AS (
    SELECT 
        e.JobRole,
        MIN(YEAR(p.ReviewDate)) AS MinReviewYear
    FROM Employee e
    INNER JOIN PerformanceRating p ON e.EmployeeID = p.EmployeeID
    GROUP BY e.JobRole
),

WeightedData AS (
    SELECT 
        e.JobRole,
        YEAR(p.ReviewDate) AS ReviewYear,
        p.ManagerRating,
        (YEAR(p.ReviewDate) - m.MinReviewYear + 1) AS Weight,
        p.ManagerRating * (YEAR(p.ReviewDate) - m.MinReviewYear + 1) AS WeightedRating
    FROM Employee e
     JOIN PerformanceRating p ON e.EmployeeID = p.EmployeeID
     JOIN MinReviewYear m ON e.JobRole = m.JobRole
),

WeightedAverage AS (
    SELECT 
        JobRole,
        SUM(WeightedRating) * 1.0 / SUM(Weight) AS WeightedAvgManagerRating
    FROM WeightedData
    GROUP BY JobRole
)

SELECT 
    JobRole,
    WeightedAvgManagerRating
FROM WeightedAverage
ORDER BY WeightedAvgManagerRating DESC;


