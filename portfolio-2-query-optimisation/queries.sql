-- Step 1: Ensure you are using your actual database
USE hospital_db;

-- Step 2: Measure baseline execution plan prior to custom indexing
EXPLAIN ANALYZE
SELECT p.FirstName,
       p.LastName,
       m.Diagnosis,
       pr.Medication
FROM Patient p
JOIN MedicalRecord m 
    ON p.PatientID = m.PatientID
JOIN Prescription pr 
    ON m.RecordID = pr.RecordID
WHERE m.RecordDate BETWEEN '2026-01-01' AND '2026-10-07';

-- Step 3: Create composite index on MedicalRecord
CREATE INDEX idx_medicalrecord_patient_date 
    ON MedicalRecord (PatientID, RecordDate);

-- Step 4: Measure execution plan after adding the composite index
EXPLAIN ANALYZE
SELECT p.FirstName,
       p.LastName,
       m.Diagnosis,
       pr.Medication
FROM Patient p
JOIN MedicalRecord m 
    ON p.PatientID = m.PatientID
JOIN Prescription pr 
    ON m.RecordID = pr.RecordID
WHERE m.RecordDate BETWEEN '2026-01-01' AND '2026-10-07';
