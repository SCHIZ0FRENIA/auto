create or replace trigger check_store_capacity
before insert on cars 
for each row
declare 
    store_capacity number;
    current_car_count number;
begin 
    select capacity into store_capacity 
    from stores where id = :new.store_id;

    select car_count into current_car_count 
    from store_capacity where store_id = :new.store_id;

    if current_car_count = store_capacity then
        raise_application_error(-20001, 'Магазин переполнен, попробуйте добавть машину в другой.');
    end if;
end check_store_capacity;