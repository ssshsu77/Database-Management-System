/*
2. For customer and product, show the average sales before, during and after each month (e.g., for February, show
average sales of January and March. For “before” January and “after” December, display <NULL>. The “YEAR” 
attribute is not considered for this query – for example, both January of 2017 and January of 2018 are considered 
January regardless of the year.
*/
with q1 as
(
	select cust, prod, month, round(avg(quant),0) avg_q
	from sales
	group by cust, prod, month
),
q2 as
(
	select q1.cust, q1.prod, q1.month, q1.avg_q, q1_new.avg_q following_avg
	from q1 
	left join q1 q1_new
	on q1.cust = q1_new.cust and q1.prod=q1_new.prod and q1.month=q1_new.month-1
),
q3 as
(
	select q1.cust, q1.prod, q1.month, q1.avg_q, q1_new.avg_q previous_avg
	from q1
	left join q1 q1_new
	on q1.cust = q1_new.cust and q1.prod=q1_new.prod and q1.month=q1_new.month+1
),
q4 as
(
	select q2.cust, q2.prod, q2.month, q3.previous_avg, q2.avg_q, q2.following_avg
	from q2 
	natural join q3
	order by q2.cust, q2.prod, q2.month
)
select * from q4