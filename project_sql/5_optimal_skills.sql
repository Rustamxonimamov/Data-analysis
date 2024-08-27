/*
What are the most optimal skills to learn?
    - Identify skills in high demand and association with high average salaries for Data Analyst roles
    - Concentrates on remote positions with specified salaries
    - why? Targests skilss that offer job security (high demand) and financial benefits (high salaries),
        offering strategic insights for career development in data analysis
*/
-- the first way demand dominant
WITH high_demand_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS total_count
    FROM job_postings_fact
    INNER JOIN 
        skills_job_dim 
            ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim 
            ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), high_salary_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg)) AS avg_salary
    FROM job_postings_fact
    INNER JOIN 
        skills_job_dim 
            ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim 
            ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT 
    high_demand_skills.total_count AS demand_count,
    high_salary_skills.avg_salary AS salary,
    high_demand_skills.skills
FROM
    high_demand_skills
INNER JOIN
    high_salary_skills 
            on high_demand_skills.skill_id = high_salary_skills.skill_id
ORDER BY
    high_demand_skills.total_count DESC,
    high_salary_skills.avg_salary DESC
LIMIT 10;

-- the second way salary dominant
SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary,
    COUNT(job_postings_fact.job_id) AS count
FROM
    job_postings_fact
INNER JOIN 
    skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skills
HAVING 
    COUNT(job_postings_fact.job_id) > 10
ORDER BY
    COUNT(job_postings_fact.job_id) DESC,
    ROUND(AVG(salary_year_avg)) DESC
LIMIT 10