# NoSQL Document Model Justification

- **Flexible Schema:** Clinical vital signs and lab attributes vary widely per patient encounter. A document model handles sparse data cleanly without NULL-heavy relational columns.
- **High Read Efficiency:** Embedding prescriptions and vital readings in single patient documents avoids expensive JOIN queries during clinical lookup operations.
