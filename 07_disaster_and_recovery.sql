-- =====================================================================
-- 07_disaster_and_recovery.sql
-- Run after 06_backup_tables_and_trigger.sql.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Simulate a disaster: an accidental delete.
-- The log table should now contain the deleted row.
-- ---------------------------------------------------------------------
DELETE FROM milk_collection WHERE collection_id = 2;
SELECT * FROM deleted_collections_log;
SELECT COUNT(*) AS rows_after_delete FROM milk_collection;   -- 3

-- ---------------------------------------------------------------------
-- Recovery option 1: from the log
-- The deleted row is copied back from the log table.
-- ---------------------------------------------------------------------
INSERT INTO milk_collection
    (collection_id, farmer_id, center_id, liters, collect_date)
SELECT collection_id, farmer_id, center_id, liters, collect_date
FROM deleted_collections_log WHERE collection_id = 2;

SELECT * FROM milk_collection ORDER BY collection_id;        -- 4 rows again

-- ---------------------------------------------------------------------
-- Recovery option 2: full restore from the backup table
-- TRUNCATE empties the table, then every row is copied back.
-- Use this when many rows are damaged.
-- ---------------------------------------------------------------------
TRUNCATE TABLE milk_collection;
INSERT INTO milk_collection SELECT * FROM milk_collection_backup;

SELECT COUNT(*) AS rows_after_full_restore FROM milk_collection;  -- 4
