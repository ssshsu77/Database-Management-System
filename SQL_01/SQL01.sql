/*1. For each customer, compute the minimum and maximum sales quantities along with the corresponding products (purchased), dates (i.e., dates of those minimum and maximum sales quantities) and the states in which the sale transactions took place. If there are >1 occurrences of the min or max, display all.
For the same customer, compute the average sales quantity.*/

with q1 as
(
	select cust, min(quant) min_q, max(quant) max_q, round(avg(quant),0) avg_q
	  from sales
	group by cust
),
q2 as
(
	select q1.cust, q1.min_q, s.prod min_prod, s.date min_date, s.state min_st, q1.max_q, q1.avg_q 
	  from q1, sales s
	 where q1.cust = s.cust and q1.min_q = s.quant
),
q3 as
(
	select q2.cust, q2.min_q, q2.min_prod, q2.min_date, q2.min_st, q2.max_q, s.prod max_prod, s.date max_date, s.state max_st, q2.avg_q
	  from q2, sales s
	 where q2.cust = s.cust and q2.max_q= s.quant
	order by cust

)
select* from q3 order by cust
