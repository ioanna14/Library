use Library;

delete from Employees where EID is not NULL and PID = 2;

select * from Employees;

delete from Books where Title Like 'B%';

select * from Books;

delete from Categories where Bestseller in ('Broken Glass', 'Anna');

select * from Categories;