
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

CREATE OR REPLACE PROCEDURE delete_manager (
    p_manager_id IN NUMBER
) AS
    v_manager_exists NUMBER;
BEGIN
    IF p_manager_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Идентификатор менеджера не может быть пустым.');
        RETURN;
    END IF;

    SELECT COUNT(*)
    INTO v_manager_exists
    FROM managers
    WHERE id = p_manager_id;

    IF v_manager_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: Менеджер с таким идентификатором не существует.');
        RETURN;
    END IF;

    DELETE FROM managers
    WHERE id = p_manager_id;

    DBMS_OUTPUT.PUT_LINE('Менеджер успешно удален.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLERRM);
END delete_manager;

CREATE OR REPLACE FUNCTION search_manager_by_name (
    p_name IN VARCHAR2
) RETURN NUMBER AS
    v_manager_id NUMBER;
BEGIN
    IF p_name IS NULL OR LENGTH(TRIM(p_name)) = 0 THEN
        RETURN NULL;
    END IF;

    SELECT id
    INTO v_manager_id
    FROM managers
    WHERE name = p_name;

    RETURN v_manager_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END search_manager_by_name;