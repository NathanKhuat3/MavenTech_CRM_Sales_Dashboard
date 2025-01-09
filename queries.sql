USE crm_project;

-- Best Performing Sectors
SELECT
	a.sector AS "Sector",
    SUM(CASE WHEN quarter = 1 THEN sp.close_value ELSE 0 END) AS "Q1 Revenue",
    SUM(CASE WHEN quarter = 2 THEN sp.close_value ELSE 0 END) AS "Q2 Revenue",
    SUM(CASE WHEN quarter = 3 THEN sp.close_value ELSE 0 END) AS "Q3 Revenue",
    SUM(CASE WHEN quarter = 4 THEN sp.close_value ELSE 0 END) AS "Q4 Revenue",
    SUM(sp.close_value) AS "Annual Revenue"
FROM crm_project.sales_pipeline sp
JOIN crm_project.accounts a
ON  sp.account = a.account
GROUP BY a.sector
ORDER BY SUM(sp.close_value) DESC;

-- Best Performing Regions
SELECT
	a.office_location AS "Country",
    SUM(CASE WHEN quarter = 1 THEN sp.close_value ELSE 0 END) AS "Q1 Revenue",
    SUM(CASE WHEN quarter = 2 THEN sp.close_value ELSE 0 END) AS "Q2 Revenue",
    SUM(CASE WHEN quarter = 3 THEN sp.close_value ELSE 0 END) AS "Q3 Revenue",
    SUM(CASE WHEN quarter = 4 THEN sp.close_value ELSE 0 END) AS "Q4 Revenue",
    SUM(sp.close_value) AS "Annual Revenue"
FROM crm_project.sales_pipeline sp
JOIN crm_project.accounts a
ON  sp.account = a.account
GROUP BY a.office_location
ORDER BY SUM(sp.close_value) DESC;

-- International vs Domestic Revenue Performance
SELECT
	st.manager AS "Manager",
    SUM(CASE WHEN office_location = "United States" THEN close_value ELSE NULL END) AS "Domestic Revenue",
    CONCAT(ROUND(SUM(CASE WHEN office_location = "United States" THEN close_value ELSE NULL END) / SUM(close_value) * 100, 0), "%") AS "% of Total",
    SUM(CASE WHEN office_location != "United States" THEN close_value ELSE NULL END) AS "International Revenue",
    CONCAT(ROUND(SUM(CASE WHEN office_location != "United States" THEN close_value ELSE NULL END) / SUM(close_value) * 100, 0), "%") AS "% of Total",
    SUM(close_value) AS "Total Sales"
FROM crm_project.sales_pipeline sp
JOIN crm_project.sales_teams st
ON sp.sales_agent = st.sales_agent
JOIN crm_project.accounts a
ON sp.account = a.account
WHERE sp.close_date IS NOT NULL
GROUP BY st.manager
ORDER BY SUM(close_value) DESC;

-- Average Deal Difference by Products
WITH avg_close_value AS (
	SELECT
		sp.product AS "Product",
        ROUND(AVG(sp.close_value), 2) AS "avg_revenue"
	FROM crm_project.sales_pipeline sp
	WHERE sp.close_date IS NOT NULL AND sp.close_value != 0
	GROUP BY sp.product
    )
SELECT
    acv.Product,
    acv.avg_revenue AS "Average Revenue",
    p.sales_price AS "Expected Revenue",
    CONCAT(ROUND((acv.avg_revenue - p.sales_price) / p.sales_price * 100, 2), "%") AS "Performance"
FROM avg_close_value acv
JOIN crm_project.products p
ON acv.product = p.product;

-- Average Deal Difference by Products by Teams
WITH avg_close_value AS (
	SELECT
		st.manager AS "Manager",
		sp.product AS "Product",
        ROUND(AVG(sp.close_value), 2) AS "avg_revenue"
	FROM crm_project.sales_pipeline sp
	JOIN crm_project.sales_teams st
	ON sp.sales_agent = st.sales_agent
	WHERE sp.close_date IS NOT NULL AND sp.close_value != 0
	GROUP BY st.manager, sp.product
    ORDER BY st.manager
    )
SELECT
	acv.Manager,
    acv.Product,
    acv.avg_revenue AS "Average Revenue",
    p.sales_price AS "Expected Revenue",
    CONCAT(ROUND((acv.avg_revenue - p.sales_price) / p.sales_price * 100, 2), "%") AS "Performance"
FROM avg_close_value acv
JOIN crm_project.products p
ON acv.product = p.product;

-- Comparison of Managers' Teams' Revenue Performance By Quarter
SELECT
	st.manager AS "Manager",
    ROUND(SUM(CASE WHEN quarter = 1 THEN sp.close_value ELSE 0 END), 2) AS "Q1 Revenue",
    (SELECT ROUND(AVG(CASE WHEN quarter = 1 THEN close_value ELSE 0 END), 2) FROM crm_project.sales_pipeline) AS "Avg Q1 Revenue",
    ROUND(SUM(CASE WHEN quarter = 2 THEN sp.close_value ELSE 0 END), 2) AS "Q2 Revenue",
    (SELECT ROUND(AVG(CASE WHEN quarter = 2 THEN close_value ELSE 0 END), 2) FROM crm_project.sales_pipeline) AS "Avg Q2 Revenue",
    ROUND(SUM(CASE WHEN quarter = 3 THEN sp.close_value ELSE 0 END), 2) AS "Q3 Revenue",
    (SELECT ROUND(AVG(CASE WHEN quarter = 3 THEN close_value ELSE 0 END), 2) FROM crm_project.sales_pipeline) AS "Avg Q3 Revenue",
    ROUND(SUM(CASE WHEN quarter = 4 THEN sp.close_value ELSE 0 END), 2) AS "Q4 Revenue",
    (SELECT ROUND(AVG(CASE WHEN quarter = 4 THEN close_value ELSE 0 END), 2) FROM crm_project.sales_pipeline) AS "Avg Q4 Revenue"
FROM crm_project.sales_pipeline sp
JOIN crm_project.sales_teams st
ON sp.sales_agent = st.sales_agent
GROUP BY st.manager;

-- Distribution Of Account Conversion Stage By Managers' Teams
SELECT
	st.manager AS "Manager",
    SUM(CASE WHEN deal_stage = "Won" THEN 1 ELSE 0 END) AS "Won Deals",
    CONCAT(ROUND((SELECT SUM(CASE WHEN deal_stage = "Won" THEN 1 ELSE 0 END)) / COUNT(*) * 100, 0), "%") AS "% of Total",
    SUM(CASE WHEN deal_stage = "Lost" THEN 1 ELSE 0 END) AS "Lost Deals",
    CONCAT(ROUND((SELECT SUM(CASE WHEN deal_stage = "Lost" THEN 1 ELSE 0 END)) / COUNT(*) * 100, 0), "%") AS "% of Total",
    SUM(CASE WHEN deal_stage = "Engaging" THEN 1 ELSE 0 END) AS "Engaging Deals",
    CONCAT(ROUND((SELECT SUM(CASE WHEN deal_stage = "Engaging" THEN 1 ELSE 0 END)) / COUNT(*) * 100, 0), "%") AS "% of Total",
    SUM(CASE WHEN deal_stage = "Prospecting" THEN 1 ELSE 0 END) AS "Prospecting Deals",
    CONCAT(ROUND((SELECT SUM(CASE WHEN deal_stage = "Prospecting" THEN 1 ELSE 0 END)) / COUNT(*) * 100, 0), "%") AS "% of Total",
    COUNT(*) AS "Total Deals"
FROM crm_project.sales_pipeline sp
JOIN crm_project.sales_teams st
ON sp.sales_agent = st.sales_agent
GROUP BY st.manager
ORDER BY COUNT(*);

-- Average Turnaround Time for Won and Lost Deals
SELECT
	st.manager AS "Manager",
    ROUND(AVG(CASE WHEN deal_stage = "Won" AND quarter = 1 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Won Time Q1",
	ROUND(AVG(CASE WHEN deal_stage = "Lost" AND quarter = 1 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Lost Time Q1",
    ROUND(AVG(CASE WHEN deal_stage = "Won" AND quarter = 2 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Won Time Q2",
	ROUND(AVG(CASE WHEN deal_stage = "Lost" AND quarter = 2 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Lost Time Q2",
    ROUND(AVG(CASE WHEN deal_stage = "Won" AND quarter = 3 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Won Time Q3",
	ROUND(AVG(CASE WHEN deal_stage = "Lost" AND quarter = 3 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Lost Time Q3",
    ROUND(AVG(CASE WHEN deal_stage = "Won" AND quarter = 4 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Won Time Q4",
	ROUND(AVG(CASE WHEN deal_stage = "Lost" AND quarter = 4 THEN DATEDIFF(close_date, engage_date) ELSE NULL END) / 30, 1) AS "Avg Lost Time Q4"
FROM crm_project.sales_pipeline sp
JOIN crm_project.sales_teams st
ON sp.sales_agent = st.sales_agent
WHERE sp.close_date IS NOT NULL
GROUP BY st.manager;