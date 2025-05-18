# Exploratory-Data-Analysis-EDA-
## 📘 Overview
This individual project explores layoff trends in different industries using the Layoffs dataset from Kaggle. The analysis was conducted entirely using SQL (MySQL) and focused on uncovering insights related to company size, industry, geography, funding stage, and timing of layoffs.

## 🎯 Objectives
- Identify companies with the largest layoffs (single and total)
- Detect companies that laid off 100% of their staff
- Analyze layoffs by industry, location, and funding stage
- Generate rolling totals and rank top companies per year

## 🧠 Key Insights
- Several companies experienced full (100%) workforce layoffs
- The year 2022 saw the highest layoff volume overall
- Industries most affected: Crypto, Retail, and Transportation
- Companies at later funding stages (e.g. Public, Series D) laid off the most
- Cities like San Francisco, New York, and Bangalore were among the hardest hit

## SQL Techniques Used
- GROUP BY, ORDER BY, SUM(), MAX(), MIN()
- Time-based functions: YEAR(), SUBSTRING(), STR_TO_DATE()
- CTEs for modular query logic
- Window functions: DENSE_RANK(), SUM() OVER() for rolling totals and ranking
