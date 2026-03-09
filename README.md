# Customer-subscription

# Consumer Subscription Churn Analysis

##  Business Problem Statement

**Our subscription streaming service was designed to deliver engaging content and generate recurring revenue through customer retention.**

**We observed 28.4% churn rate** across 26681 customers, with **Premium subscribers losing ₹11,764 avg LTV** and **"Low usage" (42%) + "Price too high" (28%)** as top reasons. This causes **₹2.1M annual revenue leakage** while acquisition costs via Meta Ads remain high (35% churn rate).

**Impact**: Eroding MRR, forcing 2x customer acquisition spend to offset losses.

**Target**: Reduce churn to 15% within 6 months through targeted retention (est. ₹4.5M revenue recovery).

## 📊 Key Findings (SQL Analysis)
 # Query 1 :
 -- Overall Churn Rate
 
 SELECT 
    ROUND(AVG(churn_flag) * 100, 1) AS churn_rate_pct,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers
FROM consumer_subscription;

# Query 4 : 
-- Churn by Region + Age Group

SELECT 
    region,
    age_group,
    COUNT(*) AS customers,
    ROUND(AVG(churn_flag)*100, 1) AS churn_pct
FROM consumer_subscription
GROUP BY region, age_group
ORDER BY churn_pct DESC;

# Query 5 :

-- Top Churn Reasons Ranking

SELECT 
    churn_reason,
    COUNT(*) AS frequency,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 1) AS pct_of_churns
FROM  consumer_subscription
WHERE churn_flag = 1
GROUP BY churn_reason
ORDER BY frequency DESC;

# Query 6 :

-- Lifetime Value Loss from Churn

SELECT 
    churn_flag,
    ROUND(AVG(lifetime_value), 0) AS avg_ltv,
    ROUND(SUM(lifetime_value), 0) AS total_ltv_exposure
FROM  consumer_subscription
GROUP BY churn_flag;

# Query 8 :

-- At-Risk Customers


WITH at_risk AS (
    SELECT user_id, churn_probability, lifetime_value
    FROM  consumer_subscription
    WHERE churn_flag = 0 AND churn_probability > 0.6
)
SELECT COUNT(*) AS at_risk_customers, 
       ROUND(AVG(churn_probability)*100, 1) AS avg_risk_pct
FROM at_risk;

