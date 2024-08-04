# 1. Write a query to display all the passengers (customers) who have travelled in routes 01 to 25.
  
select first_name,last_name,route_id from customer c join passengers_on_flights p on c.customer_id = p.customer_id where route_id between 1 and 25;

# 2. Write a query to identify the number of passengers and total revenue in business class.
  
select COUNT(*) as no_of_passengers,SUM(price_per_ticket) as total_revenue from ticket_details where class_id = 'Bussiness';

# 3. Write a query to display the full name of the customer by extracting the first name and last name.
  
select CONCAT(first_name,' ',last_name) as full_name from customer;

# 4. Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.
  
select c. customer_id, t. no_of_tickets, t. class_id from customer c join ticket_details t on c. customer_id = t. customer_id where no_of_tickets > 0;

# 5. Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates).
  
select first_name,last_name from customer where customer_id in (select customer_id from ticket_details where brand = 'Emirates');

# 6. Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause.
  
select COUNT(*) as no_of_customers from passengers_on_flights group by class_id having class_id = 'Economy Plus';

# 7. Write a query to identify whether the revenue has crossed 10000 using the IF clause.
  
select revenue,IIF(revenue > 10000, 'Yes','No') as revenue_crossed from (select sum(no_of_tickets*Price_per_ticket) as revenue from ticket_details)a;

# 8. Write a query to find the maximum ticket price for each class using window functions.
  
select class_id, MAX(price_per_ticket) as max_price from ticket_details group by class_id;

# 9. Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.
  
create index passengers on passengers_on_flights (route_id);

SELECT c.customer_id, c.first_name, c.last_name, p.aircraft_id, p.route_id 
  FROM customer c INNER JOIN passengers_on_flights p ON c.customer_id = p.customer_id WHERE p.route_id = 4;

# 10. For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.
  
create view execution_plan as select * from passengers_on_flights where route_id = 4;
select * from execution_plan;

# 11. Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.
  
select aircraft_id,SUM(no_of_tickets*price_per_ticket) as total_price from ticket_details group by aircraft_id;

# 12. Write a query to create a view with only business class customers along with the brand of airlines.
  
create view business_class as select c.first_name,c.last_name,t.brand from ticket_details t join customer c on t.customer_id = c.customer_id where class_id = 'Bussiness';
select * from business_class;

# 13. Write a query to extracts all the details from the routes table where the travelled distance is more than 2000 miles
  
select * from routes where distance_miles > 2000;

# 14. Write a query to create a new column that shows the distance travelled by each flight into three categories. The categories are, short distance travel (SDT) for >=0
# AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500. 
  
select *, case when distance_miles >=0 and distance_miles <= 2000 then 'short distance travel (SDT)' 
  when distance_miles >2000 and distance_miles <= 6500 then 'intermediate distance travel (IDT)' 
  when distance_miles >6500 then 'long-distance travel (LDT)' end as categories from routes;

# 15. Write a query to extract ticket purchase date, customer ID, class ID if the class is Business and Economy Plus,
# then complimentary services are given as Yes, else it is No.
  
select p_date,customer_id,class_id, case when class_id = 'Bussiness' or class_id = 'Economy Plus' then 'Yes' else 'No' end as complimentary_services from ticket_details;

# 16. Write a query to extract the first record of the customer whose last name ends with Scott.
  
select * from customer where last_name = 'Scott';
