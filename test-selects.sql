select * from cars;

select * from managers;

select * from stores;

select * from customers;

select * from preorders;

select count(*) from cars where store_id = 1;

select capacity from stores where id = 1; 

delete from cars where model = 'Toyota Corolla';

delete from preorders where car_id = 1;

commit;

declare
  rc sys_refcursor;
  l_id NUMBER;
  l_model VARCHAR2(100);
  l_generation VARCHAR2(100);
  l_price NUMBER;
  l_store_id NUMBER;
  l_color VARCHAR2(50);
  l_fuel_type VARCHAR2(50);
  l_horse_powers NUMBER;
BEGIN
    search_cars('sedan red petrol', :rc);

    open :rc;
    LOOP
    FETCH l_cursor INTO l_id, l_model, l_generation, l_price, l_store_id, l_color, l_fuel_type, l_horse_powers;
    EXIT WHEN l_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('ID: ' || l_id || ', Model: ' || l_model || ', Generation: ' || l_generation || ', Price: ' || l_price || ', Store ID: ' || l_store_id || ', Color: ' || l_color || ', Fuel Type: ' || l_fuel_type || ', Horse Powers: ' || l_horse_powers);
  END LOOP;
  close :rc;
END;


PRINT rc;
