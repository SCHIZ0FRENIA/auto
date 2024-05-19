CREATE OR REPLACE PROCEDURE add_car (
    p_model IN VARCHAR2,
    p_generation IN VARCHAR2,
    p_price IN NUMBER,
    p_store_id IN NUMBER,
    p_color IN VARCHAR2,
    p_fuel_type IN VARCHAR2,
    p_horse_powers IN NUMBER
) AS
    v_store_exists NUMBER;
BEGIN
    IF p_model IS NULL OR LENGTH(TRIM(p_model)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Модель автомобиля не может быть пустой.');
        RETURN;
    END IF;

    IF p_price IS NULL OR p_price <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Цена автомобиля должна быть положительным числом.');
        RETURN;
    END IF;

    IF p_store_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Идентификатор магазина не может быть пустым.');
        RETURN;
    END IF;

    SELECT COUNT(*)
    INTO v_store_exists
    FROM stores
    WHERE id = p_store_id;

    IF v_store_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Магазин с таким идентификатором не существует.');
        RETURN;
    END IF;

    INSERT INTO cars (id, model, generation, price, store_id, color, fuel_type, horse_powers)
    VALUES (default, p_model, p_generation, p_price, p_store_id, p_color, p_fuel_type, p_horse_powers);

    DBMS_OUTPUT.PUT_LINE('Новый автомобиль успешно добавлен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END add_car;

create or replace procedure move_car (
  p_car_id in number,
  p_store_id in number
) as
  v_count number;
  v_count_store number;
begin
  select store_id into v_count from cars where id = p_car_id;
  if v_count = p_store_id then 
    dbms_output.put_line('Машина уже находится в этом магазине.');
    return;
  end if;

  update cars set store_id = p_store_id where id = p_car_id;
  dbms_output.put_line('Машина успешно перемещена.');
  exception
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end move_car;

create or replace procedure force_delete_car (
  p_car_id in number
) as
  v_count number;
begin 
  delete from preorders where car_id = p_car_id;
  delete from cars where id = p_car_id;
  exception 
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end force_delete_car;

create or replace procedure delete_car (
  p_car_id in number
) as
  v_count number;
begin 
  select count(*) into v_count from preorders where car_id = p_car_id;
  
  if v_count > 0 then
    dbms_output.put_line('На машину есть предзаказ, чтобы удалить используйте force_delete_car.');
    return;
  end if;

  delete from cars where id = p_car_id;
  exception 
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end delete_car;

