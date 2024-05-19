
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

CREATE OR REPLACE PROCEDURE delete_store (
    p_store_id IN NUMBER
) AS
    v_store_exists NUMBER;
BEGIN
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

    DELETE FROM stores
    WHERE id = p_store_id;

    DBMS_OUTPUT.PUT_LINE('Магазин успешно удален.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END delete_store;

CREATE OR REPLACE FUNCTION search_store_by_address (
    p_address IN VARCHAR2
) RETURN NUMBER AS
    v_store_id NUMBER;
BEGIN
    IF p_address IS NULL OR LENGTH(TRIM(p_address)) = 0 THEN
        RETURN NULL;
    END IF;

    SELECT id
    INTO v_store_id
    FROM stores
    WHERE address = p_address;

    RETURN v_store_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END search_store_by_address;