/*
4. For each customer and product combination, show the average sales quantities for the four seasons, Spring,
Summer, Fall and Winter in four separate columns – Spring being the 3 months of March, April and May; and Summer 
the next 3 months (June, July and August); and so on – ignore the YEAR component of the dates (i.e., 10/25/2016 
is considered the same date as 10/25/2017, etc.). Additionally, compute the average for the “whole” year (again 
ignoring the YEAR component, meaning simply compute AVG) along with the total quantities (SUM) and the counts (COUNT).
*/
with q1 as
(
	select cust, prod, round(avg(quant),0) winter_avg
	from sales
	where month =12 or month<=2
	group by cust, prod
	order by cust, prod
),
q2 as
(
	select q1.cust, q1.prod, q1.winter_avg, round(avg(quant),0) spring_avg
	from sales s, q1
	where month>=3 and month<=5 and s.cust=q1.cust and s.prod=q1.prod
	group by q1.cust, q1.prod, q1.winter_avg
	order by q1.cust, q1.prod
),
q3 as
(
	select q2.cust, q2.prod, q2.winter_avg, q2.spring_avg, round(avg(quant),0) summer_avg
	from sales s, q2
	where month>=6 and month<=8 and s.cust=q2.cust and s.prod=q2.prod
	group by q2.cust, q2.prod, q2.winter_avg, q2.spring_avg
	order by q2.cust, q2.prod
),
q4 as
(
	select q3.cust, q3.prod, q3.winter_avg, q3.spring_avg, q3.summer_avg, round(avg(quant),0) fall_avg
	from sales s, q3
	where month>=9 and month<=11 and s.cust=q3.cust and s.prod=q3.prod
	group by q3.cust, q3.prod, q3.winter_avg, q3.spring_avg, q3.summer_avg
	order by q3.cust, q3.prod
),
q5 as
(
	select q4.cust customer, q4.prod product, q4.spring_avg, q4.summer_avg, q4.fall_avg, q4.winter_avg, round(avg(s.quant),0) average, sum(s.quant) total, count(s.prod) count
	from sales s, q4
	where s.cust=q4.cust and s.prod=q4.prod
	group by q4.cust, q4.prod, q4.spring_avg, q4.summer_avg, q4.fall_avg, q4.winter_avg
	order by q4.cust, q4.prod
)

select * from q5
	
	
	
	
	
	
	
	
	
	
	
	