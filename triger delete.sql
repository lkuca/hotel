Create Trigger guestkustutamine
on guest1
for delete
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
Select GETDATE(),USER,
CONCAT(deleted.first_name,', ',deleted.last_name),
'guest on lisatud'
From deleted
Delete from guest1 where id=1
select * from guest1;
select * from logi1;
