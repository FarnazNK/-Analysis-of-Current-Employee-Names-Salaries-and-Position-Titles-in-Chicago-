SELECT TOP (10) [Name]
      ,[Job Titles]
      ,[Department]
      ,[Full or Part-Time]
      ,[Salary or Hourly]
      ,[Typical Hours]
      ,[Annual Salary]
      ,[Hourly Rate]
  FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]

--convert the value of the Name, department and  job titles to the propper
  UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Name] = STUFF(LOWER( [Name]), 1, 1, UPPER(LEFT([Name], 1)))

UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Department] = STUFF(LOWER( [Department]), 1, 1, UPPER(LEFT([Department], 1)))

UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Job Titles] = STUFF(LOWER( [Job Titles]), 1, 1, UPPER(LEFT([Job Titles], 1)))


--fill the null values in all columns
SELECT [Name], [Job Titles], [Department], [Full or Part-Time], [Salary or Hourly], [Typical Hours], [Annual Salary], [Hourly Rate]
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
WHERE [Name] IS NULL OR [Job Titles] IS NULL OR [Department] IS NULL OR [Full or Part-Time] IS NULL OR [Salary or Hourly] IS NULL OR [Typical Hours] IS NULL OR [Annual Salary] IS NULL OR [Hourly Rate] IS NULL


--fill the null values in the [Full or Part-Time] column based on the [Name] column
UPDATE [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
SET [Full or Part-Time] =
  CASE 
    WHEN [Name] = 'John Doe' THEN 'Full-Time'
    WHEN [Name] = 'Jane Doe' THEN 'Part-Time'
    ELSE [Full or Part-Time]
  END
WHERE [Full or Part-Time] IS NULL;

-- find the number of unique value in each column as a table?
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


-- find the duplicate
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


-- find the count of each unique value in multiple columns of a table
SELECT [Department], [Job Titles], [Salary or Hourly], [Full or Part-Time], COUNT(*) as count
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Department], [Job Titles], [Salary or Hourly], [Full or Part-Time]
ORDER BY count DESC


-- find the count of each unique value in Job Titles columns of a table
SELECT [Job Titles], COUNT(*) as count
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Job Titles]
ORDER BY count DESC


--What is the average salary for each job title?
SELECT 
  [Job Titles], 
  AVG([Annual Salary]) AS avg_salary
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
GROUP BY [Job Titles]
ORDER BY avg_salary DESC;


---How many employees are there in each company?
SELECT Department, COUNT(*) as number_of_employees
FROM [chicago_employer].[dbo].[Current_Employee_Names__Salarie$]
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

--This code gave a list of departments and the average salary for each department. 


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
