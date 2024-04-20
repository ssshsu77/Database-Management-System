/*
3. For each customer, product and state combination, compute (1) the product’s average sale of this customer for 
the state (i.e., the simple AVG for the group-by attributes – this is the easy part), (2) the average sale of the 
product and the state but for all of the other customers, (3) the customer’s average sale for the given state, but 
for all of the other products, and (4) the customer’s average sale for the given product, but for all of the other 
states.
*/
with q1 as
(
	select cust, prod, state, round(avg(quant),0) current_avg
	from sales
	group by cust, prod, state
	order by cust, prod
),
q2 as
(
	select q1.cust, q1.prod, q1.state, round(avg(quant),0) other_cust_avg
	from q1, sales s
	where q1.prod=s.prod and q1.state=s.state and q1.cust!=s.cust
	group by q1.cust, q1.prod, q1.state
),
q3 as
(
	select q1.cust, q1.prod, q1.state, round(avg(quant),0) other_prod_avg
	from q1, sales s
	where q1.cust=s.cust and q1.state=s.state and q1.prod!=s.prod
	group by q1.cust, q1.prod, q1.state
),
q4 as
(
	select q1.cust, q1.prod, q1.state, round(avg(quant),0) other_state_avg
	from q1, sales s
	where q1.cust=s.cust and q1.prod=s.prod and q1.state!=s.state
	group by q1.cust, q1.prod, q1.state
),
q5 as
(
	select q1.cust, q1.prod, q1.state, q1.current_avg, q2.other_cust_avg, q3.other_prod_avg, q4.other_state_avg
	from q1
	full outer join q2 on q1.cust = q2.cust and q1.prod = q2.prod and q1.state=q2.state
	full outer join q3 on q1.cust = q3.cust and q1.prod = q3.prod and q1.state=q3.state
	full outer join q4 on q1.cust = q4.cust and q1.prod = q4.prod and q1.state=q4.state
	order by cust
)
select * from q5