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

             1 - top paying job 
             2 - top paying skill for specific job
             3 - top paying skills  in specific location
             4 - top demanded skill
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


![top data analyst paying company](project\pic\image.png)



## top paying skill for specific job

   ```sql
   SELECT
       skills,
       ROUND(AVG(salary_year_avg),0) as avg_salary
       FROM
       job_postings_fact
       INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
       INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
       WHERE 
       job_title_short = 'Data Analyst' and salary_year_avg IS NOT NULL 

       GROUP BY skills
       ORDER BY avg_salary DESC
       
       LIMIT 25
       ```

(it will analysis top paying skill for data analytic)
```

![top paying skills](project\pic\Picture1.png)

## top paying skill in india

```sql
with top_skills_ as (
    select
     job_title_short,
    salary_year_avg,
    job_location,
    job_id,
    new_name as company_name
    from job_postings_fact
    left join company_dim on job_postings_fact.company_id=company_dim.company_id
     where salary_year_avg is not null and job_location ='India'
    order by salary_year_avg DESC
    LIMIT 10
    )
            select top_skills_.*,skills_dim.skills
            FROM top_skills_
            inner join skills_job_dim ON top_skills_.job_id=skills_job_dim.job_id
            inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
            ORDER BY salary_year_avg DESC
 ```
 
   - Identify the top 10 highest-paying jobs in India.
   - Show which companies are offering them.
   - List the skills required for those jobs.
   - Provide a salary-first ranking so you can see which skills align with the most lucrative opportunities.
   

![count of skills for different job](project\pic\Picture2.png)


## top demanded skill

```sql
SELECT
skills,
count(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE job_title_short ='Data Analyst'
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 5
```
(top demanded skill for data analyst)


![data analyst skill](project\pic\Picture3.png)

## skills with top demand and top salary for data analyst


```sql
with skills_demand AS(
    SELECT
    skills_dim.skill_id,
       skills_dim.skills,
       count(skills_job_dim.job_id) as skill_count
       FROM
       job_postings_fact
       INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
       INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
       WHERE job_title_short = 'Data Analyst' AND job_work_from_home = true AND 
       salary_year_avg IS NOT NULL
       
       GROUP BY skills_dim.skill_id
       
), average_salary AS(
    SELECT
    skills_job_dim.skill_id, 
       ROUND(AVG(salary_year_avg),0) as avg_salary
       FROM
       job_postings_fact
       INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
       INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
       WHERE 
       job_title_short = 'Data Analyst'AND job_work_from_home = true
       and salary_year_avg IS NOT NULL 

       GROUP BY skills_job_dim.skill_id
      
)
 select 
 skills_demand.skill_id,
 skills_demand.skills,
 skill_count,
 avg_salary
 FROM skills_demand
 inner join average_salary on skills_demand.skill_id=average_salary.skill_id
WHERE skill_count > 10
ORDER BY
 avg_salary DESC,
 skill_count DESC
 LIMIT 25

```
![optimal skill](project\pic\Picture4.png)



## What I Learned
- **SQL Query Structuring**: I deepened my understanding of how to use CTEs (Common Table Expressions) to simplify complex queries and make them more readable.
- **Data Filtering & Ranking**: I learned how to filter jobs by location and salary, then rank them using ORDER BY and LIMIT to focus on the most relevant results.
- **Joins Across Multiple Tables**: I practiced joining fact tables (job_postings_fact) with dimension tables (company_dim, skills_dim) to enrich the dataset with company names and skill details.
- **skill Mapping**: I saw how bridge tables (skills_job_dim) connect jobs to skills, which taught me the importance of many-to-many relationships in databases.
- **Career Insights from Data**: Beyond SQL, I realized how queries can be used to generate real-world insights—like identifying which skills are tied to the highest-paying jobs in India.
- **Practical Application**: This exercise reinforced the idea that SQL isn’t just about querying data—it’s about answering meaningful questions that can guide career decisions and business strategies.



# conclusion

- Filter and identify the top 10 highest-paying jobs in India with valid salary data.
- Integrate company information to highlight which organizations are offering these roles.
- Map essential skills to each job, providing a direct link between high-paying opportunities and the competencies required.
- Rank results by salary, ensuring that the analysis remains focused on the most lucrative career paths.


This work demonstrates how data analysis can uncover actionable career insights, showing not only which jobs pay the most but also the skills professionals should prioritize to align with those opportunities. The project now provides a strong foundation for further exploration, such as analyzing skill frequency trends or comparing results across different countries.





