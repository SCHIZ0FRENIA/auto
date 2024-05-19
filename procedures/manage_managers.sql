
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
