# Rwanda-Dairy-Farmers-Cooperative
SQL database project (PostgreSQL) for a dairy cooperative, focused on backup and recovery
[README (1).md](https://github.com/user-attachments/files/34555286/README.1.md)
# Rwanda Dairy Farmers Cooperative: SQL Database Project (PostgreSQL)

## 1. Project Title
**Rwanda Dairy Farmers Cooperative: SQL Database Project (PostgreSQL), Focus: Backup and Recovery**

## 2. Group Members
| # | Full Name | Student ID |
|---|-----------|------------|
| 1 | SAMUEL ALIER | 202510491 |
| 2 | BOLIS JAGO | 202510443 |
| 3 | ALI SALAHELDEEN | 202510215 |
| 4 | ATEM GABRIEL | 202511479 |
| 5 | AHMED GAMAL | 202510422 |
| 6 | RANA SUDAN | 202510331 |
| 7 | IBRAHIM MANSUOR | 202511226 |
| 8 | SAFA ISMIE | 202511576 |
| 9 | SAMIA ADAM | 202510951 |
| 10 | ELAF HASSAN | 202513791 |

## 3. Introduction
Dairy farming is an important source of income for many rural families in Rwanda. A dairy cooperative brings farmers together to collect milk, chill it at cooling centers, and sell it to processors. Keeping these records on paper leads to lost data, payment disputes and wasted time.

This project builds a PostgreSQL database for a dairy cooperative. It tracks farmers, milk collection, cooling centers and processors, and it demonstrates the seven main SQL operations (CREATE, INSERT, SELECT, UPDATE, ALTER, INDEX and VIEW). Its main focus is **backup and recovery**, which protects the cooperative's records against accidental deletion or loss.

## 4. Problem Statement
Farmers are paid for the milk they deliver. If milk records are deleted, damaged or lost (accidental deletion, a wrong command, hardware failure or theft), the cooperative cannot prove what each farmer delivered. This leads to unpaid or wrongly paid farmers, disputes and loss of trust. The cooperative needs a well-structured database and a tested way to protect and restore its data.

## 5. Objectives
**Main objective:** build a SQL database for a dairy cooperative and protect its data with backup and recovery.

**Specific objectives:**
- Design a database with primary keys, foreign keys and constraints.
- Demonstrate CREATE, INSERT, SELECT, UPDATE, ALTER, INDEX and VIEW.
- Back up data using backup tables, a deletion-log trigger, transactions and a full file backup.
- Simulate a disaster and recover the data in two different ways.
- Verify that no data was lost after recovery.

## 6. Research and Key Concepts
- **Relational database:** data stored in tables linked by keys.
- **Primary key (PK):** uniquely identifies each row. **Foreign key (FK):** links a row to a row in another table.
- **SERIAL:** PostgreSQL's automatic ID (the replacement for AUTO_INCREMENT).
- **Constraints:** `NOT NULL` (value required), `UNIQUE` (no duplicates), `CHECK` (a rule such as capacity above zero).
- **Index:** speeds up searches, like the index of a book.
- **View:** a saved query that behaves like a table.
- **Trigger:** code that runs automatically when something happens, such as a delete.
- **Transaction:** a group of commands that can be cancelled with `ROLLBACK` or made permanent with `COMMIT`.
- **Backup:** a saved copy of the data. **Recovery:** restoring the data after it is lost or damaged.
- **Full backup to a file:** `pg_dump` saves the whole database; `psql` restores it.

## 7. Technical Approach
- **DBMS:** PostgreSQL, used through pgAdmin (Query Tool) and the terminal.
- **Design:** three parent tables (`farmers`, `cooling_centers`, `processors`), one child table (`milk_collection`) and one log table (`deleted_collections_log`).
- **Workflow:** create tables, insert data, query, update and alter, add indexes and a view, then back up, simulate a disaster, recover and verify.
- **Four layers of protection:**
  1. **Backup tables:** `CREATE TABLE ... AS SELECT` copies a table and its rows.
  2. **Deletion-log trigger:** a `BEFORE DELETE` trigger copies each deleted row into `deleted_collections_log`.
  3. **Transactions:** `BEGIN ... ROLLBACK` cancels a mistaken change.
  4. **Full database backup:** `pg_dump` saves the whole database to a file.
- **Two recovery options:** restore a row from the log, or restore the whole table from the backup table.

## 8. Database Design and Diagrams
| Table | Purpose | Keys |
|-------|---------|------|
| `farmers` | Cooperative members | PK `farmer_id`; `phone` is UNIQUE |
| `cooling_centers` | Chilling and storage sites | PK `center_id`; `capacity_l` must be above 0 |
| `processors` | Companies that buy milk and their price per liter | PK `processor_id` |
| `milk_collection` | Each milk delivery | PK `collection_id`; FK `farmer_id`, `center_id` |
| `deleted_collections_log` | Rows deleted from `milk_collection`, filled by a trigger | PK `log_id` |

Diagrams are in [`diagrams/`](diagrams/):
- [Entity Relationship Diagram](diagrams/erd.md)
- [Architecture: four layers of backup and recovery](diagrams/architecture.md)

## 9. SQL Implementation
All scripts are in [`sql/`](sql/). Run them in this order:

| Order | File | What it does |
|-------|------|--------------|
| 1 | [`01_create_tables.sql`](sql/01_create_tables.sql) | **CREATE:** builds the five tables |
| 2 | [`02_insert_data.sql`](sql/02_insert_data.sql) | **INSERT:** adds the sample data (same as [`sample-data/`](sample-data/)) |
| 3 | [`03_select_queries.sql`](sql/03_select_queries.sql) | **SELECT:** all farmers, a three-table JOIN, SUM with GROUP BY and HAVING |
| 4 | [`04_update_and_alter.sql`](sql/04_update_and_alter.sql) | **UPDATE** a price; **ALTER** to add a column, change a type and add a CHECK |
| 5 | [`05_indexes_and_view.sql`](sql/05_indexes_and_view.sql) | **INDEX** and **VIEW** (`v_daily_totals`) |
| 6 | [`06_backup_tables_and_trigger.sql`](sql/06_backup_tables_and_trigger.sql) | Backup layers 1 and 2: backup tables and the deletion trigger |
| 7 | [`07_disaster_and_recovery.sql`](sql/07_disaster_and_recovery.sql) | Simulated delete, recovery from the log, full restore from the backup table |
| 8 | [`08_transaction_rollback.sql`](sql/08_transaction_rollback.sql) | Backup layer 3: transaction with ROLLBACK |
| 9 | [`09_full_database_backup.txt`](sql/09_full_database_backup.txt) | Backup layer 4: `pg_dump` and `psql` commands, and the pgAdmin steps |
| 10 | [`10_cleanup_drop.sql`](sql/10_cleanup_drop.sql) | Optional DROP cleanup (not needed for the demo) |

Create the database `rwanda_farmers_cooperative_database` first (see the top of `01_create_tables.sql`).

## 10. Practical Demonstration and Results
1. **Create and insert:** 5 tables are created; the data holds 3 farmers, 2 cooling centers, 2 processors and 4 milk collections.
2. **SELECT:** the JOIN lists each delivery with the farmer and center, sorted by date. The HAVING query returns only **Jean Uwimana**, with **250.50** liters in total (120.50 + 130.00).
3. **UPDATE and ALTER:** Inyange Industries' price rises from 350 to **360**. The `farmers` table gets an `email` column, `district` becomes `VARCHAR(80)`, and a CHECK rule forces capacity above zero.
4. **INDEX and VIEW:** two indexes are created and listed from `pg_indexes`. The view `v_daily_totals` shows **200.50** liters on 2026-11-01, **95.25** on 2026-11-02 and **130.00** on 2026-11-03.
5. **Backup:** `milk_collection_backup` and `farmers_backup` are created, and the deletion trigger is installed.
6. **Disaster:** deleting `collection_id = 2` leaves 3 rows in `milk_collection`, and `deleted_collections_log` now holds the deleted row.
7. **Recovery option 1 (from the log):** the row is copied back, so `milk_collection` has 4 rows again.
8. **Recovery option 2 (full restore):** `TRUNCATE` empties the table and the backup table refills it, giving 4 rows.
9. **Transaction safety:** a `DELETE` followed by `ROLLBACK` changes nothing; the count is **still 4**.
10. **File backup:** `pg_dump` saves the database to `dairy_backup.sql`, and `psql` restores it.

**Final result:** after recovery, `milk_collection` again held all 4 records.

*(Add your screenshots here, for example `![Recovery result](diagrams/recovery_result.png)`.)*

## 11. Real-World Applications
- Dairy cooperatives in Rwanda tracking deliveries and paying farmers accurately.
- Cooling centers monitoring milk received and stored.
- Processors checking the price they pay per liter.
- The same backup and recovery design works for banks, hospitals, schools and shops, anywhere records equal money.

## 12. Challenges and Recommendations
| Challenge | Recommendation |
|-----------|----------------|
| Accidental deletion by staff | Use the deletion-log trigger and transactions; restrict who can run DELETE |
| Backup tables live in the same database | Also keep a `pg_dump` file stored somewhere else |
| Restoring a table in the wrong order breaks foreign keys | Restore parent tables first, then `milk_collection` |
| Backups that are never tested may fail | Practice a restore regularly |
| `UPDATE` or `DELETE` without `WHERE` changes every row | Run risky commands inside `BEGIN ... ROLLBACK` first |
| Power cuts and weak internet in rural areas | Back up regularly and keep a copy offsite (cloud or another disk) |

## 13. Future Improvements
- Add a payments table to calculate what each farmer is owed.
- Link processors to sales records.
- Add temperature logs for cooling centers to detect spoilage risk.
- Schedule automatic `pg_dump` backups (Windows Task Scheduler or cron).
- Add user roles so that only admins can delete or restore.
- Use continuous archiving for point-in-time recovery.
- Build a simple app for entering milk collections at the collection points.

## 14. References
- PostgreSQL Documentation: "Backup and Restore" chapter.
- PostgreSQL Documentation: `pg_dump`, `CREATE TRIGGER` and `CREATE INDEX`.
- Silberschatz, A., Korth, H., Sudarshan, S. *Database System Concepts*.
- Elmasri, R., Navathe, S. *Fundamentals of Database Systems*.
- US-CERT, *Data Backup Options* (the 3-2-1 backup rule).

*(Check each reference against your course materials and add any others you used.)*

## 15. Presentation Link (Google Drive)
The presentation is hosted on Google Drive (not on GitHub):

[Presentation: Google Drive link](https://docs.google.com/presentation/d/1QJFGiBQULm1XHSsrPZIkbu_U36RHmUA8/edit?usp=sharing&ouid=103712692316995947643&rtpof=true&sd=true)

## 16. Group Contributions
*This split matches the 13 presentation slides. Edit it if any member's actual work was different.*

| Member | Contribution |
|--------|--------------|
| SAMUEL ALIER | Project lead; README sections 1 to 5; slides 1 and 2 (title, introduction, objectives) |
| BOLIS JAGO | Database design and ERD (slide 3, `diagrams/`) |
| ALI SALAHELDEEN | CREATE scripts (slide 4, `01_create_tables.sql`) |
| ATEM GABRIEL | INSERT scripts and sample data (slide 5, `02_insert_data.sql`, `sample-data/`) |
| AHMED GAMAL | SELECT queries (slide 6, `03_select_queries.sql`) |
| RANA SUDAN | UPDATE and ALTER (slide 7, `04_update_and_alter.sql`) |
| IBRAHIM MANSUOR | INDEX and VIEW (slide 8, `05_indexes_and_view.sql`) |
| SAFA ISMIE | Backup tables and deletion trigger (slide 9, `06_backup_tables_and_trigger.sql`) |
| SAMIA ADAM | Disaster, recovery and ROLLBACK (slides 10 and 11, `07_` and `08_` scripts) |
| ELAF HASSAN | Full file backup, conclusion, Google Drive link and final README check (slides 12 and 13, `09_` file) |
