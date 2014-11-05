SELECT au.id as "User ID", au.username as "Username", 
au.first_name as "First Name", 
au.last_name as "Last Name", au.email as "Email", 
sce.is_active as "Activated", 
DATE_FORMAT(au.last_login, '%c/%d/%Y') as "Most Recent Login", 
DATE_FORMAT(au.date_joined, '%c/%d/%Y') as "Activation Date", 
DATE_FORMAT(sce.created, '%c/%d/%Y') as "Enrollment Date", 
(
	Select count(*) from api_manager_coursemodulecompletion api 
	where api.user_id = au.id 
	AND api.stage IS null 
	AND api.course_id = "AcademyMMP/STRAT/Sept2014"
) 
as "Exercise Engagement"   
FROM student_courseenrollment as sce
left join auth_user as au
ON au.id = sce.user_id
WHERE course_id = "AcademyMMP/STRAT/Sept2014" and sce.is_active = 1
AND au.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
ORDER BY au.id