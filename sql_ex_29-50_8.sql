--1--
select point, [date], sum(outs), sum(incs) from (
select point, [date], sum(out) outs, null incs FROM outcome GROUP BY point, [date]
UNION 
SELECT point, [date], null, sum(inc) FROM income GROUP BY point, [date]) this_table GROUP BY point, [date]

--2--
select class, country
from Classes
where type = 'bb' and bore >= 16

--3--
select country, cast(avg(Power(bore, 3)/2) as decimal(6,2)) FROM (
select country, bore, name 
from classes 
inner join Ships on classes.class = Ships.class
union 
select country, bore, ship
from classes 
inner join outcomes on class = ship where ship not in (select name from ships)
) this_table group by country

--4--
select ship
from Outcomes
where result = 'sunk' and battle = 'North Atlantic'

--5--
select name
from Classes
inner join Ships on Ships.class = Classes.class
where type = 'bb' and Classes.displacement > 35 and launched > 1922

--6--
select model, type
from Product
where model not like '%[^0-9.]%' or model not like '%[^a-z]%'

--7--
select name from (
 select name from Classes join ships on Classes.class = ships.class 
 union 
 select ship from Outcomes join Classes on class = ship
) this_table 
where name IN (select class from classes)

--8--
SELECT class 
FROM (
    SELECT class, COUNT(name) qty 
    FROM (
        SELECT classes.class, name
        FROM classes
        INNER JOIN ships ON classes.class = ships.class
        UNION  
        SELECT class, ship
        FROM classes 
        INNER JOIN outcomes ON class = ship 
        )this_table 
GROUP BY class 
HAVING COUNT(*) = 1
) this_table2

