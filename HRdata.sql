Select * 
From hrdata;

-- What is the total number of employees?
SELECT Count(*) as Total_Employees
FROM hrdata;

-- How many employees have left the company?
SELECT COUNT(*) AS Employees_Left
FROM hrdata
WHERE termd = 1;

-- What is the average monthly income?
SELECT Avg(Salary) as Avg_income
FROM hrdata;

-- How many unique job roles and departments are present?
SELECT DISTINCT Position AS Job_Rolename
FROM hrdata
ORDER BY Position;

SELECT DISTINCT Department AS Depart_name
FROM hrdata
ORDER BY Department;

-- Count of Job role and Department
SELECT 
      COUNT(DISTINCT Position) AS Job_Roles,
      COUNT(DISTINCT Department) AS Uni_Depart
FROM hrdata;

-- Which departments has the highest number of employees?
SELECT Department, COUNT(*) AS Total_Employees
FROM hrdata
GROUP BY Department
ORDER BY Total_Employees DESC
LIMIT 1;

-- What is the average salary in each department?
SELECT 
    Department,
    ROUND(AVG(Salary), 2) AS Average_Salary
FROM hrdata
GROUP BY Department
ORDER BY Average_Salary DESC;

-- What is the gender distribution across departments?
SELECT 
    Department,
    Sex,
    COUNT(*) AS Employee_Count
FROM hrdata
GROUP BY Department, Sex
ORDER BY Department, Sex;

-- Age of the Employees 
SELECT 
    `Employee Name`,
    DOB,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM hrdata;

-- Which age group has the highest attrition rate?
SELECT
    Age_Group,
    Total_Employees,
    Employees_Left,
    ROUND(Employees_Left * 100.0 / Total_Employees, 2) AS Attrition_Rate
FROM (
    SELECT
        CASE
            WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 18 AND 25 THEN '18-25'
            WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 26 AND 35 THEN '26-35'
            WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 36 AND 45 THEN '36-45'
            WHEN TIMESTAMPDIFF(YEAR, DOB, CURDATE()) BETWEEN 46 AND 55 THEN '46-55'
            ELSE '56+'
        END AS Age_Group,

        COUNT(*) AS Total_Employees,

        SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) AS Employees_Left

    FROM hrdata
    GROUP BY Age_Group
) AS Age_Analysis
ORDER BY Attrition_Rate DESC;

-- Which job roles have the highest employee attrition?
SELECT 
    Position,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM hrdata
GROUP BY Position
ORDER BY Attrition_Rate DESC
LIMIT 1;

-- How does job satisfaction affect attrition?
SELECT
    EmpSatisfaction AS Job_Satisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM hrdata
GROUP BY EmpSatisfaction
ORDER BY EmpSatisfaction;

-- Performace parameters
SELECT DISTINCT PerformanceScore as PerforParmeters
FROM hrdata
ORDER BY PerformanceScore;

-- Count of PerformanceScore Individualy
SELECT 
    PerformanceScore,
    COUNT(*) AS Employee_Count
FROM hrdata
GROUP BY PerformanceScore;

-- Does marital status have any relationship with attrition? ATTRITION Analysis
SELECT 
    MaritalDesc,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM hrdata
GROUP BY MaritalDesc
ORDER BY Attrition_Rate DESC;

-- What is the average job satisfaction score by department?
SELECT 
    Department,
    ROUND(AVG(EmpSatisfaction), 2) AS Average_Job_Satisfaction
FROM hrdata
GROUP BY Department
ORDER BY Average_Job_Satisfaction DESC;

-- Which Department is the Highest job satisfaction?
SELECT 
     Department,
     SUM(EmpSatisfaction) AS Higest_JobSatisfy
From hrdata
GROUP BY Department 
ORDER BY Higest_JobSatisfy DESC;

-- Which job role has the lowest job satisfaction?
SELECT
     Position,
     SUM(EmpSatisfaction) AS Low_Satisfaction
FROM hrdata
GROUP BY Position
ORDER BY Low_Satisfaction ASC;
      
-- Reasons to Leave the Company
SELECT 
     DISTINCT TermReason as Reasonleave
FROM hrdata
ORDER BY ReasonLeave;

-- Which recruitment source has hired the most employees?
SELECT 
      DISTINCT RecruitmentSource as Source
FROM hrdata
GROUP BY RecruitmentSource 
ORDER BY Source DESC;

-- 
SELECT 
    Department,
    AVG(EngagementSurvey) AS Average_Engagement
FROM hrdata
GROUP BY Department
ORDER BY Average_Engagement DESC;

-- Which employees have handled the highest number of special projects?
SELECT 
    `Employee Name`,
    SpecialProjectsCount
FROM hrdata
ORDER BY SpecialProjectsCount DESC;













