-- ----------------------------------------------------------------------------
-- filename: 12_procedure_load_customers.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE load_customers(p_count IN NUMBER)  IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('>>> load_customers('|| p_count ||') >>>');
  --
  -- Step-1: customer_types
  --
  DBMS_OUTPUT.PUT_LINE('    customer_types: [F:PESSOA FISICA, J: PESSOA JURIDICA]');
  BEGIN
    INSERT INTO customer_types(id, name) 
    VALUES ('F', 'PESSOA FISICA');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  BEGIN
    INSERT INTO customer_types(id, name) 
    VALUES ('J', 'PESSOA JURIDICA');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  -- Step-2: customer_statuses
  --
  DBMS_OUTPUT.PUT_LINE('    customer_statuses: [0:INACTIVE, 1: ACTIVE, 2: BLOCK]');
  BEGIN
    INSERT INTO customer_statuses(id, name) 
    VALUES (0, 'INACTIVE');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  BEGIN
    INSERT INTO customer_statuses(id, name) 
    VALUES (1, 'ACTIVE');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  BEGIN
    INSERT INTO customer_statuses(id, name) 
    VALUES (2, 'BLOCKED');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  BEGIN
    INSERT INTO customer_statuses(id, name) 
    VALUES (3, 'RESTRICTED - ONLY WITHDRAWS');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      NULL; -- Ignore duplicate key error
  END;
  --
  -- Step-3: customers
  --
  FOR i IN 1..p_count LOOP
    BEGIN
      --
      INSERT INTO customers (
        id,
        name,
        customer_type_id,
        code,
        customer_status_id,
        email,
        phone,
        address_street,
        address_unit,
        address_details,
        address_zip_code,
        address_city,
        address_state,
        since_at,
        last_order_at,
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
        get_array_element(i, 'Rio Branco,Maceio,Macapa,Manaus,Salvador,Fortaleza,Brasilia,Vitoria,Goiania,Sao Luis,Cuiaba,Campo Grande,Belo Horizonte,Belem,Joao Pessoa,Curitiba,Recife,Teresina,Rio de Janeiro,Natal,Porto Alegre,Porto Velho,Boa Vista,Florianopolis,Sao Paulo,Aracaju,Palmas'), -- address_city
        get_array_element(i, 'AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO'), -- address_state
        NULL, -- since_at
        NULL, -- last_order_at
        NULL  -- obs
      );
      --
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN 
        NULL; -- Ignore duplicate key error
    END;
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
