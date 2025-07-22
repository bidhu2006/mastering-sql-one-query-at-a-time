# Write your MySQL query statement below
SELECT sell_date, count(distinct product) as num_sold, Group_concat(distinct product order by product)as products
from Activities
group by sell_date
order by sell_date;