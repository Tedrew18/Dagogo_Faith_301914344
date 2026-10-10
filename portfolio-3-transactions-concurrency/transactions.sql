CREATE TABLE Appointment (
    AppointmentID   INT AUTO_INCREMENT PRIMARY KEY,
    PatientID       INT NOT NULL,
    DoctorID        INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status          VARCHAR(20) NOT NULL,

    CONSTRAINT uq_doctor_slot UNIQUE (DoctorID, AppointmentDate)
) ENGINE = InnoDB;

START TRANSACTION;

INSERT IGNORE INTO Appointment (PatientID, DoctorID, AppointmentDate, Status)
VALUES (45, 101, '2026-10-15 10:00:00', 'Confirmed');

-- 1 = booked, 0 = slot already taken
SELECT ROW_COUNT() AS rows_inserted;

COMMIT;

SELECT *
FROM Appointment
WHERE DoctorID = 101
  AND AppointmentDate = '2026-10-15 10:00:00';
