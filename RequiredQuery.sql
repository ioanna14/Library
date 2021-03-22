use Library;

--a.2 queries with the union operation; use UNION [ALL] and OR;

-- all the cities where we have a library or employees
select City
from Libraries
union
select City
from Employees
order by City;

--all the employees that live in Cluj or on Decebal 1
select *
from Employees
where Adress = 'Decebal 1'
   or City = 'Cluj';


--b. 2 queries with the intersection operation; use INTERSECT and IN;

--all the cities where we have a library and where some employees live
select City
from Libraries
intersect
select City
from Employees
order by City;

--all the employees that live on Decebal 1 or Dacia 23
select *
from Employees
where Adress in ('Decebal 1', 'Dacia 23');


--c. 2 queries with the difference operation; use EXCEPT and NOT IN;

--all the cities where we have a library and where no employees live
select City
from Libraries
    except
select City
from Employees
order by City;

--all the employees that do not live on Decebal 1 or Dacia 23
select *
from Employees
where Adress not in ('Decebal 1', 'Dacia 23');


--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator);one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

-- the publisher/author/category of each book
select B.BID as ID, B.Title, A.Name as Author, C.Category, P.Name as Publisher
from Books B
         inner join Authors A
                    on B.AID = A.AID
         inner join Categories C
                    on C.CID = B.CID
         inner join Publishers P
                    on B.PBID = P.PBID;

-- all the books that we have in each library
select *
from Libraries L
         left join BooksLibraries BL
                   on L.PID = BL.PID
         left join Books B
                   on BL.BID = B.BID
         left join BooksReaders BR
                   on B.BID = BR.BID
         left join Readers R
                   on BR.REID = R.REID;

--all the books corresponding to each author
select B.BID as ID, B.Title, A.Name as Author
from Books B
         right join Authors A
                    on B.AID = A.AID;

--all the libraries and each corresponding manager
select *
from Libraries L
         full join Managers M
                   on L.PID = M.MID

--e. 2 queries with the IN operator and a subquery in the WHERE clause;
-- in at least one case, the subquery should include a
-- subquery in its own WHERE clause;

--all the books that are in each library
select *
from Books
where BID in (select BID from BooksLibraries where PID in (select PID from Libraries));

-- all the libraries where we have employees from the same city
select *
from Libraries
where City in (select City from Employees);


--f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;

-- all the libraries
select *
from Libraries L
where exists(select * from Employees E where E.Name = 'Monica');

-- all the books' titles
select B.Title
from Books B
where exists(select PID from Libraries);

--g. 2 queries with a subquery in the FROM clause;                                        

-- all the libraries with a changed id
select L.NewID, L.Name
from (select Libraries.Name, Libraries.PID * 2 as NewID from Libraries) L;

-- all the managers that have the id > 2
select M.Name, M.NewExperience
from (select Managers.Name, Managers.Experience + 2 as NewExperience from Managers where Managers.MID > 2) M;

--h. 4 queries with the GROUP BY clause, 3 of which also contain
-- the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause;
-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

-- how many books with the same title we have
select Books.Title, count(AID) as NumberOfBooks
from Books
group by Books.Title

-- the managers that have more total experience then 10 years
select Name as Manager, sum(Experience) as TotalExperience
from Managers
group by Name
having sum(Experience) >= 10;

-- all the employees that can do services
select E.PID, count(E.EID) as CountEmployees
from Employees E
group by E.PID
having E.PID in (select L.PID from Libraries L);

--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator);
-- rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

-- any employee that is working to a library with the id < 5
select Name
from Employees E
where E.PID =  any
(select E.PID from Libraries L where L.PID < 5);

select Name
from Employees E
where E.PID =  any
(select E.PID from Libraries L where L.PID in (1, 2, 3, 4));

-- any book that has the year of publication != 2000
select Title
from Books B
where B.BID >= any
(select A.AID from Authors A where B.YearOfPublication != 2000);

select Title
from Books B
where B.BID >= any
(select A.AID from Authors A where B.YearOfPublication not in (2000));

-- all the categories that have the id != from the books' categories id that have the author's id in 1, 2, 3, 5
select Category
from Categories C
where C.CID != all
(select B.CID from Books B where B.AID in (1, 2, 3, 5));

select Category
from Categories C
where C.CID != all
    (select B.CID
    from Books B
    group by B.CID having avg(B.AID) < 5);

-- all the managers that have the experience lower than the id from libraries that have the id not in 2, 4, 6
select Name
from Managers M
where M.Experience <= all
(select M.MID from Libraries L where L.PID not in(2, 4, 6));

select Name
from Managers M
where M.Experience <= all
    (select L.PID
    from Libraries L
    group by L.PID having sum(L.PID) in (2, 4, 6));