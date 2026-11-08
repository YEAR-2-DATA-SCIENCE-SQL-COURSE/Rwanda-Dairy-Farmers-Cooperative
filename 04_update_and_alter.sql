-- =====================================================================
-- 04_update_and_alter.sql
-- UPDATE changes existing rows. ALTER TABLE changes a table's structure.
-- =====================================================================

-- UPDATE: raise the price Inyange Industries pays per liter to 360.
-- The WHERE clause is important: without it, EVERY row would change.
UPDATE processors SET price_per_l = 360
WHERE company_name = 'Inyange Industries';

SELECT * FROM processors;

-- ALTER: add a new column
ALTER TABLE farmers ADD COLUMN email VARCHAR(100);

-- ALTER: change a column's data type
ALTER TABLE farmers ALTER COLUMN district TYPE VARCHAR(80);

-- ALTER: add a CHECK rule (capacity must be above zero)
ALTER TABLE cooling_centers ADD CONSTRAINT chk_cap CHECK (capacity_l > 0);
