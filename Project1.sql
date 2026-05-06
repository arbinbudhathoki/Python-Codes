Project-1
(Arbin Budhathoki)

Question: 
1: Daily Active Users (DAU)
You have a table name – user_activity and you have columns user_id and activity_date
Table structure:
(1, '2024-01-01'),
(2, '2024-01-01'),
(1, '2024-01-02'),
(3, '2024-01-02'),
(2, '2024-01-02')
Problem -  Find number of active users per day

2: Retention (Next Day Login)
Problem – Find users who logged in on consecutive days


Solution: 
# Case 1 

1. Daily Active User

SELECT activity_date, COUNT(DISTINCT user_id) AS daily_active_user
FROM user_activity
GROUP BY activity_date   	# group by each day
ORDER BY activity_date;		# sorted by date

2. Retention

SELECT DISTINCT a.user_id. 	#Finding users who logged in 
FROM user_activity a
JOIN user_activity b
ON a.user_id = b.user_id	# same USERS
AND b.activity_date = DATE_ADD(a.activity_date, INTERVAL 1 DAY);






(QUESTION)
CASE STUDY 2: 
1: Top Product per Category
You have a table name is sales with column name category, product and revenue
Table structure:
('Electronics', 'Phone', 1000),
('Electronics', 'Laptop', 2000),
('Electronics', 'Tablet', 1500),
('Clothing', 'Shirt', 500),
('Clothing', 'Jacket', 800)
Problem – Find highest selling product in each category.


Solution:
1:
SELECT category, product, revenue			# Finding highest revenue Product
FROM (
    SELECT 
        category, product,revenue,
        RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
    FROM sales 						# Rank product inside each catagory
) t
WHERE rnk = 1;            #rnk as RANK





(QUESTION)
CASE STUDY 3: 
1: Latest Transaction per User
You have table transactions with column name – user_id(int), txn_date (date) and amount(int)
Table structure:
(1, '2024-01-01', 100),
(1, '2024-02-01', 200),
(2, '2024-01-05', 300)
Problem - Find latest transaction for each user

Solution:

SELECT user_id, txn_date, amount			# getting the recent transaction for each users
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY txn_date DESC) AS rn
    FROM transactions
) t
WHERE rn = 1; 						# Keep only latest row




(QUESTION)
CASE STUDY 4: 
Funnel Analysis
You have table funnel with column names – user_id and step (e.g., view, cart and purchase)
Table structure:
(1, 'view'),
(1, 'cart'),
(1, 'purchase'),
(2, 'view'),
(2, 'cart')
Problem – Count users who completed all steps (view -> cart -> purchase)


Solution:
SELECT COUNT(*) AS total_completed_users		# counting the users who completed all steps
FROM (
    SELECT user_id
    FROM funnel
    WHERE step IN ('view', 'cart', 'purchase')
    GROUP BY user_id
    HAVING COUNT(DISTINCT step) = 3			# user must fulfill all three steps
) AS subquery;





