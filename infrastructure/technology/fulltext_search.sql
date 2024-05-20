BEGIN
  CTX_DDL.CREATE_PREFERENCE('cars_lexer', 'BASIC_LEXER');
END;

CREATE OR REPLACE PROCEDURE search_cars (
    p_search_term IN VARCHAR2,
    p_results OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_results FOR
    SELECT *
    FROM cars
    WHERE CONTAINS(search_text, lower(p_search_term)) > 0;
END;

CREATE INDEX cars_search_idx ON cars(search_text) INDEXTYPE IS CTXSYS.CONTEXT parameters('LEXER cars_lexer');

drop index cars_search_idx;

declare 
  curs SYS_REFCURSOR;
  l_id NUMBER;
  l_model VARCHAR2(100);
  l_generation VARCHAR2(100);
  l_price NUMBER;
  l_store_id NUMBER;
  l_color VARCHAR2(50);
  l_fuel_type VARCHAR2(50);
  l_horse_powers NUMBER;
  L_SEARCH_CARS clob;
begin 
  search_cars ('honda', curs);
  LOOP
    FETCH curs INTO l_id, l_model, l_generation, l_price, l_store_id, l_color, l_fuel_type, l_horse_powers, L_SEARCH_CARS;
    EXIT WHEN curs%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('Идентификатор: ' || l_id || ', Модель: ' || l_model || ', Пококление: ' || l_generation || ', Цена: ' || l_price || ', Цвет: ' || l_color || ', Тип топлива: ' || l_fuel_type || ', Л/С: ' || l_horse_powers);
  END LOOP;
end;

set serveroutput on;

select * from cars;