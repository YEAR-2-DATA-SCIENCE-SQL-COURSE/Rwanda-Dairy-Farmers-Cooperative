-- =====================================================================
-- 05_indexes_and_view.sql
-- An index makes searches faster, like the index of a book.
-- A view is a saved query that behaves like a table.
-- =====================================================================

-- Speed up searches by date and by farmer name
CREATE INDEX idx_collect_date ON milk_collection(collect_date);
CREATE INDEX idx_farmer_name  ON farmers(full_name);

-- List the indexes that exist on milk_collection
SELECT indexname, indexdef FROM pg_indexes
WHERE tablename = 'milk_collection';

-- View: total liters collected each day
CREATE VIEW v_daily_totals AS
SELECT collect_date, SUM(liters) AS total_liters
FROM milk_collection GROUP BY collect_date;

SELECT * FROM v_daily_totals;
