use Library;

update Publishers
set Name = 'Big 5'
where Name = 'Everyone Books';

select * from Publishers;

update Employees
set City = 'Bucharest'
where PID < 3 and EID >= 2;

select * from Employees;

update Books
set YearOfPublication = 2020
where YearOfPublication between 2003 and 2010;

select * from Books;