# Write your MySQL query statement below
select u.user_id as buyer_id,join_date, count(distinct o.order_id) as orders_in_2019
from Users u
left join Orders o on u.user_id = o.buyer_id and 
year(o.order_date)= 2019
group by user_id

