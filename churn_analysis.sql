select * from mytable;

-- Customer & Churn Overview

-- 1. What is the overall churn rate and how many customers stayed, churned, or joined?
SELECT 
    customer_status,
    COUNT(*) AS total_customers,
    (COUNT(*) * 100 / (SELECT COUNT(*) FROM mytable)) AS percentage
FROM mytable
GROUP BY customer_status;

-- 2. Which states have the highest churn rate — top 10?
select state, count(*) as total
from mytable
where customer_status = "Churned"
group by state;

-- Contract & Billing Impact

-- 3. How does churn rate vary across contract types (Month-to-Month, One Year, Two Year)?
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    (SUM(churn_flag) * 100 / COUNT(*)) AS churn_rate_pct
FROM mytable
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- 4. Which payment method has the highest churn rate?
select 
payment_method,
count(*) as total_customers,
sum(churn_flag) as churned_customers,
(sum(churn_flag)*100/count(*)) as churn_rate_payment_method
from mytable
group by payment_method
order by churn_rate_payment_method desc;

-- Service & Plan Impact

-- 5. Which internet type (Fiber Optic, Cable, DSL) has the highest churn rate?
SELECT 
    internet_type,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    (SUM(churn_flag) * 100 / COUNT(*)) AS churn_rate_pct
FROM mytable
GROUP BY internet_type
ORDER BY churn_rate_pct DESC;

-- 6. Do customers with premium support and online security churn less than those without?
SELECT 
    premium_support,
    online_security,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    (SUM(churn_flag) * 100 / COUNT(*)) AS churn_rate_pct
FROM mytable
GROUP BY premium_support, online_security
ORDER BY churn_rate_pct DESC;


-- Financial Insights

-- 7. What is the average monthly charge of churned vs stayed customers?
SELECT 
    customer_status,
    AVG(monthly_charge) AS avg_monthly_charge,
    AVG(total_revenue) AS avg_total_revenue,
    AVG(tenure_in_months) AS avg_tenure_months
FROM mytable
GROUP BY customer_status;

-- 8. Which value deal has the lowest churn rate — meaning which deal is retaining customers best?
SELECT 
    value_deal,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    (SUM(churn_flag) * 100 / COUNT(*)) AS churn_rate_pct
FROM mytable
GROUP BY value_deal
ORDER BY churn_rate_pct ASC;

-- Churn Reason Analysis

-- 9. What are the top 5 reasons customers are churning?
SELECT 
    churn_reason,
    COUNT(*) AS total,
    (COUNT(*) * 100 / (SELECT COUNT(*) FROM mytable WHERE churn_flag = 1)) AS pct_of_churned
FROM mytable
WHERE churn_flag = 1
GROUP BY churn_reason
ORDER BY total DESC
LIMIT 5;

-- 10. Which churn category (Competitor, Dissatisfaction, Price, etc.) is responsible for the most revenue loss?
SELECT 
    churn_category,
    COUNT(*) AS customers_lost,
    SUM(total_revenue) AS revenue_lost,
    AVG(total_revenue) AS avg_revenue_per_customer
FROM mytable
WHERE churn_flag = 1
GROUP BY churn_category
ORDER BY revenue_lost DESC;