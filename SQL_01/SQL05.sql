with q1 as
(
	select prod, month, day, sum(quant) q1_total_q
	from sales
	where extract(quarter from date)=1
	group by prod, month, day
),

q2 as
(
	select q1.prod, max(q1_total_q) q1_max
	from q1
	group by q1.prod
),

q3 as
(
	select q2.prod, q2.q1_max, q1.month, q1.day
	from q1, q2
	where q1.prod=q2.prod and q1.q1_total_q=q2.q1_max
),
q4 as
(
	select q3.prod, q3.q1_max, q3.month, q3.day, max(s.date) q1_max_date
	from sales s, q3
	where s.prod=q3.prod and s.month=q3.month and s.day=q3.day
	group by q3.prod, q3.q1_max, q3.month, q3.day
	order by 1, 2, 3, 4
),
q5 as
(
	select prod, month, day, sum(quant) q2_total_q
	from sales
	where extract(quarter from date)=2
	group by prod, month, day
),
q6 as
(
	select q5.prod, max(q2_total_q) q2_max
	from q5
	group by q5.prod
),
q7 as
(
	select q6.prod, q6.q2_max, q5.month, q5.day
	from q5, q6
	where q5.prod=q6.prod and q5.q2_total_q=q6.q2_max
),
q8 as
(
	select q7.prod, q7.q2_max, q7.month, q7.day, max(s.date) q2_max_date
	from sales s, q7
	where s.prod=q7.prod and s.month=q7.month and s.day=q7.day
	group by q7.prod, q7.q2_max, q7.month, q7.day
	order by 1, 2, 3, 4
),
q9 as
(
	select prod, month, day, sum(quant) q3_total_q
	from sales
	where extract(quarter from date)=3
	group by prod, month, day
),
q10 as
(
	select q9.prod, max(q3_total_q) q3_max
	from q9
	group by q9.prod
),
q11 as
(
	select q10.prod, q10.q3_max, q9.month, q9.day
	from q9, q10
	where q9.prod=q10.prod and q9.q3_total_q=q10.q3_max
),
q12 as
(
	select q11.prod, q11.q3_max, q11.month, q11.day, max(s.date) q3_max_date
	from sales s, q11
	where s.prod=q11.prod and s.month=q11.month and s.day=q11.day
	group by q11.prod, q11.q3_max, q11.month, q11.day
	order by 1, 2, 3, 4
),
q13 as
(
	select prod, month, day, sum(quant) q4_total_q
	from sales
	where extract(quarter from date)=4
	group by prod, month, day
),
q14 as
(
	select q13.prod, max(q4_total_q) q4_max
	from q13
	group by q13.prod
),
q15 as
(
	select q14.prod, q14.q4_max, q13.month, q13.day
	from q13, q14
	where q13.prod=q14.prod and q13.q4_total_q=q14.q4_max
),
q16 as
(
	select q15.prod, q15.q4_max, q15.month, q15.day, max(s.date) q4_max_date
	from sales s, q15
	where s.prod=q15.prod and s.month=q15.month and s.day=q15.day
	group by q15.prod, q15.q4_max, q15.month, q15.day
	order by 1, 2, 3, 4
),
q17 as
(
	select q4.prod, q4.q1_max, q4.q1_max_date, q8.q2_max, q8.q2_max_date, q12.q3_max, q12.q3_max_date, q16.q4_max, q16.q4_max_date
	from q4, q8, q12, q16
	where q4.prod=q8.prod and q8.prod=q12.prod and q12.prod=q16.prod
)
select * from q17













