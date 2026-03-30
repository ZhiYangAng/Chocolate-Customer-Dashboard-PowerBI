# Profit and revenue across age category and loyalty membership?
SELECT
	c.age_category, 
	c.loyalty_member, 
	round(AVG(s.revenue), 2) AS avg_revenue, 
	round(AVG(s.profit), 2) AS avg_profit, 
	count(s.order_id) AS number_of_transaction
FROM
	sales s
JOIN 
	customers c ON s.customer_id = c.customer_id
GROUP BY 
	c.age_category, c.loyalty_member
ORDER BY
	avg_revenue DESC;
    
# The distribution of transaction based on age category across country and city
SELECT
	c.age_category, 
    st.country_name,
    st.city,
    count(s.order_id) AS number_of_transaction
FROM
	sales s
JOIN
	customers c ON s.customer_id = c.customer_id
JOIN
    stores st ON s.store_id = st.store_id
GROUP BY 
	st.country_name, st.city, c.age_category
ORDER BY
	st.country_name, st.city;  

# The distribution of customers across country and city
SELECT
	c.age_category, 
    st.country_name,
    st.city,
    count(DISTINCT s.customer_id) AS number_of_customer
FROM
	sales s
JOIN
	customers c ON s.customer_id = c.customer_id
JOIN
    stores st ON s.store_id = st.store_id
GROUP BY 
	st.country_name, st.city, c.age_category
ORDER BY
	st.country_name, st.city;  

# TPC based on age of customer across country and city

SELECT 
    st.country_name,
    st.city,
    c.age_category,
    COUNT(DISTINCT s.customer_id) AS number_of_customer,
    COUNT(s.order_id) AS total_transactions,
    ROUND(COUNT(s.order_id) / COUNT(DISTINCT s.customer_id), 2) AS transactions_per_customer
FROM 
	sales s
JOIN 
	customers c ON s.customer_id = c.customer_id
JOIN 
	stores st ON s.store_id = st.store_id
GROUP BY 
	st.country_name, st.city, c.age_category
ORDER BY 
	transactions_per_customer DESC;

# Across aged Customer prefer using which mode for purchasing chocolate?
SELECT
	c.age_category, 
    st.store_type,
    count(s.order_id) AS number_of_transaction
FROM
	sales s
JOIN
	customers c ON s.customer_id = c.customer_id
JOIN
    stores st ON s.store_id = st.store_id
GROUP BY 
	st.store_type, c.age_category
ORDER BY
	st.store_type; 
    
SELECT
	c.age_category, 
    st.store_type,
    count(s.order_id) AS number_of_transaction
FROM
	sales s
JOIN
	customers c ON s.customer_id = c.customer_id
JOIN
    stores st ON s.store_id = st.store_id
GROUP BY 
	st.store_type, c.age_category
ORDER BY
	c.age_category, number_of_transaction DESC;

# Only Return rank one number_of_transaction
WITH ShoppingStats AS (
    SELECT
        c.age_category, 
        st.store_type,
        COUNT(s.order_id) AS number_of_transaction
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    JOIN stores st ON s.store_id = st.store_id
    GROUP BY c.age_category, st.store_type
),
RankedShopping AS (
    SELECT 
        age_category,
        store_type,
        number_of_transaction,
        RANK() OVER(PARTITION BY age_category ORDER BY number_of_transaction DESC) as pos
    FROM ShoppingStats
)
SELECT 
    age_category,
    store_type AS favorite_shopping_mode,
    number_of_transaction
FROM RankedShopping
WHERE pos = 1; 


# What is the top 3 profit chocolate across all age group
WITH chocolate AS (
    SELECT
        c.age_category, 
        p.full_product_name,
        sum(s.revenue) AS total_revenue,
        sum(s.quantity) AS total_quantity,
        sum(s.profit) AS total_profit
    FROM 
		sales s
    JOIN 
		customers c ON s.customer_id = c.customer_id
    JOIN 
		products p ON s.product_id = p.product_id
    GROUP BY 
		c.age_category, p.full_product_name
),
RankedChocolate AS (
    SELECT 
		*,
        DENSE_RANK() OVER(PARTITION BY age_category ORDER BY total_profit DESC) AS profit_rank
    FROM 
		chocolate
)
SELECT 
    *
FROM 
	RankedChocolate
WHERE 
	profit_rank <= 3;

# What is the top 3 favour chocolate across all age group
WITH chocolate AS (
    SELECT
        c.age_category, 
        p.full_product_name,
        sum(s.revenue) AS total_revenue,
        sum(s.quantity) AS total_quantity,
        sum(s.profit) AS total_profit
    FROM 
		sales s
    JOIN 
		customers c ON s.customer_id = c.customer_id
    JOIN 
		products p ON s.product_id = p.product_id
    GROUP BY 
		c.age_category, p.full_product_name
),
RankedChocolate AS (
    SELECT 
		*,
        DENSE_RANK() OVER(PARTITION BY age_category ORDER BY total_quantity DESC) AS quantity_rank
    FROM 
		chocolate
)
SELECT 
    *
FROM 
	RankedChocolate
WHERE 
	quantity_rank <= 3;
    
# Problem Solution on P000 and P201 that available in sales table but missing in product table

INSERT INTO 
	products (product_id, product_name, brand, category, cocoa_percent, weight_g, full_product_name)
VALUES 
	('P0000', 'Unknown Product (P001)', 'Unknown', 'Unknown', 0, 0, 'Unknown Product (P001)'),
	('P0201', 'Unknown Product (P002)', 'Unknown', 'Unknown', 0, 0, 'Unknown Product (P002)');
      
    
