-- ----------------------------------------------------------------------------
-- filename   : 22_execute_load_products.sql
-- revision   : 2025-05-12 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------


DECLARE
    -- Variables to store random values
    v_counter             NUMBER(6);
    v_product_name        VARCHAR2(50);
    v_product_description VARCHAR2(2000);
    v_category_id         NUMBER(2);
    v_weight_class        NUMBER(1);
    v_warranty_period     INTERVAL YEAR(2) TO MONTH;
    v_supplier_id         NUMBER(6);
    v_product_status      VARCHAR2(20);
    v_list_price          NUMBER(8,2);
    v_min_price           NUMBER(8,2);
    v_catalog_url         VARCHAR2(50);
    
    -- Array of possible product statuses
    TYPE status_array IS TABLE OF VARCHAR2(20);
    product_status status_array := status_array('orderable', 'planned', 'under development', 'obsolete');
    
    -- Range for possible categories (1-10)
    v_max_category NUMBER := 10;
    
    -- Array for product descriptions
    TYPE desc_array IS TABLE OF VARCHAR2(100);
    descriptions desc_array := desc_array(
        'High performance', 'Economic model', 'Basic model', 'Professional grade',
        'Enterprise level', 'Standard edition', 'Premium edition', 'Ultimate edition',
        'Beginners model', 'Advanced model', 'Limited edition', 'Special edition'
    );
    
    -- Array of generic product names
    TYPE name_array IS TABLE OF VARCHAR2(20);
    names name_array := name_array(
        'Laptop', 'Desktop', 'Monitor', 'Keyboard', 'Mouse', 'Printer',
        'Scanner', 'Server', 'Router', 'Switch', 'Tablet', 'Smartphone'
    );
    
    -- Commit every N records
    v_commit_count NUMBER := 1000;
    
BEGIN
    
    -- Main insertion loop
    v_counter := 30000;
    FOR i IN 1..v_counter LOOP
        -- Generate random values for each column
        v_category_id := TRUNC(DBMS_RANDOM.VALUE(1, v_max_category + 1));
        v_weight_class := TRUNC(DBMS_RANDOM.VALUE(1, 6));
        v_warranty_period := NUMTOYMINTERVAL(TRUNC(DBMS_RANDOM.VALUE(0, 5)), 'YEAR') + 
                            NUMTOYMINTERVAL(TRUNC(DBMS_RANDOM.VALUE(0, 12)), 'MONTH');
        v_supplier_id := TRUNC(DBMS_RANDOM.VALUE(100, 999));
        v_product_status := product_status(TRUNC(DBMS_RANDOM.VALUE(1, product_status.COUNT)) + 1);
        v_list_price := ROUND(DBMS_RANDOM.VALUE(100, 9999), 2);
        v_min_price := ROUND(v_list_price * DBMS_RANDOM.VALUE(0.6, 0.9), 2); -- Min price between 60-90% of list price
        
        -- Build product name
        v_product_name := names(TRUNC(DBMS_RANDOM.VALUE(1, names.COUNT)) + 1) || 
                         ' Model ' || 
                         TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(100, 999)));
        
        -- Build product description
        v_product_description := descriptions(TRUNC(DBMS_RANDOM.VALUE(1, descriptions.COUNT)) + 1) || 
                               ' ' || 
                               v_product_name || 
                               ' with exceptional quality. Category: ' || 
                               TO_CHAR(v_category_id) || 
                               ', Supplier ID: ' || 
                               TO_CHAR(v_supplier_id);
        
        -- Catalog URL
        v_catalog_url := 'http://example.com/products/' || TO_CHAR(i) || '.html';
        
        -- Insert the record
        INSERT INTO products (
            id,
            PRODUCT_NAME, 
            PRODUCT_DESCRIPTION, 
            CATEGORY_ID, 
            WEIGHT_CLASS, 
            WARRANTY_PERIOD, 
            SUPPLIER_ID, 
            PRODUCT_STATUS, 
            LIST_PRICE, 
            MIN_PRICE, 
            CATALOG_URL
        ) VALUES (
            products_seq.NEXTVAL,
            v_product_name,
            v_product_description,
            v_category_id,
            v_weight_class,
            v_warranty_period,
            v_supplier_id,
            v_product_status,
            v_list_price,
            v_min_price,
            v_catalog_url
        );
        
        -- Commit every v_commit_count records to avoid large rollback segments
        IF MOD(i, v_commit_count) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Inserted ' || i || ' records');
        END IF;
    END LOOP;
    
    -- Final commit for remaining records
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Process completed. ' || TO_CHAR(v_counter) || ' records successfully inserted.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Backtrace: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        -- Rollback in case of error
        ROLLBACK;
        -- Try to re-enable constraint in case of error
END;
/ 

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
