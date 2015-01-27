SELECT au.id as "User ID", au.username as "Username", 
au.first_name as "First Name", 
au.last_name as "Last Name", au.email as "Email", 
au.is_active as "Activated", 
DATE_FORMAT(au.last_login, '%c/%d/%Y') as "Most Recent Login", 
DATE_FORMAT(au.date_joined, '%c/%d/%Y') as "Activation Date", 
DATE_FORMAT(student_courseenrollment.created, '%c/%d/%Y') as "Enrollment Date", 
DATE_FORMAT(SM.modified, '%c/%d/%Y') as "Date user completed assessment",
(
	Select count(*) from progress_coursemodulecompletion api 
	where api.user_id = au.id 
	AND api.stage IS null 
	AND api.course_id = "FF/STRATEGYFF/2015"
) 
as "Exercise Engagement", 
SM.state as "Maximum Attempts",
(100*SM.grade/SM.max_grade) as "Assessment Grade",
(
	Select DATE_FORMAT(min(apitwo.created), '%c/%d/%Y') from progress_coursemodulecompletion apitwo 
	where apitwo.user_id = au.id 
	AND apitwo.stage IS null 
	AND apitwo.course_id = "FF/STRATEGYFF/2015"
) 
as "Date of First Progress Event"
FROM courseware_studentmodule as SM, student_courseenrollment
left join auth_user as au
ON au.id = student_courseenrollment.user_id
WHERE student_courseenrollment.course_id = "FF/STRATEGYFF/2015" 
AND SM.state like '%FA1%' and SM.course_id = "FF/STRATEGYFF/2015"
AND au.id = SM.student_id
AND au.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "FF/STRATEGYFF/2015")
ORDER BY au.id


