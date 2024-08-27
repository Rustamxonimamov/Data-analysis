/* 
What skills are most in demand for data analysts?
Find the count of the number of remote job postings per skill
    - display the top 5 skills by their demand in remote jobs
    - include skill id, name, and count of postings requiring the skill
    - look at Data Analyst roles
*/


-- the first way using 'with'

WITH top5_skills AS (
    SELECT 
        skill_id,
        count(skills_job_dim.job_id) AS count
    FROM 
        skills_job_dim
        inner join job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_work_from_home = TRUE
        AND job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
    order by 
        count(skills_job_dim.job_id) DESC
    limit 5
)

SELECT
    top5_skills.*,
    skills_dim.skills
FROM 
    top5_skills
INNER JOIN
    skills_dim ON skills_dim.skill_id = top5_skills.skill_id
ORDER BY
    count DESC;


-- the second way joing there tables simultaneously

SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS total_count
FROM job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    total_count DESC
LIMIT 5;


-- two ways of analyzing the data
/*
    SQL is the most demanded skill, followed by Excel and Python. 
    Top 5 involves Tableau and Power BI as well. 