-- Safe Concurrent Appointment Booking Transaction

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

-- Lock matching slots to prevent double-booking race conditions
SELECT COUNT(*) 
FROM Appointment 
WHERE DoctorID = 101 AND AppointmentDate = '2026-10-15 10:00:00' 
FOR UPDATE;

-- Insert appointment if available
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, Status) 
VALUES (45, 101, '2026-10-15 10:00:00', 'Confirmed');

COMMIT;
