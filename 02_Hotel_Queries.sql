
-- Hotel System Analysis (Part A)

-- Q1. For every user in the system, get the user_id and last booked room_no
SELECT u.user_id,
  (
    SELECT b2.room_no
    FROM bookings b2
    WHERE b2.user_id = u.user_id
    ORDER BY b2.booking_date DESC
    LIMIT 1
  ) AS last_room_no
FROM users u;

-- Q2. Get booking_id and total billing amount of every booking created in November, 2021
SELECT b.booking_id,  COALESCE(SUM(COALESCE(i.item_rate,0) * bc.item_quantity), 0) AS total_billing_amount
FROM  bookings b
JOIN booking_commercials bc 
ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(b.booking_date) = 2021 AND MONTH(b.booking_date) = 11
GROUP BY b.booking_id;


-- Q3. Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000 
SELECT bc.bill_id, SUM(COALESCE(i.item_rate,0) * bc.item_quantity) AS bill_amount
FROM  bookings b
JOIN booking_commercials bc 
ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(b.booking_date) = 2021 AND MONTH(b.booking_date) = 10
GROUP BY bc.bill_id
HAVING bill_amount > 1000; /* No bill_id from the table is greater than this range, 
                            only <= 500 bill_amount bill_id's are present in the table */

-- Q4. Determine the most ordered and least ordered item of each month of year 2021 
WITH monthly_item_qty AS (
  SELECT 
    MONTH(b.booking_date) AS month_no,
    DATE_FORMAT(b.booking_date, '%Y-%m') AS month_label,
    bc.item_id,
    SUM(bc.item_quantity) AS total_qty
  FROM bookings b
  JOIN booking_commercials bc ON b.booking_id = bc.booking_id
  WHERE YEAR(b.booking_date) = 2021
  GROUP BY MONTH(b.booking_date), DATE_FORMAT(b.booking_date, '%Y-%m'), bc.item_id
),

ranked_desc AS (
  SELECT 
    month_no, month_label, item_id, total_qty,
    ROW_NUMBER() OVER (PARTITION BY month_no ORDER BY total_qty DESC) AS rn_desc,
    ROW_NUMBER() OVER (PARTITION BY month_no ORDER BY total_qty ASC)  AS rn_asc
  FROM monthly_item_qty
)

SELECT 'MOST' AS which, month_label, item_id, total_qty
FROM ranked_desc
WHERE rn_desc = 1

UNION ALL

SELECT 'LEAST' AS which, month_label, item_id, total_qty
FROM ranked_desc
WHERE rn_asc = 1
ORDER BY month_label, which;


-- Q5. Find the customers with the second highest bill value of each month of year 2021 
WITH bill_totals AS (
  SELECT 
    bc.bill_id,
    b.booking_id,
    MONTH(b.booking_date) AS month_no,
    DATE_FORMAT(b.booking_date, '%Y-%m') AS month_label,
    SUM(COALESCE(i.item_rate,0) * bc.item_quantity) AS bill_amount
  FROM bookings b
  JOIN booking_commercials bc ON b.booking_id = bc.booking_id
  LEFT JOIN items i ON bc.item_id = i.item_id
  WHERE YEAR(b.booking_date) = 2021
  GROUP BY bc.bill_id, b.booking_id, MONTH(b.booking_date), DATE_FORMAT(b.booking_date, '%Y-%m')
),

ranked_bills AS (
  SELECT 
    bt.*,
    ROW_NUMBER() OVER (PARTITION BY month_no ORDER BY bill_amount DESC) AS rn
  FROM bill_totals bt
)

SELECT 
  rb.month_label,
  rb.bill_id,
  rb.booking_id,
  rb.bill_amount,
  b.user_id
FROM ranked_bills rb
JOIN bookings b ON rb.booking_id = b.booking_id
WHERE rb.rn = 2;
