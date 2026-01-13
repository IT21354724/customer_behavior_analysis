select * from customer limit 20

select gender, SUM(purchase_amount) AS total_revenue
from customer
group by gender

select customer_id,purchase_amount
from customer
where discount_applied='Yes' and purchase_amount>=(select AVG(purchase_amount)from customer )

select item_purchased,ROUND(AVG(review_rating::numeric),2) as "product review rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5

select shipping_type,ROUND(AVG(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

with item_counts as(
select category,
item_purchased,
count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id) DESC) as item_rank
from customer
group by category,item_purchased
)

select item_rank,category,item_purchased,total_orders
from item_counts
where item_rank <=3


select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases >5
group by subscription_status


select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc