use health ; 
show tables; 
select * from patient ;  
select * from doctor ; 
select * from billing ; 
select * from appointment ; 
-- TOTAL APPOINTMENT BY STATUS
SELECT 
    Status, COUNT(*) AS Total_Appointments
FROM
    appointment
GROUP BY Status;  

-- PATIENT APPOINTMENT DETAILS 
SELECT 
    p.Patient_id, p.Patient_name, a.Appointment_date, a.Status
FROM
    patient p
        JOIN
    appointment a ON p.Patient_id = a.Patient_id
WHERE
    a.Status = 'Scheduled';  

-- TOP 3 DOCTORS BY NUMBER OF PATIENT 
SELECT 
    Doctor_id, COUNT(*) AS Total_Appointments
FROM
    appointment
GROUP BY Doctor_id
ORDER BY Total_Appointments DESC  limit 3 ; 

-- APPOINTMENT COUNT BY DOCTOR SPECIALIZTION 
SELECT 
    D.Specialization,
    COUNT(A.Appointment_id) AS Total_Appointments
FROM
    doctor D
        JOIN
    appointment A ON D.Doctor_id = A.Doctor_id
GROUP BY D.Specialization;   

-- TOTAL REVENUE OF HEALTHCARE 
SELECT 
    SUM(Total_Amount) AS total_revenue
FROM
    billing
WHERE
    payment_status = 'Paid'; 

-- DOCTOR AND PATIENT APPOINTMENT DETAILS 
SELECT 
    P.Patient_name, D.Doctor_name, A.Appointment_date, A.Status
FROM
    appointment A
        JOIN
    patient P ON A.Patient_id = P.Patient_id
        JOIN
    doctor D ON A.Doctor_id = D.Doctor_id;   

-- PENDING PAYMENTS OF PATIENT 
SELECT 
    B.Billing_id,
    P.Patient_name,
    B.Payment_status,
    B.Total_amount,
    B.Billing_date
FROM
    billing B 
     JOIN
    appointment A ON B.Appointment_id = A.Appointment_id
        JOIN
    patient P ON A.Patient_id = P.Patient_id
WHERE
    B.Payment_status = 'Pending';   

-- RETRIEVE APPOINTMENT HISTORY FOR A PATIENT 
SELECT 
    a.patient_id, a.appointment_date, a.status, d.doctor_name
FROM
    appointment a
        JOIN
    doctor d ON a.doctor_id = d.doctor_id
WHERE
    a.patient_id = 103
ORDER BY a.appointment_date DESC;  

-- PATIENTS WITH MULTIPLE APPOINTMENTS 
SELECT 
    p.patient_id,
    p.patient_name,
    COUNT(a.appointment_id) AS appointment_count
FROM
    patient p
        JOIN
    appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id , p.patient_name
HAVING appointment_count > 1;  

-- TO FIND AGE DISTRIBUTION 
SELECT 
    CASE
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 0 AND 12 THEN '0-12'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 13 AND 19 THEN '13-19'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 20 AND 35 THEN '20-35'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 36 AND 50 THEN '36-50'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS patient_count
FROM
    Patient
GROUP BY age_group
ORDER BY age_group; 




  












