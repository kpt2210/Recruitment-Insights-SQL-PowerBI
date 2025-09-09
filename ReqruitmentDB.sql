CREATE DATABASE RecruitmentDB

USE RecruitmentDB;

CREATE TABLE Recruitment (
	Applicant_ID INT AUTO_INCREMENT PRIMARY KEY,
    Job_Applicant_Name VARCHAR(50),	
    Age	INT,
    Gender VARCHAR(20),
    Race VARCHAR(50),
    Ethnicity VARCHAR(50),
    Resume TEXT,
    Job_Roles VARCHAR(255),	
    Job_Description TEXT,	
    Best_Match VARCHAR(255)
);

CREATE INDEX idx_role ON recruitment(job_roles);
CREATE INDEX idx_bestmatch ON recruitment(best_match);
CREATE INDEX idx_gender ON recruitment(gender);

-- Q1. How many applicants by gender?
SELECT Gender, COUNT(*) AS total_applicants
FROM Recruitment 
GROUP BY Gender 
ORDER BY total_applicants DESC;

-- Q2. Average age of applicants per job role
SELECT job_roles, ROUND(AVG(age),1) AS avg_age
FROM recruitment
GROUP BY job_roles
ORDER BY avg_age DESC;

-- Q3. Distribution of applicants by race
SELECT race, COUNT(*) AS total
FROM recruitment
GROUP BY race
ORDER BY total DESC;

-- Q4. Which job roles have the most applicants?
SELECT job_roles, COUNT(*) AS applicants
FROM recruitment
GROUP BY job_roles
ORDER BY applicants DESC
LIMIT 10;

-- Q5. Which job roles have the highest proportion of "Best Match" candidates?
SELECT job_roles,
       COUNT(*) AS total_apps,
       SUM(CASE WHEN best_match='Yes' THEN 1 ELSE 0 END) AS matched,
       ROUND(SUM(CASE WHEN best_match='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS match_rate_pct
FROM recruitment
GROUP BY job_roles
ORDER BY match_rate_pct DESC;

-- Q6. Gender-wise match rate
SELECT gender,
       COUNT(*) AS total,
       SUM(CASE WHEN best_match='Yes' THEN 1 ELSE 0 END) AS matched,
       ROUND(SUM(CASE WHEN best_match='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS match_rate_pct
FROM recruitment
GROUP BY gender
ORDER BY match_rate_pct DESC;

-- Q9. Which age groups apply most?
SELECT 
  CASE 
    WHEN age < 25 THEN '<25'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS applicants
FROM recruitment
GROUP BY age_group
ORDER BY applicants DESC;

-- Q10. Which job descriptions (keywords) attract the most matches?
SELECT job_description,
       COUNT(*) AS total,
       SUM(CASE WHEN best_match='Yes' THEN 1 ELSE 0 END) AS matched
FROM recruitment
GROUP BY job_description
ORDER BY matched DESC
LIMIT 10;

-- Q11. Applicants with best-fit resumes for each job role
SELECT Job_Applicant_Name, Job_Roles, Best_Match
FROM recruitment r1
WHERE Best_Match = (
    SELECT MAX(Best_Match) 
    FROM recruitment r2
    WHERE r1.Job_Roles = r2.Job_Roles
);





