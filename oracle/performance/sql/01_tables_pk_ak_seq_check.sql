-- ----------------------------------------------------------------------------
-- filename: 01_tables_pk_ak_seq_check.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------


--
-- 1. DROP/CREATE TABLE, ADD CONSTRAINT
--
DROP TABLE customer_types;

CREATE TABLE customer_types (
    id VARCHAR2(1) NOT NULL PRIMARY KEY,
    name VARCHAR2(30) NOT NULL
);

ALTER TABLE customer_types ADD CONSTRAINT ak_customer_types_name UNIQUE (name);



--
-- 2. DROP/CREATE TABLE, ADD CONSTRAINT
--
DROP TABLE customer_statuses;

CREATE TABLE customer_statuses (
    id VARCHAR2(1) NOT NULL PRIMARY KEY,
    name VARCHAR2(30) NOT NULL
);

ALTER TABLE customer_statuses ADD CONSTRAINT ak_customer_statuses_name UNIQUE (name);



--
-- 3. DROP/CREATE TABLE, DROP/CREATE SEQUENCE, ADD CONSTRAINT
--
DROP TABLE customers CASCADE CONSTRAINTS;

CREATE TABLE customers (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    customer_type_id VARCHAR2(1) NOT NULL,
    code VARCHAR2(14) NOT NULL,
    customer_status_id NUMBER(1) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    phone VARCHAR2(30) NOT NULL,
    address_street VARCHAR(200),
    address_unit VARCHAR(20),
    address_details VARCHAR(30),
    address_zip_code NUMBER(8) NOT NULL,
    address_city VARCHAR(50) NOT NULL,
    address_state VARCHAR(2) NOT NULL,
    since_at DATE,
    last_order_at DATE,
    obs VARCHAR(1000)
);

DROP SEQUENCE customers_seq;

CREATE SEQUENCE customers_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

ALTER TABLE customers ADD CONSTRAINT ak_customers_code UNIQUE (code);


--
--
--
