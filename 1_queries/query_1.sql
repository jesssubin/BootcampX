
-- students in cohort 1
SELECT id, name
FROM students
WHERE cohort_id = 1
ORDER BY name ASC; 

--total students in first 3 cohorts 
SELECT COUNT(id)
FROM students
WHERE cohort_id IN (1,2,3); 

-- all students dont have email/phone number 
SELECT name, id
FROM students 
WHERE email IS NULL OR phone IS NULL; 

-- all students without gmail.com or phone number 
SELECT name, id, email, cohort_id
FROM students
WHERE email NOT LIKE '%gmail.com' AND phone IS NULL; 

-- all students currently enrolled 
-- (end date will be NULL when they are currently enrolled)
SELECT name, id, cohort_id
FROM students
WHERE end_date IS NULL
ORDER BY cohort_id; 

-- get all graduates without a linked Github account 
SELECT name, email, phone 
FROM students 
WHERE github IS NULL 
AND end_date IS NOT NULL;