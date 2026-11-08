-- =====================================================================
-- 06_backup_tables_and_trigger.sql
-- BACKUP LAYERS 1 AND 2
-- Backup = a saved copy of the data. Recovery = restoring it after loss.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Layer 1: backup tables inside SQL
-- CREATE TABLE ... AS SELECT copies a table and its data into a new table.
-- ---------------------------------------------------------------------
CREATE TABLE milk_collection_backup AS SELECT * FROM milk_collection;
CREATE TABLE farmers_backup         AS SELECT * FROM farmers;

-- ---------------------------------------------------------------------
-- Layer 2: trigger that logs deletions
-- A trigger runs automatically when something happens. This one fires
-- BEFORE every DELETE on milk_collection and copies the row (OLD) into
-- deleted_collections_log, so deleted data is never fully lost.
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION log_deleted_collection()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO deleted_collections_log
        (collection_id, farmer_id, center_id, liters, collect_date)
    VALUES (OLD.collection_id, OLD.farmer_id, OLD.center_id,
            OLD.liters, OLD.collect_date);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_delete
BEFORE DELETE ON milk_collection
FOR EACH ROW EXECUTE FUNCTION log_deleted_collection();
