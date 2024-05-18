select * from cars;

select * from managers;

select * from stores;

select * from customers;

select * from preorders;

select count(*) from cars where store_id = 1;

select capacity from stores where id = 1; 

delete from cars where model = 'Toyota Corolla';

delete from preorders where car_id = 1;

commit;