create procedure lisaGuest
@fName varchar(100),
@lname varchar(100),
@sinse date
as
begin
insert into guest1(first_name, last_name,member_since)
values (@fName, @lname, @sinse);
select * from guest1;
select* from logi1;
End;

exec lisaGuest 'Deniss', 'Gorjunov','2002-10-9';


create procedure deleteGuest
@id int
as
begin
select *from guest1;
delete from guest1
where @id=id;
select * from guest1;
select * from logi1;
END;

exec deleteGuest 4;

create procedure updateGuest
@id int
as 
begin
select * from guest1;
delete from guest1
where @id=id;
select * from guest1;
insert into guest1(first_name, last_name,member_since)
values (@fName, @lname, @sinse);
select * from guest1;
select* from logi1;
End;
