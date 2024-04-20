/*
5. For each product, find the median sales quantity (assume an odd number of sales for simplicity of presentation).
(NOTE – “median” is defined as “denoting or relating to a value or quantity lying at the midpoint of a frequency 
distribution of observed values or quantities, such that there is an equal probability of falling above or below 
it.” E.g., Median value of the list {13, 23, 12, 16, 15, 9, 29} is 15.
*/
with base as
(
	select distinct prod, quant
	from sales
	order by prod, quant asc
),
pos as
(
	select b.prod, b.quant, count(s.quant) pos
	from sales s, base b
	where b.prod=s.prod and s.quant<=b.quant
	group by b.prod, b.quant
	order by 1, 2, 3
),
med_pos as
(
	select p.prod, ceil(max(pos)/2.0) med_pos
	from pos p
	group by p.prod
),
med as
(
	select p.prod, p.quant, p.pos
	from pos p, med_pos m
	where p.prod=m.prod and p.pos>= m.med_pos
),
final as
(
	select m.prod, min(m.quant)
	from med m
	group by m.prod
)

select* from final