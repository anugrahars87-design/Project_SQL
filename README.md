## introduction
This project focuses on exploring the relationship between in-demand skills and average salaries for Data Analyst roles in remote work settings. By leveraging structured job postings data, the analysis identifies which technical skills are most frequently requested by employers and how these skills influence compensation levels.
## Objectives
- To determine the top skills required for Data Analyst positions.
- To measure the frequency of demand for each skill across job postings.
- To calculate the average salary associated with each skill.
- To provide actionable insights for job seekers and organizations on aligning skill development with market trends.
## Methodology
- Data Source: Job postings dataset containing job titles,
              work arrangements,salaries, and required skills,companys name.
- Tools Used: SQL for data extraction and aggregation;
             Excel/ visualization tools for presenting results.
- Approach:
         Created five analytical views

             1 - top paying job with remote work
             2 - top paying skill for specific job
             3 - top paying skills  in specific location
             4 - top demanded skills
             5 - skills with top demand and top salary for data analyst


### sql queries :
 [project folder](/project/)

 # Tools Used
## SQL
- Core language for querying and analyzing structured job postings data.
- Used to join tables, aggregate skill demand, and calculate average salaries.
- PostgreSQL
- Relational database management system where the dataset was stored and queried.
- Provided advanced functions (e.g., ROUND, CTEs) for efficient data manipulation.
## GitHub
- Version control and collaboration platform.
- Used to manage SQL scripts, track changes, and document the project workflow.
## postgress
- This project uses SQL with PostgreSQL for data analysis and GitHub for version control and collaboration.

# Analysis
   
   - ## top paying job

```sql
select 
job_id,
job_title_short,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date,
new_name as company_name
FROM 
job_postings_fact
LEFT JOIN company_dim on company_dim.company_id=job_postings_fact.company_id
WHERE job_title_short ='Data Analyst' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY
 salary_year_avg DESC
 LIMIT 10
 ```

( it will analysis the company name of top paying data analyst job )