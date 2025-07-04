-- PROJECT TITLE: What Drives 200+ Years of Business Survival?
-- PURPOSE: Analyze patterns in industry, location, and estimated revenue among America’s oldest companies
-- GOAL: Identify traits that lead to extreme business longevity and financial continuity


-- SITUATION: Most startups fail within 10 years.
-- But some businesses have lasted over 200–400 years. Why?
-- This project investigates those legacy businesses using structured SQL analysis.


-- TASK: Build a data table to explore patterns in age, industry, geography, and estimated revenue.
-- We will explore: Which industries survive? What states foster longevity? Is high revenue a common factor?

DROP TABLE IF EXISTS oldest_us_companies;


-- ACTION: Create the table with all key business longevity fields

CREATE TABLE oldest_us_companies (
    company VARCHAR(150),
    state VARCHAR(100),
    industry VARCHAR(100),
    year_founded INT,
    age INT,
    estimated_revenue VARCHAR(50)
);

-- Insert legacy businesses with age and estimated revenue
INSERT INTO oldest_us_companies (company, state, industry, year_founded, age, estimated_revenue) VALUES
('Shirley Plantation', 'Virginia', 'Farm / Plantation', 1638, 387, '$1M (est)'),
('Avedis Zildjian Company', 'Massachusetts', 'Musical Instruments', 1623, 402, '$50M (est)'),
('Tuttle’s Red Barn', 'New Hampshire', 'Farm', 1632, 393, '$1.2M (est)'),
('Field View Farm', 'Connecticut', 'Farm', 1639, 386, '$800K (est)'),
('Barker’s Farm', 'Massachusetts', 'Farm', 1642, 383, '$2M (est)'),
('Seaside Inn', 'Maine', 'Hotel', 1667, 358, '$1.5M (est)'),
('Hudson’s Bay Company (US)', 'New York', 'Retail', 1670, 355, '$7.3B (ICE Group)'),
('White Horse Tavern', 'Rhode Island', 'Restaurant / Tavern', 1673, 352, '$2M (est)'),
('Saunderskill Farm', 'New York', 'Farm', 1680, 345, '$900K (est)'),
('Towle Silversmiths', 'Massachusetts', 'Silversmith', 1690, 335, '$10M (est)'),
('The John Stevens Shop', 'Rhode Island', 'Stone Carving', 1705, 320, '$500K (est)'),
('Orchards of Concklin', 'New York', 'Orchard', 1711, 314, '$1M (est)'),
('Smiling Hill Farm', 'Maine', 'Farm / Lumber', 1720, 305, '$1.1M (est)'),
('Caswell-Massey', 'Rhode Island', 'Perfume / Personal Care', 1752, 273, '$12M (est)'),
('The Hartford Courant', 'Connecticut', 'Newspaper', 1764, 261, '$50M (est)'),
('Ames', 'Massachusetts', 'Manufacturing', 1774, 251, '$25M (est)'),
('The Griswold Inn', 'Connecticut', 'Restaurant / Hotel', 1776, 249, '$1.8M (est)'),
('Dowse Orchards', 'Massachusetts', 'Farm', 1778, 247, '$850K (est)'),
('Laird & Company', 'New Jersey', 'Distillery', 1780, 245, '$5M (est)'),
('Rawle & Henderson LLP', 'Pennsylvania', 'Law Firm', 1783, 242, '$70M (est)');


-- ANALYTICS: Answering the key business questions

-- Q1: What are the top 5 oldest companies?
-- PURPOSE: Find businesses that have withstood centuries of disruption
SELECT company, year_founded, age
FROM oldest_us_companies
ORDER BY year_founded ASC
LIMIT 5;

-- Q2: Which industries produce the most long-standing businesses?
-- PURPOSE: Reveal which sectors are historically sustainable
SELECT industry, COUNT(*) AS total_companies
FROM oldest_us_companies
GROUP BY industry
ORDER BY total_companies DESC;

-- Q3: Which states support business longevity the most?
-- PURPOSE: Discover regional patterns that enable long-term success
SELECT state, COUNT(*) AS total
FROM oldest_us_companies
GROUP BY state
ORDER BY total DESC;

-- Q4: Which companies generate the highest estimated revenue?
-- PURPOSE: Link longevity with financial success
SELECT company, industry, estimated_revenue
FROM oldest_us_companies
ORDER BY
  CAST(REPLACE(REPLACE(estimated_revenue, '$', ''), 'M (est)', '') AS DECIMAL(10,2)) DESC
LIMIT 5;

-- Q5: What’s the average age of businesses per industry?
-- PURPOSE: Understand how mature and stable each industry is
SELECT industry, ROUND(AVG(age), 0) AS avg_age
FROM oldest_us_companies
GROUP BY industry
ORDER BY avg_age DESC;

-- Q6: Which industries have BOTH age AND revenue dominance?
-- PURPOSE: Find sectors that are not just old, but also thriving
SELECT industry,
       COUNT(*) AS total_companies,
       ROUND(AVG(age), 0) AS avg_age
FROM oldest_us_companies
WHERE estimated_revenue LIKE '%M%'
GROUP BY industry
ORDER BY avg_age DESC;