-- Query 1: Measure baseline execution plan prior to custom indexing
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

-- Create a composite index to optimize both joining on PatientID and filtering by RecordDate
CREATE INDEX idx_medicalrecord_patient_date 
    ON MedicalRecord (PatientID, RecordDate);

-- Query 2: Measure execution plan after adding the composite index
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
