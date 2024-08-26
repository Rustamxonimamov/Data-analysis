/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls)
- Why? highlight the top-paying opportunities for Data Analyst, offering insights into employment opportunities
*/

SELECT
    job_postings_fact.job_id,
    company_dim.name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
    
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
where 
    job_title LIKE '%Data Analyst%'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC
LIMIT 10