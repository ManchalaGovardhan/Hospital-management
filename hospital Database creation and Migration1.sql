-- creating a database named db_design
create database db_design;
use db_design;
-- creating a table Department
create table Department(department_id int auto_increment primary key,department_name varchar(50) not null);

-- creating a table Doctors
create table Doctors (doctor_id int auto_increment primary key,Name varchar(50),specialization varchar(50),role varchar(50),
department_id int(10),foreign key(department_id) references department(department_id));
-- creating a patient table
create table Pateients (patient_id int auto_increment primary key,Name varchar(50),Date_of_birth date,Gender varchar(6),phone int,
check (Upper(Gender) in ('MALE','FEMALE','OTHER','F','M','O')));
ALTER TABLE patients
MODIFY phone VARCHAR(15);


-- creating table Appointment
create table appointments (appointment_id int auto_increment primary key,patient_id int ,doctor_id int ,appointment_time datetime,status varchar(20),
foreign key (patient_id) references Pateients(patient_id),foreign key (doctor_id) references Doctors(doctor_id),
check(Upper(status) in ("CANCELLED","SCHEDULED","COMPLETED")));

-- creating prescription table
create table prescription (prescription_id int auto_increment primary key,appointment_id int,medication varchar(100),Dosage varchar(50),
foreign key(appointment_id) references appointments(appointment_id));

-- BILLS TABLE
CREATE TABLE BILLS
( 
 bill_id INT auto_increment primary key,
 appointment_id INT,
 amount DECIMAL(10,2),
 paid TINYINT(1),
 billdate DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY  (appointment_id) REFERENCES appointments(appointment_id)
);


-- LABREPORT TABLES
CREATE TABLE laborates
( 
 report_id INT auto_increment primary key,
 appointment_id INT,
 report_data TEXT,
 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY  (appointment_id) REFERENCES appointments(appointment_id)
);

-- changing table titles
rename table Pateients to patients;
select * from hospital_data;
-- inserting into department table 
select `Departments.DepartmentID` from hospital_data;
SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA='db_design' 
AND TABLE_NAME='hospital_data'
and COLUMN_NAME LIKE 'Departments.%';
insert into department(department_id,department_name) 
select`Departments.DepartmentID`,`Departments.Name`from hospital_data
where `Departments.DepartmentID`<> '';
select * from department;
-- inserting into doctors_table
select concat('select ',group_concat(concat('`',column_name ,'`')), ' from hospital_data')
from information_schema.columns where table_schema='db_design' and table_name='hospital_data' and column_name like 'doctors.%';
insert into doctors(doctor_id,Name,specialization,role,department_id) 
select `Doctors.DoctorID`,`Doctors.Name`,`Doctors.Role`,`Doctors.Specialization`,`Doctors.DepartmentID` from hospital_data
 where `Doctors.DoctorID`<>'';
 
 select * from hospital_data;
select * from doctors;
select  concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data') from information_schema.columns where table_schema='db_design' and table_name='hospital_data' and column_name like 'Patients.%';

INSERT INTO PATIENTS (patient_id, Name, Date_of_birth,Gender,phone)
SELECT 
  `Patients.PatientID`,
  `Patients.Name`,
  STR_TO_DATE(`Patients.DateOfBirth`, '%d-%m-%Y'),  -- Correct format
  `Patients.Gender`,
  `Patients.Phone`
FROM HOSPITAL_DATA
WHERE `Patients.PatientID` <> '';

-- insert into table appointmetnts 
 select concat('select ',group_concat(concat('`',(column_name),'`')),' from hospital_data') from information_schema.columns where table_schema='db_design' and table_name='hospital_data' and column_name like 'Appointments.%';
 

INSERT INTO APPOINTMENTS(appointment_id,patient_id,doctor_id,appointment_time,Status)
SELECT`Appointments.AppointmentID`,`Appointments.PatientID`,
`Appointments.DoctorID`,
STR_TO_DATE(`Appointments.AppointmentTime`,'%d-%m-%Y %H:%i'),
`Appointments.Status`FROM HOSPITAL_DATA;

select * from appointments;



-- INSERTING VALUE INTO PRESCRIPTIONS
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM hospital_data') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'db_design'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'PRESCRIPTIONS.%';

INSERT INTO prescription (prescription_id,appointment_id,medication,Dosage)
SELECT`Prescriptions.PrescriptionID`,`Prescriptions.AppointmentID`,
`Prescriptions.Medication`,`Prescriptions.Dosage`FROM hospital_data 
WHERE `Prescriptions.PrescriptionID` <>'';
SELECT * FROM prescription;



--  INSERT DATA INTO LABREPORTS
SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'db_design'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'LABREPORTS.%';
  
INSERT INTO laborates (report_id,appointment_id,report_data,created_at)
SELECT `LabReports.ReportID`,`LabReports.AppointmentID`,`LabReports.ReportData`,
`LabReports.CreatedAt`FROM HOSPITAL_DATA
WHERE  `LabReports.ReportID`<>'';
SELECT * FROM laborates;


-- INSERT DATA INTO BILLS
SELECT CONCAT('SELECT ',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),' FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'db_design'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'bills.%';
  
  
INSERT INTO BILLS(bill_id,appointment_id,amount,paid,billdate)
SELECT`Bills.BillID`,`Bills.AppointmentID`,`Bills.Amount`,`Bills.Paid`,
`Bills.BillDate`FROM HOSPITAL_DATA
WHERE `Bills.BillID`<>'';
SELECT * FROM BILLS;

select * from appointments;



