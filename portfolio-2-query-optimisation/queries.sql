-- Query 1: Execution plan before optimization
EXPLAIN
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

-- Indexes to improve performance
CREATE INDEX idx_medicalrecord_date
    ON MedicalRecord (RecordDate);

CREATE INDEX idx_prescription_record
    ON Prescription (RecordID);

-- Optional if not already a primary key
CREATE INDEX idx_medicalrecord_patient
    ON MedicalRecord (PatientID);

-- Query 2: Execution plan after optimization
EXPLAIN
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
