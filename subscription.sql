-- Overall Churn Rate

SELECT 
    ROUND(AVG(churn_flag) * 100, 1) AS churn_rate_pct,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers
FROM consumer_subscription;

-- Churn by Subscription Plan

SELECT 
    subscription_plan,
    COUNT(*) AS customer_count,
    ROUND(AVG(churn_flag) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(lifetime_value), 0) AS avg_ltv
FROM  consumer_subscription
GROUP BY subscription_plan
ORDER BY churn_rate_pct DESC;

-- High-Value Customer Churn Risk

SELECT 
    COUNT(*) AS high_value_at_risk,
    ROUND(AVG(churn_probability)*100, 1) AS avg_risk_pct
FROM  consumer_subscription
WHERE lifetime_value > 3000 AND churn_probability > 0.7;

-- Churn by Region + Age Group

SELECT 
    region,
    age_group,
    COUNT(*) AS customers,
    ROUND(AVG(churn_flag)*100, 1) AS churn_pct
FROM consumer_subscription
GROUP BY region, age_group
ORDER BY churn_pct DESC;

-- Top Churn Reasons Ranking


SELECT 
    churn_reason,
    COUNT(*) AS frequency,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct_of_churns
FROM  consumer_subscription
WHERE churn_flag = 1
GROUP BY churn_reason
ORDER BY frequency DESC;

-- Lifetime Value Loss from Churn

SELECT 
    churn_flag,
    ROUND(AVG(lifetime_value), 0) AS avg_ltv,
    ROUND(SUM(lifetime_value), 0) AS total_ltv_exposure
FROM  consumer_subscription
GROUP BY churn_flag;

-- Engagement Score vs Churn


SELECT 
    CASE 
        WHEN engagement_score >= 3 THEN 'High'
        WHEN engagement_score >= 2 THEN 'Medium'
        ELSE 'Low'
    END AS engagement_tier,
    ROUND(AVG(churn_flag) * 100, 1) AS churn_rate_pct,
    COUNT(*) AS customers
FROM  consumer_subscription
GROUP BY 1
ORDER BY churn_rate_pct DESC;


-- At-Risk Customers


WITH at_risk AS (
    SELECT user_id, churn_probability, lifetime_value
    FROM  consumer_subscription
    WHERE churn_flag = 0 AND churn_probability > 0.6
)
SELECT COUNT(*) AS at_risk_customers, 
       ROUND(AVG(churn_probability)*100, 1) AS avg_risk_pct
FROM at_risk;

-- Acquisition Channel ROI


SELECT 
    acquisition_channel,
    COUNT(*) AS acquired_customers,
    ROUND(AVG(churn_flag) * 100, 1) AS churn_pct,
    ROUND(AVG(tenure_months), 1) AS avg_months
FROM  consumer_subscription
GROUP BY acquisition_channel
ORDER BY churn_pct DESC;


-- Payment Issues Driving Churn


SELECT 
    payment_failures,
    customer_support_tickets,
    ROUND(AVG(churn_flag) * 100, 1) AS churn_rate_pct,
    COUNT(*) AS affected_customers
FROM  consumer_subscription
GROUP BY payment_failures, customer_support_tickets
HAVING payment_failures > 0 OR customer_support_tickets > 0
ORDER BY churn_rate_pct DESC;

-- Monthly Churn Trend

SELECT 
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    ROUND(AVG(churn_flag) * 100, 1) AS monthly_churn_rate,
    COUNT(*) AS cohort_size
FROM  consumer_subscription
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month DESC
LIMIT 12;


-- Retention Opportunity Score (Top 10)


SELECT 
    user_id,
    lifetime_value,
    ROUND(churn_probability*100, 1) AS churn_risk_pct,
    ROUND((1 - churn_probability) * lifetime_value, 0) AS retention_potential
FROM  consumer_subscription
WHERE churn_flag = 0
ORDER BY retention_potential DESC
LIMIT 10;


-- KPIs


SELECT 
    COUNT(*) AS total_rows,
    MIN(user_id) AS first_id,
    MAX(user_id) AS last_id,
    ROUND(AVG(churn_flag)*100, 1) AS quick_churn_check
FROM  consumer_subscription;

