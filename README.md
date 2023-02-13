datasets: https://data.cityofchicago.org/Administration-Finance/Current-Employee-Names-Salaries-and-Position-Title/xzkq-xp2w/data

This data contains information about employees. The following is a description of the columns:

Name: The name of the employee.
Job Titles: The title of the employee's job.
Department: The department the employee works in.
Full or Part-Time: Whether the employee is a full-time or part-time worker.
Salary or Hourly: Indicates if the employee is paid on a salary or hourly basis.
Typical Hours: The average number of hours worked per week by the employee. This column contains float64 data type values.
Annual Salary: The employee's annual salary, if they are paid on a salary basis. This column contains float64 data type values.
Hourly Rate: The employee's hourly rate, if they are paid on an hourly basis. This column contains float64 data type values.
Note: Some rows may have missing values, especially in the columns that are not relevant to the employee's pay structure. For example, if the employee is paid on a salary basis, the "Hourly Rate" column will have a missing value.

The number of missing values in the "Hourly Rate" and "Typical Hours" columns is quite high, so I did not include these columns in my analysis.

In this repository, I have performed a data analysis to understand the current employee salaries and their distribution across different companies and job titles. The analysis was performed using SQL and I have answered the following questions:

What is the average salary for each job title?

How many employees are there in each company?

What is the average number of employees in each company?

What is the distribution of job titles in each company?

How does the salary vary between different job titles within the same company?

Are there any companies that pay significantly higher or lower salaries compared to others?

which job titles in companies have the highest average?

What is the percentage of impact that the "Full or Part-Time" status has on the average annual salary?

The results of the analysis were obtained through SQL queries and were presented in a clear and concise manner for easy understanding. I believe this analysis will be valuable for HR departments, executives, and employees looking to understand the current state of salaries in different companies and job titles.
