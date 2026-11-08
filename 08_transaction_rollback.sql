-- =====================================================================
-- 08_transaction_rollback.sql
-- BACKUP LAYER 3: transaction safety
-- BEGIN starts a transaction, ROLLBACK cancels everything done since BEGIN,
-- and COMMIT would make the changes permanent.
-- =====================================================================

BEGIN;
DELETE FROM milk_collection WHERE farmer_id = 1;
ROLLBACK;   -- the delete is undone, so no data is lost

SELECT COUNT(*) FROM milk_collection;   -- still 4
