--1--
SELECT model, speed, hd
FROM PC
where price < 500

--2--
SELECT distinct maker 
FROM Product
where type = 'Printer'

--3--
select model, ram, screen
from Laptop
where price > 1000

--4--
select * 
from Printer
where color = 'y'

--5--
select model, speed, hd
from pc
where (cd = '12x' or cd = '24x') and price < 600

--6--
select maker, speed
from laptop
inner join product on product.model = laptop.model
where hd >= 10

--7--
select pc.model, price 
from pc
inner join product on pc.model = product.model
where maker = 'B'
union
select laptop.model, price 
from laptop
inner join product on laptop.model = product.model
where maker = 'B'
union
select printer.model, price 
from printer
inner join product on printer.model = product.model
where maker = 'B'

--8--
select maker
from product
where type = 'PC'
except 
select maker 
from product 
where type = 'Laptop'

--9--
select distinct maker 
from product
inner join pc on pc.model = product.model
where speed >= 450

--10--
select model, price
from Printer
where price = (select max(price) from Printer)

--11--
select avg(speed) 
from pc

--12--
SELECT AVG(speed) 
FROM Laptop
WHERE price > 1000

--13--
SELECT AVG(speed) 
FROM Product
INNER JOIN PC ON Product.model = PC.model 
WHERE maker = 'A'

--14--
select Classes.class, name, country
from Classes
inner join Ships on Ships.class = Classes.class
where numGuns >= 10

--15--
select hd
from PC
group by hd
having count(*) >= 2

--16--
select A.model, B.model, A.speed, A.ram
from PC A, PC B
where A.speed = B.speed and A.ram = B.ram and A.model != B.model and A.model > B.model

--17--
select type, Product.model, laptop.speed
from laptop
inner join product on product.model = laptop.model
where laptop.speed < ALL (select speed from pc)

--18--
select maker, price
from Printer
inner join Product on Printer.model = Product.model
where color = 'y' and price = (select MIN(price) from Printer where color = 'y')

--19--
select maker, avg(screen) 
from Product
inner join Laptop on Laptop.model = Product.model
group by maker

--20--
select maker, count(model) as count_model
from Product
where type = 'PC'
group by maker
having count(model) >= 3

--21--
select maker, MAX(PC.price)
from product 
inner join PC on PC.model = product.model
group by maker

--22--
select speed, avg(price) as avg_price
from pc
group by speed
having speed > 600

--23--
select maker 
from product
inner join pc on product.model = pc.model
where speed >= 750
INTERSECT 
select maker 
from product
inner join Laptop on product.model = Laptop.model
where speed >= 750

--24--
with price_bd as (
select price 
from pc 
union 
select price
from Laptop
union 
select price
from Printer
)

select model
from PC
where PC.price = (select max(price) from price_bd)
union
select model
from Laptop
where Laptop.price = (select max(price) from price_bd)
union 
select model
from Printer
where Printer.price = (select max(price) from price_bd)

--задание 25--
with pc_ram_speed as (
 select maker, min(ram) as ram_pc, max(speed) as speed_pc
 from product
 inner join pc on pc.model = product.model
 group by maker
)

select distinct maker
from Product 
where type = 'Printer' and maker in (select maker
from pc_ram_speed)
