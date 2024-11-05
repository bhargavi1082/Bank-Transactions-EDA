CREATE DATABASE bank_transactions_db;
USE bank_transactions_db;
 -- code to create and populate the table:
CREATE TABLE bank_transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(10),
    amount DECIMAL(10, 2),
    balance DECIMAL(10, 2),
    branch_id INT,
    account_type VARCHAR(10),
    age INT,
    gender VARCHAR(10),
    occupation VARCHAR(50)
);

INSERT INTO bank_transactions VALUES
(1, 101, '2023-01-01', 'debit', 100.00, 900.00, 1, 'savings', 30, 'male', 'engineer'),
(2, 101, '2023-01-02', 'credit', 200.00, 1100.00, 1, 'savings', 30, 'male', 'engineer'),
(3, 102, '2023-01-01', 'debit', 50.00, 950.00, 2, 'current', 45, 'female', 'teacher');

-- 1. Exploratory Data Analysis Steps
-- Step 1: Overview of Data
SELECT * FROM bank_transactions;
SELECT COUNT(*) AS total_transactions,
       COUNT(DISTINCT account_id) AS unique_accounts,
       MIN(transaction_date) AS first_transaction_date,
       MAX(transaction_date) AS last_transaction_date
FROM bank_transactions;
-- Step 2: Transaction Volume Analysis
-- Monthly Transaction Volume:
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY month
ORDER BY month;
-- Total Amount by Transaction Type:
SELECT transaction_type,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_type;
-- Step 3: Customer Segmentation
-- Transactions by Gender:
SELECT gender, 
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY gender;
-- Transactions by Age Group:
SELECT CASE 
           WHEN age < 25 THEN '18-24'
           WHEN age BETWEEN 25 AND 34 THEN '25-34'
           WHEN age BETWEEN 35 AND 44 THEN '35-44'
           WHEN age BETWEEN 45 AND 54 THEN '45-54'
           ELSE '55+' 
       END AS age_group,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY age_group;
-- Step 4: Branch Performance
-- Transactions per Branch:
SELECT branch_id,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY branch_id;
-- Step 5: Account Type Analysis
-- Transaction Volume by Account Type:
SELECT account_type,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY account_type;
-- Step 6: Average Balance Over Time
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       AVG(balance) AS avg_balance
FROM bank_transactions
GROUP BY month;

-- 2. Additional Analysis 
-- --1.Top 5 Professions by Transaction Volume:
SELECT occupation, 
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY occupation
ORDER BY transaction_count DESC
LIMIT 5;
-- 2.Day of the Week Analysis (to see if specific days have more transactions):
SELECT DAYNAME(transaction_date) AS day_of_week,
       COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY day_of_week
ORDER BY transaction_count DESC;
-- 3. Monthly Growth in Balance:
SELECT account_id,
       DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       MAX(balance) - MIN(balance) AS monthly_growth
FROM bank_transactions
GROUP BY account_id, month
HAVING monthly_growth > 0
ORDER BY monthly_growth DESC;





