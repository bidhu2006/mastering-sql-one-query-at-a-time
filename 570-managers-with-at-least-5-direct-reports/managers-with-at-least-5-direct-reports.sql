# Write your MySQL query statement below
# Manager with at least 5 direct reports
select e.name
from Employee e 
where e.id in(
    select managerId
    from Employee
    group by managerId
    having count(*)>=5
);

