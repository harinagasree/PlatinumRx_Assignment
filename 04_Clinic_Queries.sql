
-- Clinic System Analysis

-- Q1. Find the revenue we got from each sales channel in a given year
SELECT cs.sales_channel, SUM(cs.amount) AS revenue
FROM clinic_sales cs
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.sales_channel
ORDER BY revenue DESC;

-- Q2. Find top 10 the most valuable customers for a given year 
SELECT
  cs.uid, c.name,
  SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

-- Q3. Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year
SELECT
  m.month_label,
  COALESCE(r.revenue,0) AS revenue,
  COALESCE(e.expense,0)  AS expense,
  COALESCE(r.revenue,0) - COALESCE(e.expense,0) AS profit,
  CASE WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) > 0 THEN 'Profitable'
       WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) < 0 THEN 'Not Profitable'
       ELSE 'Breakeven'
  END AS status
FROM (
   SELECT DISTINCT DATE_FORMAT(datetime, '%Y-%m') AS month_label
   FROM (
     SELECT datetime FROM clinic_sales WHERE YEAR(datetime)=2021
     UNION
     SELECT datetime FROM expenses WHERE YEAR(datetime)=2021
   ) t
) m
LEFT JOIN (
  SELECT DATE_FORMAT(datetime, '%Y-%m') AS month_label, SUM(amount) AS revenue
  FROM clinic_sales WHERE YEAR(datetime)=2021
  GROUP BY DATE_FORMAT(datetime, '%Y-%m')
) r ON m.month_label = r.month_label
LEFT JOIN (
  SELECT DATE_FORMAT(datetime, '%Y-%m') AS month_label, SUM(amount) AS expense
  FROM expenses WHERE YEAR(datetime)=2021
  GROUP BY DATE_FORMAT(datetime, '%Y-%m')
) e ON m.month_label = e.month_label
ORDER BY m.month_label;


-- Q4. For each city find the most profitable clinic for a given month
WITH clinic_month AS (
  SELECT c.cid, c.clinic_name, c.city,
    DATE_FORMAT(cs.datetime, '%Y-%m') AS month_label,
    SUM(cs.amount) AS revenue
  FROM clinics c
  LEFT JOIN clinic_sales cs ON c.cid = cs.cid AND DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09'
  GROUP BY c.cid, c.clinic_name, c.city, DATE_FORMAT(cs.datetime, '%Y-%m')
),
clinic_exp AS (
  SELECT
    c.cid,
    DATE_FORMAT(e.datetime, '%Y-%m') AS month_label,
    SUM(e.amount) AS expense
  FROM clinics c
  LEFT JOIN expenses e ON c.cid = e.cid AND DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09'
  GROUP BY c.cid, DATE_FORMAT(e.datetime, '%Y-%m')
),
clinic_profit AS (
  SELECT cm.cid, cm.clinic_name, cm.city, cm.month_label,
    COALESCE(cm.revenue,0) AS revenue,
    COALESCE(ce.expense,0) AS expense,
    COALESCE(cm.revenue,0) - COALESCE(ce.expense,0) AS profit
  FROM clinic_month cm
  LEFT JOIN clinic_exp ce ON cm.cid = ce.cid AND cm.month_label = ce.month_label
)
SELECT city, cid, clinic_name, revenue, expense, profit
FROM (
  SELECT
    cp.*,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY profit DESC) AS rn
  FROM clinic_profit cp
) t
WHERE rn = 1
ORDER BY city;

-- Q5. For each state find the second least profitable clinic for a given month 

WITH clinic_re AS (
  SELECT c.cid, c.clinic_name, c.state,
    COALESCE(SUM(CASE WHEN DATE_FORMAT(cs.datetime, '%Y-%m') = '2021-09' THEN cs.amount ELSE 0 END),0) AS revenue,
    COALESCE(SUM(CASE WHEN DATE_FORMAT(e.datetime, '%Y-%m') = '2021-09' THEN e.amount ELSE 0 END),0) AS expense
  FROM clinics c
  LEFT JOIN clinic_sales cs ON c.cid = cs.cid
  LEFT JOIN expenses e ON c.cid = e.cid
  GROUP BY c.cid, c.clinic_name, c.state
),
clinic_profit AS (
  SELECT
    cid, clinic_name, state, revenue, expense, (revenue - expense) AS profit
  FROM clinic_re
)
SELECT
  state, cid, clinic_name, profit
FROM (
  SELECT
    cp.*,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY profit ASC) AS rn
  FROM clinic_profit cp
) t
WHERE rn = 2
ORDER BY state;
