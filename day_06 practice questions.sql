-- Q51: Count the total number of customers in the customers.customers table.



-- Q90: What is the minimum expense amount in finance.expenses?

-- Q91: Find the maximum age of customers in customers.customers.

-- Q92: What is the highest salary in stores.employees?

-- Q93: Find the maximum product price in products.products.

-- Q94: What is the largest order amount in sales.orders?

-- Q95: Find the latest order_date in sales.orders.

-- Q96: What is the maximum rating in customers.reviews?

-- Q97: Find the highest stock quantity in products.inventory.

-- Q98: What is the maximum discount in sales.order_items?

-- Q99: Find the latest join_date in customers.customers.

-- Q100: What is the maximum budget in marketing.campaigns?


-- MEDIUM QUESTIONS 



-- Q1: Count the number of customers in each city from customers.customers.

SELECT CITY,COUNT(CUST_ID) FROM customers.customers
GROUP BY 1;


-- Q2: Find the total order amount (total_amount) for each store from sales.orders.

-- Q3: Calculate the average salary for each department in stores.employees.

-- Q4: Count how many products exist in each category from products.products.

-- Q5: Find the total stock quantity (stock_qty) for each store from products.inventory.

-- Q6: Calculate the average rating for each product (prod_id) in customers.reviews.

-- Q7: Count the number of orders placed by each customer from sales.orders.

-- Q8: Find the total payment amount for each payment_mode from sales.payments.

-- Q9: Calculate the average age of customers in each state from customers.customers.

SELECT STATE , AVG(AGE) FROM customers.customers
GROUP BY 1;


-- Q10: C
GROUP BY 1;
ount how many employees work in each store from stores.employees.


-- Q81 – Stores with order count > 100 AND average order amount > ₹5000 from sales.orders. 

SELECT * FROM sales.orders;

SELECT S.STORE_NAME, COUNT(O.ORDER_ID), AVG(O.TOTAL_AMOUNT) FROM sales.orders O
INNER JOIN STORES.STORES S 
ON O.STORE_ID=S.STORE_ID
GROUP BY 1
HAVING COUNT(ORDER_ID)>100 AND AVG(TOTAL_AMOUNT)>5000;


-- Q84 – Customers with more than 10 orders AND total spending above ₹1 lakh  from sales.orders



-- Q85 – Stores with more than 15 employees AND average salary above ₹60000 stores.employees.

SELECT * FROM stores.employees;

SELECT S.STORE_NAME, COUNT(E.EMP_), AVG(O.TOTAL_AMOUNT) FROM stores.employees E
INNER JOIN STORES.STORES S 
ON O.STORE_ID=S.STORE_ID
GROUP BY 1
HAVING COUNT(ORDER_ID)>100 AND AVG(TOTAL_AMOUNT)>5000;


-- Q83 – Categories with more than 30 products AND average price below ₹3000



-- Q17 – Orders placed in each month of 2024 from sales.orders.

select * from  sales.orders;

select extract 
-- Q30 – Count number of orders in each quarter

-- Q48 – Months in 2024 with order count less than 50

-- Q95 – Average order value for each day of week

-- Q99 – Revenue per store per month for 2024


-- 🧠 CASE WHEN / Bucketing Logic




-- Q23 – Product count by price ranges (0-1000, 1001-5000, etc.)

SELECT * FROM PRODUCTS.PRODUCTS;

SELECT 
	CASE
		WHEN PRICE BETWEEN 0 AND 1000  THEN '0 TO 1000 RANGE PRODUCT'
		WHEN PRICE BETWEEN 1001 AND 5000  THEN '1001 TO 5000 RANGE PRODUCT'
		ELSE 'OTHER RANGE'
	END AS PRODUCT_PRICE_RANGE,
	COUNT(*) AS Product_count_price_ranges 
FROM
	PRODUCTS.PRODUCTS
	GROUP BY  PRODUCT_PRICE_RANGE;


-- Q93 – Customer distribution by age groups (18-25, 26-35, 36-45, 46+)

SELECT * FROM CUSTOMERS.CUSTOMERS;

SELECT 
       CASE 
           WHEN AGE BETWEEN 18 AND 25 THEN '18-25 GROUP'
            WHEN AGE BETWEEN 26 AND 35 THEN '26-35 GROUP'
			WHEN AGE BETWEEN 36 AND 45 THEN '36-45 GROUP'
			ELSE  '46+ GROUP'
       END AS AGE_GROUP,
	   COUNT(*) AS CUSTOMER_COUNT
	   FROM CUSTOMERS.CUSTOMERS
	   GROUP BY AGE_GROUP;



-- 🧠 JOIN + Aggregation (Very Important)




-- Q91 – Total sales for each region (orders + stores) from sales.orders and stores.stores.

select * from sales.orders;

select * from stores.stores;

select s.region, sum(o.total_amount) as total_sales 
from stores.stores s 
inner join sales.orders o
on s.store_id=s.store_id
group by 1;

-- Q92 – Customer count & total spending for each region from customers.customers and sales.orders.

-- Q94 – Total sales and total expenses for each store

-- Q97 – Total stock quantity & number of products per category




-- 🧠 DISTINCT / Frequency / Business Logic




-- Q96: Find suppliers who supply more than one category from products.products.

select s.supplier_
select * from products.products;

select * from products.suppliers;
-- Q97: Calculate total stock quantity and number of products for each category from products.inventory and products.products.

-- Q98: Find the most frequent order status for each store from sales.orders.

-- Q87: Find products with stock below 10 units in at least 3 stores from products.inventory.

SELECT * FROM PRODUCTS.INVENTORY;

SELECT * FROM PRODUCTS.PRODUCTS;


SELECT DISTINCT P.PROD_NAME,SUM(STOCK_QT)




-- 🧠 Advanced Filtering with Aggregates



-- Q82 – Products with rating > 4.0 AND at least 20 reviews   from customers.reviews.

select * from  customers.reviews;

select prod_name,avg(r.rating) as Avg_rating ,count(r.review_text) as no_of_reviews
from customers.reviews r 
inner join PRODUCTS.PRODUCTS p
on r.prod_id=p.prod_id
group by 1
having avg(r.rating)>4 and count(r.review_text)>20;

-- Q100 – Customers who ordered every month in 2024 from sales.orders.

select * from sales.orders





-- 🧠 Advanced Filtering with Aggregates



-- Q82 – Products with rating > 4.0 AND at least 20 reviews   from customers.reviews.

select * from  customers.reviews;

select prod_name,avg(rating) as Avg_rating ,count(reviews) as no_of_reviews

from customers.reviews r 
inner join 

-- Q100 – Customers who ordered every month in 2024 from sales.orders.

SELECT * FROM CUSTOMERS.CUSTOMERS;

select * from sales.orders;

select c.full_name,  ,extract(month from o.order_date),   count(o.order_id) as total_orders_2024
from sales.orders o
inner join CUSTOMERS.CUSTOMERS c
on o.cust_id=c.cust_id
where extract (year from o.order_date)=2024
group by c.full_name,  extract(month from o.order_date)
having count(distinct extract(month from o.order_date))=12;


select 
    c.full_name,
    to_char(o.order_date, 'Month') as month_name,
    count(o.order_id) as orders_in_month
from sales.orders o
inner join customers.customers c
    on o.cust_id = c.cust_id
where extract(year from o.order_date) = 2024
group by 
    c.full_name,
    to_char(o.order_date, 'Month'),
    extract(month from o.order_date)
having c.full_name in (
    select c2.full_name
    from sales.orders o2
    inner join customers.customers c2
        on o2.cust_id = c2.cust_id
    where extract(year from o2.order_date) = 2024
    group by c2.full_name
    having count(distinct extract(month from o2.order_date)) = 12
)
order by 
    c.full_name,
    extract(month from o.order_date);

-- Q1: Find customers who have spent more than the average order amount, showing customer name, total spending, and order count from customers.customers and sales.orders.

-- Q2: Identify stores where total sales in 2024 exceeded ₹50 lakh and had more than 200 orders from sales.orders and stores.stores.

-- Q3: Calculate the sales growth percentage for each store comparing Q1 2024 vs Q4 2024 from sales.orders and stores.stores.

-- Q4: Find products available in all stores, showing product name and total stock across stores from products.products and products.inventory.

-- Q5: Identify customers who placed orders in every quarter of 2024 from customers.customers and sales.orders.

-- Q6: Calculate the customer retention rate by finding customers who ordered in both January and December 2024 from sales.orders.

-- Q7: Find the top performing product in each category based on total revenue from sales.order_items and products.products.

-- Q8: Identify products with declining sales trend by comparing Q1 vs Q4 2024 quantities from sales.order_items and sales.orders.

-- Q9: Calculate the average basket size (items per order) for each store and identify stores above average from sales.orders and sales.order_items.

-- Q10: Find categories where the price variance (max price - min price) exceeds ₹10000 and have at least 20 products from products.products.



