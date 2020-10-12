-- total number of assignments for each day of bootcamp
SELECT day count(*) as total_assignments
FROM assignments
GROUP BY day
ORDER BY day; 

--total number of assignments for each day > 10
SELECT day count(*) as total_assignments
FROM assignments
GROUP BY day
HAVING count(*) >= 10 
ORDER BY day; 

-- all cohorts with 18 or more students 
SELECT cohorts.name as cohort_name, count(students.*) AS student_count
FROM cohorts
JOIN students ON cohorts.id = cohort_id
GROUP BY cohort_name
HAVING count(students.*) >= 18
ORDER BY student_count; 

-- total number of assignment for each cohort
SELECT cohorts.name as cohort, count(assignment_submission.*) AS total_submission
FROM assignment_submissions
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY
GROUP BY cohorts.name
ORDER BY total_submission DESC; 