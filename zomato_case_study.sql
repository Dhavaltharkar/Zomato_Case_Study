USE zomato;
SELECT * FROM zomato.food;
SELECT * FROM zomato.restaurants;
SELECT * FROM zomato.orders;
SELECT * FROM zomato.order_details;
SELECT * FROM zomato.menu;
SELECT * FROM zomato.users;

# Q1. Find the customers who have never oredered
SELECT name FROM 
zomato.users 
WHERE user_id NOT IN (SELECT user_id FROM zomato.orders);

# Q2. Average  Price of per Dish
SELECT f.f_id,f.f_name, AVG(m.price) AS Avg_Price
FROM zomato.menu AS m
JOIN zomato.food AS f ON m.f_id = f.f_id
GROUP BY f.f_id, f.f_name
LIMIT 1000;

# Q3. Find top restaurants in terms of number of orders for a given month.
#SELECT *,monthname(date) FROM zomato.orders # Extract Month Name from date column

#SELECT *,monthname(date) AS 'month' 
#FROM zomato.orders 
#WHERE monthname(date) Like 'June'; # Extract date column where it is June

SELECT r.r_id,r.r_name,count(*) AS 'month' 
FROM zomato.orders o
JOIN zomato.restaurants r
ON o.r_id = r.r_id 
WHERE monthname(o.date) Like 'July'
group by o.r_id, r.r_name
order by count(*) DESC LIMIT 1;

# Q4. Restaurants with monthly sales greater than 800 for restaurant
SELECT o.r_id,r.r_name,sum(o.amount) AS 'revenue'
FROM zomato.orders AS o
JOIN zomato.restaurants AS r
ON o.r_id = r.r_id
WHERE monthname(o.date) Like 'June'
group by o.r_id, r.r_name
having revenue >800

# Q5. Show all orders with order details for a particular customer in a particular date range.
SELECT o.order_id,r.r_name,f.f_name
FROM zomato.orders AS o
JOIN zomato.restaurants AS r
ON o.r_id = r.r_id
JOIN zomato.order_details AS od
ON  o.order_id = od.order_id
JOIN zomato.food AS f
ON f.f_id = od.f_id
WHERE user_id = (SELECT user_id FROM users WHERE name LIKE 'Ankit')
AND (date > '2022-06-10' AND date < '2022-07-10');

# Q6. Find restaurants with maximum number of repeated customers.

SELECT r.r_name, count(*) AS loyal_customers
FROM (
	SELECT r_id,user_id,count(*) AS 'visits'
	from zomato.orders 
	group by r_id, user_id
	having visits>2
) AS t
JOIN zomato.restaurants r 
ON t.r_id = r.r_id
GROUP BY r.r_id, r.r_name
ORDER BY loyal_customers DESC LIMIT 1;

# Q7. Month over month revenue growth of Zomato
WITH sales AS (
    SELECT MONTHNAME(date) AS month, DATE_FORMAT(date, '%Y-%m') AS month_order,SUM(amount) AS revenue
    FROM zomato.orders
    GROUP BY month, month_order
    ORDER BY month_order
)
SELECT month,revenue,LAG(revenue, 1) OVER (ORDER BY month_order) AS previous_month_revenue,((revenue - LAG(revenue, 1) OVER (ORDER BY month_order)) / LAG(revenue, 1) OVER (ORDER BY month_order)) * 100 AS percentage_change
FROM sales;

# Q8. Find favourite food of customer

with temp AS (
SELECT o.user_id, od.f_id, count(*) AS freq
FROM zomato.orders AS o
JOIN zomato.order_details AS od
ON o.order_id = od.order_id
group by o.user_id,od.f_id
)
SELECT u.name, f.f_name, freq 
FROM temp AS t1
JOIN zomato.users AS u
ON u.user_id =t1.user_id
JOIN zomato.food AS f
ON f.f_id = t1.f_id
WHERE t1.freq = (SELECT MAX(freq) FROM temp AS t2 
WHERE t2.user_id = t1.user_id)
