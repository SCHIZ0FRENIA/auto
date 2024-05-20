CREATE TABLE customers (
    id NUMBER generated always as identity PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    login VARCHAR2(100) NOT NULL UNIQUE,
    password VARCHAR2(100) NOT NULL,
    phone_number VARCHAR2(20)
);

CREATE TABLE stores (
    id NUMBER generated always as identity PRIMARY KEY,
    address VARCHAR2(255) NOT NULL,
    capacity NUMBER NOT NULL
);

CREATE TABLE managers (
    id NUMBER generated always as identity PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    store_id NUMBER not null,
    CONSTRAINT fk_managers_store_id FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE INDEX idx_managers_name ON managers(name);

CREATE TABLE cars (
    id NUMBER generated always as identity PRIMARY KEY,
    model VARCHAR2(100) NOT NULL,
    generation VARCHAR2(100) not null,
    price NUMBER NOT NULL,
    store_id NUMBER not null,
    color VARCHAR2(50) not null,
    fuel_type VARCHAR2(50) not null,
    horse_powers NUMBER not null,
    CONSTRAINT fk_cars_store_id FOREIGN KEY (store_id) REFERENCES stores(id)
);

ALTER TABLE cars ADD (search_text CLOB);

UPDATE cars
SET search_text = lower(model) || ' ' || lower(generation) || ' ' || lower(color) || ' ' || lower(fuel_type);

CREATE TABLE preorders (
    id NUMBER generated always as identity PRIMARY KEY,
    car_id NUMBER not null,
    customer_id NUMBER not null,
    total_cost NUMBER NOT NULL,
    CONSTRAINT fk_preorders_car_id FOREIGN KEY (car_id) REFERENCES cars(id),
    CONSTRAINT fk_preorders_customer_id FOREIGN KEY (customer_id) REFERENCES customers(id)
);

drop table preorders;
drop table cars;
drop table managers;
drop table stores;
drop table customers;

truncate table preorders;
truncate table cars;
truncate table managers;
truncate table stores;
truncate table customers;