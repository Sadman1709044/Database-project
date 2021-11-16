drop table coursess; 
drop table studentss; 
drop table admins; 
drop table stdreg;
create table admins( 
admincode integer not null,
username varchar(20) not null, 
passwords varchar(20) not null, 
primary key(admincode)
);
create table studentss( 
stu_id number(4) not null,
stu_name varchar(10) not null, 
course varchar(10) not null, 
year number(10) not null, 
contact varchar(10) not null,
age number(10) not null, 
gender varchar(12) , 
primary key(stu_id)
);
create table coursess(
course_id number(5) not null, 
description varchar(20) not null, 
credit number(10,2) not null, 
type varchar(20) not null, 
stu_id number(4) not null, 
primary key(course_id),
foreign key(stu_id) references studentss(stu_id)
);
ALTER TABLE coursess
MODIFY credit number(10,3);
ALTER TABLE coursess
MODIFY course_id integer;
create table stdreg(
stureg_id number(5) not null,
stu_names varchar(15) not null, 
department varchar(15) not null, 
course varchar(15) not null, 
regdate number(11) not null, 
primary key(stureg_id)
);
/*altering the tables*/
/*insert admin*/
insert into admins values(1,'sadman','abcgujd'); 
insert into admins values(2,'Dr Andrew','fsfsf');
UPDATE admins
set username='sadman' where admincode=1;
/*insert studentss*/
insert into studentss values(01,'A Sultana','EPD',2020,'057',22,'Female'); 
insert into studentss values(02,'F Rashid','IT',2020,'085',22,'Female'); 
insert into studentss values(03,'Abu ','DSP',2020,'068',24,'Male');
insert into studentss values(04,'Biswas','DSP Lab',2020,'0975',23,'Male'); 
insert into studentss values(05,'Debnath','DCOM',2020,'0256',23,'Male');
/*insert coursess*/
insert into coursess values(3200,'EPD',1.5,'Sessin',01);
insert into coursess values(3201,'IT',3,'Theory',01); 
insert into coursess values(3203,'DSP',3,'Theory',02);
insert into coursess values(3204,'DSP Lab',0.75,'Sessin',02); 
insert into coursess values(3205,'DCOM',3,'Theory',03);
/*insert stdregistration*/
insert into stdreg values(1001,'Thomas','CSE','EPD',2020); 
insert into stdreg values(1002,'Jordan','CSE','IT',2021); 
insert into stdreg values(1003,'Jessica','EEE','DSP',2019);
insert into stdreg values(1004,'Martina','CSE','DSP Lab',2020); 
insert into stdreg values(1005,'Shan','CSE','DCOM',2021);
/*showing studentss and coursess with default values*/
select stu_id,stu_name,course,year,contact,age,gender from studentss; 
select course_id from courses;
/*updating studentss table and coursess table*/ 
update studentss set gender='male' where stu_id=01; 
update studentss set gender='female' where stu_id=03; 
update studentss set gender='female' where stu_id=05;
/*showing studentss and coursess without default values*/
select stu_id,stu_name,course from studentss;
select course_id from courses;
/*Set Operations*/
select stu_id as ID,stu_name,course,contact from studentss; 
union
select course_id,stu_id from courses;
select stu_id as ID,course,gender from studentss; 
intersect
select stu_id as ID,stu_name,course from studentss;
/*Aliasing and Subquery*/
select
s.stu_id,s.stu_name as coursess,s.age from studentss s,coursess c
where c.stu_id in(select stu_id from studentss where age>=20 and 
age<=23)
and s.stu_id=c.stu_id;
/*Inner Join Operation*/
select c.description,c.credit,s.stu_name,s.course 
from coursess c
inner join studentss s on s.stu_id = c.course_id;
/*Right Outer Join*/
select s.stu_id,c.description,c.credit,s.stu_name,s.course
from coursess c
right join studentss s on c.course_id= s.stu_id 
where year= 2020
order by s.stu_id;
/*Left Outer Join*/
select s.stu_id,c.description,s.stu_name,c.credit,s.course 
from coursess c
left join studentss s on c.course_id = s.stu_id 
order by s.course;
/*Cross Join*/
select c.description,c.credit,s.stu_name ,s.age,s.gender,s.year,s.course 
from coursess c
cross join studentss s;
/*Natural Join*/
select c.description,c.credit,s.course,s.stu_name 
from coursess c
natural join studentss s;
/*Full Outer Join*/
select s.stu_id, s.stu_name,s.course ,s.year,c.description,c.credit,s.gender
from coursess c full outer join studentss s on c.course_id = s.stu_id 
order by s.year;
/*PLSQL*/
/*Maximum Age of Studentss Table*/
set serveroutput on 
declare max_age 
studentss.age%type; 
stu_name 
studentss.stu_name%type; 
begin
select max(age) into max_age from studentss;
select stu_name into stu_name from studentss where age=max_age;
dbms_output.put_line(stu_name||'is got the maximum age of'|| max_age||' 
years');
end;
/
/*Input and Conditions*/ 
set serveroutput on 
declare
stu_name studentss.stu_name%type; 
age studentss.age%type;
statement varchar(20);
begin 
stu_name:='&x';
select age into age from studentss where stu_name=stu_name; 
if age<20 and age>12 then
statement:='a teenager'; 
elsif age>19 then 
statement:='an adult'; 
else
statement:='Not clear'; 
end if;
dbms_output.put_line(stu_name||' is '||statement); 
exception
when others then
dbms_output.put_line('Enter the correct name with correct case'); 
end;
/ 
commit;