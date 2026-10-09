-- Query 1: Unoptimised execution check
EXPLAIN SELECT p.FirstName, p.LastName, m.Diagnosis, pr.Medication
FROM Patient p
JOIN MedicalRecord m ON p.PatientID = m.PatientID
JOIN Prescription pr ON m.RecordID = pr.RecordID
WHERE m.RecordDate BETWEEN '2026-01-01' AND '2026-10-07';

-- Indexes to improve performance
CREATE INDEX idx_medicalrecord_patient_date ON MedicalRecord(PatientID, RecordDate);
CREATE INDEX idx_prescription_record ON Prescription(RecordID);

-- Query 2: Post-optimization execution check
EXPLAIN SELECT p.FirstName, p.LastName, m.Diagnosis, pr.Medication
FROM Patient p
JOIN MedicalRecord m ON p.PatientID = m.PatientID
JOIN Prescription pr ON m.RecordID = pr.RecordID
WHERE m.RecordDate BETWEEN '2026-01-01' AND '2026-10-07';
