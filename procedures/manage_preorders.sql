create or replace procedure create_preorder(
  p_car_id in number,
  p_customer_id in number
) as
  v_exists number;
begin
  select count (*) into v_exists from cars where id = p_car_id;
  if v_exists = 0 then
    dbms_output.put_line('Ошибка: Машины с таким id не существует.');
    return;
  end if;

  select count(*) into v_exists from customers where id = p_customer_id;
  if v_exists = 0 then 
    dbms_output.put_line('Ошибка: Пользователя с таким id не существует.');
    return;
  end if;
  
  select count(*) into v_exists from preorders where car_id = p_car_id;
  if v_exists > 0 then 
    dbms_output.put_line('Ошибка: Машина уже предзаказана.');
    return;
  end if;

  select price into v_exists from cars where id = p_car_id;
  insert into preorders(id, car_id, customer_id, total_cost)
  values (default, p_car_id, p_customer_id, v_exists);

  dbms_output.put_line('Машина успешно предзаказана.');

  exception
  when others then 
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end create_preorder;

create or replace procedure delete_preorder(
  p_preorder_id number
) as
  v_count number;
begin
  delete from preorders where id = p_preorder_id;
  dbms_output.put_line('Предзаказ успешно удален.');
  exception
  when others then 
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end delete_preorder;

CREATE OR REPLACE FUNCTION search_preorder (
    p_car_id IN NUMBER,
    p_customer_id IN NUMBER
) RETURN NUMBER AS
    v_preorder_id NUMBER;
BEGIN
    IF p_car_id IS NULL OR p_customer_id IS NULL THEN
        RETURN NULL;
    END IF;

    SELECT id
    INTO v_preorder_id
    FROM preorders
    WHERE car_id = p_car_id AND customer_id = p_customer_id;

    RETURN v_preorder_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END search_preorder;