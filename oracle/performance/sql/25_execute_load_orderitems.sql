-- ----------------------------------------------------------------------------
-- filename   : 25_execute_load_orderitems.sql
-- revision   : 2025-05-13 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------

-- SET SERVEROUT ON SIZE 1000000

DECLARE
    -- Variables for random value generation
    v_line_item_id NUMBER(3);
    v_product_id NUMBER(6);
    v_unit_price NUMBER(8,2);
    v_quantity NUMBER(8);
    
    -- Constants - use known values
    v_products_count CONSTANT NUMBER := 30000;  -- 30K - Known product count
    v_orders_count CONSTANT NUMBER := 1000000;  -- 1M - Known order count
    v_min_products_per_order CONSTANT NUMBER := 1;
    v_max_products_per_order CONSTANT NUMBER := 8;
    v_min_quantity CONSTANT NUMBER := 1;
    v_max_quantity CONSTANT NUMBER := 50;
    
    -- Settings
    v_commit_count CONSTANT NUMBER := 10000;
    v_total_line_items NUMBER := 0;
    v_batch_size CONSTANT NUMBER := 1000;  -- Process orders in batches
    v_current_batch NUMBER := 0;
    
    -- Array of product IDs for faster random selection
    TYPE product_id_array IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_product_ids product_id_array;
    
    -- Function to get product price
    FUNCTION get_product_price(p_product_id IN NUMBER) RETURN NUMBER IS
    BEGIN
        -- Generate a realistic price based on product ID
        -- Products with higher IDs tend to be more expensive in this simulation
        RETURN ROUND(
            50 + (p_product_id MOD 100) + 
            DBMS_RANDOM.VALUE(10, 200) + 
            (FLOOR(p_product_id/1000) * 50),
            2);
    END get_product_price;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting order items generation for 1,000,000 orders with 30,000 products...');
    
    -- Disable constraints for faster inserts
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE order_items DISABLE CONSTRAINT order_items_pk';
        EXECUTE IMMEDIATE 'ALTER TABLE order_items DISABLE CONSTRAINT fk_orderitems_orders';
        DBMS_OUTPUT.PUT_LINE('Constraints disabled for faster processing.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not disable some constraints: ' || SQLERRM);
    END;
    
    -- Process orders in batches to avoid excessive memory usage
    FOR batch_start IN 1..v_orders_count LOOP
        -- Process each order
        v_current_batch := v_current_batch + 1;
        
        -- Generate random number of line items for this order
        FOR i IN 1..TRUNC(DBMS_RANDOM.VALUE(v_min_products_per_order, v_max_products_per_order + 1)) LOOP
            -- Line item number is sequential for each order
            v_line_item_id := i;
            
            -- Random product ID from available range
            v_product_id := TRUNC(DBMS_RANDOM.VALUE(1, v_products_count + 1));
            
            -- Get unit price based on product ID
            v_unit_price := get_product_price(v_product_id);
            
            -- Random quantity - typically lower quantities but occasionally bulk orders
            IF DBMS_RANDOM.VALUE(0, 1) < 0.9 THEN
                -- Regular order - typically smaller quantities (1-5)
                v_quantity := TRUNC(DBMS_RANDOM.VALUE(v_min_quantity, 6));
            ELSE
                -- Bulk order - larger quantities (6-50)
                v_quantity := TRUNC(DBMS_RANDOM.VALUE(6, v_max_quantity + 1));
            END IF;
            
            -- Insert the order item
            INSERT /*+ APPEND */ INTO order_items (
                id,
                order_id,
                line_item_id,
                product_id,
                unit_price,
                quantity
            ) VALUES (
                order_items_seq.NEXTVAL,
                batch_start,  -- Use batch_start as the order_id
                v_line_item_id,
                v_product_id,
                v_unit_price,
                v_quantity
            );
            
            v_total_line_items := v_total_line_items + 1;
        END LOOP;
        
        -- Commit periodically
        IF MOD(batch_start, v_commit_count) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Processed ' || batch_start || ' orders with ' || 
                                v_total_line_items || ' total line items');
        END IF;
    END LOOP;
    
    -- Final commit
    COMMIT;
    
    -- Re-enable constraints
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE order_items ENABLE CONSTRAINT order_items_pk';
        EXECUTE IMMEDIATE 'ALTER TABLE order_items ENABLE CONSTRAINT fk_orderitems_orders';
        DBMS_OUTPUT.PUT_LINE('Constraints re-enabled.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not re-enable some constraints: ' || SQLERRM);
    END;
    
    -- Update order totals to match the sum of order items
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Updating order totals to match sum of line items...');
        
        -- Use direct update with subquery instead of MERGE for better performance with large datasets
        UPDATE orders o
        SET order_total = (
            SELECT SUM(unit_price * quantity)
            FROM order_items oi
            WHERE oi.order_id = o.id
        )
        WHERE EXISTS (
            SELECT 1 FROM order_items oi WHERE oi.order_id = o.id
        );
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Order totals updated successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not update order totals: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('Order items generation complete. ' || v_total_line_items || ' total line items created.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Backtrace: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        ROLLBACK;
        
        -- Try to re-enable constraints in case of error
        BEGIN
            EXECUTE IMMEDIATE 'ALTER TABLE order_items ENABLE CONSTRAINT order_items_pk';
            EXECUTE IMMEDIATE 'ALTER TABLE order_items ENABLE CONSTRAINT fk_orderitems_orders';
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Could not re-enable constraints: ' || SQLERRM);
        END;
END;
/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
