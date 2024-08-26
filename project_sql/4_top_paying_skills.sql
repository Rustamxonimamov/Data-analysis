/*
What are the top skills on salary?
    - Look at the average salary associated with each skill for Data Analyst positions
    - Focuses on roles with specified salaries, regardless of location
    - Why? It reveals how different skills impact salary levels for Data Analyst and
        helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
Here are a few insights based on the top 25 high-paid skills for Data Analysts:

1. Data Engineering and Big Data Tools Dominate the Top Slots:
Skills like PySpark (Avg. Salary: $208,172) and Couchbase (Avg. Salary: $160,515) command high salaries. These tools are essential for large-scale data processing and distributed computing, making them highly valued.
2. Version Control and DevOps Tools are Highly Valued:
Bitbucket (Avg. Salary: $189,155), GitLab (Avg. Salary: $154,500), and Jenkins (Avg. Salary: $125,436) show how critical version control and CI/CD pipelines are in the data space. Data Analysts with DevOps skills can significantly impact projects by ensuring smooth deployment and integration.
3. AI and Machine Learning Tools Offer Competitive Salaries:
Tools like Watson (Avg. Salary: $160,515), DataRobot (Avg. Salary: $155,486), and scikit-learn (Avg. Salary: $125,781) reflect the growing demand for machine learning in analytics roles.
4. Data Science and Analytics Libraries Remain Critical:
Core libraries like Pandas (Avg. Salary: $151,821), Jupyter (Avg. Salary: $152,777), and Numpy (Avg. Salary: $143,513) continue to offer strong salary prospects. These tools form the backbone of data analysis, modeling, and exploratory data science.
5. Programming Languages Tailored for Data Engineering are Valued:
Golang (Avg. Salary: $145,000), Scala (Avg. Salary: $124,903), and Swift (Avg. Salary: $153,750) indicate that specialized programming languages associated with data pipelines and performance optimization lead to higher earnings.
6. Cloud Platforms are Important:
Google Cloud Platform (GCP) (Avg. Salary: $122,500) is highlighted, showing the importance of cloud infrastructure in analytics. Mastering cloud tools is becoming essential as data storage and processing increasingly move to cloud environments.
7. Visualization and Reporting Tools have Good Pay but are Lower on the List:
Tools like MicroStrategy (Avg. Salary: $121,619) are still well-paid but are lower on the list, showing that data engineering and machine learning skills tend to command higher salaries.
8. Open Source and Enterprise Collaboration Tools Have Growing Importance:
Notion (Avg. Salary: $125,000) and Atlassian (Avg. Salary: $131,162) show that data analysts are also expected to be familiar with collaboration tools that enhance productivity in team-based environments.
In summary, the highest-paying roles focus heavily on data engineering, cloud platforms, and machine learning, with strong demand for both DevOps and core data science libraries. Data analysts looking to maximize their earning potential should consider specializing in these high-demand areas.
*/
