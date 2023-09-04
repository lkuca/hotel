Create Trigger guestLisamine
on guest1
for insert
as
insert into logi1(kuupaev, kasutaja, andmed, tegevus)
Select GETDATE(),USER,
CONCAT(inserted.first_name,', ',inserted.last_name),
'guest on lisatud'
From inserted
insert into guest1(first_name,last_name,member_since)
values ('Alenka', 'Plenka', '2000-01-23');
SELECT * from guest1;
select * from logi1;
