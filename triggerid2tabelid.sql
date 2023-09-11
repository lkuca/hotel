create table guest(
id int primary key identity(1,1),
first_name varchar(80),
last_name varchar(80) null,
member_since date);

create table room_type(
id int primary key identity(1,1),
description_ varchar(80),
max_capacity int);

create table reservation(
id int primary key identity(1,1),
date_in date,
date_out date,
made_by varchar (20),
guest_id int,
foreign key (guest_id) references guest (id));

create table reserved_room(
id int primary key identity(1,1),
number_of_rooms int,
room_type_id int,
foreign key (room_type_id) references room_type(id),
reservation_id int,
foreign key (reservation_id) references reservation(id),
status_ varchar(20));

insert into reserved_room(number_of_rooms, status_)
values(1, 'active');
insert into reserved_room(number_of_rooms, status_)
values(2, 'active');
insert into reserved_room(number_of_rooms, status_)
values(3, 'deactive');
insert into reserved_room(number_of_rooms, status_)
values(4, 'deactive');
insert into reserved_room(number_of_rooms, status_)
values(5, 'active');

insert into guest(first_name, last_name, member_since)
values ('Alenka', 'Plenka', '2000-01-23');
insert into guest(first_name, last_name, member_since)
values('Kiril' ,'Blinchik','2000-02-12');
insert into guest(first_name, last_name, member_since)
values('Sasha','Durslakov','2000-01-10');
insert into guest(first_name, last_name, member_since)
values('Pasha', 'Opolovnik', '2000-02-09');
insert into guest(first_name, last_name, member_since)
values('Luca','Chihulja','2000-05-09');

insert into room_type(description_,max_capacity)
values('asdasdadasd',4);
insert into room_type(description_,max_capacity)
values('sfadsadafds',5);
insert into room_type(description_,max_capacity)
values('bjghjfigh',2);
insert into room_type(description_,max_capacity)
values('fdslkdj',1);
insert into room_type(description_,max_capacity)
values('fdjggjdfjg',3);

insert into reservation(date_in, date_out, made_by)
values('2000-01-10', '2000-02-10', 'china');
insert into reservation(date_in, date_out, made_by)
values('2000-03-10', '2000-04-10', 'Inglant');
insert into reservation(date_in, date_out, made_by)
values('2000-05-10', '2000-06-10','Canada');
insert into reservation(date_in, date_out, made_by)
values('2000-07-10', '2000-08-10', 'Estonia');
insert into reservation(date_in, date_out, made_by)
values('2000-09-10', '2000-010-10','France');

create table logi1(
id int primary key identity(1,1),
andmed text,
kuupaev datetime,
kasutaja varchar(100));


select * from guest
select * from room_type
select * from reservation

create trigger reslisamine
on reservation
for insert
as
INSERT INTO logi1(kuupaev,andmed,kasutaja)
SELECT GETDATE(),
CONCAT(inserted.made_by,', ',reservation.guest_id),
USER
from inserted
inner join reservation on inserted.guest_id= reservation.guest_id

insert into reservation(made_by, guest_id)
Values('koklahoma',null);
Select * from reservation;
select * from logi1;

create trigger  resupdate
on reservation
for UPDATE
as
INSERT INTO logi(kuupaev,andmed,kasutaja)
SELECT GETDATE(),
CONCAT('vanad andmed',deleted.made_by,', ',g1.first_name,'uued andmed',inserted.made_by, ',',g2.first_name),
USER
from deleted
inner join inserted on deleted.id=inserted.id
inner join guest g1 on deleted.id=g1.id
inner join guest g2 on inserted.id=g2.id

select * from reservation;
update reservation set guest_id=1
where made_by = 'Lcua fgdkgj'
Select * from reservation;
select * from logi1;


