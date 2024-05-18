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
  
end move_car;