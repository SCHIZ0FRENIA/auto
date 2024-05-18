create or replace view store_capacity as
select s.id store_id, count(c.id) car_count
from stores s
join cars c on s.id = c.store_id
group by s.id order by s.id;