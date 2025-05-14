-- ----------------------------------------------------------------------------
-- filename   : 22_indexes_scenario_11_initial.sql
-- revision   : 2025-04-13 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------

--
-- 1. DROP/CREATE INDEX
--
DROP INDEX idx_orderitems_orderid ;

CREATE INDEX idx_orderitems_orderid ON order_items (order_id) ;
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'ORDER_ITEMS');

--
-- 2. DROP/CREATE INDEX
--
DROP INDEX idx_orders_customerid ;

CREATE INDEX idx_orders_customerid ON orders (customer_id) ;
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'ORDERS');

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
