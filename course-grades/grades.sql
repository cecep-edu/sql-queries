/*Group Grades */
Select AU.first_name, AU.last_name, AU.email, SM.grade, SM.max_grade, (100*SM.grade/SM.max_grade) as Percentage_Score 
FROM courseware_studentmodule SM, auth_user AU
WHERE AU.id = SM.student_id and SM.course_id='AcademyMMP/STRAT/Sept2014' AND SM.module_type = 'group-project'
AND AU.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
ORDER BY AU.id

/* Assessment Grades */

/*assessment name for lesson 2 assessment 1 is L2A1 */
Select AU.first_name, AU.last_name, AU.email, SM.state, SM.grade, SM.max_grade, (100*SM.grade/SM.max_grade) as Percentage_Score 
FROM courseware_studentmodule SM, auth_user AU
WHERE AU.id = SM.student_id and SM.course_id='AcademyMMP/STRAT/Sept2014'
AND SM.state like '%L2A1%' 
AND AU.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
ORDER BY AU.id

/*Assessment name for l2 a2 is FA1 */
Select AU.first_name, AU.last_name, AU.email, SM.state, SM.grade, SM.max_grade, (100*SM.grade/SM.max_grade) as Percentage_Score 
FROM courseware_studentmodule SM, auth_user AU
WHERE AU.id = SM.student_id and SM.course_id='AcademyMMP/STRAT/Sept2014'
AND SM.state like '%FA1%'
AND AU.id NOT IN 
(Select sc.user_id from student_courseaccessrole as sc 
WHERE sc.course_id = "AcademyMMP/STRAT/Sept2014") 
ORDER BY AU.id

/*TA REVIEW */
SELECT pwr.id,pwr.workgroup_id, pwr.content_id, SM.id, SM.module_id,
AU.username,SM.grade AS "final_score", 
pwr.question,pwr.answer as "mean_scores"   
FROM auth_user AU
LEFT JOIN courseware_studentmodule as SM ON SM.student_id = AU.id
LEFT JOIN projects_workgroup_users as pwu ON pwu.user_id = SM.student_id
LEFT JOIN projects_workgroupreview as pwr ON pwu.workgroup_id = pwr.workgroup_id
WHERE SM.module_type = 'group-project' 
AND SM.course_id='AcademyMMP/MAPS/Nov2014'
AND pwr.content_id LIKE '%AcademyMMP/MAPS%'
ORDER BY SM.grade, AU.username, pwr.question

/*PEER REVIEW*/
SELECT pwr.id,pwr.workgroup_id, pwr.content_id, SM.id, SM.module_id,
AU.username,SM.grade AS "final_score", 
pwr.question,pwr.answer as "mean_scores"   
FROM auth_user AU
LEFT JOIN courseware_studentmodule as SM ON SM.student_id = AU.id
LEFT JOIN projects_workgroup_users as pwu ON pwu.user_id = SM.student_id
LEFT JOIN projects_workgrouppeerreview as pwr ON pwu.workgroup_id = pwr.workgroup_id
WHERE SM.module_type = 'group-project' 
AND SM.course_id='AcademyMMP/MAPS/Nov2014'
AND pwr.content_id LIKE '%AcademyMMP/MAPS%'
ORDER BY SM.grade, AU.username, pwr.question
