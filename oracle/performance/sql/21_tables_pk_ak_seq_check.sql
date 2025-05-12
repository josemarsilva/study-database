-- ----------------------------------------------------------------------------
-- filename   : 01_tables_pk_ak_seq_check.sql
-- revision   : 2025-04-11 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------


--
-- 1. DROP/CREATE TABLE, DROP/CREATE SEQUENCE, ADD CONSTRAINT
--
DROP TABLE orders CASCADE CONSTRAINTS;

CREATE TABLE orders (
    id NUMBER PRIMARY KEY,
    order_branch NUMBER(3) NOT NULL,
    order_num NUMBER(6) NOT NULL,
    order_at TIMESTAMP NOT NULL,
    order_mode VARCHAR2(8),
    customer_id NUMBER NOT NULL,
    order_status NUMBER(2),
    order_total NUMBER(15,2),
    sales_rep_id NUMBER(6),
    promotion_id NUMBER(6),
    obs VARCHAR(100)
);

DROP SEQUENCE orders_seq;

CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

ALTER TABLE orders ADD CONSTRAINT ak_orders UNIQUE (order_branch, order_num);

ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (id);

--
-- 2. DROP/CREATE TABLE, DROP/CREATE SEQUENCE, ADD CONSTRAINT
--
DROP TABLE order_items CASCADE CONSTRAINTS;

CREATE TABLE order_items (
    id           NUMBER PRIMARY KEY,
    order_id     NUMBER NOT NULL,
    line_item_id NUMBER(3) NOT NULL,
    product_id   NUMBER(6) NOT NULL,
    unit_price   NUMBER(8,2),
    quantity     NUMBER(8)
);

DROP SEQUENCE order_items_seq;

CREATE SEQUENCE order_items_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

ALTER TABLE order_items ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_id) REFERENCES orders (id);

--
-- 3. DROP/CREATE TABLE, DROP/CREATE SEQUENCE, ADD CONSTRAINT
--
DROP TABLE products CASCADE CONSTRAINTS;

CREATE TABLE products (
    id                  NUMBER PRIMARY KEY,
    product_name        VARCHAR2(50) NOT NULL,
    product_description VARCHAR2(2000),
    category_id         NUMBER(2),
    weight_class        NUMBER(1),
    warranty_period     INTERVAL YEAR(2) TO MONTH,
    supplier_id         NUMBER(6),
    product_status      VARCHAR2(20),
    list_price          NUMBER(8,2),
    min_price           NUMBER(8,2),
    catalog_url         VARCHAR2(50)
);

DROP SEQUENCE products_seq;

CREATE SEQUENCE products_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
