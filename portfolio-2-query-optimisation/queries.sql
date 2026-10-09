-- 1. Create the database
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- 2. Create the Patient table
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

-- 3. Create the MedicalRecord table
CREATE TABLE MedicalRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    RecordDate DATETIME NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,

    CONSTRAINT fk_medicalrecord_patient
        FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 4. Create the Prescription table
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT NOT NULL,
    Medication VARCHAR(255) NOT NULL,

    CONSTRAINT fk_prescription_record
        FOREIGN KEY (RecordID)
        REFERENCES MedicalRecord(RecordID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- 5. Insert sample patients
INSERT INTO Patient (FirstName, LastName) VALUES
('John', 'Doe'),
('Mary', 'Smith'),
('David', 'Johnson'),
('Grace', 'Williams'),
('Peter', 'Brown');

-- 6. Insert sample medical records
INSERT INTO MedicalRecord
    (PatientID, RecordDate, Diagnosis)
VALUES
(1, '2026-01-15 09:30:00', 'Malaria'),
(2, '2026-02-20 10:00:00', 'Typhoid'),
(3, '2026-04-12 14:15:00', 'Hypertension'),
(4, '2026-07-05 11:45:00', 'Diabetes'),
(5, '2026-10-07 16:30:00', 'Common cold');

-- 7. Insert sample prescriptions
INSERT INTO Prescription (RecordID, Medication) VALUES
(1, 'Artemether-Lumefantrine'),
(2, 'Ciprofloxacin'),
(3, 'Amlodipine'),
(4, 'Metformin'),
(5, 'Paracetamol');


EXPLAIN
SELECT
    p.FirstName,
    p.LastName,
    m.Diagnosis,
    pr.Medication
FROM Patient AS p
INNER JOIN MedicalRecord AS m
    ON p.PatientID = m.PatientID
INNER JOIN Prescription AS pr
    ON m.RecordID = pr.RecordID
WHERE m.RecordDate >= '2026-01-01'
  AND m.RecordDate < '2026-10-08';


CREATE INDEX idx_medicalrecord_date
    ON MedicalRecord (RecordDate);

-- Update table statistics for the optimizer
ANALYZE TABLE Patient, MedicalRecord, Prescription;


EXPLAIN
SELECT
    p.FirstName,
    p.LastName,
    m.Diagnosis,
    pr.Medication
FROM Patient AS p
INNER JOIN MedicalRecord AS m
    ON p.PatientID = m.PatientID
INNER JOIN Prescription AS pr
    ON m.RecordID = pr.RecordID
WHERE m.RecordDate >= '2026-01-01'
  AND m.RecordDate < '2026-10-08';

SHOW TABLES;

-- Verify the table structures and relationships
SHOW CREATE TABLE Patient;
SHOW CREATE TABLE MedicalRecord;
SHOW CREATE TABLE Prescription;

-- View the sample query results
SELECT
    p.FirstName,
    p.LastName,
    m.Diagnosis,
    pr.Medication
FROM Patient AS p
INNER JOIN MedicalRecord AS m
    ON p.PatientID = m.PatientID
INNER JOIN Prescription AS pr
    ON m.RecordID = pr.RecordID
WHERE m.RecordDate >= '2026-01-01'
  AND m.RecordDate < '2026-10-08';
