--funkts.loomine 32
create Function fn_ILTVF_GetEmpleey()
returns Table
as
return (Select EmployeeKey,FirstName,CAST(BirthDate as date) as DOB From DimEmployee);

select * from fn_ILTVF_GetEmpleey() ;

create function fn_ILTVF_GetEmpleey1()
returns @Table Table(Id int, Name varchar(20),DOB DATE)
as
begin
Insert into @Table
select EmployeeKey,FirstName,CAST(BirthDate as date)
From DimEmployee
return
END

select * from fn_ILTVF_GetEmpleey1();

update fn_ILTVF_GetEmpleey() set FirstName='Sam123' where EmployeeKey = 1;
select * from fn_ILTVF_GetEmpleey();
Update fn_ILTVF_GetEmpleey1() set Name= 'Sam2' where Id = 1;
--funktsiooni loomine 33
select * from DimEmployee;

Create Function fn_GetEmployeeNameByld(@id int)
returns nvarchar(20)
as
Begin
Return (Select FirstName from DimEmployee where EmployeeKey = @id)
end

select dbo.fn_GetEmployeeNameByld(1);



alter function fn_GetEmployeeNameByld(@id int)
returns nvarchar(20)
with Encryption
as
begin
return ( select FirstName from dbo.DimEmployee where EmployeeKey = @id)
end


alter function fn_GetEmployeeNameByld(@id int)
returns varchar(20)
with Schemabinding
as
begin
return ( select FirstName from dbo.DimEmployee where EmployeeKey = @id)
end
--ajutine tabelid 34
CREATE TABLE #PersonDetails(
Id int PRIMARY KEY,
Name VARCHAR(20))

INSERT INTO #PersonDetails VALUES(1,'Artem')
INSERT INTO #PersonDetails VALUES(2,'Matvei')
INSERT INTO #PersonDetails VALUES(3,'Sasha')
SELECT * FROM #PersonDetails


SELECT name FROM  tempdb.sys.all_objects
WHERE name LIKE '#PersonDetails%'

DROP TABLE #PersonDetails

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
--indeksite loomine
Create index IX_tblEmployee_Salary
on DimEmployee (BaseRate ASC)

Execute sys.sp_helptext @Objname = 'DimEmployee'

drop INDEX DimEmployee.IX_tblEmployee_Salary
