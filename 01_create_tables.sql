-- =====================================================================
-- 01_create_tables.sql
-- Rwanda Dairy Farmers Cooperative (PostgreSQL)
-- Builds the structure of the database. Run this file first.
--
-- Before running: create the database in pgAdmin
--   (right-click Databases > Create > Database) and name it
--   rwanda_farmers_cooperative_database, then open the Query Tool on it.
--   Or, connected to the default "postgres" database, run:
--   CREATE DATABASE rwanda_farmers_cooperative_database;
--
-- SERIAL       = automatic ID (PostgreSQL's replacement for AUTO_INCREMENT)
-- PRIMARY KEY  = uniquely identifies each row
-- NOT NULL     = a value is required
-- UNIQUE       = no duplicate values (no duplicate phone numbers)
-- REFERENCES   = foreign key linking one table to another
-- =====================================================================

-- Cooperative members
CREATE TABLE farmers (
    farmer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    district  VARCHAR(50),
    phone     VARCHAR(15) UNIQUE
);

-- Places where milk is chilled and stored
CREATE TABLE cooling_centers (
    center_id   SERIAL PRIMARY KEY,
    center_name VARCHAR(100) NOT NULL,
    location    VARCHAR(50),
    capacity_l  INT
);

-- Companies that buy the milk
CREATE TABLE processors (
    processor_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    price_per_l  DECIMAL(8,2)
);

-- Each delivery of milk (links a farmer to a cooling center)
CREATE TABLE milk_collection (
    collection_id SERIAL PRIMARY KEY,
    farmer_id     INT NOT NULL REFERENCES farmers(farmer_id),
    center_id     INT NOT NULL REFERENCES cooling_centers(center_id),
    liters        DECIMAL(8,2) NOT NULL,
    collect_date  DATE NOT NULL
);

-- Stores deleted milk records so they can be recovered (filled by a trigger,
-- see 06_backup_tables_and_trigger.sql)
CREATE TABLE deleted_collections_log (
    log_id        SERIAL PRIMARY KEY,
    collection_id INT,
    farmer_id     INT,
    center_id     INT,
    liters        DECIMAL(8,2),
    collect_date  DATE,
    deleted_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
