# HR Employee Attrition Analysis

**Python • SQL • Power BI**

An end-to-end analysis of employee attrition for a 1,470-employee dataset. I cleaned and explored the data in Python, answered 24 business questions in SQL, and built a 4-page Power BI dashboard to show which employee groups leave most often.

## Business Problem

Employee turnover is costly. HR needs to know **who is leaving, in which parts of the organization, and which work and pay factors are linked to leaving**, so retention efforts can be aimed at the right groups instead of the whole workforce.

## Key Findings

- **Overall attrition is 16.12%.** 237 of 1,470 employees left.
- **Overtime shows the biggest gap.** Employees working overtime left at **30.53%**, versus **10.44%** for those who did not.
- **Sales has the highest department attrition.** Sales is at 20.63%, Human Resources 19.05% and Research & Development 13.84%.
- **Sales Representatives leave most often by role.** Their attrition rate is 39.76%. Laboratory Technicians have the highest number of leavers (62).
- **Entry-level Sales is the highest-risk segment.** Sales Job Level 1 has a 42.11% attrition rate (32 of 76 employees). R&D Job Level 1 has 23.27%, which is 101 leavers from a much larger group.
- **Lower pay goes with higher attrition.** The two lowest income deciles each show 31.29% attrition, against 3.40% in the highest decile. The median monthly income of leavers is 3,202, compared with 5,204 for those who stayed.
- **Leavers are younger and newer.** Median age is 32 for leavers and 36 for stayers. Median years at the company is 3 for leavers and 6 for stayers.
- **Engagement matters.** Attrition is 33.73% at the lowest job involvement level, against 9.03% at the highest.

> These are **observed patterns, not proof of cause**. A small segment (for example HR Job Level 3, with 6 employees) should be read with caution.

## Recommendations

1. **Review overtime workloads**, starting with the roles where overtime and attrition are both high. The overtime gap is the largest one found in the data.
2. **Focus retention on entry-level Sales and Sales Representatives**, where attrition is highest. Look at pay, targets and career paths for these roles.
3. **Look at early-career pay and growth.** Attrition is concentrated in lower income and lower job level groups, so check how pay compares across levels.
4. **Support new joiners.** 16 employees left within their first year. A structured onboarding and early check-in could help.
5. **Track job involvement and satisfaction.** Low involvement and satisfaction scores show higher attrition and could serve as early signals.
6. **Use the risk score only for prioritizing.** The rule-based score in the SQL file (overtime, tenure, work-life balance) is a way to decide which groups to review first. It is **not** a prediction model.

## Tools and Workflow

| Step | Tool | What I did |
|---|---|---|
| 1. Understand and clean | Python (Pandas, NumPy) | Checked the structure, missing values and duplicates |
| 2. Explore | Python (Matplotlib, Seaborn) | Univariate, bivariate and multivariate analysis with 15 charts |
| 3. Query | SQL (MySQL) | 24 business questions: window functions, CTEs, a summary view |
| 4. Visualize | Power BI | 4-page interactive dashboard |

## Dataset

- **Rows:** 1,470 employees
- **Columns:** 35 (age, department, job role, monthly income, overtime, job satisfaction, attrition and more)
- **Format:** CSV

See the `data/` folder for dataset notes.

## Power BI Dashboard

The dashboard has four pages: Employee Overview, Attrition Deep Dive, Workforce & Compensation, and Key Insights. It includes slicers for department, job role, gender, business travel and overtime.

### Employee Overview
![HR Employee Overview](screenshots/hr_attrition_employee_overview.png)

### Attrition Deep Dive
![HR Attrition Deep Dive](screenshots/hr_attrition_attrition_deep%20dive.png)

### Workforce and Compensation
![HR Attrition Workforce and Compensation](screenshots/hr_attrition_workforce%20%26%20compensation.png)

### Key Insights
![HR Attrition Key Insights](screenshots/hr_attrition_key%20insights.png)

## SQL Highlights

A few of the 24 queries in [`hr_employee_attrition_analysis.sql`](hr_employee_attrition_analysis.sql):

- **Attrition rate by department:** `COUNT(CASE WHEN ...)` with `GROUP BY` to compare departments.
- **Income deciles:** `NTILE(10)` in a CTE to compare attrition across ten income groups.
- **Top earners in each department:** `NTILE(4) OVER (PARTITION BY department ...)`.
- **Experience ranking:** `RANK() OVER (...)`.
- **Risk score:** a rule-based score built with `CASE WHEN` logic.
- **Reusable summary:** a `department_joblevel_summary` view with employees, leavers, attrition rate and average income.

## Project Files

- [Python notebook](hr_employee_attrition_analysis.ipynb)
- [SQL queries](hr_employee_attrition_analysis.sql)
- [Power BI dashboard](hr_employee_attrition_dashboard.pbix) (open in Power BI Desktop)
- [Dashboard screenshots](screenshots)
- [Dataset](data)

## How to Run

1. Open the notebook in Jupyter (Python 3 with Pandas, NumPy, Matplotlib and Seaborn installed).
2. Place the dataset CSV in the same folder as the notebook.
3. For SQL, load the data into a MySQL table named `employee_attrition`, then run the queries.
4. Open the `.pbix` file in Power BI Desktop.

## Author

**Jagdish Sahukari**
[LinkedIn](https://www.linkedin.com/in/jagdish-sahukari-49064b312) • [GitHub](https://github.com/jagdishsahukari)
