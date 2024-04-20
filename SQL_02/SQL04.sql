/*
4. For each customer, find the top 3 highest quantities purchased in New Jersey (NJ). Show the customer’s name, the
quantity and product purchased, and the date they purchased it. If there are ties, show all – refer to the sample 
output below.
*/
with q1 as
(
	select cust, max(quant) max1
	from sales
	where state='NJ'
	group by cust
),
q2 as
(
	select s.cust, max(quant) max2
	from sales s, q1
	where s.cust=q1.cust and s.quant< q1.max1 and state='NJ'
	group by s.cust
),
q3 as
(
	select s.cust, max(quant) max3
	from sales s, q2
	where s.cust=q2.cust and s.quant< q2.max2 and state='NJ'
	group by s.cust
),
q4 as
(
	select s.cust, s.quant, s.prod, s.date
	from sales s
	join q1 on q1.cust=s.cust and q1.max1=s.quant and state='NJ'
),
q5 as
(
	select s.cust, s.quant, s.prod, s.date
	from sales s
	join q2 on q2.cust=s.cust and q2.max2=s.quant and state='NJ'
),
q6 as
(
	select s.cust, s.quant, s.prod, s.date
	from sales s
	join q3 on q3.cust=s.cust and q3.max3=s.quant and state='NJ'
),
q7 as
(
	select q4.cust,q4.quant, q4.prod, q4.date
	from q4
	union
	select q5.cust,q5.quant, q5.prod, q5.date
	from q5
	union
	select q6.cust,q6.quant, q6.prod, q6.date
	from q6
	order by cust, quant desc
)
select *from q7