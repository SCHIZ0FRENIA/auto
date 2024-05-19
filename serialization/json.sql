CREATE OR REPLACE PROCEDURE save_customers_to_json AS
    l_file UTL_FILE.file_type;
    l_json CLOB;
BEGIN
    SELECT JSON_ARRAYAGG(
             JSON_OBJECT(
                 'name' VALUE name,
                 'login' VALUE login,
                 'password' VALUE password,
                 'phone_number' VALUE phone_number
             ) RETURNING CLOB
           ) INTO l_json
    FROM customers;

    l_file := UTL_FILE.fopen('SERIALIZATION', 'customers.json', 'w');

    UTL_FILE.put_line(l_file, l_json);

    UTL_FILE.fclose(l_file);

    DBMS_OUTPUT.put_line('JSON file has been created successfully.');
END save_customers_to_json;

CREATE OR REPLACE PROCEDURE load_customers_from_json AS
    l_file UTL_FILE.file_type;
    l_json CLOB;
    l_customer_exists NUMBER;
BEGIN
    l_file := UTL_FILE.fopen('SERIALIZATION', 'customers.json', 'r');

    UTL_FILE.get_line(l_file, l_json);

    UTL_FILE.fclose(l_file);
    
    INSERT INTO customers (name, login, password, phone_number)
    SELECT jt.name, jt.login, jt.password, jt.phone_number
    FROM JSON_TABLE(
        l_json,
        '$[*]'
        COLUMNS (
            name VARCHAR2(100) PATH '$.name',
            login VARCHAR2(100) PATH '$.login',
            password VARCHAR2(100) PATH '$.password',
            phone_number VARCHAR2(100) PATH '$.phone_number'
        )
    ) jt
    WHERE NOT EXISTS (
        SELECT 1
        FROM customers
        WHERE customers.login = jt.login
    );

    l_customer_exists := SQL%ROWCOUNT;
    
    IF l_customer_exists > 0 THEN
        DBMS_OUTPUT.put_line('Customer already exists. Procedure cancelled.');
        RETURN;
    END IF;

    DBMS_OUTPUT.put_line('Data has been loaded from JSON file successfully.');
END load_customers_from_json;

CREATE OR REPLACE PROCEDURE save_managers_to_json AS
    l_file UTL_FILE.file_type;
    l_json CLOB;
BEGIN
    SELECT JSON_ARRAYAGG(
             JSON_OBJECT(
                 'id' VALUE id,
                 'name' VALUE name,
                 'store_id' VALUE store_id
             ) RETURNING CLOB
           ) INTO l_json
    FROM managers;

    l_file := UTL_FILE.fopen('SERIALIZATION', 'managers.json', 'w');

    UTL_FILE.put_line(l_file, l_json);

    UTL_FILE.fclose(l_file);

    DBMS_OUTPUT.put_line('JSON file has been created successfully.');
END save_managers_to_json;

CREATE OR REPLACE PROCEDURE load_managers_from_json AS
    l_file UTL_FILE.file_type;
    l_json CLOB;
BEGIN
    l_file := UTL_FILE.fopen('SERIALIZATION', 'managers.json', 'r');

    UTL_FILE.get_line(l_file, l_json);

    UTL_FILE.fclose(l_file);
    
    INSERT INTO managers (name, store_id)
    SELECT jt.name, jt.store_id
    FROM JSON_TABLE(
        l_json,
        '$[*]'
        COLUMNS (
            name VARCHAR2(100) PATH '$.name',
            store_id NUMBER PATH '$.store_id'
        )
    ) jt;

    DBMS_OUTPUT.put_line('Data has been loaded from JSON file successfully.');
END load_managers_from_json;

CREATE OR REPLACE PROCEDURE load_managers_from_json AS
    l_file         UTL_FILE.file_type;
    l_json         CLOB;
    l_buffer       VARCHAR2(32767);
    l_amount       BINARY_INTEGER := 32767;
    l_file_dir     VARCHAR2(30) := 'SERIALIZATION';
    l_file_name    VARCHAR2(30) := 'managers.json';

    l_json_list    JSON_ARRAY_T;
    l_json_elem    JSON_ELEMENT_T;
    l_json_obj     JSON_OBJECT_T;
    l_name         VARCHAR2(100);
    l_store_id     NUMBER;
BEGIN
    l_file := UTL_FILE.fopen(l_file_dir, l_file_name, 'r');
    
    DBMS_LOB.createtemporary(l_json, TRUE);
    
    LOOP
        BEGIN
            UTL_FILE.get_line(l_file, l_buffer, l_amount);
            DBMS_LOB.writeappend(l_json, LENGTH(l_buffer), l_buffer);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;

    UTL_FILE.fclose(l_file);

    l_json_list := JSON_ARRAY_T.parse(l_json);
    
    FOR i IN 0 .. l_json_list.get_size - 1 LOOP
        l_json_elem := l_json_list.get(i);
        l_json_obj := TREAT(l_json_elem AS JSON_OBJECT_T);

        l_name := l_json_obj.get_String('name');
        l_store_id := l_json_obj.get_Number('store_id');

        INSERT INTO managers ( name, store_id)
        VALUES ( l_name, l_store_id);
    END LOOP;

    DBMS_OUTPUT.put_line('Data has been loaded successfully from the JSON file.');
    
    DBMS_LOB.freetemporary(l_json);

EXCEPTION
    WHEN OTHERS THEN
        IF UTL_FILE.is_open(l_file) THEN
            UTL_FILE.fclose(l_file);
        END IF;
        
        IF DBMS_LOB.istemporary(l_json) = 1 THEN
            DBMS_LOB.freetemporary(l_json);
        END IF;
        
        RAISE;
END load_managers_from_json;

begin load_managers_from_json; end;

select * from managers where name like 'coffey leach bobbie';

select index_name, table_name from all_indexes where table_name = 'MANAGERS';

alter table managers drop primary key;
alter table managers add primary key (id);

commit;
select count(*) from managers;