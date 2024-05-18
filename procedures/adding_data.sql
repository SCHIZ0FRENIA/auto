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



CREATE OR REPLACE PROCEDURE add_store (
    p_address IN VARCHAR2,
    p_capacity IN NUMBER
) AS
BEGIN
    IF p_address IS NULL OR LENGTH(TRIM(p_address)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Адрес магазина не может быть пустым.');
        RETURN;
    END IF;
    
    IF p_capacity IS NULL OR p_capacity <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Вместимость магазина должна быть положительным числом.');
        RETURN;
    END IF;

    INSERT INTO stores (id, address, capacity)
    VALUES (default, p_address, p_capacity);

    DBMS_OUTPUT.PUT_LINE('Новый магазин успешно добавлен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END add_store;



CREATE OR REPLACE PROCEDURE add_store (
    p_address IN VARCHAR2,
    p_capacity IN NUMBER
) AS
BEGIN
    IF p_address IS NULL OR LENGTH(TRIM(p_address)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Адрес магазина не может быть пустым.');
        RETURN;
    END IF;

    IF p_capacity IS NULL OR p_capacity <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Вместимость магазина должна быть положительным числом.');
        RETURN;
    END IF;

    INSERT INTO stores (id, address, capacity)
    VALUES (default, p_address, p_capacity);

    DBMS_OUTPUT.PUT_LINE('Новый магазин успешно добавлен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END add_store;

CREATE OR REPLACE PROCEDURE add_manager (
    p_name IN VARCHAR2,
    p_store_id IN NUMBER
) AS
    v_store_exists NUMBER;
BEGIN
    IF p_name IS NULL OR LENGTH(TRIM(p_name)) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Имя менеджера не может быть пустым.');
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

    INSERT INTO managers (id, name, store_id)
    VALUES (default, p_name, p_store_id);

    DBMS_OUTPUT.PUT_LINE('Новый менеджер успешно добавлен.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END add_manager;



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