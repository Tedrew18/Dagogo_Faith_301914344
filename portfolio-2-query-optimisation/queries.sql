
-- MySQL 8.0+ complete runnable example
-- Run this in MySQL Workbench or another MySQL client.

CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- Reset these demo tables so the script can be rerun.
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS MedicalRecord;
DROP TABLE IF EXISTS Patient;

CREATE TABLE Patient (
    PatientID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PRIMARY KEY (PatientID)
) ENGINE=InnoDB;

CREATE TABLE MedicalRecord (
    RecordID INT NOT NULL AUTO_INCREMENT,
    PatientID INT NOT NULL,
    RecordDate DATETIME NOT NULL,
    Diagnosis VARCHAR(255) NOT NULL,
    PRIMARY KEY (RecordID),
    CONSTRAINT fk_medicalrecord_patient
        FOREIGN KEY (PatientID) REFERENCES Patient (PatientID)
) ENGINE=InnoDB;

CREATE TABLE Prescription (
    PrescriptionID INT NOT NULL AUTO_INCREMENT,
    RecordID INT NOT NULL,
    Medication VARCHAR(255) NOT NULL,
    PRIMARY KEY (PrescriptionID),
    CONSTRAINT fk_prescription_record
        FOREIGN KEY (RecordID) REFERENCES MedicalRecord (RecordID)
) ENGINE=InnoDB;

-- Sample data
INSERT INTO Patient (FirstName, LastName) VALUES
('Ada', 'Okafor'),
('John', 'Bello'),
('Mary', 'James');

INSERT INTO MedicalRecord (PatientID, RecordDate, Diagnosis) VALUES
(1, '2026-02-10 09:30:00', 'Malaria'),
(2, '2026-06-15 14:00:00', 'Hypertension'),
(3, '2025-12-20 10:00:00', 'Flu'),
(1, '2026-10-07 23:59:00', 'Routine checkup');

INSERT INTO Prescription (RecordID, Medication) VALUES
(1, 'Artemether-Lumefantrine'),
(2, 'Amlodipine'),
(3, 'Paracetamol'),
(4, 'Vitamin D');

-- Query 1: execution plan before adding the performance indexes
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
  AND m.RecordDate <  '2026-10-08';

-- Create indexes. The primary keys already index PatientID and RecordID
-- on Patient and MedicalRecord, respectively.
CREATE INDEX idx_medicalrecord_date
    ON MedicalRecord (RecordDate);

CREATE INDEX idx_prescription_record
    ON Prescription (RecordID);

CREATE INDEX idx_medicalrecord_patient
    ON MedicalRecord (PatientID);

-- Query 2: execution plan after adding the indexes
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
  AND m.RecordDate <  '2026-10-08';

-- Return the actual matching rows
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
  AND m.RecordDate <  '2026-10-08'
ORDER BY m.RecordDate;
