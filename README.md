# Customer-subscription

# Consumer Subscription Churn Analysis

##  Business Problem Statement

**Our subscription streaming service was designed to deliver engaging content and generate recurring revenue through customer retention.**

**We observed 28.4% churn rate** across 26681 customers, with **Premium subscribers losing ₹11,764 avg LTV** and **"Low usage" (42%) + "Price too high" (28%)** as top reasons. This causes **₹2.1M annual revenue leakage** while acquisition costs via Meta Ads remain high (35% churn rate).

**Impact**: Eroding MRR, forcing 2x customer acquisition spend to offset losses.

**Target**: Reduce churn to 15% within 6 months through targeted retention (est. ₹4.5M revenue recovery).

## 📊 Key Findings (SQL Analysis)

| Business Problem         | Your SQL Insight                     | Solution Delivered                                             |
| ------------------------ | ------------------------------------ | -------------------------------------------------------------- |
| 28.4% High Churn         | Query #1: Measured exact rate        | Baseline established for tracking improvement                  |
| "Low usage" (42%)        | Query #5: Top reason identified      | Personalized content nudges for low engagement_score users     |
| Premium LTV loss ₹11K    | Query #6: Quantified revenue leakage | Tiered pricing - Basic+ plan for price-sensitive Premium users |
| South-Mobile 18-24 (38%) | Query #4: High-risk segment found    | Targeted campaigns - Regional content + mobile UX fixes        |
| 67 at-risk customers     | Query #8: Early warning list         | Win-back campaigns - 20% discount + content bundles            |
