--1-- 
--Объединили таблицы и сделали фильтрацию по столбцу bore--
select name
from classes 
inner join ships on classes.class = ships.class
where bore = 16
union 
select ship
from classes 
inner join outcomes on outcomes.ship = classes.class
where bore = 16

--2--
select battle 
from Ships
inner join outcomes on Ships.name = outcomes.ship
where class = 'Kongo'

--3--
select name from (
select distinct coalesce(ship, name) name, numGuns, displacement  from outcomes o
full join ships s on o.ship = s.name
join classes c on c.class = s.class or c.class = o.ship) c1
where numGuns = ALL(select max(numGuns) from classes c where c.displacement = c1.displacement)

--4--
with avg_nm as (
	select cast(numGuns as decimal(6, 2)) as numGuns
	from Classes
	inner join ships on ships.class = classes.class
	where type = 'bb'
	union 
	select cast(numGuns as decimal(6, 2)) as numGuns
	from Classes
	inner join Outcomes on Outcomes.ship = classes.class
	where type = 'bb'
) 
select cast(sum(numGuns)/count(numGuns) as decimal(6, 2))
from avg_nm

--5--
select classes.class, min(launched) from classes left join (
select class, launched from outcomes full join ships on name = ship
) this_table on classes.class = this_table.class group by classes.class

--6-- 
select classes.class, count(name) from classes left join (
select classes.class, name from classes inner join ships on classes.class = ships.class where name in (select ship from outcomes where result = 'sunk')
union 
select class, ship from classes inner join outcomes on class = ship where result = 'sunk'
) this_table on classes.class = this_table.class group by classes.class
