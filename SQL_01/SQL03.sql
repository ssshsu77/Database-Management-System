/*
3.For each customer, find the “most favorite” product (the product that the customer purchased the most) 
and the “least favorite” product (the product that the customer purchased the least).

*/
with q1 as
(
	select cust, prod, sum(quant) total_prod
	from sales
	group by cust, prod
	order by cust
),

q2 as
(
	select q1.cust,  max(total_prod) most_fav_prod_q, min(total_prod) least_fav_prod_q
	from q1
	group by q1.cust
	order by q1.cust 
),

q3 as
(
	select q2.cust, q1.prod most_fav_prod 
	from q1, q2
	where q1.cust=q2.cust and total_prod=most_fav_prod_q
	group by q2.cust, most_fav_prod
),

q4 as
(
	select q2.cust, q1.prod least_fav_prod
	from q1, q2
	where q1.cust=q2.cust and total_prod=least_fav_prod_q
	group by q2.cust, least_fav_prod
),

q5 as
(
	select q3.cust, q3.most_fav_prod , q4.least_fav_prod
	from q3, q4
	where q3.cust=q4.cust
	group by q3.cust, q3.most_fav_prod , q4.least_fav_prod
	
)
select * from q5