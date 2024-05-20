create role rl_manager;

grant create session to rl_manager;
grant execute on programmer.delete_car to rl_manager;
grant execute on programmer.delete_customer to rl_manager;
grant execute on programmer.delete_preorder to rl_manager;
grant execute on programmer.force_delete_car to rl_manager;
grant execute on programmer.force_delete_customer to rl_manager;
grant execute on programmer.move_car to rl_manager;
grant execute on programmer.update_customer to rl_manager;

create user test_manager identified by 12341234;
grant rl_manager to test_manager;

