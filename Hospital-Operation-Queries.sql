#BASIC DATA RETRIEVAL QUERIES

# Total number of patients
select count(distinct patient_id) as total_patients from patient;

#QUERY 1) List all physicians with their positions:
select name, position from physician;

#QUERY 2) Retrieve all departments along with their head's names:
select department.dept_name , physician.name from department inner join physician on department.head = physician.employeeid;

#QUERY 3) Find all nurses who are registered:
select name from nurse where registered = 'Yes';

SELECT position, COUNT(*) AS number_of_nurses 
FROM nurse 
WHERE registered = 'Yes'
GROUP BY position;


#QUERY 4) List all patients along with their primary physician's name:
select concat(patient.name, ' ', patient.surname) as patient_name, physician.name as physician_name from patient inner join physician on patient.primary_check = physician.employeeid;

#QUERY 5) Retrieve all procedures that cost more than 3000:
select name, cost from procedures where cost > 3000;

#JOIN OPERATIONS

#QUERY 6) List all physicians along with their affiliated departments: 
select physician.name, affiliated_with.departmentid, department.dept_name from physician inner join affiliated_with on physician.employeeid = affiliated_with.physicianid inner join department on affiliated_with.departmentid = department.department_id;

#QUERY 7) Find all patients diagnosed with 'Chronic Pain' along with the prescribing physician's name:
select concat(patient.name, ' ',patient.surname) as patient_name, patient_diagnosis.Diagnosis, physician.name as physician_name from patient inner join patient_diagnosis on patient.patient_id = patient_diagnosis.Patient_ID inner join physician on patient_diagnosis.Physician_id = physician.employeeid where Diagnosis = 'Chronic Pain';

#QUERY 8) List all departments and the number of physicians primarily affiliated with them:
select department.dept_name, count(affiliated_with.physicianid) from department inner join affiliated_with on department.department_id = affiliated_with.departmentid where affiliated_with.primaryaffiliation = 't' group by department.dept_name;

#QUERY 9) Retrieve the names of physicians who are not affiliated with any department:
select physician.name from physician inner join affiliated_with on physician.employeeid = affiliated_with.physicianid where affiliated_with.primaryaffiliation = 'f';

#QUERY 10) Find the average cost of all procedures:
select avg(cost) as average_cost from procedures;

#AGGREGATE FUNCTIONS AND GROUPING

#QUERY 11) Count the number of patients assigned to each physician:
select physician.name, count(patient.patient_id) as number_of_patients from physician inner join patient on physician.employeeid = patient.primary_check group by physician.name;

#QUERY 12) Find the most common diagnosis among patients:
select Diagnosis, count(*) from patient_diagnosis group by diagnosis order by count(*) desc limit 1;

#QUERY 13) List the number of nurses in each position:
select position, count(nurse_id) as number_of_nurses from nurse group by position;

#QUERY 14) Determine the total cost of all procedures:
select CONCAT('$', FORMAT(SUM(cost), 0)) AS total_cost FROM procedures;

#QUERY 15) Find the department with the highest number of affiliated physicians:
select department.dept_name, count(affiliated_with.physicianid) as num_of_physicians from department inner join affiliated_with on department.department_id = affiliated_with.departmentid group by department.dept_name order by count(affiliated_with.physicianid) desc limit 1;

#ADVANCED QUERIES

#QUERY 16) List patients who have been prescribed 'Fluoxetine':
select concat(patient.name,' ', patient.surname) as patient_name, patient_diagnosis.prescription from patient inner join patient_diagnosis on patient.patient_id = patient_diagnosis.Patient_ID where Prescription = 'Fluoxetine';

#QUERY 17) Find physicians who have prescribed more than one type of medication:
select physician.name, count(distinct patient_diagnosis.prescription) as prescribed_medicine from physician inner join patient_diagnosis on physician.employeeid = patient_diagnosis.Physician_id group by physician.name having count(distinct patient_diagnosis.prescription) > 1;

#QUERY 18) Retrieve the names of patients diagnosed by physicians from the 'Neurology' department:
select distinct patient.name as patient_name, physician.name as physician_name, department.dept_name from patient inner join physician on patient.primary_check = physician.employeeid inner join affiliated_with on physician.employeeid = affiliated_with.physicianid inner join department on affiliated_with.departmentid = department.department_id where dept_name = 'Neurology';

#QUERY 19) Find the names of physicians who are heads of departments and also have primary affiliations with those departments:
select physician.name as physician_name from department inner join physician on department.head = physician.employeeid inner join affiliated_with on physician.employeeid = affiliated_with.physicianid  where affiliated_with.departmentid = department.department_id and primaryaffiliation = 't';

#QUERY 20) Categorize procedures into cost levels:
select *, 
case 
	when cost < 1000 then 'low' 
    when cost between 1000 and 3000 then 'medium' 
    else 'high' 
    end as cost_of_procedures_category_wise
    from procedures;


select patient_diagnosis.Diagnosis, patient.gender, count(*) as count_of_patients from patient_diagnosis inner join patient on patient_diagnosis.Patient_ID = patient.patient_id group by diagnosis , Gender ;


SELECT prescription, COUNT(*) AS total_prescribed
FROM patient_diagnosis
GROUP BY prescription
ORDER BY COUNT(*) DESC
LIMIT 5;



