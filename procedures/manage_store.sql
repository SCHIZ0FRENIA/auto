
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

