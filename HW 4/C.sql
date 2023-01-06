CREATE TABLE SOCIALNETWORK
(
  PERSON       VARCHAR2(25) NOT NULL,
  FRIEND       VARCHAR2(25) NOT NULL
);
DROP TABLE SOCIALNETWORK;

--====================================================================================

insert into SocialNetwork values ('Amy', 'Brad');
insert into SocialNetwork values ('Amy', 'Christine');
insert into SocialNetwork values ('Amy', 'Edgar');
insert into SocialNetwork values ('Brad', 'Fiona');
insert into SocialNetwork values ('Brad', 'Gary');
insert into SocialNetwork values ('Brad', 'Hannah');
insert into SocialNetwork values ('Christine', 'Hannah');
insert into SocialNetwork values ('Christine', 'Ingrid');
insert into SocialNetwork values ('Christine', 'Dave');
insert into SocialNetwork values ('Dave', 'Ingrid');
insert into SocialNetwork values ('Dave', 'Kate');
insert into SocialNetwork values ('Dave', 'James');
insert into SocialNetwork values ('Dave', 'Leo');
insert into SocialNetwork values ('Edgar', 'Kate');
insert into SocialNetwork values ('Edgar', 'Melissa');
insert into SocialNetwork values ('Edgar', 'Nicole');
insert into SocialNetwork values ('Fiona', 'Amy');    
insert into SocialNetwork values ('Gary', 'Oliver');
insert into SocialNetwork values ('Hannah', 'Quincey');
insert into SocialNetwork values ('James', 'Quincey');
insert into SocialNetwork values ('Melissa', 'Leo');
insert into SocialNetwork values ('Oliver', 'Fiona');
insert into SocialNetwork values ('Oliver', 'Penny');
insert into SocialNetwork values ('Quincey', 'James');

select * from SOCIALNETWORK;

--====================================================================================

--C) 1)People to whom Brad can reach to either directly or transitively.

WITH DIRECTFRIEND(P,F) AS (
(SELECT PERSON AS P, FRIEND AS F  FROM SocialNetwork)
UNION ALL
(SELECT DF1.P,DF2.FRIEND
FROM DIRECTFRIEND DF1, SOCIALNETWORK DF2
WHERE DF1.F=DF2.PERSON)
)CYCLE F SET IS_CYCLE TO 1 DEFAULT 0
SELECT DISTINCT F FROM DIRECTFRIEND  WHERE P='Brad' AND F!='Brad' AND IS_CYCLE=0;

--====================================================================================

--2)People in DePauledIN network to whom Brad cannot reach to.

WITH DIRECTFRIEND(P,F) AS (
(SELECT PERSON AS P, FRIEND AS F  FROM SocialNetwork)
UNION ALL
(SELECT DF1.P,DF2.FRIEND
FROM DIRECTFRIEND DF1, SOCIALNETWORK DF2
WHERE DF1.F=DF2.PERSON)
)CYCLE F SET IS_CYCLE TO 1 DEFAULT 0
SELECT DISTINCT F FROM DIRECTFRIEND  WHERE P!='Brad' AND F!='Brad' AND IS_CYCLE=0;


--====================================================================================

--3)Only those people who are connected to Christine via transitive relationship i.e not an immediate follower.

WITH DIRECTFRIEND(P,F) AS (
(SELECT PERSON AS P, FRIEND AS F  FROM SocialNetwork)
UNION ALL
(SELECT DF1.P,DF2.FRIEND
FROM DIRECTFRIEND DF1, SOCIALNETWORK DF2
WHERE DF1.F=DF2.PERSON)
)CYCLE F SET IS_CYCLE TO 1 DEFAULT 0
SELECT DISTINCT F FROM DIRECTFRIEND  WHERE P!='Christine' AND F!='Christine' AND IS_CYCLE=0;


--====================================================================================

--4)Find the shortest path to reach from Amy to James.
create or replace function EvalMath( math varchar2 ) return number is
         n       number;
 begin
         execute immediate
                 'begin :0 := '||math||'; end;'
         using out n;
 
         return( n );
 end;


with paths(person,friend,distance) as (
select 'Amy' , 'Brad'      , 1  from SocialNetwork union all
select 'Amy' , 'Christine' , 1 from socialnetwork union all
select 'Amy' , 'Edgar'     , 1 from socialnetwork union all
select 'Brad' , 'Fiona'     , 1 from socialnetwork union all
select 'Brad' , 'Gary'      , 1 from socialnetwork union all
select 'Brad' , 'Hannah'    , 1  from socialnetwork union all
select 'Christine' , 'Hannah'    , 1 from socialnetwork union all
select 'Christine' , 'Ingrid'    , 1  from socialnetwork union all
select 'Christine' , 'Dave'      , 1  from socialnetwork union all
select 'Dave' ,    'Ingrid'    , 1  from socialnetwork union all
select 'Dave' , 'Kate'      , 1  from socialnetwork union all
select 'Dave' , 'James'     , 1 from socialnetwork union all
select 'Dave' , 'Leo'       , 1  from socialnetwork union all
select 'Edgar' , 'Kate'      , 1  from socialnetwork union all
select 'Edgar' , 'Melissa'   , 1  from socialnetwork union all
select 'Edgar' , 'Nicole'    , 1  from socialnetwork union all
select 'Fiona' , 'Amy'       , 1  from socialnetwork union all
select 'Gary' , 'Oliver'    , 1  from socialnetwork union all
select 'Hannah' , 'Quincey'   , 1  from socialnetwork union all
select 'James' , 'Quincey'   , 1  from socialnetwork union all
select 'Melissa' , 'Leo'   , 1  from socialnetwork union all
select 'Oliver', 'Fiona'     , 1  from socialnetwork union all
select 'Oliver' , 'Penny'     , 1  from socialnetwork union all
select 'Quincey' , 'James' , 1  from socialnetwork

  ),
  grid as(
          select
                  level+1                                                 as POINTS,
                  friend,
                  sys_connect_by_path(person,'/')||'/'||friend      as PATH,
                  '0'||sys_connect_by_path(distance,'+')                  as DISTANCE
          from    paths
          start with person = 'Ammy'
          connect by prior friend = person
  )
  select
          points,
          path,
          distance,
          EvalMath(distance)      as DISTANCE
  from       grid
  where      FRIEND = 'James'
--====================================================================================





