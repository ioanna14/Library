create database Library;
use Library;

create table Libraries (
PID int primary key identity(1,1), 
Name varchar(50),
City varchar(50))

create table Managers (
MID int foreign key references Libraries(PID),
Name varchar(50) NOT NULL,
Experience int, 
Constraint pk_LibrariesManagers primary key(MID))

create table Employees (
EID int primary key identity,
Name varchar(50),
Adress varchar(100),
Phone int,
City varchar(50),
PID int foreign key references Libraries(PID))

create table Authors (
AID int primary key identity(1,1),
Name varchar(50),
Category varchar(50),
Bestseller varchar(100) )

create table Categories (
CID int primary key identity(1,1),
Category varchar(50), 
Bestseller varchar(100) )

create table Publishers (
PBID int primary key identity(1,1),
Name varchar(50) )

create table Books (
BID int primary key identity(1,1),
Title varchar(100),
YearOfPublication int,
AID int foreign key references Authors(AID),
CID int foreign key references Categories(CID),
PBID int foreign key references Publishers(PBID))

create table BooksLibraries(
BID int foreign key references Books(BID),
PID int foreign key references Libraries(PID)
constraint pk_Books primary key (BID, PID))


create table Readers (
REID int primary key identity(1,1),
Name varchar(50), 
Adress varchar(100),
Phone int,
City varchar(50) )

create table BooksReaders (
BID int foreign key references Books(BID),
REID int foreign key references Readers(REID)
constraint pk_Readers primary key (BID, REID) )


create table Rentals (
RID int primary key identity(1,1),
Reader int, 
Book varchar(100),
RentedDate varchar(10),
ReturnedDate varchar(10),
REID int foreign key references Readers(REID))

create table Fees (
FID int primary key identity,
Type varchar(50),
Name varchar(50),
RID int foreign key references Rentals(RID) )
