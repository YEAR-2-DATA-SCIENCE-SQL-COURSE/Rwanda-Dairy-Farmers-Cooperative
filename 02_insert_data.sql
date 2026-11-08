-- =====================================================================
-- 02_insert_data.sql
-- Adds the sample data (same data as ../sample-data/*.csv).
-- Farmers and cooling centers are inserted first because milk_collection
-- depends on them through foreign keys.
-- =====================================================================

INSERT INTO farmers (full_name, district, phone) VALUES
  ('Jean Uwimana',   'Nyagatare', '0788111222'),
  ('Marie Mukamana', 'Gicumbi',   '0788333444'),
  ('Eric Habimana',  'Rubavu',    '0788555666');

INSERT INTO cooling_centers (center_name, location, capacity_l) VALUES
  ('Nyagatare Cooling Center', 'Nyagatare', 5000),
  ('Gicumbi Cooling Center',   'Gicumbi',   3000);

INSERT INTO processors (company_name, price_per_l) VALUES
  ('Inyange Industries',     350.00),
  ('Akagera Business Group', 340.00);

INSERT INTO milk_collection (farmer_id, center_id, liters, collect_date) VALUES
  (1, 1, 120.50, '2026-11-01'),
  (2, 2,  80.00, '2026-11-01'),
  (3, 1,  95.25, '2026-11-02'),
  (1, 1, 130.00, '2026-11-03');
