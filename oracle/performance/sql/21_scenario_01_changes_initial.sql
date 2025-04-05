-- ----------------------------------------------------------------------------
-- filename   : 21_scenario_01_changes_initial.sql
-- revision   : 2025-04-04 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------

-- Scenario 01 CHANGES: INITIAL

/*
  * Table `customers` has 200.000 rows
  * Column `customers.customer_type_id` has 2 distinct values: (**F** Fisica, **J** Juridica)
  * Column `customers.code` is alternate key CNPJ/CPF, has 200.000 distincts keys
  * Column `customer_status_id` has a 4 distinct values: (0: INACTIVE; 1: ACTIVE; 2:BLOCKED; 3:RESTRICTED - ONLY WITHDRAWS)
  * Column `customers.address_city` is 27 distinct values: 'Rio Branco', 'Maceio', ..., 'Palmas'
  * Column `customers.address_state` is 27 distinct values: 'AC', 'AL', ..., 'TO'
  * Index Unique `customers.customer_code`
*/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
