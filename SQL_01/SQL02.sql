/*2. For each year and month combination, find the “busiest” and the “slowest” day (those days with the most and 
the least total sales quantities of products sold) and the corresponding total sales quantities (i.e., SUMs).
*/
with q1 as
(
	select year, month, day, sum(quant) total_quant
	from sales
	group by year, month, day
	order by year, month, total_quant
),

q2 as
(
	select q1.year, q1.month, max(total_quant) busiest_total_q, min(total_quant) slowest_total_q
	from q1
	group by 1,2
),
 q3 as
 (
	 select q1.year, q1.month, q1.day busiest_day, q2.busiest_total_q, q2.slowest_total_q
	 from q1, q2
	 where q1.year=q2.year and q1.month=q2.month and q1.total_quant=q2.busiest_total_q
),
q4 as
(
	select q3.year, q3.month, q3.busiest_day, q3.busiest_total_q, q1.day slowest_day, q3.slowest_total_q
	from q3,q1
	where q1.year=q3.year and q1.month=q3.month and q1.total_quant=q3.slowest_total_q
	
)

 select * from q4