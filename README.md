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

The data shows the average salary for different departments within an organization. The departments with the highest salaries are the CPSA, Board of Ethics, and Department of Buildings, which have average salaries of $124,065, $114,428, and $113,449 respectively. On the other hand, the departments with the lowest salaries are the Board of Election Commissioners, with an average salary of $60,881, and Commission on Animal Care and Control, with an average salary of $73,183.

The data reveals a wide variation in salaries across the different departments, with some departments having much higher salaries than others. The reasons for these disparities could be due to the size of the departments, the responsibilities of employees, or the level of education and experience required.

This information could be used to make decisions about staffing levels, compensation structures, and resource allocation within the organization. For example, it could highlight departments that may be underfunded or understaffed, and suggest areas for improvement in the HR policies and compensation systems.
