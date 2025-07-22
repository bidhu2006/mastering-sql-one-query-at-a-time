# Write your MySQL query statement below
SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM Employee e
join Department d on d.id = e.departmentid
where (e.departmentid, e.salary) in (select departmentid, MAX(salary)
from Employee 
group by departmentid
);
