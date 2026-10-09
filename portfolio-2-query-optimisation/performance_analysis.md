# Query Performance & Optimisation Analysis

## Findings
1. Before indexing, the query performed full table scans (`type: ALL`) across `MedicalRecord` and `Prescription`.
2. Adding composite index `idx_medicalrecord_patient_date` reduced scan cost by allowing index-range lookups (`type: range`).
3. Foreign key indexing on `Prescription(RecordID)` streamlined join evaluation (`type: ref`).
