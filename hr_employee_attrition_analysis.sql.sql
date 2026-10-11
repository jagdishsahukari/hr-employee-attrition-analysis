-- Employee Attrition & Workforce Analysis

CREATE DATABASE employee_attrition_analysis; 
USE employee_attrition_analysis;

SELECT * FROM employee_attrition;

-- 1. Display the first 10 rows from the table. 
SELECT * 
FROM employee_attrition
LIMIT 10;

/*
Insight: Displays the first 10 employee records for a quick inspection of the table.
*/

-- 2. Find the total number of employees in the company. 

SELECT COUNT(*) AS employee_count
FROM employee_attrition;

/*
Insight: The company has 1,470 employees in the dataset.
*/

-- 3. List all unique departments. 

SELECT DISTINCT(department)
FROM employee_attrition;

/*
The Unique Departments Are:
Human Resources
Research & Development
Sales
Department Structure: The workforce is represented across three departments: Research & Development, Sales, and Human Resources.
*/

-- 4. Show how many employees have left the company and how many are still working.
SELECT 
	COUNT(CASE WHEN attrition = "Yes" THEN 1 END)AS employee_left_count,
    COUNT(CASE WHEN attrition = "No" THEN 1 END) AS employee_working_count
FROM employee_attrition;

SELECT 
	attrition,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY attrition;
 
 /*
 Insight: 237 employees have left, while 1,233 remain.
 */
 
-- 5. Retrieve the list of employees who work overtime. 
SELECT 
	COUNT(*) AS employee_count
FROM employee_attrition
WHERE overtime = "Yes";

SELECT *
FROM employee_attrition
WHERE overtime = "Yes";

SELECT 
	employeenumber,
    age,
    department,
    jobrole,
    overtime
FROM employee_attrition
WHERE overtime = "Yes";

/*
Insight: Returns all employees currently working overtime.
*/

-- 6. Find the average monthly income of all employees. 

SELECT 
	ROUND(AVG(monthlyincome),2) AS average_monthly_income
FROM employee_attrition;

/*
insight : The average monthly income of all employees is approximately 6502.93
*/

-- 7. Identify employees whose number of companies worked is missing (NULL). 
SELECT 
	*
FROM employee_attrition
WHERE numcompaniesworked IS NULL; 

/*
Insight: The cleaned dataset contains no missing values in NumCompaniesWorked.
*/

-- 8. Find the employee(s) with the maximum monthly income. 

SELECT *
FROM employee_attrition
WHERE monthlyincome = (
	SELECT MAX(monthlyincome)
    FROM employee_attrition
);

SELECT 
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    Attrition
FROM employee_attrition
WHERE MonthlyIncome = (
    SELECT MAX(MonthlyIncome)
    FROM employee_attrition
);

/*
Highest Monthly Income: The highest monthly income in the dataset is 19,999, recorded for an employee in the Research & Development department working as a Manager. This employee has not left the company.
*/

-- 9. Count the number of employees by gender. 

SELECT 
	COUNT(CASE WHEN gender = "Male" THEN 1 END) AS male_employee_count,
    COUNT(CASE WHEN gender = "Female" THEN 1 END) AS female_employee_count
FROM employee_attrition;

SELECT 
	gender,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY gender;

/*
Insight : The Number of empoloyees by gender is:
Female = 588
Male   = 882

Gender Composition: The workforce consists of 60% male employees and 40% female employees, indicating that male employees represent the larger share of the recorded workforce.
*/

-- 10. List all employees who have just joined (YearsAtCompany = 0). 

SELECT *
FROM employee_attrition
WHERE yearsatcompany = 0;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany
FROM employee_attrition
WHERE YearsAtCompany = 0;

/*
Insight: Identifies employees who have completed less than one year at the company.
*/

-- 11. Calculate the attrition rate (%) by department. 

SELECT 
	department,
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS leavers,
    ROUND(COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM employee_attrition
GROUP BY department
ORDER BY attrition_rate DESC;

/*
Insight: Observed attrition rates vary across departments.
1.Department Attrition: Observed attrition varies across departments. Sales has an observed attrition rate of 20.63%, followed by Human Resources at 19.05%, while Research & Development has the lowest observed attrition rate at 13.84%.
2.Sales accounts for the largest number of leavers (92) among the three departments, while Research & Development has the largest workforce and 133 leavers.
3.Human Resources has an observed attrition rate of 19.05%, although the department has a relatively small workforce of 63 employees.
*/

-- 12. List the top 10 employees with the highest total working years.
SELECT *
FROM employee_attrition
ORDER BY totalworkingyears DESC
LIMIT 10;

SELECT
    EmployeeNumber,
    Age,
    JobRole,
    TotalWorkingYears
FROM employee_attrition
ORDER BY TotalWorkingYears DESC
LIMIT 10;

/*
Insight: Identifies the 10 most experienced employees based on total working years.
Highly Experienced Employees: The top 10 employees have 36–40 years of total working experience, with the highest experience being 40 years. These employees are predominantly in senior or managerial roles, reflecting a group of highly experienced employees within the workforce.
*/
 
-- 13. Group employees into tenure categories (<1yr, 1–3yr, 4–6yr, 7+yr) and count employees in each. 

SELECT 
	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END AS tenure_category,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY tenure_category
ORDER BY 	
    CASE tenure_category
        WHEN '<1yr' THEN 1
        WHEN '1-3yr' THEN 2
        WHEN '4-6yr' THEN 3
        WHEN '7+yr' THEN 4
    END;

SELECT 
	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END AS tenure_category,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY tenure_category
ORDER BY 	CASE 
		WHEN yearsatcompany < 1 THEN "<1yr" 
        WHEN yearsatcompany BETWEEN 1 AND 3 THEN "1-3yr"
        WHEN yearsatcompany BETWEEN 4 AND 6 THEN "4-6yr"
		ELSE "7+yr"
	END ASC;
	
/*
Insight: Shows how the workforce is distributed across company-tenure groups.
Tenure Distribution: The workforce is concentrated in longer-tenure employees, with 42.04% having 7+ years at the company. Employees with 1–3 years represent 28.98%, while 25.99% have 4–6 years and only 2.99% have less than one year of recorded tenure.
*/

-- 14. Find the average monthly income by job level and attrition status. 

SELECT 
	joblevel,
    attrition,
    COUNT(*) AS employee_count,
    ROUND(AVG(monthlyincome),2) AS average_monthly_income
FROM employee_attrition
GROUP BY joblevel,attrition 
ORDER BY joblevel,attrition;

/*
Insight: Shows how income differs across JobLevels for employees who stayed versus those who left.
Job Level and Compensation: Average monthly income increases substantially with JobLevel, from approximately 2,854 at Level 1 to 19,171 at Level 5 among employees who stayed. Within individual job levels, income differences between employees who stayed and those who left are generally smaller and are not consistent across all levels.
*/

-- 15. Identify the top 5 job roles with the highest number of employees who left.

SELECT 
	jobrole,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS employees_left_count
FROM employee_attrition
GROUP BY jobrole
ORDER BY employees_left_count DESC
LIMIT 5;

SELECT
    JobRole,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY employees_left DESC
LIMIT 5;
 
/*
Insight: Identifies the JobRoles contributing the largest number of leavers in absolute count.
Leavers by Job Role: Laboratory Technicians have the highest number of recorded leavers (62), followed by Sales Executives (57) and Research Scientists (47). Sales Representatives recorded 33 leavers, while Human Resources recorded 12.
*/ 

-- 16. List employees who left the company within their first year. 

SELECT 
	*
FROM employee_attrition
WHERE attrition = "Yes"
AND yearsatcompany < 1;

SELECT COUNT(*) count_of_employees
FROM employee_attrition
WHERE attrition = "Yes"
AND yearsatcompany < 1;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    Attrition
FROM employee_attrition
WHERE Attrition = 'Yes'
AND YearsAtCompany < 1;

/*
Insight: Identifies employees who left before completing one year at the company.
Early Attrition: 16 employees in the dataset left with less than one recorded year at the company. These early leavers are found across both Research & Development and Sales, with Laboratory Technician and Sales Representative roles appearing multiple times.
*/

-- 17. Calculate each employee’s approximate new monthly compensation after applying their salary hike percentage.

SELECT 
	monthlyincome,
    monthlyincome * percentsalaryhike / 100.0 AS hike,
	monthlyincome + monthlyincome * percentsalaryhike / 100.0 AS new_monthly_income
FROM employee_attrition;

SELECT
    EmployeeNumber,
    MonthlyIncome,
    PercentSalaryHike,
    ROUND(MonthlyIncome * (1 + PercentSalaryHike / 100),2) AS approximate_new_monthly_income
FROM employee_attrition;

/*
Insight: Estimates monthly income after applying the recorded salary-hike percentage.
Estimated Compensation After Salary Hike: Applying each employee's recorded salary-hike percentage to their current monthly income produces an estimated new monthly compensation for comparison purposes. The calculation shows how the same percentage hike results in different absolute income increases depending on the employee's current income.
*/

-- 18. Count employees grouped by overtime status and attrition. 

SELECT
	overtime, 
    attrition,
	COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY overtime, attrition
ORDER BY overtime, attrition;

/*
Insight: Shows the distribution of employees across overtime and attrition status.
Overtime and Attrition: Employees who worked overtime had an observed attrition rate of 30.53%, compared with 10.44% among employees who did not work overtime. This shows a substantial difference in observed attrition between the two overtime groups.
*/

-- 19. Display the top 10 employees who attended the most training sessions last year. 

SELECT *
FROM employee_attrition
WHERE trainingtimeslastyear = (
	SELECT max(trainingtimeslastyear)
    FROM employee_attrition
)
LIMIT 10;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    TrainingTimesLastYear
FROM employee_attrition
ORDER BY TrainingTimesLastYear DESC
LIMIT 10;

/*
Insight: Identifies employees with the highest number of training sessions last year.
Training Participation: The top 10 employees attended 6 training sessions last year, which is the highest recorded training frequency in the dataset. These employees span multiple departments and job roles, indicating that the highest training participation is not limited to a single role or department.
*/

-- 20. Rank employees by total working years (most experienced = rank 1).

SELECT 
	*,
    RANK() OVER(ORDER BY totalworkingyears DESC) AS experience_rank
FROM employee_attrition;

SELECT
    EmployeeNumber,
    Age,
    JobRole,
    TotalWorkingYears,
    RANK() OVER (ORDER BY TotalWorkingYears DESC) AS experience_rank
FROM employee_attrition; 

/*
Insight: Rank 1 represents employees with the highest total working experience.
Experience Ranking: Employees were ranked by total working experience, with the most experienced employees receiving rank 1. Employees with equal total working years receive the same rank.
*/

-- 21. For each department, find employees whose monthly income is in the top 25% of that department. 

WITH cte AS(
	SELECT
		employeenumber,
		department,
		monthlyincome,
		PERCENT_RANK() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS percent_rnk,
		CUME_DIST() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS cume_dist_,
		NTILE(4) OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS quartile
	FROM employee_attrition
)
SELECT *
FROM cte 
WHERE quartile = 1
ORDER BY monthlyincome DESC;

/*
Insight: Identifies employees whose income falls within approximately the highest 25% of their respective department.
The analysis identifies the highest-income employee segment within each department, providing a basis for comparing compensation distribution across departments.
*/

-- 22. Divide employees into 10 income deciles and find attrition rate for each decile. 

WITH cte AS(
	SELECT *,
		NTILE(10) OVER(ORDER BY monthlyincome ASC) AS income_deciles
	FROM employee_attrition
)
SELECT 
	income_deciles,
    ROUND(AVG(monthlyincome),2) AS avg_monthly_income,
    COUNT(*) AS employee_count,
	COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS leavers,
    ROUND(COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*),2) AS attrition_rate
FROM cte 
GROUP BY income_deciles
ORDER BY income_deciles;	

WITH income_deciles AS (
    SELECT
        EmployeeNumber,
        MonthlyIncome,
        Attrition,
        NTILE(10) OVER (ORDER BY MonthlyIncome) AS income_decile
    FROM employee_attrition
)
SELECT
    income_decile,
    COUNT(*) AS employee_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2) AS attrition_rate
FROM income_deciles
GROUP BY income_decile
ORDER BY income_decile;

/*
Insight: Shows how observed attrition varies across the employee income distribution.
1 represents the lowest income decile and 10 the highest.
Income Decile & Attrition: Attrition is highest among employees in the two lowest income deciles, at 31.29% each, and generally declines as income increases. The highest-income decile has the lowest observed attrition rate at 3.40%, compared with 31.29% in the lowest two deciles.
*/

-- 23. Create a simple risk score based on tenure, performance, overtime, and work-life balance —and list the top 50 high-risk employees. 

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    PerformanceRating,
    OverTime,
    WorkLifeBalance,
    (
        CASE
            WHEN OverTime = 'Yes' THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN YearsAtCompany < 3 THEN 2
            ELSE 0
        END
        +
        CASE
            WHEN PerformanceRating = 3 THEN 1
            ELSE 0
        END
        +
        CASE
            WHEN WorkLifeBalance <= 2 THEN 2 
            ELSE 0 
		END) AS risk_score
FROM employee_attrition
ORDER BY risk_score DESC
LIMIT 50;

SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    YearsAtCompany,
    PerformanceRating,
    OverTime,
    WorkLifeBalance,
    (
        CASE WHEN OverTime = 'Yes' THEN 2 ELSE 0 END
        +
        CASE WHEN YearsAtCompany < 3 THEN 2 ELSE 0 END
        +
        CASE WHEN WorkLifeBalance <= 2 THEN 2 ELSE 0 END
    ) AS risk_score
FROM employee_attrition
ORDER BY risk_score DESC
LIMIT 50;

/*
Insight: Produces a list of employees who meet more of the selected business-rule conditions.
Important: This score should be described as a custom analytical score, not as a prediction that these employees will leave.
A custom rule-based HR risk score was created using factors that showed notable associations with observed attrition in the EDA. The score is an analytical prioritization tool and is not a predictive model or probability of employee attrition.
*/
-- 24. Create a summary view showing, for each department and job level: total employees, number of leavers, attrition rate, and average monthly income.

SELECT 
	department,
    joblevel,
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) AS no_of_leavers,
    COUNT(CASE WHEN attrition = "Yes" THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate,
    AVG(monthlyincome) AS average_monthly_income
FROM employee_attrition
GROUP BY department,joblevel
ORDER BY department,joblevel;

CREATE VIEW department_joblevel_summary AS
SELECT
    Department,
    JobLevel,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) AS number_of_leavers,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0 
			END) * 100.0 / COUNT(*),2) AS attrition_rate,
	ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM employee_attrition
GROUP BY Department, JobLevel;

SELECT *
FROM department_joblevel_summary
ORDER BY department,joblevel;

/*
Insight: Creates a reusable summary showing employee count, leavers, attrition rate, and average income for every Department + JobLevel combination.
Department and Job Level Analysis: Attrition is particularly high among lower-level employees, with Sales Job Level 1 showing the highest observed attrition rate at 42.11%. R&D Job Level 1 also shows a notable 23.27% rate across a much larger employee group. Meanwhile, average monthly income increases substantially with job level across departments. These results show meaningful differences in attrition and compensation across employee segments, but do not establish causation.
*/

-- key Insights
/*
Key Insights:
• Attrition varies considerably across different department and job-level combinations.
• Sales Job Level 1 has the highest observed attrition rate at 42.11%, with 32 leavers out of 76 employees.
• Research & Development Job Level 1 has an observed attrition rate of 23.27%, with 101 leavers out of 434 employees. This is an important group due to its large employee population.
• Human Resources Job Level 3 shows an observed attrition rate of 33.33%, but the group contains only 6 employees, so the rate should be interpreted cautiously.
• Average monthly income increases substantially with Job Level across all three departments, from approximately 2,500–2,840 at Level 1 to more than 19,000 at Level 5.
• Higher job levels generally show lower observed attrition, particularly in Research & Development, where Job Level 4 has an observed attrition rate of 1.47%.
• Overall, the analysis shows meaningful differences in attrition and compensation across department and job-level segments, but these are observed associations and do not establish causation.
*/

-- Overall Key Insights — SQL Analysis

/*
Key Insights:
• The dataset contains 1,470 employee records across three departments: Research & Development, Sales, and Human Resources.
• Overall, 237 employees have left the company, resulting in an observed attrition rate of 16.12%.
• The workforce is distributed across different departments, job roles, job levels, income groups, and tenure categories, providing multiple dimensions for workforce analysis.
• Sales has the highest observed departmental attrition rate at 20.63%, followed by Human Resources at 19.05% and Research & Development at 13.84%.
• Employees working overtime have a substantially higher observed attrition rate of 30.53%, compared with 10.44% among employees who do not work overtime.
• Job role shows considerable variation in the number and rate of employee attrition. Laboratory Technicians have the highest number of leavers, while Sales Representatives have the highest observed attrition rate among job roles at 39.76%.
• Employees with shorter tenure represent an important attrition segment. 16 employees who left had less than one recorded year at the company.
• The workforce contains a large proportion of longer-tenure employees, with 42.04% having 7 or more recorded years at the company.
• Average monthly income increases substantially with Job Level, ranging from approximately 2,854 at Level 1 to approximately 19,171 at Level 5 among employees who stayed.
• Department and Job Level combinations reveal additional differences in attrition. Sales Job Level 1 has the highest observed attrition rate at 42.11%, with 32 leavers out of 76 employees.
• Research & Development Job Level 1 has 101 leavers and an observed attrition rate of 23.27%, making it an important segment because of its large employee population.
• Employees in the lowest income deciles show substantially higher observed attrition. The first and second income deciles both have an attrition rate of 31.29%, while the highest income decile has the lowest observed attrition rate at 3.40%.
• Attrition varies across income groups but does not decrease perfectly across every income decile, indicating that the relationship is not strictly monotonic.
• Employees who left generally have lower average monthly income and fewer years of total work experience and company tenure compared with employees who stayed.
• The SQL analysis also identified differences in attrition across employee characteristics such as department, job role, job level, overtime, tenure, and income.
• A rule-based HR risk score can be used to prioritize employee segments for further review, but it should be treated as an analytical scoring framework rather than a predictive attrition model.
• Overall, the SQL analysis provides business-focused insights into workforce composition, compensation, tenure, and observed attrition patterns that can be further explored and presented through the Power BI dashboard.
• These findings represent observed patterns and associations within the dataset and should not be interpreted as proof that any individual factor directly causes employee attrition.
*/
