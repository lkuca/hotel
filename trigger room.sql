Create trigger roomlisamine
on room
for delete
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
SELECT getdate(),user,
CONCAT(inserted.number,inserted.name,inserted.status,inserted.smoke),
'room on lisatud'
From inserted

insert into room(number,name,status,smoke)
values ('1', 'Plenka', 'active',1);
SELECT * from room;
select * from logi1;

Create trigger roomkustutamine
on room
for insert
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
SELECT getdate(),user,
CONCAT(deleted.number,deleted.name,deleted.status,deleted.smoke),
'room on lisatud'
From deleted

delete from room where id=1
select * from room;
select * from logi1;

Create trigger roomUuendamine
on room
for insert
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
SELECT getdate(),user,
CONCAT(deleted.number,deleted.name,deleted.status,deleted.smoke,inserted.number,inserted.name,inserted.status,inserted.smoke),
'room on lisatud'
From deleted inner join inserted
on deleted.id=inserted.id

select * from room;
update room set name='Luca'
Where id=3;
select * from room;
select * from logi1;
