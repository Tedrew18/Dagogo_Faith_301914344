# Database Normalisation Report

## Normal Forms Applied
- **1NF (First Normal Form):** Ensured all column values are atomic (e.g., patient names separated into `FirstName` and `LastName`) and removed repeating attribute groups.
- **2NF (Second Normal Form):** Every non-key attribute is fully dependent on the entire primary key. Each entity table uses a single surrogate key (`PatientID`, `RecordID`, etc.).
- **3NF (Third Normal Form):** Removed transitive dependencies. For example, `DepartmentName` is stored inside the `Department` table instead of being repeated on every `Doctor` record.

## Entity Relationships
- **Patient (1) — (M) Appointment**
- **Doctor (1) — (M) Appointment**
- **Patient (1) — (M) MedicalRecord**
- **MedicalRecord (1) — (M) Prescription**
- **MedicalRecord (1) — (M) Laboratory**
