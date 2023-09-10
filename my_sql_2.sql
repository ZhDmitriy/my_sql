--1--
select distinct ship from outcomes o join battles s on battle=name
where result = 'damaged' and exists (select ship from outcomes join battles on battle=name where ship=o.ship and s.date<date)
--2--
select maker, type from product where maker in (select maker from(
select maker, type from product group by maker, type) this_table group by maker having count(*) = 1)
group by maker, type having count(*) > 1
