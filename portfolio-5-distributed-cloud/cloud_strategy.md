# Distributed & Cloud Database Deployment Strategy

## Architecture Details
- **Sharding Key:** `PatientID` hash-based sharding to balance read/write operations evenly across database nodes.
- **Replication Strategy:** Multi-AZ Primary-Secondary replica set to maintain continuous uptime during zone failures.
- **CAP Theorem Stance:** Designed as a CP System (Consistency & Partition Tolerance) to ensure medical histories and appointments remain strict and accurate across all nodes.
