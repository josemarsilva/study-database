-- ----------------------------------------------------------------------------
-- filename   : 21_scenario_02_changes_states_sp_mg_rj_cities_645_853_92.sql
-- revision   : 2025-04-04 - josemarsilva
-- description: 
-- ----------------------------------------------------------------------------

-- Scenario 02 CHANGES: address_states IN ('SP', 'MG', 'RJ') has much more cities (645, ?, 92)

/*
  * Table `customers` has 200.000 rows
  * Column `customers.customer_type_id` has 2 distinct values: (**F** Fisica, **J** Juridica)
  * Column `customers.code` is alternate key CNPJ/CPF, has 200.000 distincts keys
  * Column `customer_status_id` has a 4 distinct values: (0: INACTIVE; 1: ACTIVE; 2:BLOCKED; 3:RESTRICTED - ONLY WITHDRAWS)
  * Column `customers.address_city` IN states ('SP', 'MG', 'RJ') has respectively (645, 853, 92) distinct values
  * Column `customers.address_city` IN states ('SP', 'MG', 'RJ') has only 1 (one) distinct values for each state, so 25 distinct values
  * Column `customers.address_state` is 27 distinct values: 'AC', 'AL', ..., 'TO'
  * Index Unique `customers.customer_code` - scenario 01 INITIAL
*/



-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
