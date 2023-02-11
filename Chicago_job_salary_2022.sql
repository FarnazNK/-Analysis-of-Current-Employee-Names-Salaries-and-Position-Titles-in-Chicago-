SELECT TOP (5) [Name]
      ,[Job Titles]
      ,[Department]
      ,[Full or Part-Time]
      ,[Salary or Hourly]
      ,[Typical Hours]
      ,[Annual Salary]
      ,[Hourly Rate]
  FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]


-- Results:

--Name                |Job Titles                 |Department                             |Full or Part-Time  |Salary or Hourly |Typical Hours|Annual Salary|Hourly Rate
----------+--------+----------+--------+-------- --+--------+----------+--------+----------+--------+----------+--------+--------+----------+--------+--------+
--Boyking jr, james l|Pool motor truck driver	        |Dept streets and sanitation    	|F                  |HOURLY|	          |40|	    |NULL|	      |39.25
--Mis, stephen j	   |Firefighter-emt (recruit)	        |Fire department	            |F                  |SALARY             |NULL	    |76122	      |NULL
--Davis, motisola	   |Pool motor truck driver	        |Department of aviation       	|F	              |HOURLY             |40	    |NULL	      |39.25
--Johnson, elisha q  |Police communications operator ii |Office of emergency management	|F	              |SALARY             |NULL	    |78384	      |NULL
--Swann, pamela b	   |Accounting technician	        |Department of aviation          	|F	              |SALARY             |NULL	    |85344	      |NULL


--Convert the value of the Name, department and  job titles to the propper
  UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Name] = STUFF(LOWER( [Name]), 1, 1, UPPER(LEFT([Name], 1)))

UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Department] = STUFF(LOWER( [Department]), 1, 1, UPPER(LEFT([Department], 1)))

UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Job Titles] = STUFF(LOWER( [Job Titles]), 1, 1, UPPER(LEFT([Job Titles], 1)))


--Find the number of null values in each column
  SELECT 
    SUM(CASE WHEN [Name] IS NULL THEN 1 ELSE 0 END) AS [Name_NULLs],
    SUM(CASE WHEN [Job Titles] IS NULL THEN 1 ELSE 0 END) AS [Job_Titles_NULLs],
    SUM(CASE WHEN [Department] IS NULL THEN 1 ELSE 0 END) AS [Department_NULLs],
    SUM(CASE WHEN [Full or Part-Time] IS NULL THEN 1 ELSE 0 END) AS [Full_or_Part_Time_NULLs],
    SUM(CASE WHEN [Salary or Hourly] IS NULL THEN 1 ELSE 0 END) AS [Salary_or_Hourly_NULLs],
    SUM(CASE WHEN [Typical Hours] IS NULL THEN 1 ELSE 0 END) AS [Typical_Hours_NULLs],
    SUM(CASE WHEN [Annual Salary] IS NULL THEN 1 ELSE 0 END) AS [Annual_Salary_NULLs],
    SUM(CASE WHEN [Hourly Rate] IS NULL THEN 1 ELSE 0 END) AS [Hourly_Rate_NULLs]
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$];


--Fill the null values in all columns
SELECT [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate]
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
WHERE [Name] IS NULL OR [Job Titles] IS NULL OR [Department] IS NULL OR [Full or Part-Time] IS NULL OR [Salary or Hourly] IS NULL OR [Typical Hours] IS NULL OR [Annual Salary] IS NULL OR [Hourly Rate] IS NULL


-- Find the number of unique value in each column as a table
SELECT 
    COUNT(DISTINCT [Name]) AS [Name_Unique],
    COUNT(DISTINCT [Job Titles]) AS [Job Titles_Unique],
    COUNT(DISTINCT [Department]) AS [Department_Unique],
    COUNT(DISTINCT [Full or Part-Time]) AS [Full or Part-Time_Unique],
    COUNT(DISTINCT [Salary or Hourly]) AS [Salary or Hourly_Unique],
    COUNT(DISTINCT [Typical Hours]) AS [Typical Hours_Unique],
    COUNT(DISTINCT [Annual Salary]) AS [Annual Salary_Unique],
    COUNT(DISTINCT [Hourly Rate]) AS [Hourly Rate_Unique]
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]


-- Find the duplicate
WITH CTE AS (
    SELECT [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate],
           ROW_NUMBER() OVER (PARTITION BY [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate] ORDER BY (SELECT NULL)) AS RN
    FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
)
SELECT [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate]
FROM CTE
WHERE RN > 1

--- remove duplicates
WITH CTE AS (
    SELECT [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate],
           ROW_NUMBER() OVER (PARTITION BY [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate] ORDER BY (SELECT NULL)) AS RN
    FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
)
DELETE FROM CTE
WHERE RN > 1


-- Find the count of each unique value in multiple columns of a table
SELECT [Department], [Job Titles], [Salary or Hourly], [Full or Part-Time], COUNT(*) as count
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Department], [Job Titles], [Salary or Hourly], [Full or Part-Time]
ORDER BY count DESC

-- Find the count of each unique value in Job Titles columns of a table
SELECT [Job Titles], COUNT(*) as count
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Job Titles]
ORDER BY count DESC


--What is the number of employees in each Job Titles by the Department and Full or Part-Time?
SELECT [Job Titles], [Full or Part-Time], [Department], COUNT(*)
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Job Titles], [Full or Part-Time], [Department];


--What is the average salary for each job title?
SELECT 
  [Job Titles], 
  AVG([Annual Salary]) AS avg_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Job Titles];


---How many employees are there in each company?
SELECT Department, COUNT(*) as number_of_employees
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY Department;


--What is the average number of employees in each company?
WITH company_counts AS (
SELECT Department, COUNT(*) as number_of_employees
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY Department
)
SELECT Department, AVG(number_of_employees) as average_number_of_employees
FROM company_counts
GROUP BY Department;


--What is the distribution of job titles in each company?
SELECT Department, [Job Titles], COUNT(*) as number_of_employees
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY Department, [Job Titles];


---How does the salary vary between different job titles within the same company?
SELECT Department, [Job Titles], AVG([Annual Salary]) as average_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY Department, [Job Titles];


--Are there any companies that pay significantly higher or lower salaries compared to others?
WITH department_salaries AS (
SELECT Department, AVG([Annual Salary]) as average_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
WHERE [Salary or Hourly] = 'Salary'
GROUP BY Department
)
SELECT Department, average_salary
FROM department_salaries
ORDER BY average_salary DESC;


--which job titles in companies have the highest average?
WITH department_salaries AS (
SELECT Department, [Job Titles], AVG([Annual Salary]) as average_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
WHERE [Salary or Hourly] = 'Salary'
GROUP BY Department, [Job Titles]
)
SELECT Department, [Job Titles], average_salary
FROM department_salaries
ORDER BY average_salary DESC;
--It creates a derived table named "department_salaries" which groups the salary data by department and job title,
--calculates the average salary for each group, and then orders the results in descending order of average salary, 
--so the highest average salary is displayed first.


--What is the percentage of impact that the "Full or Part-Time" status has on the average annual salary?
WITH full_part_salaries AS (
SELECT [Full or Part-Time], AVG([Annual Salary]) as average_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Full or Part-Time]
)
SELECT [Full or Part-Time], (average_salary / (SELECT SUM(average_salary) FROM full_part_salaries)) * 100 AS percentage_of_total
FROM full_part_salaries
ORDER BY average_salary DESC;


