create role rl_head;

grant create session to rl_head;
grant execute on programmer.add_manager to rl_head;
grant execute on programmer.add_store to rl_head;
grant execute on programmer.delete_manager to rl_head;
grant execute on programmer.force_delete_customer to rl_head;
grant execute on programmer.load_customers_from_json to rl_head;
grant execute on programmer.load_managers_from_json to rl_head;
grant execute on programmer.save_customers_to_json to rl_head;
grant execute on programmer.save_managers_to_json to rl_head;
grant execute on programmer.search_manager to rl_head;

create user test_head identified by 12341234;
grant rl_head to test_head;