/*Daily Stats */

/*TOTAL ENROLLED STUDENTS IN COURSE */
SELECT count(*)  
FROM student_courseenrollment as sce
left join auth_user as au
ON au.id = sce.user_id
WHERE course_id = "AcademyMMP/STRAT/Sept2014" 
AND au.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
UNION ALL

/* TOTAL ACTIVATED STUDENTS IN COURSE */
SELECT count(*)  
FROM student_courseenrollment as sce
left join auth_user as au
ON au.id = sce.user_id
WHERE course_id = "AcademyMMP/STRAT/Sept2014" and sce.is_active = 1
AND au.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
UNION ALL

/* TOTAL ENGAGED STUDENTS IN COURSE */
SELECT count(DISTINCT user_id) FROM api_manager_coursemodulecompletion 
WHERE course_id = "slashes:AcademyMMP+STRAT+Sept2014" 
AND user_id NOT IN
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 

UNION ALL
/* TOTAL ACTIVE IN PAST 7 DAYS IN COURSE */
SELECT count(*) FROM auth_user AS au 
LEFT JOIN student_courseenrollment as sc
on au.id = sc.user_id
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014" 
AND DATEDIFF(NOW(), au.last_login) <= 7
AND au.id NOT IN
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
