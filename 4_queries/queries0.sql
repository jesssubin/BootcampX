-- total number of assistance_requests for teacher 
SELECT teachers.name, count(assistance_requests.*) as total_assistnaces 
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE name = 'Waylon Boehm'
GROUP BY teachers.name; 

-- total number of assistances_requests for a student 
SELECT students.name, count(assistance_requests.*) as total_assistnaces 
FROM assistance_requests
JOIN students ON students.id = student_id
WHERE name = 'Elliot Dickinson'
GROUP BY students.name; 

--each assistnace request data 
SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (completed_at - started_at) as duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN teachers ON teachers.id = teacher_id
JOIN assignments ON assignments.id = assignment_id
ORDER BY duration; 

-- average time of an assistance request 
SELECT avg(completed_at - started_at) as average_assistance_request_duration
FROM assistance_requests; 

-- average duration of assistance requests for each cohort 
SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time;

--cohort with the longest average duration of assistance 
SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;

-- average time it takes to start an assistance request 
SELECT avg(started_at - created_at) as average_wait_time
FROM assistance_requests; 

-- total duration of assistance requests for each cohort 
SELECT cohorts.name as cohort, sum(completed_at - started_at) as total_duration 
FROM assistance_requests
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;

-- average total duration of assistance requests for each cohorts 
SELECT avg (total_duration) as average_total_duration
FROM (
  SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts on cohorts.id = cohort_id
  GROUP BY cohorts.name
  ORDER BY total_duration
) as total_durations;

--list each assignment with the toal number of assistance requests with it 
SELECT assignments.id, name, day, chapter, count(assistance_requests) as total_requests
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;

--each day with total number of assignments and the total duration of the assignments 
SELECT day, count(*) as number_of_assignments, sum(duration) as duration
FROM assignments
GROUP BY day 
ORDER BY day; 

-- name of all teacher assisted request during a cohort
SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
ORDER BY teacher;

-- name of all teacher assisted request during a cohort including number of assistance
SELECT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests) as total_assistances
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;