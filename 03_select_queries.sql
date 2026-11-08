-- =====================================================================
-- 03_select_queries.sql
-- SELECT reads data.
-- =====================================================================

-- 1. All farmers
SELECT * FROM farmers;

-- 2. JOIN three tables and ORDER BY date
SELECT f.full_name, c.center_name, m.liters, m.collect_date
FROM milk_collection m
JOIN farmers f ON m.farmer_id = f.farmer_id
JOIN cooling_centers c ON m.center_id = c.center_id
ORDER BY m.collect_date;

-- 3. SUM + GROUP BY + HAVING: farmers who delivered more than 100 liters in total
SELECT f.full_name, SUM(m.liters) AS total_liters
FROM milk_collection m
JOIN farmers f ON m.farmer_id = f.farmer_id
GROUP BY f.full_name
HAVING SUM(m.liters) > 100;
