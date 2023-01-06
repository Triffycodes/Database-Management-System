drop table Restaurant cascade constraints;
drop table Reviewer cascade constraints;
drop table Rating cascade constraints;
drop table Restaurant_Locations cascade constraints;

create table Restaurant(rID int, name varchar2(100), address varchar2(100), cuisine varchar2(100));
create table Reviewer(vID int, name varchar2(100));
create table Rating(rID int, vID int, stars int, ratingDate date);

insert into Restaurant values(101, 'India House Restaurant', '59 W Grand Ave Chicago, IL 60654', 'Indian');
insert into Restaurant values(102, 'Bombay Wraps', '122 N Wells St Chicago, IL 60606', 'Indian');
insert into Restaurant values(103, 'Rangoli', '2421 W North Ave Chicago, IL 60647', 'Indian');
insert into Restaurant values(104, 'Cumin', '1414 N Milwaukee Ave Chicago, IL 60622', 'Indian');
insert into Restaurant values(105, 'Shanghai Inn', '4723 N Damen Ave Chicago, IL 60625', 'Chinese');
insert into Restaurant values(106, 'MingHin Cuisine', '333 E Benton Pl Chicago, IL 60601', 'Chinese');
insert into Restaurant values(107, 'Shanghai Terrace', '108 E Superior St Chicago, IL 60611', 'Chinese');
insert into Restaurant values(108, 'Jade Court', '626 S Racine Ave Chicago, IL 60607', 'Chinese');

insert into Reviewer values(2001, 'Sarah M.');
insert into Reviewer values(2002, 'Daniel L.');
insert into Reviewer values(2003, 'B. Harris');
insert into Reviewer values(2004, 'P. Suman');
insert into Reviewer values(2005, 'Suikey S.');
insert into Reviewer values(2006, 'Elizabeth T.');
insert into Reviewer values(2007, 'Cameron J.');
insert into Reviewer values(2008, 'Vivek T.');

insert into Rating values( 101, 2001,2, to_DATE ('2011-01-22','yyyy-mm-dd'));
insert into Rating values( 101, 2001,4, to_DATE ('2011-01-27');
insert into Rating values( 106, 2002,4, null);
insert into Rating values( 103, 2003,2, to_DATE ('2011-01-20','yyyy-mm-dd'));
insert into Rating values( 108, 2003,4, to_DATE ('2011-01-12','yyyy-mm-dd'));
insert into Rating values( 108, 2003,2, to_DATE ('2011-01-30','yyyy-mm-dd'));
insert into Rating values( 101, 2004,3, to_DATE ('2011-01-09','yyyy-mm-dd'));
insert into Rating values( 103, 2005,3, to_DATE ('2011-01-27','yyyy-mm-dd'));
insert into Rating values( 104, 2005,2, to_DATE ('2011-01-22','yyyy-mm-dd'));
insert into Rating values( 108, 2005,4, null);
insert into Rating values( 107, 2006,3, to_DATE ('2011-01-15','yyyy-mm-dd'));
insert into Rating values( 106, 2006,5, to_DATE ('2011-01-19','yyyy-mm-dd'));
insert into Rating values( 107, 2007,5,to_DATE ('2011-01-20','yyyy-mm-dd'));
insert into Rating values( 104, 2008,3, to_DATE ( '2011-01-02','yyyy-mm-dd'));

select * from Restaurant;
select * from Reviewer;
select * from Rating;


create table Restaurant_Locations(rId int,
                               name varchar(30),
                               street_address varchar(20),
                               city varchar(10),
                               state varchar(5),
                               zipcode int,
                               cusine varchar(10));


declare
z_rid Restaurant_Locations.rID%TYPE;
z_name Restaurant_Locations.name%TYPE;
z_street_Address Restaurant_Locations.street_Address%TYPE;
z_city Restaurant_Locations.city%TYPE;
z_state Restaurant_Locations.state%TYPE;
z_zip Restaurant_Locations.zipcode%TYPE;
z_cusine Restaurant_Locations.cusine%TYPE;

CURSOR RES_LOC Is
   select rId,name,regexp_substr(address,'[0-9]{1,} [A-Z]{1,} [A-Z][a-z]{1,} [A-Z][a-z]{1,}') as street_Adrress,
       regexp_substr(address,'\w+',1,5) as City,
       regexp_substr(address,'\w+',1,6) as State,
       regexp_substr(address,'\w+',1,7) as Zip,cuisine
   from Restaurant;
BEGIN
open RES_LOC;
Loop  
   FETCH RES_LOC INTO z_rid,z_name,z_street_Address,z_city,z_state,z_zip,z_cusine;
   EXIT when RES_LOC%notfound;
   insert into
   Restaurant_Locations(rID,name,street_Address,city,state,zipcode,cusine)
   values(z_rid,z_name,z_street_Address,z_city,z_state,z_zip,z_cusine);
end Loop;
CLOSE RES_LOC;
end;
/

select * from Restaurant_Locations;