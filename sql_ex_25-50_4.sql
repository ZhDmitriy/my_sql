--1--
with answer_price as (
select price, Product.model as model
from Product
inner join PC on PC.model = Product.model
where maker = 'A' and type in ('PC', 'Laptop')
union 
select price, Product.model as model
from Product
inner join Laptop on Laptop.model = Product.model
where maker = 'A' and type in ('PC', 'Laptop')
) 

select sum(price)/count(model)
from answer_price

--2--
select maker, avg(hd) 
from PC
inner join Product on PC.model = Product.model
where maker in (select maker from Product where type='Printer')
group by maker 

--3--
with maker_group as (
select maker, count(model) as qty
from product 
group by maker
having count(model) = 1
) 

select count(*)
from maker_group

--4--
select income_o.point, income_o.[date], inc, out 
from income_o 
left join outcome_o on outcome_o.point = outcome_o.point and outcome_o.[date] = income_o.[date]
union 
select outcome_o.point, outcome_o.[date], inc, out 
from income_o 
right join outcome_o on outcome_o.point = income_o.point and outcome_o.[date] = income_o.[date]
