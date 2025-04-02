-- ----------------------------------------------------------------------------
-- filename: 01_tables_pk_seq_check.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------

--
-- Create table "customers"
--
CREATE TABLE customers (
    id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100) NOT NULL,
    customer_type VARCHAR2(1) NOT NULL CHECK (customer_type IN ('F', 'J')),
    customer_code VARCHAR2(14) NOT NULL,
    customer_status NUMBER(1) NOT NULL CHECK (customer_status IN (0, 1)),
    customer_email VARCHAR2(100),
    customer_phone VARCHAR2(30),
    address_street VARCHAR(200) NOT NULL,
    address_unit VARCHAR(20) NOT NULL,
    address_details VARCHAR(30),
    address_zip_code NUMBER(8) NOT NULL,
    address_city VARCHAR(50) NOT NULL,
    address_state VARCHAR(2) NOT NULL,
    last_purchase_at DATE,
    obs VARCHAR(1000)
);

--
-- Create sequence for auto-incrementing the primary key
--
CREATE SEQUENCE customers_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

