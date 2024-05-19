create role rl_customer;

grant create session to rl_customer;
grant execute on programmer.create_preorder to rl_customer;
grant execute on programmer.delete_preorder to rl_customer;
grant execute on programmer.add_customer to rl_customer;
grant execute on programmer.delete_customer to rl_customer;
grant execute on programmer.update_customer to rl_customer;

create user cust_test identified by 12341234;
grant rl_customer to cust_test;