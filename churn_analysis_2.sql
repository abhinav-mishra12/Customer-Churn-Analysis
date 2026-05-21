select * from mytable2;

-- 1. Churned customers by state
SELECT state, COUNT(*) as total
FROM mytable2
GROUP BY state
ORDER BY total DESC
LIMIT 10;

-- 2. Average monthly charge of predicted churners
SELECT AVG(monthly_charge) as avg_charge,
       AVG(tenure_in_months) as avg_tenure
FROM mytable2;

-- 3. Contract type breakdown
SELECT contract, COUNT(*) as total,
       (COUNT(*) * 100 / (SELECT COUNT(*) FROM mytable2)) as pct
FROM mytable2
GROUP BY contract;

-- 4. Internet type breakdown
SELECT internet_type, COUNT(*) as total
FROM mytable2
GROUP BY internet_type
ORDER BY total DESC;

-- 5. High value churners (monthly charge > avg)
SELECT customer_id, state, monthly_charge, contract, internet_type
FROM mytable2
WHERE monthly_charge > (SELECT AVG(monthly_charge) FROM mytable2)
ORDER BY monthly_charge DESC;