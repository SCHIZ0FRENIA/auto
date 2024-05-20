BEGIN
    add_store('TEST!1', 300);
    add_store('TEST!12', 300);
    add_store('TEST!13', 300);
    add_store('TEST!14', 300);
    add_store('TEST!15', 300);
    add_store('TEST!16', 300);
    add_store('TEST!17', 300);
    add_store('TEST!18', 300);
    add_store('TEST!19', 300);
    add_store('TEST!10', 300);
    add_store('TEST!11', 300);
    add_store('TEST!12', 300);
END;

BEGIN
    add_customer('Ivan Ivanov', 'ivanivanov', 'password123', '1234567890');
    add_customer('Petr Petrov', 'petrpetrov', 'password123', '1234567891');
    add_customer('Sidor Sidorov', 'sidorsidorov', 'password123', '1234567892');
    add_customer('Anna Ivanova', 'annaivanova', 'password123', '1234567893');
    add_customer('Elena Petrova', 'elenapetrova', 'password123', '1234567894');
    add_customer('Maria Sidorova', 'mariasidorova', 'password123', '1234567895');
    add_customer('Dmitry Ivanov', 'dmitryivanov', 'password123', '1234567896');
    add_customer('Olga Petrova', 'olgapetrova', 'password123', '1234567897');
    add_customer('Tatiana Sidorova', 'tatianasidorova', 'password123', '1234567898');
    add_customer('Sergey Ivanov', 'sergeyivanov', 'password123', '1234567899');
END;

select * from customers;

BEGIN
    add_car('Honda Civic', '2021', 22000, 1, 'Black', 'Petrol', 158);
    add_car('Ford Focus', '2019', 18000, 1, 'Red', 'Petrol', 160);
    add_car('Chevrolet Malibu', '2020', 24000, 2, 'Blue', 'Petrol', 160);
    add_car('Nissan Sentra', '2019', 19000, 2, 'Silver', 'Petrol', 149);
    add_car('Hyundai Elantra', '2021', 21000, 2, 'Gray', 'Petrol', 147);
    add_car('Mazda 3', '2020', 23000, 3, 'White', 'Petrol', 186);
    add_car('Kia Optima', '2019', 25000, 3, 'Black', 'Petrol', 178);
    add_car('Volkswagen Jetta', '2021', 26000, 3, 'Red', 'Petrol', 147);
    add_car('Subaru Impreza', '2020', 22000, 1, 'Blue', 'Petrol', 152);
    add_car('BMW 3 Series', '2021', 35000, 2, 'Black', 'Petrol', 255);
    add_car('Mercedes-Benz C-Class', '2020', 40000, 3, 'Silver', 'Petrol', 255);
END;

BEGIN
    add_manager('Ivan Ivanovich', 1);
    add_manager('Petr Petrovich', 1);
    add_manager('Sidor Sidorovich', 2);
    add_manager('Anna Ivanovna', 2);
    add_manager('Elena Petrovna', 3);
END;

begin 
  create_preorder(5, 1);
end;

commit;