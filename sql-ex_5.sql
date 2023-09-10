--1-- 
SELECT maker, max(price) from(
select maker, price from product inner join pc on pc.model = product.model 
union select maker, price from product inner join laptop on laptop.model = product.model 
union 
select maker, price from product inner join printer on printer.model = product.midel
) this_table group by maker

--2--

select ship, battle
from Outcomes
where result = 'sunk'

--3--

select name
from Battles
where datepart(year, date) not in (select launched from Ships where launched is not null)
--4--
select Ships.name
from Ships
where Ships.name LIKE 'R%'
union 
select Outcomes.ship 
from Outcomes
where Outcomes.ship LIKE 'R%'
--5--
select name 
from Ships
where name like '% % %'
union
select ship
from Outcomes
where ship like '% % %'
--46--