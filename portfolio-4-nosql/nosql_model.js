// MongoDB Document Definition for Patient EHR

db.patients.insertOne({
  patientId: 1001,
  personalInfo: {
    firstName: "John",
    lastName: "Doe",
    dob: ISODate("1985-06-15T00:00:00Z"),
    contacts: { phone: "+2348000000000", address: "Lagos, Nigeria" }
  },
  medicalRecords: [
    {
      recordId: "REC-9921",
      date: ISODate("2026-08-10T09:30:00Z"),
      doctor: "Dr. Smith",
      diagnosis: "Acute Bronchitis",
      prescriptions: [
        { medication: "Amoxicillin", dosage: "500mg" }
      ],
      vitals: { bp: "120/80", hr: 72, temp: 36.8 }
    }
  ]
});
