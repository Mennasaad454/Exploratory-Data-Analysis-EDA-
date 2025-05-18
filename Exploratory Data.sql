# Exploratory Data Analysis

SELECT * 
FROM layoffs_staging2;

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

# Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

# Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;


# If we order by funds_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


# Companies with the biggest single Layoff

SELECT company, total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC;

# Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

# By location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

# This it total in the past 3 years or in the dataset

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

# By year
SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 desc;

# Which industry is the most affected
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

# Rolling Total of Layoffs Per Month
SELECT SUBSTRING(`date` ,1,7) as `MONTH`, SUM(total_laid_off) AS Total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date` ,1,7) as `MONTH`, SUM(total_laid_off) AS Total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(`date` ,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC)
SELECT `Month`, Total_laid_off, SUM(Total_laid_off) OVER(ORDER BY `MONTH`) AS Rolling_Total
FROM Rolling_Total;

# Rolling Total of Layoffs Per company Per Year
SELECT company, YEAR(`DATE`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`DATE`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(SELECT company, YEAR(`DATE`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`DATE`)
), Company_Year_Rank AS
(SELECT*,
 DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year 
WHERE years IS NOT NULL
) 
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5
;