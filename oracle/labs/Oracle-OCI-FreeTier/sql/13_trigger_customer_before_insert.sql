-- ----------------------------------------------------------------------------
-- filename: 13_trigger_customer_before_insert.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------

--
-- Create trigger to auto-increment "id" using the sequence
--
CREATE OR REPLACE TRIGGER customer_before_insert
BEFORE INSERT ON customer
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
    SELECT customer_seq.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/