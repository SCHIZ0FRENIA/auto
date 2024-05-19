CREATE OR REPLACE PROCEDURE add_customer (
    p_name IN VARCHAR2,
    p_login IN VARCHAR2,
    p_password IN VARCHAR2,
    p_phone_number IN VARCHAR2
) AS
    v_exists NUMBER;
BEGIN
    IF p_name IS NULL OR LENGTH(TRIM(p_name)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Имя клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_login IS NULL OR LENGTH(TRIM(p_login)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Логин клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_password IS NULL OR LENGTH(TRIM(p_password)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Пароль клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_phone_number IS NULL OR LENGTH(TRIM(p_phone_number)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Телефонный номер клиента не может быть пустым.');
        RETURN;
    END IF;

    SELECT COUNT(*)
    INTO v_exists
    FROM customers
    WHERE login = p_login;

    IF v_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Логин уже существует.');
        RETURN;
    END IF;

    INSERT INTO customers (id, name, login, password, phone_number)
    VALUES (default, p_name, p_login, p_password, p_phone_number);

    DBMS_OUTPUT.PUT_LINE('Новый клиент успешно добавлен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END add_customer;

create or replace procedure delete_customer (
  p_customer_id in number
) as
  v_count number;
begin 
  select count(*) into v_count from preorders where customer_id = p_customer_id;
  
  if v_count > 0 then
    dbms_output.put_line('У данного пользователя есть предзаказы, чтобы удалить используйте force_delete_customer.');
    return;
  end if;

  delete from customers where id = p_customer_id;
  exception 
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end delete_customer;


create or replace procedure force_delete_customer (
  p_customer_id in number
) as
  v_count number;
begin 
  delete from preorders where customer_id = p_customer_id;
  delete from customers where id = p_customer_id;
  exception 
  when others then
    dbms_output.put_line('Ошибка: ' || sqlerrm);
end force_delete_customer;

create or replace procedure update_customer(
  p_customer_id in number,
  p_name IN VARCHAR2,
    p_login IN VARCHAR2,
    p_password IN VARCHAR2,
    p_phone_number IN VARCHAR2
) AS
    v_exists NUMBER;
BEGIN
    IF p_name IS NULL OR LENGTH(TRIM(p_name)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Имя клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_login IS NULL OR LENGTH(TRIM(p_login)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Логин клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_password IS NULL OR LENGTH(TRIM(p_password)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Пароль клиента не может быть пустым.');
        RETURN;
    END IF;

    IF p_phone_number IS NULL OR LENGTH(TRIM(p_phone_number)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Телефонный номер клиента не может быть пустым.');
        RETURN;
    END IF;

    SELECT COUNT(*)
    INTO v_exists
    FROM customers
    WHERE login = p_login;

    IF v_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Логин уже существует.');
        RETURN;
    END IF;

    update customers 
    set name = p_name, 
    login = p_login,
    password = p_password,
    phone_number = p_phone_number
    where id = p_customer_id;

    DBMS_OUTPUT.PUT_LINE('Клиент успешно изменен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
end update_customer;