create trigger guestUUendamine
on guest1
for update
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
Select GETDATE(),USER,
CONCAT('vanad',
deleted.first_name,', ',deleted.last_name,
'uued',inserted.first_name, inserted.last_name),
'guest on uuendatud'
From deleted inner join inserted
on deleted.id=inserted.id

select * from guest1;
update guest1 set first_name='Luca'
Where id=3;
select * from guest1;
select * from logi1;
