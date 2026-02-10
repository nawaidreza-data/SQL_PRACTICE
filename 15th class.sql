-- Swiggy's marketing team needs to understand customer reach -
-- how many unique cities do they serve,
-- and how many customers have provided email addresses for marketing campaigns?



-- **Scenario:** RetailMart's finance team needs to calculate total sales revenue and understand the value 
-- of pending shipments.**Task:** Calculate total order amounts and sum of orders that are still pending delivery.

select sum(total_amount) as total_pending_amount
 from sales.orders
 where order_status in ('Cancelled','Returned');
 

select distinct order_status from sales.orders;


-- Scenario: RetailMart wants to analyze their payment collection and identify potential revenue from high-value orders.
-- Task: Calculate total payments received, total refunds processed, and sum of high-value orders (above ₹5000).
select sum(amount) as total_payments_received
from sales.payments;

select * from   sales.returns

select sum(refund_amount) as total_refund_amount
from sales.returns


select sum(amount) as High_value_orders
from sales.payments
where amount>5000;


-- **Scenario:** RetailMarts HR team needs to analyze employee salaries and customer review ratings.
-- **Task:** Find average salary of employees and average product ratings from customer reviews.

select round(avg(salary),2) from stores.employees;

select round(avg(rating),2) from customers.reviews;




-- **Scenario:** RetailMart's CeO wants a quick snapshot: all payment modes accepted, all courier partners, and all employee 
-- roles in the company.Task:Aggregate distinct values from multiple tables into readable strings.

select string_agg (distinct payment_mode ,',' ord)


-- Scenario: RetailMarts tech team needs arrays of data for their mobile app - product categories and store IDs.
-- Task: Create arrays of distinct categories and store IDs for API responses.








-- 16th january class

-- Scenario: RetailMart wants to categorize their customers based on their state to understand regional distribution. 
-- North India (Delhi, UP, Punjab, Haryana), South India (Karnataka, Tamil Nadu, Kerala, Andhra Pradesh),
-- West India (Maharashtra, Gujarat, Rajasthan), and East India (West Bengal, Bihar, Odisha).
-- Task: Create a region category for each customer based on their state.

select full_name,state
       case 
	   when state in ('Delhi','Uttar pardesh','Punjab','Haryana') then 'North India'
	   when state in ('Karnataka', 'Tamil Nadu', 'Kerala', 'Andhra Pradesh') then 'South India'
	   when state in ('Maharashtra', 'Gujarat', 'Rajasthan') 



-- Scenario: RetailMart wants to calculate the average order value per customer. Some customers have made
-- orders worth ₹0 (cancelled orders that were logged). Calculating total/count where count includes ₹0 orders 
-- would skew the average.
-- Task: Calculate meaningful average order value by excluding zero-value orders from division.
-- Concepts Used: NULLIF, COUNT, SUM, Division, GROUP BY 

select * from sales.orders;

select orders,count(order_id),avg



-- Exercise 2 (Medium): Write a query that shows all stores with their employee count and classifies them as
-- 'Understaffed' (<5), 'Optimal' (5-15), or 'Overstaffed' (>15).

select s.store_name , case 
                       when count(e.emp_id)<5 then 'Understaffed'
					   when count(e.emp_id) between 5 and 15 then  'Optimal' 
					   else 'Overstaffed'
					   end as employee_count_classifies
from stores.employees e 
left join stores.stores s 
on e.store_id=s.store_id
group by s.store_name;


select distinct total_amount from sales.orders;

-- Exercise 3 (Hard): Create a comprehensive order analysis showing: order value tier, payment status 
-- (using COALESCE for NULL amounts), and calculate 'Revenue per Day' using NULLIF to handle days with zero orders.
select (Order_date) ,
sum(coalesce (total_amount,0))/ nullif(count (order_id),0) as safe_amount,
   case 
      when sum(coalesce (total_amount,0)) is not null then'Paid' 
	  else 'Pending'
	  end as Payment_status,
        case 
         when sum(coalesce (total_amount,0))<100000 then 'Low Value'
		 when  sum(coalesce (total_amount,0))< 300000 then 'Medium Value'
		 else 'High Value'
		 end as value_tier
		 from sales.orders
group by 1;


-- Exercise 4 (Challenge): Build a store performance scorecard using nested CASE to classify stores based on both 
-- their region AND sales performance.

select s.store_name, s.region, sum(coalesce( o.total_amount,0)) as total_sales,
case 
    when s.region = 'North' then 
	  case 
	    when sum(coalesce (o.total_amount,0))<20000 then 'Mid North Score'
	    when sum(coalesce (o.total_amount,0)) between 50000 and 200000 then 'Mid North Score'
		else 'Low North Score'
end 
   when s.region = 'South' then 
	  case 
	    when sum(coalesce (o.total_amount,0))<20000 then 'Mid South Score'
	    when sum(coalesce (o.total_amount,0)) between 50000 and 200000 then 'Mid South Score'
		else 'Low SouthScore'
end 
        else 
		 case 
		    when sum(coalesce (o.total_amount,0))<20000 then 'Top Other region'
			else 'Low oTher region'
END
    END AS store_performance_score
from stores.stores s 
inner join sales.orders o 
on s.store_id=o.store_id
group by 1,2;

