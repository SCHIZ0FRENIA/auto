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
