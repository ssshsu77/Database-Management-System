/* 
For each customer, product and month, count the number of sales transactions that were between the previous and the
following month's average sales quantities. For January and December, display <NULL> or 0.
*/
with q1 as 
(
	select cust, prod, month, round(avg(quant),0) avg_q
	from sales
	group by cust, prod, month
	order by cust, prod, month
),
q2 as
(
	select s.cust, s.prod, s.month, s.quant, q1.avg_q following_q 
	from sales s
	left join q1 
	on s.cust=q1.cust and s.prod=q1.prod and s.month=q1.month-1
),
q3 as
(
	select s.cust, s.prod, s.month, s.quant, q1.avg_q previous_q 
	from sales s
	left join q1 
	on s.cust=q1.cust and s.prod=q1.prod and s.month=q1.month+1
),
q4 as
(
	select q2.cust, q2.prod, q2.month, count(q2.quant) count_q
	from q2
	natural join q3
	where quant between following_q and previous_q
	or quant between previous_q and following_q
	group by q2.cust, q2.prod, q2.month
),
q5 as
(
	select cust, prod, month
	from sales
	group by cust, prod, month
	order by cust, prod, month
),
q6 as
(
	select q5.cust, q5.prod, q5.month, q4.count_q sales_count_between_avgs
	from q5
	left join q4
	on q5.cust=q4.cust and q5.prod=q4.prod and q5.month=q4.month
	order by q5.cust, q5.prod, q5.month
)
select * from q6
