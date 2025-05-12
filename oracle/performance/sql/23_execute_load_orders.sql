-- ----------------------------------------------------------------------------
-- filename   : 23_execute_load_orders.sql
-- revision   : 2025-05-12 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------


DECLARE
    -- Variables for random value generation
    v_order_branch NUMBER(3);
    v_order_num NUMBER(6);
    v_order_at TIMESTAMP;
    v_order_mode VARCHAR2(8);
    v_customer_id NUMBER;
    v_order_status NUMBER(2);
    v_order_total NUMBER(15,2);
    v_sales_rep_id NUMBER(6);
    v_promotion_id NUMBER(6);
    v_obs VARCHAR2(100);
    
    -- Arrays for sample data
    TYPE mode_array IS TABLE OF VARCHAR2(8);
    order_modes mode_array := mode_array('ONLINE', 'DIRECT', 'PHONE', 'FAX', 'MAIL');
    
    TYPE status_array IS TABLE OF NUMBER(2);
    order_statuses status_array := status_array(1, 2, 3, 4, 5, 6, 8, 9, 10);
    
    TYPE observation_array IS TABLE OF VARCHAR2(100);
    observations observation_array := observation_array(
        'Regular order',
        'Rush delivery requested',
        'Customer is VIP',
        'First-time customer',
        'Repeat customer',
        'Special instructions',
        'Holiday promotion',
        'Seasonal discount applied',
        'Corporate account',
        'Gift order',
        'Phone order processed by support team',
        'Partial shipment allowed',
        'No substitutions allowed',
        'Fragile items',
        'International shipping'
    );
    
    -- Constants for data ranges
    v_num_orders CONSTANT NUMBER := 1000000; -- Number of orders to generate
    v_min_customer_id CONSTANT NUMBER := 1;
    v_max_customer_id CONSTANT NUMBER := 200000;
    v_min_sales_rep CONSTANT NUMBER := 100;
    v_max_sales_rep CONSTANT NUMBER := 500;
    v_min_promotion CONSTANT NUMBER := 1;
    v_max_promotion CONSTANT NUMBER := 20;
    v_max_order_items CONSTANT NUMBER := 20;
    v_min_price CONSTANT NUMBER := 10;
    v_max_price CONSTANT NUMBER := 5000;
    v_num_branches CONSTANT NUMBER := 50; -- Number of branch offices
    
    -- Commit frequency
    v_commit_count CONSTANT NUMBER := 1000;
    
    -- Start and end dates for order generation
    v_start_date DATE := TO_DATE('2020-01-01', 'YYYY-MM-DD');
    v_end_date DATE := SYSDATE;
    v_days_range NUMBER;
    
    -- Tracking last order number per branch
    TYPE branch_order_num_array IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    branch_last_order_num branch_order_num_array;
    
BEGIN
    -- Disable constraints for faster inserts
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE orders DISABLE CONSTRAINT fk_orders_customers';
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not disable some constraints: ' || SQLERRM);
    END;

    -- Initialize last order number for each branch to 0
    FOR i IN 1..v_num_branches LOOP
        branch_last_order_num(i) := 0;
    END LOOP;
    
    -- Calculate date range for random order dates
    v_days_range := v_end_date - v_start_date;
    
    -- Generate orders
    FOR i IN 1..v_num_orders LOOP
        -- Get ID from sequence
        -- Using sequence for id instead of loop counter i
        
        -- Generate random branch number (1-50)
        v_order_branch := TRUNC(DBMS_RANDOM.VALUE(1, v_num_branches + 1));
        
        -- Increment order number for this branch
        branch_last_order_num(v_order_branch) := branch_last_order_num(v_order_branch) + 1;
        v_order_num := branch_last_order_num(v_order_branch);
        
        -- Generate random order date within range
        v_order_at := TO_TIMESTAMP(
            v_start_date + DBMS_RANDOM.VALUE(0, v_days_range) +
            DBMS_RANDOM.VALUE(0, 1), -- Random time portion
            'YYYY-MM-DD HH24:MI:SS.FF'
        );
        
        -- Random order mode
        v_order_mode := order_modes(TRUNC(DBMS_RANDOM.VALUE(1, order_modes.COUNT)) + 1);
        
        -- Random customer
        v_customer_id := TRUNC(DBMS_RANDOM.VALUE(v_min_customer_id, v_max_customer_id + 1));
        
        -- Random order status
        v_order_status := order_statuses(TRUNC(DBMS_RANDOM.VALUE(1, order_statuses.COUNT)) + 1);
        
        -- Calculate order total - simulate multiple items with different prices
        v_order_total := 0;
        FOR j IN 1..TRUNC(DBMS_RANDOM.VALUE(1, v_max_order_items + 1)) LOOP
            v_order_total := v_order_total + ROUND(DBMS_RANDOM.VALUE(v_min_price, v_max_price), 2);
        END LOOP;
        
        -- Random sales rep - some orders might not have a sales rep (NULL)
        IF DBMS_RANDOM.VALUE(0, 1) < 0.8 THEN -- 80% of orders have sales rep
            v_sales_rep_id := TRUNC(DBMS_RANDOM.VALUE(v_min_sales_rep, v_max_sales_rep + 1));
        ELSE
            v_sales_rep_id := NULL;
        END IF;
        
        -- Random promotion - some orders might not have a promotion (NULL)
        IF DBMS_RANDOM.VALUE(0, 1) < 0.3 THEN -- 30% of orders have promotion
            v_promotion_id := TRUNC(DBMS_RANDOM.VALUE(v_min_promotion, v_max_promotion + 1));
        ELSE
            v_promotion_id := NULL;
        END IF;
        
        -- Random observation text - some orders might not have observations (NULL)
        IF DBMS_RANDOM.VALUE(0, 1) < 0.6 THEN -- 60% of orders have observations
            v_obs := observations(TRUNC(DBMS_RANDOM.VALUE(1, observations.COUNT)) + 1);
            
            -- Sometimes add branch and order number to observation
            IF DBMS_RANDOM.VALUE(0, 1) < 0.3 THEN
                v_obs := v_obs || ' - Branch ' || v_order_branch || ', Order #' || v_order_num;
            END IF;
        ELSE
            v_obs := NULL;
        END IF;
        
        -- Insert the order record
        INSERT INTO orders (
            id,
            order_branch,
            order_num,
            order_at,
            order_mode,
            customer_id,
            order_status,
            order_total,
            sales_rep_id,
            promotion_id,
            obs
        ) VALUES (
            orders_seq.NEXTVAL, -- Use sequence instead of counter
            v_order_branch,
            v_order_num,
            v_order_at,
            v_order_mode,
            v_customer_id,
            v_order_status,
            v_order_total,
            v_sales_rep_id,
            v_promotion_id,
            v_obs
        );
        
        -- Commit periodically to avoid large rollback segments
        IF MOD(i, v_commit_count) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Inserted ' || i || ' of ' || v_num_orders || ' orders');
        END IF;
    END LOOP;
    
    -- Final commit for any remaining records
    COMMIT;

    -- Re-enable constraints
    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE orders ENABLE CONSTRAINT fk_orders_customers';
        DBMS_OUTPUT.PUT_LINE('Constraints re-enabled.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Could not re-enable some constraints: ' || SQLERRM);
    END;
    

    DBMS_OUTPUT.PUT_LINE('Order data generation complete. ' || v_num_orders || ' records inserted.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Backtrace: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        ROLLBACK;

        -- Try to Re-enable constraints when error
        BEGIN
            EXECUTE IMMEDIATE 'ALTER TABLE orders ENABLE CONSTRAINT fk_orders_customers';
            DBMS_OUTPUT.PUT_LINE('Constraints re-enabled.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Warning: Could not re-enable some constraints: ' || SQLERRM);
        END;

END;
/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
