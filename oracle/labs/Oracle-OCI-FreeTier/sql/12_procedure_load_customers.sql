-- ----------------------------------------------------------------------------
-- filename: 12_procedure_load_customers.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE load_customers(p_count IN NUMBER)  IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('>>> load_customers('|| p_count ||') >>>');
  --
  FOR i IN 1..p_count LOOP
    INSERT INTO customers (
      id,
      customer_name,
      customer_type,
      customer_code,
      customer_status,
      customer_email,
      customer_phone,
      address_street,
      address_unit,
      address_details,
      address_zip_code,
      address_city,
      address_state,
      last_purchase_at,
      obs
    )
    VALUES (
      customers_seq.nextval, -- id
      DBMS_RANDOM.STRING('U', 20) || ' ' || DBMS_RANDOM.STRING('U', 30) || ' ' || DBMS_RANDOM.STRING('U', 30), -- customer_name
      DECODE(MOD(i,2), 0, 'F', 'J'), -- customer_type
      SUBSTR( TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1e13, 1e14))), 1, DECODE(MOD(i,2), 0, 11, 14)), -- customer_code
      1, -- customer_status
      DBMS_RANDOM.STRING('L', 20) || '@example.com', -- customer_email
      '+55 11' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1e8, 1e9))), -- customer_phone
      'Rua ' || DBMS_RANDOM.STRING('A', 20) || ' ' || DBMS_RANDOM.STRING('A', 30), -- address_street
      TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1e2, 1e3))), -- address_unit
      DECODE(MOD(i,2), 0, '', DBMS_RANDOM.STRING('A', 20)), -- address_details
      TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1e7, 1e8))), -- address_zip_code
      DBMS_RANDOM.STRING('A', 30), -- address_city
      get_array_element(i, 'AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO'), -- address_state
      NULL, -- last_purchase_at
      NULL -- obs
    );
    --
    IF MOD(i, 100) = 0 THEN
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('    ' || i || ': PARTIAL COMMIT');
    END IF;
    --

  END LOOP;
  --
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('<<< load_customers() <<<');
END;
/
