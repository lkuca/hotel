
select * from DimEmployee

Create TABLE [tblEmployee](
[id] int Primary Key,
[Name] nvarchar(50),
[Salary] int,
[Gender] nvarchar(10),
[City] nvarchar(50))

drop table [tblEmployee]

execute sp_helpindex tblEmployee

insert into tblEmployee Values(3,'John',4500,'Male','New York')
insert into tblEmployee Values(1,'Sam',2500,'Male','London')
insert into tblEmployee Values(4,'Sara',5500,'Female','Tokyo')
insert into tblEmployee Values(2,'Pam',6500,'Female','Sydney')
insert into tblEmployee Values(5,'Todd',3100,'Male','Toronto')

select * from tblEmployee

Create Clustered Index IX_tblEmployee_Gender_Salary
On [tblEmployee]([Gender] DESC, [Salary] ASC)
select * from [tblEmployee]

Drop index [tblEmployee].PK__tblEmplo__3213E83FEC21E326

create NonClustered Index IX_tblEmployee_Name
on tblEmployee(Name)



insert into tblEmployee values(1,'Mike','Sandoz',4500,'Male','New York')
insert into tblEmployee Values(1,'John','Menco',2500,'Male','London')


Insert into tblEmployee Values(1,'Mike', 'Sandoz',4500,'Male','New York')
Insert into tblEmployee Values(1,'John', 'Menco',2500,'Male','London')

create unique NonClustered Index UIX_tblEmployee_FirstName_LastName
on [tblEmployee]([Name], [City])



alter table [tblEmployee]
add constraint uq_tblEmployee_City
unique nonclustered([City])

EXECUTE SP_HELPCONSTRAINT [tblEmployee]

create unique index IX_tblEmployee_City
on [tblEmployee]([City])
with IGNORE_DUP_KEY


create table tblEmployee(
id int primary key,
Name nvarchar(30),
salary int,
Gender nvarchar(10),
DepartmentId int)

create table tblDepartment(
DeptId int Primary KEy,
DeptName nvarchar(20))

drop table tblDepartment
drop table tblEmployee
insert into tblDepartment values (1,'IT')
insert into tblDepartment values(2,'Payroll')
insert into tblDepartment values (3,'HR')
insert into tblDepartment values (4,'Admin')

insert into tblEmployee values (1,'john', 5000, ' Male',3)
insert into tblEmployee values(2,'Mike',3400,'MAle',2)
insert into tblEmployee values (3,'Pam',6000,'Female',1)
insert into tblEmployee values(4,'todd', 4800,'Male',4)
insert into tblEmployee values(5,'sara', 3200,'Female',1)
insert into tblEmployee values(6,'Ben', 4800,'Male',3)

select * from tblEmployee

select Id,Name,Salary,Gender,DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId

create view vWEmployeesByDepartment
as
select id,Name,Salary,Gender,DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId

select * from  vWEmployeesByDepartment

create View vWITDepartment_Eployees
as
select Id,Name,Salary,Gender,DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
where tblDepartment.DeptName = 'IT'

Select * from vWITDepartment_Eployees

create View vWEmpoyeesNonConfidentialData
as
Select Id,Name,Gender,DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId

select * from vWEmpoyeesNonConfidentialData


create view vWEmployeesCountByDepartment
as
Select DeptName,COUNT(Id) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
Group By DeptName

select * from vWEmployeesCountByDepartment


create table tblEmployee(
Id int Primary Key,
Name nvarchar(30),
Salary int,
Gender nvarchar(10),
DepartmentId int)


insert into tblEmployee values (1,'John', 5000,'Male',3)
insert into tblEmployee values(2,'Mike',3400,'Male',2)
insert into tblEmployee values(3,'Pam',6000,'Female',1)
insert into tblEmployee values(4,'todd', 4800,'Male',4)
insert into tblEmployee values(5,'Sara',3200,'female',1)
insert into tblEmployee values(6,'Ben',4800,'Male',3)

create view vWEmployeesDataExceptSalary
as
Select Id,Name,Gender,DepartmentId
from tblEmployee

select * from vWEmployeesDataExceptSalary

Update vWEmployeesDataExceptSalary
set Name = 'Mikey' where Id = 2

delete from vWEmployeesDataExceptSalary where Id = 2
Insert into vWEmployeesDataExceptSalary values(2,'Mikey','Male',2)


create table tble
