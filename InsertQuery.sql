use Library

insert into Managers values 
(1,'Michael', 10 ),
(2,'Mary', 10 ),
(3,'Julianna', 2 );

select * from Managers;

insert into Libraries values
('Judeteana', 'Oradea' ),
('Babes-Boylai', 'Cluj' ),
('Central', 'NY'  );

select * from Libraries;

insert into Employees values 
('Monica', 'Decebal 1', '0712345678', 'Oradea', 1),
('John', 'Viilor 12D', '0789765432', 'Cluj', 2),
('Sergiu', 'Tatra 12', '0746544123', 'Cluj', 3),
('Clive', 'Dacia 23', '0748462211', 'Oradea', 1);


select * from Employees;

insert into Authors values
('JK Rowling', 'SF', 'Harry Potter'),
('Hanya Yanagihara', 'Romance', 'A Little Life'),
('Alain Mabanckou ', 'Comedy', 'Broken Glass');

select * from Authors;

insert into Publishers values
('Humanitas'),
('New Books'),
('Everyone Books');

select * from Publishers;

insert into Categories values
('Romance','The notebook'),
('Comedy', 'Broken Glass'),
('SF', 'The fantastic animals');

select * from Categories;

insert into Books values
('Broken Glass', 2005, 3, 2, 1),
('Harry Potter and the Goblet of Fire', 2000, 1, 3, 2),
('A Little Life', 2015, 2, 1, 3);

select * from Books

insert into BooksLibraries values
(2, 1),
(3, 1),
(3, 5),
(5, 2),
(6, 3);


--This is broken
insert into Fees values
('Late Return', 'Maria', 12);


