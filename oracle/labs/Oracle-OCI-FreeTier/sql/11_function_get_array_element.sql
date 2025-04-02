-- ----------------------------------------------------------------------------
-- filename: 11_function_get_array_element.sql
-- revision: 2025-04-01 - josemarsilva
-- ----------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION get_array_element(p_index IN NUMBER, p_str_csv IN VARCHAR2)
RETURN VARCHAR2 IS
    TYPE t_array IS TABLE OF VARCHAR2(4000) INDEX BY PLS_INTEGER;
    array_elements t_array;
    result VARCHAR2(4000);
    n_array_elements NUMBER := 0;
    v_index NUMBER;
BEGIN
    -- Inicializa o resultado como NULL
    result := NULL;

    -- Converte a string CSV em um array usando REGEXP_SUBSTR
    FOR i IN 1..REGEXP_COUNT(p_str_csv, '[^,]+') LOOP
        array_elements(i) := REGEXP_SUBSTR(p_str_csv, '[^,]+', 1, i);
        n_array_elements := n_array_elements + 1;
    END LOOP;

    -- Verifica se o índice é menor ou igual a 0
    IF p_index < 0 THEN
        RETURN result;
    END IF;

    -- Ajusta p_index usando módulo para garantir que esteja dentro dos limites
    v_index := MOD(p_index, n_array_elements);

    -- Recupera o elemento no índice ajustado
    result := array_elements(v_index + 1); -- Arrays em PL/SQL usam indexação baseada em 1

    RETURN result;
END;
/
