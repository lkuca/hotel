--Mitme avaldisega tabeliväärtusega funktsioonid

Create Function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select EmployeeKey,FirstName,Cast(BirthDate as Date) as DOB From DimEmployee);

Select * from fn_ILTVF_GetEmployees();


create Function fn_MSTVF_GetEmployees2()
Returns @Table Table (Id int, Name varchar(20), DOB Date)
as
Begin
Insert into @Table
Select EmployeeKey, FirstName,CAST(BirthDate as Date)
From DimEmployee
Return
End

select * from fn_MSTVF_GetEmployees();

Update fn_MSTVF_GetEmployees2() set Name='Sam 1' where id=1
select * from fn_MSTVF_GetEmployees2();

--Funktsiooniga seotud tähtsad kontseptsioonid

create function fn_GetEmployeeNameBuild(@id int)
Returns varchar(20)
as
Begin
Return(Select FirstName from DimEmployee where EmployeeKey=@id)
end

select dbo.fn_GetEmployeeNameBuild(1);



alter Function fn_GetEmployeeNameBuild(@Id int)
returns varchar(20)
with Encryption
as
Begin
Return (Select FirstName from dbo.DimEmployee where EmployeeKey = @Id)
End

select dbo.fn_GetEmployeeNameBuild(1);


drop table DimEmployee


--Ajutised tabelid

CREATE TABLE #PersonDetails(
Id int PRIMARY KEY,
Name VARCHAR(20))

INSERT INTO #PersonDetails VALUES(1,'Artem')
INSERT INTO #PersonDetails VALUES(2,'Matvei')
INSERT INTO #PersonDetails VALUES(3,'Sasha')
SELECT * FROM #PersonDetails

SELECT name FROM  tempdb.sys.all_objects
WHERE name LIKE '#PersonDetails%'



CREATE PROCEDURE spCreateLocalTempTable
AS
BEGIN
CREATE TABLE #PersonDetails(
Id int PRIMARY KEY,
Name VARCHAR(20))

INSERT INTO #PersonDetails VALUES(1,'Artem')
INSERT INTO #PersonDetails VALUES(2,'Matvei')
INSERT INTO #PersonDetails VALUES(3,'Sasha')
SELECT * FROM #PersonDetails
END

EXEC spCreateLocalTempTable

CREATE TABLE ##EmployeeDetails(Id int, Name NVARCHAR(20))
SELECT * FROM ##EmployeeDetails


--Ineksid serveris

select * from DimEmployee
select * from DimEmployee where BaseRate > 35 and BaseRate <50



create index IX_DimEmployee  where BaseRate > 35 and BaseRate < 50

Create index IX_DimEmployee_BaseRate 
on DimEmployee (BaseRate ASC)

select top 10 * from DimEmployee order by IX_DimEmployee_BaseRate

exec sys.sp_helpindex @Objname='DimEmployee'

drop index DimEmployee.IX_DimEmployee_BaseRate

--36. Klastreeritud ja mitte-klastreeritud indeksid

select * from DimEmployee;

execute sp_helpindex [tbEmployee];

create table [tbEmployee]
(
[id] int Primary Key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(10)
)

insert into [tbEmployee] Values(3,'John',4500,'Male','New York')
insert into [tbEmployee] Values(1,'Don',3400,'Male','London')
insert into [tbEmployee] Values(4,'Gan',6500,'Female','Tokyo')
insert into [tbEmployee] Values(5,'Pid',2100,'Female','Toronto')
insert into [tbEmployee] Values(2,'Onas',2400,'Male','Sydney')

Select * from [tbEmployee]

create Clustered Index IX_tbEmployee_Name
ON [tbEmployee](Name)

Drop index [tbEmployee].PK__tbEmploy__3213E83F65501ADA

create Clustered index IX_tblEmployee_Gender_Salary
on tbEmployee(Gender desc, Salary ASC)

Select * from tbEmployee

create NonClustered index IX_tbEmployee_Name
on tbEmployee(Name)

--37. Unikaalne ja mitte-unikaalne indeks

create table [tbEmployee]
(
[id] int Primary Key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(10)
)

execute sp_helpindex [tbEmployee];

insert into [tbEmployee] Values(1,'John',4500,'Male','New York')
insert into [tbEmployee] Values(1,'Don',3400,'Male','London')

drop index tbEmployee.PK__tbEmploy__3213E83F55419F46

Create Unique NonClustered Index UIX_tblEmployee_Name_City
on tbEmployee(Name desc, City ASC)

ALTER TABLE tbEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tbEmployee(City)
WITH IGNORE_DUP_KEY

--38. Indeksi plussid ja miinused

create table [tblEmployee]
(
[id] int primary key,
[FirstName] nvarchar(50),
[LastName] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(50)
)

insert into tblEmployee Values(1, 'Mike', 'Groshev', 5400, 'Male', 'New York')
insert into tblEmployee Values(2, 'Luca', 'Kerekesha', 7600, 'Female', 'Kyiv')
insert into tblEmployee Values(3, 'Max', 'Yanovich', 2300, 'Female', 'Moscow')
insert into tblEmployee Values(4, 'Mona', 'Grozny', 1200, 'Male', 'Tokyo')
insert into tblEmployee Values(5, 'Lisa', 'Veliky', 9100, 'Female', 'Las Vegas')

select * from tblEmployee;

create nonClustered index IX_tblEmployee_Salary
on tblEmployee (Salary Asc)

select * from tblEmployee where Salary>4000 and Salary<8000

delete from tblEmployee where Salary=2500
update tblEmployee Set Salary=9000 where Salary = 7500

select * from tblEmployee order by Salary desc

select Salary, count(Salary) as Total
from tblEmployee
Group by Salary


--39. View SQL serveris

create table tblEmployee
(
Id int Primary Key,
Name nvarchar(30),
Slary int,
Gender nvarchar(10),
DepartmentId int
)

create table tblDepartment
(
DeptId int Primary key,
DeptName nvarchar(20)
)

insert into tblDepartment values (1, 'IT')
insert into tblDepartment values (2, 'Payroll')
insert into tblDepartment values (3, 'HR')
insert into tblDepartment values (4, 'Admin')
insert into tblDepartment values (5, 'Stack')

insert into tblEmployee values (1, 'Luca', 3400, 'Male', 3)
insert into tblEmployee values (2, 'Max', 2300, 'Female', 1)
insert into tblEmployee values (3, 'Katya', 5000, 'Female', 2)
insert into tblEmployee values (4, 'Dasha', 1200, 'Male', 4)
insert into tblEmployee values (5, 'Masha', 6500, 'Female', 1)

select * from tblDepartment

select * from tblEmployee

select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

create view vWEmployeesByDepartment
as
Select  Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

select * from vWEmployeesByDepartment

create view vWITDepartment_Employees2
as
select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId
where tblDepartment.DeptName='IT'

select * from vWITDepartment_Employees2




create view vWEmployeesNonConfidentialData
as
select Id, Name, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId

select * from vWEmployeesNonConfidentialData


create view vwEmployeesCountByDepartment
as
select DeptName, COUNT(id) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.DeptId
Group by DeptName

select * from vwEmployeesCountByDepartment

--40. View uuendused


create view vWEmployeesDataExceptionSalary
as
select Id, Name, Gender, DepartmentId
from tblEmployee

select * from vWEmployeesDataExceptionSalary

update vWEmployeesDataExceptionSalary
set Name = 'Mikey' Where Id = 2

delete from vWEmployeesDataExceptionSalary where Id = 2
insert into vWEmployeesDataExceptionSalary values (2, 'Mikey', 'Male', 2)

create view vwEmployeeDetailsByDepartment
as
select Id, Name, Slary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId=tblDepartment.Deptid

select * from vwEmployeeDetailsByDepartment


Update vwEmployeeDetailsByDepartment
set DeptName='IT' where Name='John'

--41. Indekseeritud view-d

create table tblProduct
(
ProductId int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into tblProduct Values(1, 'Books', 20)
insert into tblProduct Values(2, 'Pens', 14)
insert into tblProduct Values(3, 'Pencils', 11)
insert into tblProduct Values(4, 'Clips', 10)

create table tblProductSales
(
ProductId int,
QuantitySold int
)

Insert into tblProductSales values(1, 10)
Insert into tblProductSales values(3, 23)
Insert into tblProductSales values(4, 21)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 13)
Insert into tblProductSales values(3, 12) 
Insert into tblProductSales values(4, 13) 
Insert into tblProductSales values(1, 11)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 14)

Create view vWTotalSalesByProduct
with SchemaBinding
as
Select Name,
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
group by Name
select * from vWTotalSalesByProduct


Image
Create Unique Clustered Index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct(Name)

select * from vWTotalSalesByProduct

--42. View piirangud

CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (1,'John', 5000, 'Male', 3)
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1)
Insert into tblEmployee values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmployee values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmployee values (6,'Ben', 4800, 'Male', 3)

Create View vWEmployeeDetails
@Gender nvarchar(20)
as
Select Id, Name, Gender, DepartmentId
from  tblEmployee
where Gender = @Gender

Create function fnEmployeeDetails(@Gender nvarchar(20))
Returns Table
as
Return 
(Select Id, Name, Gender, DepartmentId
from tblEmployee where Gender = @Gender)

Select * from dbo.fnEmployeeDetails('Male')

Create View vWEmployeeDetailsSorted
as
Select Id, Name, Gender, DepartmentId
from tblEmployee
order by Id

Create Table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

Insert into ##TestTempTable values(101, 'Martin', 'Male')
Insert into ##TestTempTable values(102, 'Joe', 'Female')
Insert into ##TestTempTable values(103, 'Pam', 'Female')
Insert into ##TestTempTable values(104, 'James', 'Male')

Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable

--92 DDL Trigger SQL Server

-- Loo DDL-triger, mis jälgib andmebaasisiseseid CREATE_TABLE sündmusi.
create trigger trMyNotFirstTrigger
on database
for CREATE_TABLE
as
begin
    print 'Uus tabel loodud'
end

-- Muuda olemasolevat trigerit, et see reageeriks ka ALTER_TABLE ja DROP_TABLE sündmustele.
alter trigger trMyNotFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
    print 'Tabelit on just loodud, muudetud või kustutatud'
end

DROP TABLE Test;

-- Muuda trigerit, et see takistaks tabelite loomist, muutmist või kustutamist.
alter trigger trMyNotFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit'
end

disable trigger trMyNotFirstTrigger on database

--93 Server-Scoped DDL triggerid
	
-- Loo andmebaasi ja serveri tasandi trigerid, mis reageerivad CREATE_TABLE, ALTER_TABLE ja DROP_TABLE sündmustele.
create trigger tr_DatabaseScopeTrigger
on database
for create_table, alter_table, drop_table
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit selles andmebaasis'
end

Create table Test (Id int)

-- Loo serveri tasandi triger, mis takistab tabelite loomist, muutmist või kustutamist serveri kõigis andmebaasides.
create trigger tr_ServerScopeTrigger
on all server
for create_table, alter_table, drop_table
as
begin
    rollback
    print 'Sa ei saa luua, muuta ega kustutada tabelit üheski andmebaasis serveris'
end

Create table Test (Id int)

disable trigger tr_ServerScopeTrigger on all server

Create table Test (Id int)

disable trigger trMyNotFirstTrigger on database;
disable trigger tr_DatabaseScopeTrigger on  database;

enable trigger tr_ServerScopeTrigger on all server

drop table Test

Create table Test (Id int)

drop trigger tr_ServerScopeTrigger on all server

--94 SQL Serveri trigerite täitmise järjekord
	
-- Määra trigerite täitmise järjekord tabeli loomisel andmebaasis.
exec sp_settriggerorder
@triggername = 'tr_DatabaseScopeTrigger',
@order = 'none',
@stmttype = 'create_table',
@namespace = 'database'

EXEC sp_helptrigger 'Test';

--96 Logon trigger SQL Serveris

-- Loo logon-triger, mis jälgib sisselogimissündmusi ja blokeerib liiga palju ühendusi.
create trigger tr_LogonAuditTriggers
on all server
for LOGON
as
begin
    declare @LoginName nvarchar(100)

    set @LoginName = ORIGINAL_LOGIN()

    if (select count(*) from sys.dm_exec_sessions
        where is_user_process=1
        and original_login_name = @LoginName) > 3
    begin
        print 'Neljas ühendus kasutajalt ' + @LoginName + ' on blokeeritud'
        rollback
    end
end

drop trigger tr_LogonAuditTriggers on all server

Execute sp_readerrorlog


