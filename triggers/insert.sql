create or replace trigger check_store_capacity
before insert or update on cars 
for each row
declare 
    store_capacity number;
    current_car_count number;
begin 
    select car_count, max_cap into current_car_count, store_capacity
    from store_capacity where store_id = :new.store_id;

    if current_car_count = store_capacity then
        raise_application_error(-20001, 'Магазин переполнен, попробуйте добавить машину в другой.');
    end if;
end check_store_capacity;

CREATE OR REPLACE TRIGGER trg_cars_search_text
BEFORE INSERT OR UPDATE ON cars
FOR EACH ROW
BEGIN
  :NEW.search_text := lower(:NEW.model) || ' ' || lower(:NEW.generation) || ' ' || lower(:NEW.color) || ' ' || lower(:NEW.fuel_type);
END trg_cars_search_text;