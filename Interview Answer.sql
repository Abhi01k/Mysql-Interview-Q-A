--- Basic Answer ---
select * from payin;

-- 1. Retrieve the MerchantName and Amount for all transactions.
SELECT MerchantName, Amount
FROM Transactions;

-- 2. Filter the data to show only transactions where the Amount is greater than 100.
SELECT *
FROM Transactions
WHERE Amount > 100;

-- 3. Find all transactions that occurred on 2024-07-09.
SELECT *
FROM Transactions
WHERE DATE(DateTime) = '2024-07-09';

-- 4. Calculate the total Amount for each MerchantName in the table.
SELECT MerchantName, SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY MerchantName;

-- 5. Find the average Amount for transactions grouped by Gateway.
SELECT Gateway, AVG(Amount) AS AverageAmount
FROM Transactions
GROUP BY Gateway;

-- 6. Retrieve the MerchantEmail and Amount for transactions where the Status is null.
SELECT MerchantEmail, Amount
FROM Transactions
WHERE Status IS NULL;

-- 7. Find the maximum Amount transacted by each MerchantName where the Commission is zero.
SELECT MerchantName, MAX(Amount) AS MaxAmount
FROM Transactions
WHERE Commission = 0
GROUP BY MerchantName;

-- 8. Find the distinct MerchantID and their total transaction Amount where the UPI field is not empty.
SELECT DISTINCT MerchantID, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE UPI IS NOT NULL AND UPI != ''
GROUP BY MerchantID;

-- 9. Get all transactions that involved the Gateway "timepay" and sort them by DateTime.
SELECT *
FROM Transactions
WHERE Gateway = 'timepay'
ORDER BY DateTime;

-- 10. Retrieve the MerchantName, Amount, and ExtTransactionID for all transactions, ensuring that the ExtTransactionID is unique.
SELECT MerchantName, Amount, ExtTransactionID
FROM Transactions
GROUP BY ExtTransactionID, MerchantName, Amount;

-- 11. Write a query to find the total Commission collected for each MerchantEmail.
SELECT MerchantEmail, SUM(Commission) AS TotalCommission
FROM Transactions
GROUP BY MerchantEmail;

-- 12. Find all transactions where the Status is not null and the Amount is greater than 500.
SELECT *
FROM Transactions
WHERE Status IS NOT NULL AND Amount > 500;

-- 13. Retrieve the distinct MerchantID and count the number of transactions for each.
SELECT MerchantID, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY MerchantID;

-- 14. Identify transactions that do not have an associated BankUTR.
SELECT *
FROM Transactions
WHERE BankUTR IS NULL OR BankUTR = '';

-- 15. Find the first transaction (by DateTime) for each MerchantName.
WITH FirstTransaction AS (
    SELECT MerchantName, MIN(DateTime) AS FirstTransactionDate
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN FirstTransaction ft
ON t.MerchantName = ft.MerchantName AND t.DateTime = ft.FirstTransactionDate;

-- 16. Retrieve the MerchantName and the highest Amount for each Gateway.
SELECT Gateway, MerchantName, MAX(Amount) AS HighestAmount
FROM Transactions
GROUP BY Gateway, MerchantName;

-- 17. Calculate the total Amount and the average Commission for transactions grouped by VPA.
SELECT VPA, SUM(Amount) AS TotalAmount, AVG(Commission) AS AverageCommission
FROM Transactions
GROUP BY VPA;

-- 18. Find all transactions where the ExtTransactionID starts with "PEBLITZ".
SELECT *
FROM Transactions
WHERE ExtTransactionID LIKE 'PEBLITZ%';

-- 19. Retrieve the SID and the corresponding MerchantName for transactions where the Amount is the highest for each MerchantEmail.
WITH MaxAmountPerMerchant AS (
    SELECT MerchantEmail, MAX(Amount) AS MaxAmount
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.SID, t.MerchantName
FROM Transactions t
JOIN MaxAmountPerMerchant m
ON t.MerchantEmail = m.MerchantEmail AND t.Amount = m.MaxAmount;

-- 20. Identify transactions that occurred after 12:00 PM on 2024-07-09.
SELECT *
FROM Transactions
WHERE DATE(DateTime) = '2024-07-09' AND TIME(DateTime) > '12:00:00';

-- 21. Get the total Amount and count of transactions for each unique MerchantEmail.
SELECT MerchantEmail, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY MerchantEmail;

-- 22. List all distinct VPA values in the table.
SELECT DISTINCT VPA
FROM Transactions;

-- 23. Retrieve all transactions with a Commission greater than 0 but less than 10.
SELECT *
FROM Transactions
WHERE Commission > 0 AND Commission < 10;

-- 24. Find transactions where the DateTime is between '2024-07-01' and '2024-07-10'.
SELECT *
FROM Transactions
WHERE DateTime BETWEEN '2024-07-01' AND '2024-07-10';

-- 25. List all MerchantNames where the Amount is less than 50.
SELECT DISTINCT MerchantName
FROM Transactions
WHERE Amount < 50;

-- 26. Find the average Amount for transactions grouped by MerchantID.
SELECT MerchantID, AVG(Amount) AS AverageAmount
FROM Transactions
GROUP BY MerchantID;

-- 27. Retrieve all transactions where the MerchantEmail ends with "gmail.com".
SELECT *
FROM Transactions
WHERE MerchantEmail LIKE '%gmail.com';

-- 28. Get all transactions where the Amount is exactly 200.
SELECT *
FROM Transactions
WHERE Amount = 200;

-- 29. Retrieve all unique MerchantIDs where the Amount is greater than the average Amount.
WITH AvgAmount AS (
    SELECT AVG(Amount) AS AverageAmount
    FROM Transactions
)
SELECT DISTINCT MerchantID
FROM Transactions
WHERE Amount > (SELECT AverageAmount FROM AvgAmount);

-- 30. List all transactions with a BankUTR value that starts with "Y".
SELECT *
FROM Transactions
WHERE BankUTR LIKE 'Y%';

-- 31. Calculate the total Amount for transactions grouped by Commission.
SELECT Commission, SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY Commission;

-- 32. Retrieve all transactions where the SID is not NULL.
SELECT *
FROM Transactions
WHERE SID IS NOT NULL;

-- 33. Find all transactions where the Amount is between 100 and 500.
SELECT *
FROM Transactions
WHERE Amount BETWEEN 100 AND 500;

-- 34. List the distinct values in the Gateway column.
SELECT DISTINCT Gateway
FROM Transactions;

-- 35. Find all transactions where the MerchantName contains the word "Tech".
SELECT *
FROM Transactions
WHERE MerchantName LIKE '%Tech%';

-- 36. Retrieve all transactions where the DateTime is in August 2024.
SELECT *
FROM Transactions
WHERE DATE_FORMAT(DateTime, '%Y-%m') = '2024-08';

-- 37. Get all transactions with a null MerchantEmail.
SELECT *
FROM Transactions
WHERE MerchantEmail IS NULL;

-- 38. Find the average Commission for transactions where the Amount is greater than 1000.
SELECT AVG(Commission) AS AverageCommission
FROM Transactions
WHERE Amount > 1000;

-- 39. Retrieve all transactions with an Amount of less than the median Amount.
WITH SortedAmounts AS (
    SELECT Amount,
           ROW_NUMBER() OVER (ORDER BY Amount) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Amount DESC) AS RowDesc
    FROM Transactions
),
MedianAmount AS (
    SELECT AVG(Amount) AS MedianAmount
    FROM SortedAmounts
    WHERE RowAsc = RowDesc
       OR RowAsc + 1 = RowDesc
       OR RowAsc = RowDesc + 1
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT MedianAmount FROM MedianAmount);

-- 40. List all transactions where the Amount is equal to the maximum Amount in the table.
WITH MaxAmount AS (
    SELECT MAX(Amount) AS MaxAmount
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount = (SELECT MaxAmount FROM MaxAmount);

-- 41. Find the total Amount for transactions with a Status of 'Completed'.
SELECT SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Status = 'Completed';

-- 42. Retrieve transactions where the Commission is the highest for each MerchantName.
WITH MaxCommission AS (
    SELECT MerchantName, MAX(Commission) AS MaxCommission
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN MaxCommission mc
ON t.MerchantName = mc.MerchantName AND t.Commission = mc.MaxCommission;

-- 43. Get all transactions where the DateTime is on a weekend.
SELECT *
FROM Transactions
WHERE DAYOFWEEK(DateTime) IN (1, 7);

-- 44. Find all distinct MerchantNames with at least 3 transactions.
SELECT MerchantName
FROM Transactions
GROUP BY MerchantName
HAVING COUNT(*) >= 3;

-- 45. List all transactions where the UPI field is empty.
SELECT *
FROM Transactions
WHERE UPI IS NULL OR UPI = '';

-- 46. Retrieve the top 10 highest transaction amounts.
SELECT *
FROM Transactions
ORDER BY Amount DESC
LIMIT 10;

-- 47. Find all transactions where the Amount is divisible by 10.
SELECT *
FROM Transactions
WHERE Amount % 10 = 0;

-- 48. Get all transactions where the Amount is less than the average Amount of the table.
WITH AvgAmount AS (
    SELECT AVG(Amount) AS AverageAmount
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT AverageAmount FROM AvgAmount);

-- 49. Retrieve all transactions where the MerchantID is not in a given list.
-- Replace (list_of_ids) with the actual list of IDs.
SELECT *
FROM Transactions
WHERE MerchantID NOT IN (list_of_ids);

-- 50. Find all transactions where the ExtTransactionID contains the substring "TXN".
SELECT *
FROM Transactions
WHERE ExtTransactionID LIKE '%TXN%';

-- 51. Retrieve the total Amount for transactions by month for 2024.
SELECT DATE_FORMAT(DateTime, '%Y-%m') AS Month, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE YEAR(DateTime) = 2024
GROUP BY DATE_FORMAT(DateTime, '%Y-%m');

-- 52. List all transactions where the Amount is greater than the Amount of the previous transaction.
WITH RankedTransactions AS (
    SELECT Amount,
           LAG(Amount) OVER (ORDER BY DateTime) AS PreviousAmount
    FROM Transactions
)
SELECT *
FROM RankedTransactions
WHERE Amount > PreviousAmount;

-- 53. Get all transactions where the VPA contains the substring "pay".
SELECT *
FROM Transactions
WHERE VPA LIKE '%pay%';

-- 54. Find all transactions where the MerchantName is one of the top 5 most frequent.
WITH MerchantFrequency AS (
    SELECT MerchantName, COUNT(*) AS Frequency
    FROM Transactions
    GROUP BY MerchantName
    ORDER BY Frequency DESC
    LIMIT 5
)
SELECT *
FROM Transactions
WHERE MerchantName IN (SELECT MerchantName FROM MerchantFrequency);

-- 55. Retrieve all transactions with a Commission that is either NULL or greater than 5.
SELECT *
FROM Transactions
WHERE Commission IS NULL OR Commission > 5;

-- 56. Find transactions where the Amount is less than the Amount of the highest transaction in a specific Gateway.
-- Replace 'specific_gateway' with the actual Gateway value.
WITH MaxAmountPerGateway AS (
    SELECT Gateway, MAX(Amount) AS MaxAmount
    FROM Transactions
    WHERE Gateway = 'specific_gateway'
    GROUP BY Gateway
)
SELECT *
FROM Transactions t
JOIN MaxAmountPerGateway m
ON t.Gateway = m.Gateway
WHERE t.Amount < m.MaxAmount;

-- 57. Retrieve all transactions with a DateTime in the first quarter of 2024.
SELECT *
FROM Transactions
WHERE DateTime BETWEEN '2024-01-01' AND '2024-03-31';

-- 58. List all MerchantNames that have never had a transaction with Amount over 1000.
WITH HighAmountTransactions AS (
    SELECT DISTINCT MerchantName
    FROM Transactions
    WHERE Amount > 1000
)
SELECT DISTINCT MerchantName
FROM Transactions
WHERE MerchantName NOT IN (SELECT MerchantName FROM HighAmountTransactions);

-- 59. Find all transactions where the Amount is within the interquartile range.
WITH Percentiles AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS Q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Q3
    FROM Transactions
),
IQR AS (
    SELECT Q1, Q3, (Q3 - Q1) AS IQR
    FROM Percentiles
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT Q1 FROM IQR)
  AND Amount <= (SELECT Q3 FROM IQR);

-- 60. Retrieve transactions where the Commission is exactly 0 or greater than 10.
SELECT *
FROM Transactions
WHERE Commission = 0 OR Commission > 10;

-- 61. Get all transactions where the Status is 'Pending' and the Amount is between 50 and 150.
SELECT *
FROM Transactions
WHERE Status = 'Pending' AND Amount BETWEEN 50 AND 150;

-- 62. Retrieve all transactions where the MerchantEmail starts with "info@".
SELECT *
FROM Transactions
WHERE MerchantEmail LIKE 'info%@';

-- 63. Find all transactions where the Amount is greater than the Amount of the last transaction.
WITH LastTransaction AS (
    SELECT Amount
    FROM Transactions
    ORDER BY DateTime DESC
    LIMIT 1
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT Amount FROM LastTransaction);

-- 64. List all distinct MerchantIDs that have transactions in the last 30 days.
SELECT DISTINCT MerchantID
FROM Transactions
WHERE DateTime >= CURDATE() - INTERVAL 30 DAY;

-- 65. Retrieve all transactions where the DateTime is before '2024-06-01'.
SELECT *
FROM Transactions
WHERE DateTime < '2024-06-01';

-- 66. Find all transactions where the Commission is the same as the average Commission.
WITH AvgCommission AS (
    SELECT AVG(Commission) AS AverageCommission
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission = (SELECT AverageCommission FROM AvgCommission);

-- 67. Retrieve all transactions where the Gateway is not 'timepay'.
SELECT *
FROM Transactions
WHERE Gateway <> 'timepay';

-- 68. List all transactions where the MerchantName starts with the letter 'A'.
SELECT *
FROM Transactions
WHERE MerchantName LIKE 'A%';

-- 69. Get the total Amount and average Commission for transactions grouped by Status.
SELECT Status, SUM(Amount) AS TotalAmount, AVG(Commission) AS AverageCommission
FROM Transactions
GROUP BY Status;

-- 70. Find all transactions with a DateTime between two specific hours of the day.
-- Replace 'start_hour' and 'end_hour' with actual hour values.
SELECT *
FROM Transactions
WHERE TIME(DateTime) BETWEEN 'start_hour' AND 'end_hour';

-- 71. Retrieve transactions where the Amount is greater than the median of the last month's transactions.
WITH LastMonthTransactions AS (
    SELECT Amount
    FROM Transactions
    WHERE DateTime BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
),
MedianAmount AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS Median
    FROM LastMonthTransactions
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT Median FROM MedianAmount);

-- 72. List all MerchantNames where the Amount is greater than 500 and less than 1000.
SELECT DISTINCT MerchantName
FROM Transactions
WHERE Amount BETWEEN 500 AND 1000;

-- 73. Find all transactions where the Amount is the same as the Amount of the previous day's transactions.
WITH PreviousDayTransactions AS (
    SELECT Amount, DATE(DateTime) AS Date
    FROM Transactions
    WHERE DateTime = CURDATE() - INTERVAL 1 DAY
)
SELECT t.*
FROM Transactions t
JOIN PreviousDayTransactions p
ON t.Amount = p.Amount AND DATE(t.DateTime) = CURDATE();

-- 74. Retrieve all transactions with a non-NULL UPI value and a Commission of 0.
SELECT *
FROM Transactions
WHERE UPI IS NOT NULL AND UPI != '' AND Commission = 0;

-- 75. Get all transactions where the MerchantEmail is in a specific domain list.
-- Replace (domain_list) with the actual domain list.
SELECT *
FROM Transactions
WHERE MerchantEmail LIKE ANY (ARRAY[domain_list]);

-- 76. List transactions where the DateTime is in the last 7 days.
SELECT *
FROM Transactions
WHERE DateTime >= CURDATE() - INTERVAL 7 DAY;

-- 77. Retrieve transactions where the Amount is greater than the total Amount of a specific MerchantID.
-- Replace 'specific_merchant_id' with the actual MerchantID value.
WITH TotalAmountForMerchant AS (
    SELECT SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE MerchantID = 'specific_merchant_id'
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT TotalAmount FROM TotalAmountForMerchant);

-- 78. Find all transactions where the Commission is greater than the median Commission.
WITH RankedCommissions AS (
    SELECT Commission,
           ROW_NUMBER() OVER (ORDER BY Commission) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Commission DESC) AS RowDesc,
           COUNT(*) OVER () AS TotalCount
    FROM Transactions
)
SELECT Commission
FROM RankedCommissions
WHERE RowAsc = RowDesc
   OR (RowAsc + 1 = RowDesc AND TotalCount % 2 = 0);

-- 79. Get the total Amount for transactions grouped by the first character of MerchantName.
SELECT LEFT(MerchantName, 1) AS FirstCharacter, SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY LEFT(MerchantName, 1);

-- 80. Retrieve transactions with an Amount less than the Amount of the most recent transaction.
WITH MostRecentTransaction AS (
    SELECT Amount
    FROM Transactions
    ORDER BY DateTime DESC
    LIMIT 1
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT Amount FROM MostRecentTransaction);

-- 81. List all transactions where the DateTime is between '2024-05-01' and '2024-07-01'.
SELECT *
FROM Transactions
WHERE DateTime BETWEEN '2024-05-01' AND '2024-07-01';

-- 82. Find transactions where the MerchantName contains the word "Global".
SELECT *
FROM Transactions
WHERE MerchantName LIKE '%Global%';

-- 83. Retrieve all transactions with a Commission that is a multiple of 5.
SELECT *
FROM Transactions
WHERE Commission % 5 = 0;

-- 84. List all transactions where the MerchantID is repeated more than twice.
WITH MerchantCount AS (
    SELECT MerchantID, COUNT(*) AS TransactionCount
    FROM Transactions
    GROUP BY MerchantID
)
SELECT *
FROM Transactions
WHERE MerchantID IN (SELECT MerchantID FROM MerchantCount WHERE TransactionCount > 2);

-- 85. Find transactions with an Amount equal to the average Amount of the last 3 months.
WITH Last3MonthsTransactions AS (
    SELECT Amount
    FROM Transactions
    WHERE DateTime BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND CURDATE()
),
AverageAmount AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Last3MonthsTransactions
)
SELECT *
FROM Transactions
WHERE Amount = (SELECT AvgAmount FROM AverageAmount);

-- 86. Retrieve all transactions where the Gateway is either 'timepay' or 'paynow'.
SELECT *
FROM Transactions
WHERE Gateway IN ('timepay', 'paynow');

-- 87. List transactions where the Amount is greater than the highest Amount in a specific MerchantName.
-- Replace 'specific_merchant_name' with the actual MerchantName value.
WITH MaxAmountPerMerchant AS (
    SELECT MerchantName, MAX(Amount) AS MaxAmount
    FROM Transactions
    WHERE MerchantName = 'specific_merchant_name'
    GROUP BY MerchantName
)
SELECT *
FROM Transactions t
JOIN MaxAmountPerMerchant m
ON t.MerchantName = m.MerchantName
WHERE t.Amount > m.MaxAmount;

-- 88. Find all transactions with a Commission value between 1 and 5.
SELECT *
FROM Transactions
WHERE Commission BETWEEN 1 AND 5;

-- 89. Retrieve transactions where the DateTime is on the last day of the month.
SELECT *
FROM Transactions
WHERE DATE(DateTime) = LAST_DAY(DateTime);

-- 90. Get all transactions where the MerchantEmail contains "support".
SELECT *
FROM Transactions
WHERE MerchantEmail LIKE '%support%';

-- 91. Find all transactions where the Amount is less than the average Amount of transactions for each Gateway.
WITH AvgAmountPerGateway AS (
    SELECT Gateway, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY Gateway
)
SELECT *
FROM Transactions t
JOIN AvgAmountPerGateway a
ON t.Gateway = a.Gateway
WHERE t.Amount < a.AvgAmount;

-- 92. Retrieve transactions with a Commission of exactly 10 or more.
SELECT *
FROM Transactions
WHERE Commission >= 10;

-- 93. List all transactions where the MerchantName ends with "Tech".
SELECT *
FROM Transactions
WHERE MerchantName LIKE '%Tech';

-- 94. Get all transactions where the DateTime is between two specific months of the year.
-- Replace 'start_month' and 'end_month' with actual month values (e.g., '01' and '06').
SELECT *
FROM Transactions
WHERE DATE_FORMAT(DateTime, '%m') BETWEEN 'start_month' AND 'end_month';

-- 95. Retrieve transactions where the Amount is in the top 20% of all transactions.
WITH AmountPercentiles AS (
    SELECT PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY Amount) AS Top20Percent
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT Top20Percent FROM AmountPercentiles);

-- 96. Find transactions where the Status is 'Failed' and the Amount is greater than 100.
SELECT *
FROM Transactions
WHERE Status = 'Failed' AND Amount > 100;

-- 97. Retrieve all transactions where the ExtTransactionID does not contain "PAY".
SELECT *
FROM Transactions
WHERE ExtTransactionID NOT LIKE '%PAY%';

-- 98. List all transactions where the Commission is the same for all transactions of a given MerchantID.
-- Replace 'specific_merchant_id' with the actual MerchantID value.
WITH CommissionPerMerchant AS (
    SELECT MerchantID, Commission
    FROM Transactions
    GROUP BY MerchantID, Commission
    HAVING COUNT(*) = (SELECT COUNT(*) FROM Transactions WHERE MerchantID = 'specific_merchant_id')
)
SELECT *
FROM Transactions
WHERE MerchantID = 'specific_merchant_id' AND Commission = (SELECT Commission FROM CommissionPerMerchant WHERE MerchantID = 'specific_merchant_id');

-- 99. Find all transactions where the DateTime is within the last hour.
SELECT *
FROM Transactions
WHERE DateTime >= NOW() - INTERVAL 1 HOUR;

-- 100. Retrieve all transactions where the Amount is greater than 200 but less than 800.
SELECT *
FROM Transactions
WHERE Amount BETWEEN 200 AND 800;


--- Intermediate Answer ---


-- 1. Calculate the total Amount for each MerchantName and sort them by the total Amount in descending order.
SELECT MerchantName, SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY MerchantName
ORDER BY TotalAmount DESC;

-- 2. Find the maximum Amount for each Gateway and retrieve the corresponding MerchantName.
WITH MaxAmount AS (
    SELECT Gateway, MAX(Amount) AS MaxAmount
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.Gateway, t.MerchantName, t.Amount
FROM Transactions t
JOIN MaxAmount ma ON t.Gateway = ma.Gateway AND t.Amount = ma.MaxAmount;

-- 3. Get the average Amount and total Commission for transactions grouped by MerchantID.
SELECT MerchantID, AVG(Amount) AS AverageAmount, SUM(Commission) AS TotalCommission
FROM Transactions
GROUP BY MerchantID;

-- 4. Retrieve transactions where the DateTime is in the last 90 days and sort by Amount.
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
ORDER BY Amount;

-- 5. Find all transactions where the Commission is higher than the average Commission for that MerchantName.
WITH AvgCommission AS (
    SELECT MerchantName, AVG(Commission) AS AvgCommission
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN AvgCommission ac ON t.MerchantName = ac.MerchantName
WHERE t.Commission > ac.AvgCommission;

-- 6. Retrieve the top 5 MerchantNames with the highest total Amount.
SELECT MerchantName, SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY MerchantName
ORDER BY TotalAmount DESC
LIMIT 5;

-- 7. List all transactions where the Amount is within the 25th to 75th percentile range.
WITH Percentiles AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS Q1,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Q3
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount BETWEEN (SELECT Q1 FROM Percentiles) AND (SELECT Q3 FROM Percentiles);

-- 8. Get all transactions where the DateTime is within the last 30 days and the Amount is greater than the median Amount.
WITH MedianAmount AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS Median
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
  AND Amount > (SELECT Median FROM MedianAmount);

-- 9. Find all unique MerchantIDs where the Amount is above the 90th percentile of all transaction amounts.
WITH Percentile90 AS (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
)
SELECT DISTINCT MerchantID
FROM Transactions
WHERE Amount > (SELECT P90 FROM Percentile90);

-- 10. Retrieve the total Amount and count of transactions for each Gateway, ordered by total Amount.
SELECT Gateway, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY Gateway
ORDER BY TotalAmount DESC;

-- 11. List all transactions where the Amount is higher than the average Amount for transactions within the same month.
WITH MonthlyAvg AS (
    SELECT EXTRACT(YEAR FROM DateTime) AS Year, EXTRACT(MONTH FROM DateTime) AS Month, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY EXTRACT(YEAR FROM DateTime), EXTRACT(MONTH FROM DateTime)
)
SELECT t.*
FROM Transactions t
JOIN MonthlyAvg ma ON EXTRACT(YEAR FROM t.DateTime) = ma.Year AND EXTRACT(MONTH FROM t.DateTime) = ma.Month
WHERE t.Amount > ma.AvgAmount;

-- 12. Find the total Amount and average Commission for each MerchantEmail where the Commission is not NULL.
SELECT MerchantEmail, SUM(Amount) AS TotalAmount, AVG(Commission) AS AverageCommission
FROM Transactions
WHERE Commission IS NOT NULL
GROUP BY MerchantEmail;

-- 13. Retrieve the MerchantName and Amount for transactions where the Amount is in the top 10% of all transactions.
WITH Percentile90 AS (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
)
SELECT MerchantName, Amount
FROM Transactions
WHERE Amount >= (SELECT P90 FROM Percentile90);

-- 14. Find the distinct MerchantEmails where the total Amount for transactions is more than the average Amount for all emails.
WITH AvgAmount AS (
    SELECT AVG(TotalAmount) AS AvgTotal
    FROM (
        SELECT MerchantEmail, SUM(Amount) AS TotalAmount
        FROM Transactions
        GROUP BY MerchantEmail
    ) subquery
)
SELECT MerchantEmail
FROM (
    SELECT MerchantEmail, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantEmail
) subquery
WHERE TotalAmount > (SELECT AvgTotal FROM AvgAmount);

-- 15. Get all transactions where the Commission is the highest for each MerchantName.
WITH MaxCommission AS (
    SELECT MerchantName, MAX(Commission) AS MaxCommission
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN MaxCommission mc ON t.MerchantName = mc.MerchantName AND t.Commission = mc.MaxCommission;

-- 16. List all transactions where the Amount is within the range of the highest and lowest Amounts for each MerchantID.
WITH MinMaxAmount AS (
    SELECT MerchantID, MIN(Amount) AS MinAmount, MAX(Amount) AS MaxAmount
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN MinMaxAmount mma ON t.MerchantID = mma.MerchantID
WHERE t.Amount BETWEEN mma.MinAmount AND mma.MaxAmount;

-- 17. Retrieve all transactions where the Amount is higher than the median Amount for that specific Gateway.
WITH MedianAmount AS (
    SELECT Gateway, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS Median
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN MedianAmount ma ON t.Gateway = ma.Gateway
WHERE t.Amount > ma.Median;

-- 18. Find the total Amount and average Commission for transactions where the Status is 'Completed' and the Amount is above 200.
SELECT SUM(Amount) AS TotalAmount, AVG(Commission) AS AverageCommission
FROM Transactions
WHERE Status = 'Completed' AND Amount > 200;

-- 19. Get all transactions where the MerchantEmail starts with 'sales' and the Amount is greater than 150.
SELECT *
FROM Transactions
WHERE MerchantEmail LIKE 'sales%' AND Amount > 150;

-- 20. Retrieve the MerchantID and the total Amount for transactions grouped by Status, where Status is not NULL.
SELECT MerchantID, Status, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Status IS NOT NULL
GROUP BY MerchantID, Status;

-- 21. Find the MerchantName with the highest total Amount for transactions where the Commission is less than 5.
SELECT MerchantName
FROM Transactions
WHERE Commission < 5
GROUP BY MerchantName
ORDER BY SUM(Amount) DESC
LIMIT 1;

-- 22. Retrieve all transactions where the DateTime is in the second quarter of 2024 and the Amount is greater than the average Amount.
WITH QuarterlyAvg AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime BETWEEN '2024-04-01' AND '2024-06-30'
)
SELECT *
FROM Transactions
WHERE DateTime BETWEEN '2024-04-01' AND '2024-06-30'
  AND Amount > (SELECT AvgAmount FROM QuarterlyAvg);

-- 23. List all transactions where the Amount is in the 90th percentile range for each MerchantID.
WITH Percentile90 AS (
    SELECT MerchantID, PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile90 p90 ON t.MerchantID = p90.MerchantID
WHERE t.Amount >= p90.P90;

-- 24. Find all transactions where the Commission is between the 25th and 75th percentile of all Commission values.
WITH CommissionPercentiles AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Commission) AS Q1,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Commission) AS Q3
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission BETWEEN (SELECT Q1 FROM CommissionPercentiles) AND (SELECT Q3 FROM CommissionPercentiles);

-- 25. Retrieve transactions with the top 3 highest Amounts for each MerchantName.
WITH RankedTransactions AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY MerchantName ORDER BY Amount DESC) AS Rank
    FROM Transactions
)
SELECT *
FROM RankedTransactions
WHERE Rank <= 3;

-- 26. Get all transactions where the Amount is above the average Amount for the last 6 months.
WITH AvgAmount AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT AvgAmount FROM AvgAmount)
  AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 27. Find the total Amount and count of transactions for each MerchantID, where Amount is above the median Amount.
WITH MedianAmount AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS Median
    FROM Transactions
)
SELECT MerchantID, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
WHERE Amount > (SELECT Median FROM MedianAmount)
GROUP BY MerchantID;

-- 28. Retrieve all transactions where the Commission is the same as the Commission for the MerchantName with the highest total Amount.
WITH MaxAmountMerchant AS (
    SELECT MerchantName, MAX(SUM(Amount)) AS MaxAmount
    FROM Transactions
    GROUP BY MerchantName
    ORDER BY MaxAmount DESC
    LIMIT 1
)
SELECT t.*
FROM Transactions t
JOIN MaxAmountMerchant mam ON t.MerchantName = mam.MerchantName
WHERE t.Commission = (
    SELECT Commission
    FROM Transactions
    WHERE MerchantName = mam.MerchantName
    ORDER BY Amount DESC
    LIMIT 1
);

-- 29. List all transactions where the Amount is greater than the average Amount of transactions with the Status 'Pending'.
WITH AvgPendingAmount AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE Status = 'Pending'
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT AvgAmount FROM AvgPendingAmount);

-- 30. Find all transactions where the MerchantName appears more than 10 times in the dataset.
WITH MerchantCounts AS (
    SELECT MerchantName, COUNT(*) AS Count
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN MerchantCounts mc ON t.MerchantName = mc.MerchantName
WHERE mc.Count > 10;

-- 31. Retrieve the total Amount and average Commission for each Gateway, but only if the total Amount is more than the average Amount for all Gateways.
WITH AvgGatewayAmount AS (
    SELECT AVG(TotalAmount) AS AvgAmount
    FROM (
        SELECT Gateway, SUM(Amount) AS TotalAmount
        FROM Transactions
        GROUP BY Gateway
    ) subquery
)
SELECT Gateway, SUM(Amount) AS TotalAmount, AVG(Commission) AS AverageCommission
FROM Transactions
GROUP BY Gateway
HAVING SUM(Amount) > (SELECT AvgAmount FROM AvgGatewayAmount);

-- 32. Get all transactions where the DateTime is within the last year and the Amount is in the top 25% of all amounts.
WITH Percentile75 AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
)
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
  AND Amount >= (SELECT P75 FROM Percentile75);

-- 33. Find the MerchantEmail with the highest average Amount for transactions where Commission is not NULL.
WITH AvgAmountPerEmail AS (
    SELECT MerchantEmail, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE Commission IS NOT NULL
    GROUP BY MerchantEmail
)
SELECT MerchantEmail
FROM AvgAmountPerEmail
ORDER BY AvgAmount DESC
LIMIT 1;

-- 34. Retrieve the MerchantName and total Amount for transactions where the DateTime is in the current month.
SELECT MerchantName, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE EXTRACT(MONTH FROM DateTime) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(YEAR FROM DateTime) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY MerchantName;

-- 35. List all transactions where the Amount is below the 10th percentile of all Amounts.
WITH Percentile10 AS (
    SELECT PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY Amount) AS P10
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT P10 FROM Percentile10);

-- 36. Find the total Amount and count of transactions for each MerchantName where the Amount is between 100 and 500.
SELECT MerchantName, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
WHERE Amount BETWEEN 100 AND 500
GROUP BY MerchantName;

-- 37. Retrieve all transactions where the Commission is greater than the average Commission for the same MerchantID.
WITH AvgCommission AS (
    SELECT MerchantID, AVG(Commission) AS AvgCommission
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN AvgCommission ac ON t.MerchantID = ac.MerchantID
WHERE t.Commission > ac.AvgCommission;

-- 38. List all MerchantIDs with the highest total Amount and the average Commission for those MerchantIDs.
WITH MaxAmountMerchant AS (
    SELECT MerchantID, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantID
    ORDER BY TotalAmount DESC
    LIMIT 1
)
SELECT MerchantID, AVG(Commission) AS AverageCommission
FROM Transactions
WHERE MerchantID IN (SELECT MerchantID FROM MaxAmountMerchant)
GROUP BY MerchantID;

-- 39. Retrieve all transactions where the Amount is between the 50th and 75th percentiles of all Amounts.
WITH Percentiles AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS P50,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount BETWEEN (SELECT P50 FROM Percentiles) AND (SELECT P75 FROM Percentiles);

-- 40. Find all transactions where the Amount is higher than the average Amount for the previous month.
WITH AvgPreviousMonth AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1' MONTH)
      AND DateTime < DATE_TRUNC('month', CURRENT_DATE)
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT AvgAmount FROM AvgPreviousMonth)
  AND DateTime >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1' MONTH)
  AND DateTime < DATE_TRUNC('month', CURRENT_DATE);

-- 41. Retrieve the MerchantEmail and total Amount where the Amount is in the top 5% for that MerchantEmail.
WITH Percentile95 AS (
    SELECT MerchantEmail, PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS P95
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.MerchantEmail, SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN Percentile95 p95 ON t.MerchantEmail = p95.MerchantEmail
WHERE t.Amount >= p95.P95
GROUP BY t.MerchantEmail;

-- 42. List all transactions where the Amount is below the 25th percentile of all Amounts and the DateTime is in the current year.
WITH Percentile25 AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT P25 FROM Percentile25)
  AND EXTRACT(YEAR FROM DateTime) = EXTRACT(YEAR FROM CURRENT_DATE);

-- 43. Find the MerchantName and total Amount for transactions where the Status is 'Failed'.
SELECT MerchantName, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Status = 'Failed'
GROUP BY MerchantName;

-- 44. Retrieve all transactions where the Commission is above the average Commission for that MerchantEmail.
WITH AvgCommission AS (
    SELECT MerchantEmail, AVG(Commission) AS AvgCommission
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN AvgCommission ac ON t.MerchantEmail = ac.MerchantEmail
WHERE t.Commission > ac.AvgCommission;

-- 45. Get the total Amount for transactions where the DateTime is within the last 6 months, grouped by Gateway.
SELECT Gateway, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY Gateway;

-- 46. List all transactions where the Amount is greater than the average Amount for that specific MerchantName and the Status is 'Completed'.
WITH AvgAmount AS (
    SELECT MerchantName, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE Status = 'Completed'
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN AvgAmount aa ON t.MerchantName = aa.MerchantName
WHERE t.Amount > aa.AvgAmount
  AND t.Status = 'Completed';

-- 47. Find the total Amount and count of transactions for each MerchantID where the Amount is below the 20th percentile.
WITH Percentile20 AS (
    SELECT PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY Amount) AS P20
    FROM Transactions
)
SELECT MerchantID, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
WHERE Amount < (SELECT P20 FROM Percentile20)
GROUP BY MerchantID;

-- 48. Retrieve all transactions where the Amount is between the 10th and 50th percentiles of all Amounts and the DateTime is in the current year.
WITH Percentiles AS (
    SELECT PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY Amount) AS P10,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS P50
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount BETWEEN (SELECT P10 FROM Percentiles) AND (SELECT P50 FROM Percentiles)
  AND EXTRACT(YEAR FROM DateTime) = EXTRACT(YEAR FROM CURRENT_DATE);

-- 49. Find the MerchantID with the highest average Amount and list all transactions for that MerchantID where the Amount is greater than the average Amount for that MerchantID.
WITH AvgAmountPerID AS (
    SELECT MerchantID, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY MerchantID
)
SELECT MerchantID, Amount, Commission, DateTime, Status
FROM Transactions t
JOIN (
    SELECT MerchantID, AVG(Amount) AS MaxAvgAmount
    FROM AvgAmountPerID
    ORDER BY MaxAvgAmount DESC
    LIMIT 1
) max_avg ON t.MerchantID = max_avg.MerchantID
WHERE t.Amount > max_avg.MaxAvgAmount;

-- 50. Retrieve the total Amount for each MerchantEmail where the Amount is in the top 10% for that MerchantEmail.
WITH Percentile90 AS (
    SELECT MerchantEmail, PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.MerchantEmail, SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN Percentile90 p90 ON t.MerchantEmail = p90.MerchantEmail
WHERE t.Amount >= p90.P90
GROUP BY t.MerchantEmail;

-- 51. Retrieve the MerchantName with the highest total Amount and the total Amount itself.
WITH MaxTotalAmount AS (
    SELECT MerchantName, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantName
    ORDER BY TotalAmount DESC
    LIMIT 1
)
SELECT MerchantName, TotalAmount
FROM MaxTotalAmount;

-- 52. List all transactions where the Amount is above the 90th percentile for the whole dataset and the Status is 'Completed'.
WITH Percentile90 AS (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT P90 FROM Percentile90)
  AND Status = 'Completed';

-- 53. Find all transactions where the Commission is in the top 10% for each MerchantID.
WITH Percentile90Commission AS (
    SELECT MerchantID, PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Commission) AS P90
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile90Commission p90c ON t.MerchantID = p90c.MerchantID
WHERE t.Commission >= p90c.P90;

-- 54. Retrieve the MerchantID and the average Amount for transactions where the DateTime is within the last 30 days.
WITH AvgAmountLast30Days AS (
    SELECT MerchantID, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
    GROUP BY MerchantID
)
SELECT MerchantID, AvgAmount
FROM AvgAmountLast30Days;

-- 55. List all transactions where the Amount is below the average Amount for the entire dataset and the Commission is not NULL.
WITH AvgAmountOverall AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT AvgAmount FROM AvgAmountOverall)
  AND Commission IS NOT NULL;

-- 56. Find the top 5 MerchantNames with the highest total Amount and list their average Commission.
WITH Top5Merchants AS (
    SELECT MerchantName, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantName
    ORDER BY TotalAmount DESC
    LIMIT 5
)
SELECT t.MerchantName, AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN Top5Merchants t5 ON t.MerchantName = t5.MerchantName
GROUP BY t.MerchantName;

-- 57. Retrieve all transactions where the Amount is between the median and the 90th percentile of all amounts.
WITH Percentiles AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS P50,
           PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount BETWEEN (SELECT P50 FROM Percentiles) AND (SELECT P90 FROM Percentiles);

-- 58. List all transactions where the Amount is in the bottom 5% for that specific MerchantID.
WITH Percentile5 AS (
    SELECT MerchantID, PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY Amount) AS P5
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile5 p5 ON t.MerchantID = p5.MerchantID
WHERE t.Amount <= p5.P5;

-- 59. Find the MerchantEmail with the highest total Amount for transactions where the DateTime is within the last 90 days.
WITH TotalAmountLast90Days AS (
    SELECT MerchantEmail, SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
    GROUP BY MerchantEmail
    ORDER BY TotalAmount DESC
    LIMIT 1
)
SELECT MerchantEmail, TotalAmount
FROM TotalAmountLast90Days;

-- 60. Retrieve the total Amount for transactions where the Commission is above the average Commission for that MerchantName and the Status is 'Approved'.
WITH AvgCommissionByMerchant AS (
    SELECT MerchantName, AVG(Commission) AS AvgCommission
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.MerchantName, SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN AvgCommissionByMerchant acm ON t.MerchantName = acm.MerchantName
WHERE t.Commission > acm.AvgCommission
  AND t.Status = 'Approved'
GROUP BY t.MerchantName;
-- 61. Find the total Amount and average Commission for each MerchantID where the Amount is greater than the average Amount for that MerchantID.
WITH AvgAmountByMerchant AS (
    SELECT MerchantID, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.MerchantID, SUM(t.Amount) AS TotalAmount, AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN AvgAmountByMerchant avgAmt ON t.MerchantID = avgAmt.MerchantID
WHERE t.Amount > avgAmt.AvgAmount
GROUP BY t.MerchantID;

-- 62. List all transactions where the DateTime is in the first quarter of 2024 and the Amount is greater than the median Amount for that quarter.
WITH MedianAmountQ1 AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime BETWEEN '2024-01-01' AND '2024-03-31'
)
SELECT *
FROM Transactions
WHERE DateTime BETWEEN '2024-01-01' AND '2024-03-31'
  AND Amount > (SELECT MedianAmount FROM MedianAmountQ1);

-- 63. Retrieve all transactions where the Amount is above the average Amount for transactions within the same MerchantID and Status is 'Completed'.
WITH AvgAmountByMerchantAndStatus AS (
    SELECT MerchantID, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE Status = 'Completed'
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByMerchantAndStatus avgAmt ON t.MerchantID = avgAmt.MerchantID
WHERE t.Amount > avgAmt.AvgAmount
  AND t.Status = 'Completed';

-- 64. Find the total Amount and average Commission for transactions grouped by Gateway where the Amount is above the median Amount for that Gateway.
WITH MedianAmountByGateway AS (
    SELECT Gateway, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.Gateway, SUM(t.Amount) AS TotalAmount, AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN MedianAmountByGateway medAmt ON t.Gateway = medAmt.Gateway
WHERE t.Amount > medAmt.MedianAmount
GROUP BY t.Gateway;

-- 65. Retrieve all transactions where the Amount is above the 75th percentile of all Amounts and the Commission is less than 10.
WITH Percentile75 AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT P75 FROM Percentile75)
  AND Commission < 10;

-- 66. Find all transactions where the Amount is in the 25th to 50th percentile range for each MerchantEmail.
WITH PercentilesByEmail AS (
    SELECT MerchantEmail, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25,
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS P50
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN PercentilesByEmail p ON t.MerchantEmail = p.MerchantEmail
WHERE t.Amount BETWEEN p.P25 AND p.P50;

-- 67. List all transactions where the Commission is exactly equal to the median Commission for the entire dataset.
WITH MedianCommission AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Commission) AS Median
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission = (SELECT Median FROM MedianCommission);

-- 68. Retrieve the MerchantID with the highest total Amount and the average Commission for that MerchantID.
WITH TotalAmountByMerchant AS (
    SELECT MerchantID, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantID
    ORDER BY TotalAmount DESC
    LIMIT 1
)
SELECT t.MerchantID, AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN TotalAmountByMerchant tam ON t.MerchantID = tam.MerchantID
GROUP BY t.MerchantID;

-- 69. Find all transactions where the Amount is less than the average Amount for transactions within the same month and the Status is 'Pending'.
WITH AvgAmountByMonth AS (
    SELECT DATE_TRUNC('month', DateTime) AS Month, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY DATE_TRUNC('month', DateTime)
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByMonth avgAmt ON DATE_TRUNC('month', t.DateTime) = avgAmt.Month
WHERE t.Amount < avgAmt.AvgAmount
  AND t.Status = 'Pending';

-- 70. Retrieve all transactions where the Amount is greater than the median Amount for the last 60 days.
WITH MedianAmountLast60Days AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '60' DAY
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT MedianAmount FROM MedianAmountLast60Days)
  AND DateTime >= CURRENT_DATE - INTERVAL '60' DAY;

-- 71. List all transactions where the Commission is within the interquartile range of all Commission values.
WITH CommissionPercentiles AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Commission) AS Q1,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Commission) AS Q3
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission BETWEEN (SELECT Q1 FROM CommissionPercentiles) AND (SELECT Q3 FROM CommissionPercentiles);

-- 72. Retrieve the MerchantName with the lowest total Amount and the average Commission for that MerchantName.
WITH TotalAmountByMerchant AS (
    SELECT MerchantName, SUM(Amount) AS TotalAmount
    FROM Transactions
    GROUP BY MerchantName
    ORDER BY TotalAmount ASC
    LIMIT 1
)
SELECT t.MerchantName, AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN TotalAmountByMerchant tam ON t.MerchantName = tam.MerchantName
GROUP BY t.MerchantName;

-- 73. Find all transactions where the Amount is in the top 5% and the Status is 'Completed'.
WITH Percentile5 AS (
    SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS P95
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT P95 FROM Percentile5)
  AND Status = 'Completed';
-- 74. Retrieve all transactions where the Amount is within the top 10% for each Gateway.
WITH Percentile90ByGateway AS (
    SELECT Gateway, PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN Percentile90ByGateway p90 ON t.Gateway = p90.Gateway
WHERE t.Amount >= p90.P90;

-- 75. Find all transactions where the Commission is between 5 and 15.
SELECT *
FROM Transactions
WHERE Commission BETWEEN 5 AND 15;

-- 76. Retrieve all transactions where the Amount is less than the lowest Amount for a specific MerchantID.
WITH MinAmountByMerchant AS (
    SELECT MerchantID, MIN(Amount) AS MinAmount
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN MinAmountByMerchant minAmt ON t.MerchantID = minAmt.MerchantID
WHERE t.Amount < minAmt.MinAmount;

-- 77. List all transactions with a DateTime that falls on a weekend and the Amount is above the average Amount.
WITH AvgAmount AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE EXTRACT(DOW FROM DateTime) IN (0, 6) -- 0 = Sunday, 6 = Saturday
  AND Amount > (SELECT AvgAmount FROM AvgAmount);

-- 78. Get all transactions where the Amount is within the top 10% for the last 6 months.
WITH Percentile90Last6Months AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT P90 FROM Percentile90Last6Months)
  AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 79. Retrieve all transactions where the Amount is higher than the average Amount for a specific MerchantName.
WITH AvgAmountByMerchantName AS (
    SELECT MerchantName, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByMerchantName avgAmt ON t.MerchantName = avgAmt.MerchantName
WHERE t.Amount > avgAmt.AvgAmount;

-- 80. Find all transactions where the DateTime is within the first and last hour of each day.
WITH DateTimeRange AS (
    SELECT DISTINCT DATE_TRUNC('day', DateTime) AS Day
    FROM Transactions
)
SELECT *
FROM Transactions t
JOIN DateTimeRange dr ON DATE_TRUNC('day', t.DateTime) = dr.Day
WHERE EXTRACT(HOUR FROM t.DateTime) BETWEEN 0 AND 1;

-- 81. List all transactions with a Commission that is less than the median Commission for all transactions.
WITH MedianCommission AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Commission) AS Median
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission < (SELECT Median FROM MedianCommission);

-- 82. Retrieve all transactions where the Amount is in the top 5% for each MerchantEmail.
WITH Percentile95ByEmail AS (
    SELECT MerchantEmail, PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS P95
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN Percentile95ByEmail p95 ON t.MerchantEmail = p95.MerchantEmail
WHERE t.Amount >= p95.P95;

-- 83. Find all transactions where the Amount is higher than the median Amount for the last 30 days.
WITH MedianAmountLast30Days AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT MedianAmount FROM MedianAmountLast30Days)
  AND DateTime >= CURRENT_DATE - INTERVAL '30' DAY;

-- 84. Get the total Amount and count of transactions for each Gateway where the Amount is in the top 25%.
WITH Percentile75ByGateway AS (
    SELECT Gateway, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.Gateway, SUM(t.Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions t
JOIN Percentile75ByGateway p75 ON t.Gateway = p75.Gateway
WHERE t.Amount >= p75.P75
GROUP BY t.Gateway;

-- 85. Retrieve transactions where the Amount is below the 25th percentile for the last quarter.
WITH Percentile25LastQuarter AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25
    FROM Transactions
    WHERE DateTime >= DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '3' MONTH)
      AND DateTime < DATE_TRUNC('quarter', CURRENT_DATE)
)
SELECT *
FROM Transactions
WHERE Amount < (SELECT P25 FROM Percentile25LastQuarter)
  AND DateTime >= DATE_TRUNC('quarter', CURRENT_DATE - INTERVAL '3' MONTH)
  AND DateTime < DATE_TRUNC('quarter', CURRENT_DATE);

-- 86. Find all transactions where the MerchantName starts with the letter 'G' and the Amount is above 200.
SELECT *
FROM Transactions
WHERE MerchantName LIKE 'G%' AND Amount > 200;

-- 87. List all transactions where the DateTime is in the last month and the Amount is higher than the average Amount.
WITH AvgAmountLastMonth AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' MONTH
)
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '1' MONTH
  AND Amount > (SELECT AvgAmount FROM AvgAmountLastMonth);

-- 88. Retrieve all transactions where the Commission is in the 75th percentile range of all Commission values.
WITH PercentilesCommission AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Commission) AS P75
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission >= (SELECT P75 FROM PercentilesCommission);

-- 89. Find all transactions where the Amount is higher than the total Amount of the previous month's transactions.
WITH TotalAmountLastMonth AS (
    SELECT SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1' MONTH)
      AND DateTime < DATE_TRUNC('month', CURRENT_DATE)
)
SELECT *
FROM Transactions
WHERE Amount > (SELECT TotalAmount FROM TotalAmountLastMonth);

-- 90. Get all transactions where the MerchantID is repeated more than twice and the Amount is greater than 50.
WITH MerchantCount AS (
    SELECT MerchantID
    FROM Transactions
    GROUP BY MerchantID
    HAVING COUNT(*) > 2
)
SELECT *
FROM Transactions
WHERE MerchantID IN (SELECT MerchantID FROM MerchantCount)
  AND Amount > 50;

-- 91. Retrieve all transactions where the Amount is within the 90th percentile range for each MerchantID.
WITH Percentile90ByMerchant AS (
    SELECT MerchantID, PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile90ByMerchant p90 ON t.MerchantID = p90.MerchantID
WHERE t.Amount >= p90.P90;

-- 92. Find all transactions with a Commission value in the top 5% for each MerchantName.
WITH Percentile95ByMerchantName AS (
    SELECT MerchantName, PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Commission) AS P95
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN Percentile95ByMerchantName p95 ON t.MerchantName = p95.MerchantName
WHERE t.Commission >= p95.P95;

-- 93. List all transactions where the Amount is in the bottom 25% of all transactions.
WITH Percentile25 AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount <= (SELECT P25 FROM Percentile25);

-- 94. Retrieve all transactions where the DateTime is within the last 30 days and the Amount is greater than the average Amount.
WITH AvgAmountLast30Days AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
)
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
  AND Amount > (SELECT AvgAmount FROM AvgAmountLast30Days);

-- 95. Find all transactions where the Amount is higher than the average Amount for a specific Gateway and MerchantName.
WITH AvgAmountByGatewayAndMerchant AS (
    SELECT Gateway, MerchantName, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY Gateway, MerchantName
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByGatewayAndMerchant avgAmt ON t.Gateway = avgAmt.Gateway
                                            AND t.MerchantName = avgAmt.MerchantName
WHERE t.Amount > avgAmt.AvgAmount;

-- 96. Get the total Amount and average Commission for each Status where the Amount is greater than the 75th percentile.
WITH Percentile75 AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
)
SELECT Status, SUM(Amount) AS TotalAmount, AVG(Commission) AS AvgCommission
FROM Transactions
WHERE Amount > (SELECT P75 FROM Percentile75)
GROUP BY Status;

-- 97. Retrieve all transactions where the Amount is in the bottom 10% and the Commission is greater than 5.
WITH Percentile10 AS (
    SELECT PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY Amount) AS P10
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Amount <= (SELECT P10 FROM Percentile10)
  AND Commission > 5;

-- 98. Find all transactions where the Amount is in the top 25% for transactions made in the last year.
WITH Percentile75LastYear AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT P75 FROM Percentile75LastYear)
  AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 99. Retrieve all transactions where the Commission is less than the 25th percentile of all Commission values.
WITH Percentile25Commission AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Commission) AS P25
    FROM Transactions
)
SELECT *
FROM Transactions
WHERE Commission < (SELECT P25 FROM Percentile25Commission);

-- 100. List all transactions where the Amount is within the interquartile range (25th to 75th percentile) for each MerchantEmail.
WITH Percentile25And75ByEmail AS (
    SELECT MerchantEmail, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN Percentile25And75ByEmail p ON t.MerchantEmail = p.MerchantEmail
WHERE t.Amount BETWEEN p.P25 AND p.P75;


--- Advanced Answer ---

-- 1. Calculate the total Amount and average Commission for each MerchantID, grouping by the year and month of the DateTime.
SELECT MerchantID, 
       EXTRACT(YEAR FROM DateTime) AS Year, 
       EXTRACT(MONTH FROM DateTime) AS Month, 
       SUM(Amount) AS TotalAmount, 
       AVG(Commission) AS AvgCommission
FROM Transactions
GROUP BY MerchantID, EXTRACT(YEAR FROM DateTime), EXTRACT(MONTH FROM DateTime);

-- 2. Retrieve the total Amount for each MerchantEmail, segmented by Gateway, and then sort the results by total Amount.
SELECT MerchantEmail, 
       Gateway, 
       SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY MerchantEmail, Gateway
ORDER BY TotalAmount DESC;

-- 3. Find the MerchantNames with the highest average Amount for transactions where the Commission is above the median Commission.
WITH MedianCommission AS (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Commission) AS MedianCommission
    FROM Transactions
)
SELECT MerchantName, AVG(Amount) AS AvgAmount
FROM Transactions
WHERE Commission > (SELECT MedianCommission FROM MedianCommission)
GROUP BY MerchantName
ORDER BY AvgAmount DESC;

-- 4. List all transactions where the Amount is above the 95th percentile of all transactions, along with the corresponding MerchantNames.
WITH Percentile95 AS (
    SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS P95
    FROM Transactions
)
SELECT MerchantName, Amount
FROM Transactions
WHERE Amount > (SELECT P95 FROM Percentile95);

-- 5. Get the total Amount for transactions grouped by MerchantID, where the Amount is higher than the average Amount for that MerchantID over the last year.
WITH AvgAmountLastYear AS (
    SELECT MerchantID, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantID, SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN AvgAmountLastYear a ON t.MerchantID = a.MerchantID
WHERE t.Amount > a.AvgAmount
GROUP BY t.MerchantID;

-- 6. Retrieve all transactions where the DateTime falls within the last 90 days, the Amount is above the average Amount, and the Status is not 'Failed'.
WITH AvgAmountLast90Days AS (
    SELECT AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
)
SELECT *
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
  AND Amount > (SELECT AvgAmount FROM AvgAmountLast90Days)
  AND Status != 'Failed';

-- 7. Find the MerchantEmail with the highest total Amount for transactions where the Commission is in the top 5% of all Commission values.
WITH Top5PercentCommission AS (
    SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Commission) AS Top5Percent
    FROM Transactions
)
SELECT MerchantEmail, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Commission >= (SELECT Top5Percent FROM Top5PercentCommission)
GROUP BY MerchantEmail
ORDER BY TotalAmount DESC
LIMIT 1;

-- 8. List all transactions where the DateTime is within a specified date range and the Amount is in the top 10% of all transactions for each MerchantID.
WITH Percentile10ByMerchant AS (
    SELECT MerchantID, PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE DateTime BETWEEN 'start_date' AND 'end_date'
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile10ByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount >= p.P90
  AND t.DateTime BETWEEN 'start_date' AND 'end_date';

-- 9. Retrieve the MerchantName, Amount, and DateTime for transactions where the Amount is greater than the average Amount for that MerchantName and the Commission is not NULL.
WITH AvgAmountByMerchant AS (
    SELECT MerchantName, AVG(Amount) AS AvgAmount
    FROM Transactions
    GROUP BY MerchantName
)
SELECT t.MerchantName, t.Amount, t.DateTime
FROM Transactions t
JOIN AvgAmountByMerchant a ON t.MerchantName = a.MerchantName
WHERE t.Amount > a.AvgAmount
  AND t.Commission IS NOT NULL;

-- 10. Find all transactions where the Amount is above the median Amount for each specific Gateway and the DateTime is within the last 6 months.
WITH MedianAmountByGateway AS (
    SELECT Gateway, PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN MedianAmountByGateway m ON t.Gateway = m.Gateway
WHERE t.Amount > m.MedianAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 11. Calculate the total Amount and average Commission for transactions where the DateTime is in the last quarter and group by MerchantID and Status.
SELECT MerchantID, 
       Status, 
       SUM(Amount) AS TotalAmount, 
       AVG(Commission) AS AvgCommission
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
GROUP BY MerchantID, Status;

-- 12. Retrieve all transactions where the Commission is higher than the average Commission for the last 3 months, grouped by MerchantEmail.
WITH AvgCommissionLast3Months AS (
    SELECT MerchantEmail, AVG(Commission) AS AvgCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN AvgCommissionLast3Months a ON t.MerchantEmail = a.MerchantEmail
WHERE t.Commission > a.AvgCommission
  AND t.DateTime >= CURRENT_DATE - INTERVAL '3' MONTH;

-- 13. List all transactions with the top 1% of amounts and their corresponding MerchantNames and Gateway, and sort by Amount in descending order.
WITH Top1PercentAmounts AS (
    SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY Amount) AS Top1Percent
    FROM Transactions
)
SELECT MerchantName, Gateway, Amount
FROM Transactions
WHERE Amount >= (SELECT Top1Percent FROM Top1PercentAmounts)
ORDER BY Amount DESC;

-- 14. Find all transactions where the DateTime is within the last year, the Amount is in the top 20% of all transactions, and the Status is 'Completed'.
WITH Percentile80 AS (
    SELECT PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY Amount) AS P80
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
)
SELECT *
FROM Transactions
WHERE Amount >= (SELECT P80 FROM Percentile80)
  AND Status = 'Completed'
  AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 15. Retrieve the total Amount and average Commission for each Gateway, with an Amount greater than the 75th percentile of all amounts in the last 6 months.
WITH Percentile75Last6Months AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
)
SELECT Gateway, 
       SUM(Amount) AS TotalAmount, 
       AVG(Commission) AS AvgCommission
FROM Transactions
WHERE Amount > (SELECT P75 FROM Percentile75Last6Months)
  AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY Gateway;

-- 16. Get all transactions where the MerchantName contains "Tech" and the Amount is above the 90th percentile for that MerchantName.
WITH Percentile90ByMerchantName AS (
    SELECT MerchantName, 
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE MerchantName LIKE '%Tech%'
    GROUP BY MerchantName
)
SELECT t.*
FROM Transactions t
JOIN Percentile90ByMerchantName p ON t.MerchantName = p.MerchantName
WHERE t.Amount > p.P90
  AND t.MerchantName LIKE '%Tech%';

-- 17. List all transactions where the Amount is within the interquartile range for each MerchantID and the DateTime is within the last 90 days.
WITH Percentile25And75ByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile25And75ByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount BETWEEN p.P25 AND p.P75
  AND t.DateTime >= CURRENT_DATE - INTERVAL '90' DAY;

-- 18. Retrieve transactions where the DateTime is in the last 30 days and the Amount is greater than the average Amount of transactions for each MerchantEmail.
WITH AvgAmountByMerchantEmail AS (
    SELECT MerchantEmail, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByMerchantEmail a ON t.MerchantEmail = a.MerchantEmail
WHERE t.Amount > a.AvgAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '30' DAY;

-- 19. Find the total Amount and average Commission for transactions where the Amount is above the median Amount for each Gateway.
WITH MedianAmountByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    GROUP BY Gateway
)
SELECT t.Gateway, 
       SUM(t.Amount) AS TotalAmount, 
       AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN MedianAmountByGateway m ON t.Gateway = m.Gateway
WHERE t.Amount > m.MedianAmount
GROUP BY t.Gateway;

-- 20. Retrieve all transactions where the Commission is above the average Commission for transactions in the last year, with a DateTime in the last 90 days.
WITH AvgCommissionLastYear AS (
    SELECT AVG(Commission) AS AvgCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
)
SELECT *
FROM Transactions
WHERE Commission > (SELECT AvgCommission FROM AvgCommissionLastYear)
  AND DateTime >= CURRENT_DATE - INTERVAL '90' DAY;
-- 21. Retrieve the total Amount and average Commission for each MerchantID and Status, only for transactions with DateTime in the last 6 months and Amount greater than the 50th percentile.
WITH MedianAmountLast6Months AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
)
SELECT MerchantID, 
       Status, 
       SUM(Amount) AS TotalAmount, 
       AVG(Commission) AS AvgCommission
FROM Transactions
WHERE Amount > (SELECT MedianAmount FROM MedianAmountLast6Months)
  AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY MerchantID, Status;

-- 22. Find all transactions where the Amount is greater than the average Amount for the last year, grouped by MerchantEmail, and where the Commission is not NULL.
WITH AvgAmountLastYear AS (
    SELECT MerchantEmail, AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantEmail
)
SELECT t.MerchantEmail, 
       t.Amount, 
       t.Commission, 
       t.DateTime
FROM Transactions t
JOIN AvgAmountLastYear a ON t.MerchantEmail = a.MerchantEmail
WHERE t.Amount > a.AvgAmount
  AND t.Commission IS NOT NULL
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 23. List all transactions where the Amount is between the 25th and 75th percentiles for each MerchantID, with DateTime in the last 12 months.
WITH PercentilesByMerchant AS (
    SELECT MerchantID,
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN PercentilesByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount BETWEEN p.P25 AND p.P75
  AND t.DateTime >= CURRENT_DATE - INTERVAL '12' MONTH;

-- 24. Retrieve the MerchantNames with the highest total Amount for transactions where the DateTime is in the last 30 days and Amount is above the 90th percentile of all amounts.
WITH Percentile90Amount AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
)
SELECT MerchantName, 
       SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Amount > (SELECT P90 FROM Percentile90Amount)
  AND DateTime >= CURRENT_DATE - INTERVAL '30' DAY
GROUP BY MerchantName
ORDER BY TotalAmount DESC;

-- 25. List all transactions with the highest Commission and their corresponding MerchantEmail and Gateway, where the Amount is in the top 10% of all amounts.
WITH Top10PercentAmount AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
)
SELECT MerchantEmail, 
       Gateway, 
       Amount, 
       Commission
FROM Transactions
WHERE Amount >= (SELECT P90 FROM Top10PercentAmount)
ORDER BY Commission DESC
LIMIT 10;

-- 26. Find transactions where the Amount is in the top 5% for each MerchantEmail and the DateTime is within the last 3 months.
WITH Top5PercentAmountByMerchantEmail AS (
    SELECT MerchantEmail, 
           PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS Top5Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantEmail
)
SELECT t.*
FROM Transactions t
JOIN Top5PercentAmountByMerchantEmail p ON t.MerchantEmail = p.MerchantEmail
WHERE t.Amount >= p.Top5Percent
  AND t.DateTime >= CURRENT_DATE - INTERVAL '3' MONTH;

-- 27. Retrieve all transactions where the DateTime is within the last year, the Amount is above the median Amount for that MerchantID, and the Status is 'Completed'.
WITH MedianAmountByMerchantID AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN MedianAmountByMerchantID m ON t.MerchantID = m.MerchantID
WHERE t.Amount > m.MedianAmount
  AND t.Status = 'Completed'
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 28. List all transactions where the Amount is between the 10th and 90th percentiles for each Gateway, with DateTime in the last 6 months.
WITH PercentilesByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY Amount) AS P10,
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN PercentilesByGateway p ON t.Gateway = p.Gateway
WHERE t.Amount BETWEEN p.P10 AND p.P90
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 29. Retrieve the MerchantName, total Amount, and average Commission for transactions where the Amount is above the median Amount for each Gateway and DateTime in the last year.
WITH MedianAmountByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY Gateway
)
SELECT t.MerchantName, 
       SUM(t.Amount) AS TotalAmount, 
       AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN MedianAmountByGateway m ON t.Gateway = m.Gateway
WHERE t.Amount > m.MedianAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantName;

-- 30. Find all transactions where the Amount is below the 25th percentile for each MerchantID and DateTime in the last 90 days.
WITH Percentile25ByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile25ByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount < p.P25
  AND t.DateTime >= CURRENT_DATE - INTERVAL '90' DAY;
-- 31. Retrieve MerchantID, total Amount, and the number of transactions for each MerchantID where the Amount is in the top 1% of all transactions, and DateTime is within the last 6 months.
WITH Top1PercentAmount AS (
    SELECT PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY Amount) AS Top1Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
)
SELECT MerchantID, 
       SUM(Amount) AS TotalAmount, 
       COUNT(*) AS TransactionCount
FROM Transactions
WHERE Amount >= (SELECT Top1Percent FROM Top1PercentAmount)
  AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY MerchantID;

-- 32. Find transactions where the Amount is within the 40th to 60th percentiles for each Gateway, with DateTime in the last 12 months and where Commission is not NULL.
WITH PercentilesByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.40) WITHIN GROUP (ORDER BY Amount) AS P40,
           PERCENTILE_CONT(0.60) WITHIN GROUP (ORDER BY Amount) AS P60
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN PercentilesByGateway p ON t.Gateway = p.Gateway
WHERE t.Amount BETWEEN p.P40 AND p.P60
  AND t.DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
  AND t.Commission IS NOT NULL;

-- 33. Retrieve the top 5 MerchantNames with the highest average Amount per transaction, only for transactions with Status 'Completed' and DateTime in the last 3 months.
SELECT MerchantName, 
       AVG(Amount) AS AvgAmount
FROM Transactions
WHERE Status = 'Completed'
  AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
GROUP BY MerchantName
ORDER BY AvgAmount DESC
LIMIT 5;

-- 34. List all transactions where the Commission is higher than the average Commission for the respective MerchantID and DateTime in the last 1 year.
WITH AvgCommissionByMerchant AS (
    SELECT MerchantID, AVG(Commission) AS AvgCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN AvgCommissionByMerchant a ON t.MerchantID = a.MerchantID
WHERE t.Commission > a.AvgCommission
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 35. Find all MerchantNames where the total Amount for transactions in the last 6 months is greater than the total Amount for transactions in the previous 6 months.
WITH TotalAmountLast6Months AS (
    SELECT MerchantName, SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantName
),
TotalAmountPrevious6Months AS (
    SELECT MerchantName, SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime < CURRENT_DATE - INTERVAL '6' MONTH
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantName
)
SELECT t1.MerchantName
FROM TotalAmountLast6Months t1
JOIN TotalAmountPrevious6Months t2 ON t1.MerchantName = t2.MerchantName
WHERE t1.TotalAmount > t2.TotalAmount;

-- 36. Retrieve the average Amount and Commission for transactions with Amount in the top 5% for each MerchantID, where DateTime is within the last year.
WITH Top5PercentAmountByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Amount) AS Top5Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       AVG(t.Amount) AS AvgAmount, 
       AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN Top5PercentAmountByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount >= p.Top5Percent
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantID;

-- 37. List all MerchantEmails with total Amount greater than the median Amount for their respective MerchantID, with DateTime in the last 90 days.
WITH MedianAmountByMerchantID AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
    GROUP BY MerchantID
)
SELECT t.MerchantEmail, 
       SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN MedianAmountByMerchantID m ON t.MerchantID = m.MerchantID
WHERE t.Amount > m.MedianAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '90' DAY
GROUP BY t.MerchantEmail;

-- 38. Retrieve all transactions where the Amount is below the 25th percentile for each Gateway and the Commission is above the average Commission for that Gateway, with DateTime in the last 6 months.
WITH Percentile25ByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS P25,
           AVG(Commission) AS AvgCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN Percentile25ByGateway p ON t.Gateway = p.Gateway
WHERE t.Amount < p.P25
  AND t.Commission > p.AvgCommission
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 39. Find all transactions where the Amount is above the 75th percentile for each MerchantID and DateTime is in the last 3 months.
WITH Percentile75ByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS P75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT t.*
FROM Transactions t
JOIN Percentile75ByMerchant p ON t.MerchantID = p.MerchantID
WHERE t.Amount >= p.P75
  AND t.DateTime >= CURRENT_DATE - INTERVAL '3' MONTH;

-- 40. Retrieve the total Amount and average Commission for transactions with Amount between the 10th and 90th percentiles, grouped by MerchantID and DateTime in the last year.
WITH PercentilesByMerchantID AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY Amount) AS P10,
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS P90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       SUM(t.Amount) AS TotalAmount, 
       AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN PercentilesByMerchantID p ON t.MerchantID = p.MerchantID
WHERE t.Amount BETWEEN p.P10 AND p.P90
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantID;
-- 41. List the top 10 MerchantIDs with the highest total Amount in transactions within the last 30 days, including their average Commission and total Commission.
SELECT MerchantID, 
       SUM(Amount) AS TotalAmount, 
       AVG(Commission) AS AvgCommission, 
       SUM(Commission) AS TotalCommission
FROM Transactions
WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
GROUP BY MerchantID
ORDER BY TotalAmount DESC
LIMIT 10;

-- 42. Find all transactions where the Amount is more than twice the average Amount for each Gateway in the last 6 months and the Commission is less than the median Commission for that Gateway.
WITH AvgAmountByGateway AS (
    SELECT Gateway, 
           AVG(Amount) AS AvgAmount,
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Commission) AS MedianCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY Gateway
)
SELECT t.*
FROM Transactions t
JOIN AvgAmountByGateway a ON t.Gateway = a.Gateway
WHERE t.Amount > 2 * a.AvgAmount
  AND t.Commission < a.MedianCommission
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH;

-- 43. Retrieve MerchantIDs with transactions having the highest average Commission, only if the Amount is within the top 10% for the MerchantID in the last 12 months.
WITH Top10PercentAmount AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS Top10Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
AvgCommissionByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       AVG(t.Commission) AS AvgCommission
FROM Transactions t
JOIN Top10PercentAmount p ON t.MerchantID = p.MerchantID
JOIN AvgCommissionByMerchant a ON t.MerchantID = a.MerchantID
WHERE t.Amount >= p.Top10Percent
  AND t.DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
GROUP BY t.MerchantID
ORDER BY AvgCommission DESC;

-- 44. List all Gateway values where the total Amount of transactions exceeds the 90th percentile of total Amounts for all Gateways in the last 6 months.
WITH TotalAmountByGateway AS (
    SELECT Gateway, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY Gateway
),
Percentile90 AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY TotalAmount) AS P90
    FROM TotalAmountByGateway
)
SELECT Gateway
FROM TotalAmountByGateway
WHERE TotalAmount > (SELECT P90 FROM Percentile90);

-- 45. Retrieve all transactions where the Amount is within the interquartile range (IQR) for each MerchantID, with DateTime in the last year.
WITH IQRByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS Q1,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Q3
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
IQRRangeByMerchant AS (
    SELECT MerchantID, 
           Q3 - Q1 AS IQR
    FROM IQRByMerchant
)
SELECT t.*
FROM Transactions t
JOIN IQRRangeByMerchant i ON t.MerchantID = i.MerchantID
WHERE t.Amount BETWEEN (i.Q1) AND (i.Q1 + i.IQR)
  AND t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR;

-- 46. Find the average Commission and total Amount for transactions where the Amount is greater than the average Amount for the same MerchantID in the last 90 days.
WITH AvgAmountByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '90' DAY
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       AVG(t.Commission) AS AvgCommission, 
       SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN AvgAmountByMerchant a ON t.MerchantID = a.MerchantID
WHERE t.Amount > a.AvgAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '90' DAY
GROUP BY t.MerchantID;

-- 47. List MerchantNames with the highest standard deviation in Amount, with DateTime in the last year.
WITH StdDevByMerchant AS (
    SELECT MerchantID, 
           STDDEV(Amount) AS StdDevAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantName, 
       s.StdDevAmount
FROM Transactions t
JOIN StdDevByMerchant s ON t.MerchantID = s.MerchantID
WHERE t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantName, s.StdDevAmount
ORDER BY s.StdDevAmount DESC;

-- 48. Retrieve the total Amount and number of transactions for each MerchantID, where the Amount is above the median Amount for the MerchantID and DateTime is within the last 30 days.
WITH MedianAmountByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       SUM(t.Amount) AS TotalAmount, 
       COUNT(*) AS TransactionCount
FROM Transactions t
JOIN MedianAmountByMerchant m ON t.MerchantID = m.MerchantID
WHERE t.Amount > m.MedianAmount
  AND t.DateTime >= CURRENT_DATE - INTERVAL '30' DAY
GROUP BY t.MerchantID;

-- 49. Find the top 5 MerchantIDs with the highest total Commission where Amount is within the top 10% for that MerchantID, with DateTime in the last 6 months.
WITH Top10PercentAmountByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS Top10Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalCommissionByMerchant AS (
    SELECT MerchantID, 
           SUM(Commission) AS TotalCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       SUM(t.Commission) AS TotalCommission
FROM Transactions t
JOIN Top10PercentAmountByMerchant p ON t.MerchantID = p.MerchantID
JOIN TotalCommissionByMerchant c ON t.MerchantID = c.MerchantID
WHERE t.Amount >= p.Top10Percent
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY t.MerchantID
ORDER BY TotalCommission DESC
LIMIT 5;

-- 50. Retrieve MerchantEmails where the number of transactions with Amount above the 90th percentile for that MerchantID is greater than the median number of transactions for all MerchantIDs in the last year.
WITH TransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCount
    FROM Transactions
    WHERE Amount >= PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
MedianTransactionCount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY COUNT(*)) AS MedianCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantEmail
FROM Transactions t
JOIN TransactionCountByMerchant c ON t.MerchantID = c.MerchantID
JOIN MedianTransactionCount m ON c.TransactionCount > m.MedianCount
WHERE t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantEmail;
-- 51. List all MerchantIDs where the total Amount for transactions with Status 'Completed' is higher than the average total Amount for all MerchantIDs in the last 6 months.
WITH TotalAmountByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgTotalAmount AS (
    SELECT AVG(TotalAmount) AS AvgAmount
    FROM TotalAmountByMerchant
)
SELECT MerchantID, 
       TotalAmount
FROM TotalAmountByMerchant
WHERE TotalAmount > (SELECT AvgAmount FROM AvgTotalAmount);

-- 52. Retrieve MerchantNames where the total Commission in the last year is more than twice the total Commission in the previous year.
WITH TotalCommissionCurrentYear AS (
    SELECT MerchantID, 
           SUM(Commission) AS TotalCommission
    FROM Transactions
    WHERE DateTime >= DATE_TRUNC('year', CURRENT_DATE)
    GROUP BY MerchantID
),
TotalCommissionPreviousYear AS (
    SELECT MerchantID, 
           SUM(Commission) AS TotalCommission
    FROM Transactions
    WHERE DateTime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1' YEAR
      AND DateTime < DATE_TRUNC('year', CURRENT_DATE)
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       t.MerchantName, 
       c.TotalCommission AS CurrentYearCommission, 
       p.TotalCommission AS PreviousYearCommission
FROM TotalCommissionCurrentYear c
JOIN TotalCommissionPreviousYear p ON c.MerchantID = p.MerchantID
JOIN Transactions t ON c.MerchantID = t.MerchantID
WHERE c.TotalCommission > 2 * p.TotalCommission
GROUP BY c.MerchantID, t.MerchantName, c.TotalCommission, p.TotalCommission;

-- 53. Find the top 3 Gateway values with the highest average Amount where the Amount is above the median Amount for each Gateway in the last 12 months.
WITH MedianAmountByGateway AS (
    SELECT Gateway, 
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY Gateway
),
AvgAmountByGateway AS (
    SELECT Gateway, 
           AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
      AND Amount > (SELECT MedianAmount FROM MedianAmountByGateway WHERE Gateway = Transactions.Gateway)
    GROUP BY Gateway
)
SELECT Gateway, 
       AvgAmount
FROM AvgAmountByGateway
ORDER BY AvgAmount DESC
LIMIT 3;

-- 54. Retrieve MerchantIDs with the highest total Amount where the Commission is in the top 10% for that MerchantID in the last 6 months.
WITH Top10PercentCommission AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Commission) AS Top10Percent
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       SUM(t.Amount) AS TotalAmount
FROM Transactions t
JOIN Top10PercentCommission c ON t.MerchantID = c.MerchantID
JOIN TotalAmountByMerchant a ON t.MerchantID = a.MerchantID
WHERE t.Commission >= c.Top10Percent
  AND t.DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
GROUP BY t.MerchantID
ORDER BY TotalAmount DESC;

-- 55. List all MerchantEmails where the number of transactions with Amount above the 75th percentile for that MerchantID is greater than the median number of transactions for all MerchantIDs in the last year.
WITH Percentile75AmountByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Percentile75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCount
    FROM Transactions
    WHERE Amount > (SELECT Percentile75 FROM Percentile75AmountByMerchant WHERE MerchantID = Transactions.MerchantID)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
MedianTransactionCount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TransactionCount) AS MedianCount
    FROM TransactionCountByMerchant
)
SELECT t.MerchantEmail
FROM Transactions t
JOIN TransactionCountByMerchant c ON t.MerchantID = c.MerchantID
JOIN MedianTransactionCount m ON c.TransactionCount > m.MedianCount
WHERE t.DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
GROUP BY t.MerchantEmail;

-- 56. Find MerchantIDs where the total Amount in the last 30 days is greater than the total Amount in the previous 30 days and list the top 5 such MerchantIDs by total Amount.
WITH TotalAmountLast30Days AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '30' DAY
    GROUP BY MerchantID
),
TotalAmountPrevious30Days AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '60' DAY
      AND DateTime < CURRENT_DATE - INTERVAL '30' DAY
    GROUP BY MerchantID
)
SELECT l.MerchantID, 
       l.TotalAmount AS AmountLast30Days
FROM TotalAmountLast30Days l
JOIN TotalAmountPrevious30Days p ON l.MerchantID = p.MerchantID
WHERE l.TotalAmount > p.TotalAmount
ORDER BY l.TotalAmount DESC
LIMIT 5;

-- 57. Retrieve all MerchantIDs where the average Amount for transactions with Status 'Pending' is greater than the average Amount for all transactions of that MerchantID in the last year.
WITH AvgAmountByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
AvgAmountPendingByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT p.MerchantID
FROM AvgAmountByMerchant a
JOIN AvgAmountPendingByMerchant p ON a.MerchantID = p.MerchantID
WHERE p.AvgAmountPending > a.AvgAmount;

-- 58. List all MerchantIDs where the number of transactions in the last 6 months is greater than the average number of transactions for all MerchantIDs in the last 6 months.
WITH TransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgTransactionCount AS (
    SELECT AVG(TransactionCount) AS AvgCount
    FROM TransactionCountByMerchant
)
SELECT MerchantID
FROM TransactionCountByMerchant
WHERE TransactionCount > (SELECT AvgCount FROM AvgTransactionCount);

-- 59. Retrieve the MerchantNames where the total Amount for transactions with Status 'Refunded' is more than twice the total Amount for transactions with Status 'Completed' for the same MerchantID in the last year.
WITH TotalAmountRefunded AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE Status = 'Refunded'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountCompleted AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT r.MerchantID, 
       t.MerchantName, 
       r.TotalAmount AS RefundedAmount, 
       c.TotalAmount AS CompletedAmount
FROM TotalAmountRefunded r
JOIN TotalAmountCompleted c ON r.MerchantID = c.MerchantID
JOIN Transactions t ON r.MerchantID = t.MerchantID
WHERE r.TotalAmount > 2 * c.TotalAmount
GROUP BY r.MerchantID, t.MerchantName, r.TotalAmount, c.TotalAmount;

-- 60. Find the top 5 MerchantIDs with the highest total Amount for transactions with Status 'Completed' where the total Amount is above the median total Amount for all MerchantIDs in the last year.
WITH TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
MedianTotalAmount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TotalAmount) AS MedianAmount
    FROM TotalAmountCompletedByMerchant
)
SELECT MerchantID, 
       TotalAmount
FROM TotalAmountCompletedByMerchant
WHERE TotalAmount > (SELECT MedianAmount FROM MedianTotalAmount)
ORDER BY TotalAmount DESC
LIMIT 5;
-- 61. List all MerchantIDs where the average Amount for transactions with Status 'Failed' is greater than the average Amount for transactions with Status 'Completed' for the same MerchantID in the last 12 months.
WITH AvgAmountFailedByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
AvgAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
)
SELECT f.MerchantID
FROM AvgAmountFailedByMerchant f
JOIN AvgAmountCompletedByMerchant c ON f.MerchantID = c.MerchantID
WHERE f.AvgAmountFailed > c.AvgAmountCompleted;

-- 62. Retrieve MerchantNames where the total Amount in the last 6 months is higher than the 90th percentile of total Amount for all MerchantIDs in the last 6 months.
WITH TotalAmountByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
Percentile90Amount AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY TotalAmount) AS Percentile90
    FROM TotalAmountByMerchant
)
SELECT t.MerchantID, 
       t.MerchantName, 
       a.TotalAmount
FROM TotalAmountByMerchant a
JOIN Transactions t ON a.MerchantID = t.MerchantID
WHERE a.TotalAmount > (SELECT Percentile90 FROM Percentile90Amount);

-- 63. Find all MerchantIDs where the total Amount for transactions with PaymentMode 'Card' is more than twice the total Amount for transactions with PaymentMode 'Cash' in the last year.
WITH TotalAmountCardByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCard
    FROM Transactions
    WHERE PaymentMode = 'Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountCashByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCash
    FROM Transactions
    WHERE PaymentMode = 'Cash'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.TotalAmountCard AS CardAmount, 
       p.TotalAmountCash AS CashAmount
FROM TotalAmountCardByMerchant c
JOIN TotalAmountCashByMerchant p ON c.MerchantID = p.MerchantID
WHERE c.TotalAmountCard > 2 * p.TotalAmountCash;

-- 64. Retrieve the top 10 MerchantIDs with the highest total Amount for transactions with Status 'Completed' where the total Amount is above the median of total Amount for all MerchantIDs in the last 3 months.
WITH TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmount
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
MedianTotalAmount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TotalAmount) AS MedianAmount
    FROM TotalAmountCompletedByMerchant
)
SELECT MerchantID, 
       TotalAmount
FROM TotalAmountCompletedByMerchant
WHERE TotalAmount > (SELECT MedianAmount FROM MedianTotalAmount)
ORDER BY TotalAmount DESC
LIMIT 10;

-- 65. List all MerchantEmails where the total Commission in the last 6 months is greater than the average Commission for all MerchantIDs in the same period.
WITH TotalCommissionByMerchant AS (
    SELECT MerchantID, 
           SUM(Commission) AS TotalCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgCommission AS (
    SELECT AVG(TotalCommission) AS AvgCommission
    FROM TotalCommissionByMerchant
)
SELECT t.MerchantEmail
FROM Transactions t
JOIN TotalCommissionByMerchant c ON t.MerchantID = c.MerchantID
WHERE c.TotalCommission > (SELECT AvgCommission FROM AvgCommission)
GROUP BY t.MerchantEmail;

-- 66. Find all MerchantIDs where the number of transactions with Amount greater than the 75th percentile Amount is more than the median number of transactions for all MerchantIDs in the last 12 months.
WITH Percentile75AmountByMerchant AS (
    SELECT MerchantID, 
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Percentile75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
TransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCount
    FROM Transactions
    WHERE Amount > (SELECT Percentile75 FROM Percentile75AmountByMerchant WHERE MerchantID = Transactions.MerchantID)
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
MedianTransactionCount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TransactionCount) AS MedianCount
    FROM TransactionCountByMerchant
)
SELECT MerchantID
FROM TransactionCountByMerchant
WHERE TransactionCount > (SELECT MedianCount FROM MedianTransactionCount);

-- 67. Retrieve MerchantNames where the average Amount for transactions with Status 'Successful' is higher than the average Amount for transactions with Status 'Failed' for the same MerchantID in the last year.
WITH AvgAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
AvgAmountFailedByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT s.MerchantID, 
       t.MerchantName, 
       s.AvgAmountSuccessful
FROM AvgAmountSuccessfulByMerchant s
JOIN AvgAmountFailedByMerchant f ON s.MerchantID = f.MerchantID
JOIN Transactions t ON s.MerchantID = t.MerchantID
WHERE s.AvgAmountSuccessful > f.AvgAmountFailed
GROUP BY s.MerchantID, t.MerchantName, s.AvgAmountSuccessful;

-- 68. Find MerchantIDs where the total Amount for transactions with PaymentMode 'Online' in the last 3 months is greater than the total Amount for transactions with PaymentMode 'Offline' in the same period.
WITH TotalAmountOnlineByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountOnline
    FROM Transactions
    WHERE PaymentMode = 'Online'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
TotalAmountOfflineByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountOffline
    FROM Transactions
    WHERE PaymentMode = 'Offline'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT o.MerchantID, 
       o.TotalAmountOnline AS OnlineAmount, 
       f.TotalAmountOffline AS OfflineAmount
FROM TotalAmountOnlineByMerchant o
JOIN TotalAmountOfflineByMerchant f ON o.MerchantID = f.MerchantID
WHERE o.TotalAmountOnline > f.TotalAmountOffline;

-- 69. Retrieve MerchantIDs where the average Commission for transactions with Status 'Pending' is greater than the average Commission for transactions with Status 'Completed' in the last 6 months.
WITH AvgCommissionPendingByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommissionPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgCommissionCompletedByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommissionCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT p.MerchantID
FROM AvgCommissionPendingByMerchant p
JOIN AvgCommissionCompletedByMerchant c ON p.MerchantID = c.MerchantID
WHERE p.AvgCommissionPending > c.AvgCommissionCompleted;

-- 70. Find all MerchantIDs where the number of transactions with Status 'Refunded' is higher than the median number of transactions with Status 'Completed' in the last year.
WITH TransactionCountRefundedByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountRefunded
    FROM Transactions
    WHERE Status = 'Refunded'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountCompletedByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
MedianTransactionCountCompleted AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TransactionCountCompleted) AS MedianCount
    FROM TransactionCountCompletedByMerchant
)
SELECT r.MerchantID, 
       r.TransactionCountRefunded
FROM TransactionCountRefundedByMerchant r
JOIN TransactionCountCompletedByMerchant c ON r.MerchantID = c.MerchantID
WHERE r.TransactionCountRefunded > (SELECT MedianCount FROM MedianTransactionCountCompleted);
-- 71. Retrieve MerchantIDs where the total Amount of transactions with Status 'Completed' in the last 6 months is more than twice the total Amount of transactions with Status 'Pending' in the same period.
WITH TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountPendingByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.TotalAmountCompleted AS CompletedAmount, 
       p.TotalAmountPending AS PendingAmount
FROM TotalAmountCompletedByMerchant c
JOIN TotalAmountPendingByMerchant p ON c.MerchantID = p.MerchantID
WHERE c.TotalAmountCompleted > 2 * p.TotalAmountPending;

-- 72. Find the top 5 MerchantIDs with the highest average Commission for transactions with Status 'Failed' over the last year.
WITH AvgCommissionFailedByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommissionFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT MerchantID, 
       AvgCommissionFailed
FROM AvgCommissionFailedByMerchant
ORDER BY AvgCommissionFailed DESC
LIMIT 5;

-- 73. List MerchantNames where the total Commission for transactions with PaymentMode 'Online' is higher than the 75th percentile of total Commission for all PaymentModes in the last 6 months.
WITH TotalCommissionByPaymentMode AS (
    SELECT PaymentMode, 
           SUM(Commission) AS TotalCommission
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY PaymentMode
),
Percentile75Commission AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TotalCommission) AS Percentile75
    FROM TotalCommissionByPaymentMode
),
TotalCommissionOnlineByMerchant AS (
    SELECT MerchantID, 
           SUM(Commission) AS TotalCommissionOnline
    FROM Transactions
    WHERE PaymentMode = 'Online'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
MerchantInfo AS (
    SELECT t.MerchantID, 
           t.MerchantName, 
           c.TotalCommissionOnline
    FROM Transactions t
    JOIN TotalCommissionOnlineByMerchant c ON t.MerchantID = c.MerchantID
)
SELECT DISTINCT mi.MerchantID, 
                mi.MerchantName
FROM MerchantInfo mi
JOIN Percentile75Commission p ON mi.TotalCommissionOnline > p.Percentile75;

-- 74. Retrieve MerchantIDs where the total Amount for transactions with Status 'Successful' is higher than the average total Amount for all MerchantIDs with Status 'Failed' in the last 12 months.
WITH TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
TotalAmountFailedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
AvgTotalAmountFailed AS (
    SELECT AVG(TotalAmountFailed) AS AvgTotalAmountFailed
    FROM TotalAmountFailedByMerchant
)
SELECT s.MerchantID, 
       s.TotalAmountSuccessful
FROM TotalAmountSuccessfulByMerchant s
JOIN TotalAmountFailedByMerchant f ON s.MerchantID = f.MerchantID
WHERE s.TotalAmountSuccessful > (SELECT AvgTotalAmountFailed FROM AvgTotalAmountFailed);

-- 75. Find all MerchantIDs where the number of transactions with Amount greater than the 90th percentile Amount in the last 3 months is higher than the median number of transactions with Amount greater than the 50th percentile Amount.
WITH Percentile90Amount AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS Percentile90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
),
TransactionCountAbove90Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountAbove90
    FROM Transactions
    WHERE Amount > (SELECT Percentile90 FROM Percentile90Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
Percentile50Amount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS Percentile50
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
),
TransactionCountAbove50Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountAbove50
    FROM Transactions
    WHERE Amount > (SELECT Percentile50 FROM Percentile50Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
MedianTransactionCountAbove50 AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TransactionCountAbove50) AS MedianCount
    FROM TransactionCountAbove50Percentile
)
SELECT t.MerchantID, 
       t.TransactionCountAbove90
FROM TransactionCountAbove90Percentile t
JOIN MedianTransactionCountAbove50 m ON t.TransactionCountAbove90 > m.MedianCount;

-- 76. Retrieve MerchantNames where the total Amount of transactions with Status 'Completed' and PaymentMode 'Cash' is more than the average total Amount for transactions with Status 'Failed' and PaymentMode 'Card' in the last year.
WITH TotalAmountCompletedCashByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCompletedCash
    FROM Transactions
    WHERE Status = 'Completed'
      AND PaymentMode = 'Cash'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountFailedCardByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailedCard
    FROM Transactions
    WHERE Status = 'Failed'
      AND PaymentMode = 'Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
AvgTotalAmountFailedCard AS (
    SELECT AVG(TotalAmountFailedCard) AS AvgTotalAmountFailedCard
    FROM TotalAmountFailedCardByMerchant
)
SELECT c.MerchantID, 
       t.MerchantName, 
       c.TotalAmountCompletedCash
FROM TotalAmountCompletedCashByMerchant c
JOIN TotalAmountFailedCardByMerchant f ON c.MerchantID = f.MerchantID
JOIN Transactions t ON c.MerchantID = t.MerchantID
WHERE c.TotalAmountCompletedCash > (SELECT AvgTotalAmountFailedCard FROM AvgTotalAmountFailedCard)
GROUP BY c.MerchantID, t.MerchantName, c.TotalAmountCompletedCash;

-- 77. Find MerchantIDs where the total Amount for transactions with Status 'Pending' is higher than the median total Amount for transactions with Status 'Completed' in the last 6 months.
WITH TotalAmountPendingByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
MedianTotalAmountCompleted AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TotalAmountCompleted) AS MedianAmount
    FROM TotalAmountCompletedByMerchant
)
SELECT p.MerchantID, 
       p.TotalAmountPending
FROM TotalAmountPendingByMerchant p
JOIN TotalAmountCompletedByMerchant c ON p.MerchantID = c.MerchantID
WHERE p.TotalAmountPending > (SELECT MedianAmount FROM MedianTotalAmountCompleted);

-- 78. Retrieve MerchantIDs where the average Amount for transactions with PaymentMode 'Cheque' is greater than the average Amount for transactions with PaymentMode 'Transfer' in the last year.
WITH AvgAmountChequeByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountCheque
    FROM Transactions
    WHERE PaymentMode = 'Cheque'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
AvgAmountTransferByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountTransfer
    FROM Transactions
    WHERE PaymentMode = 'Transfer'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.AvgAmountCheque AS ChequeAmount, 
       t.AvgAmountTransfer AS TransferAmount
FROM AvgAmountChequeByMerchant c
JOIN AvgAmountTransferByMerchant t ON c.MerchantID = t.MerchantID
WHERE c.AvgAmountCheque > t.AvgAmountTransfer;

-- 79. Find the MerchantIDs where the number of transactions with Amount greater than the 50th percentile Amount in the last 6 months is higher than the number of transactions with Amount greater than the 90th percentile Amount in the same period.
WITH Percentile50Amount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS Percentile50
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
),
Percentile90Amount AS (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Amount) AS Percentile90
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
),
TransactionCountAbove50Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountAbove50
    FROM Transactions
    WHERE Amount > (SELECT Percentile50 FROM Percentile50Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TransactionCountAbove90Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS TransactionCountAbove90
    FROM Transactions
    WHERE Amount > (SELECT Percentile90 FROM Percentile90Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT a.MerchantID, 
       a.TransactionCountAbove50
FROM TransactionCountAbove50Percentile a
JOIN TransactionCountAbove90Percentile b ON a.MerchantID = b.MerchantID
WHERE a.TransactionCountAbove50 > b.TransactionCountAbove90;

-- 80. List MerchantNames where the total Amount for transactions with Status 'Successful' is higher than the total Amount for transactions with Status 'Failed' for the same MerchantID, and the number of Successful transactions is greater than the number of Failed transactions.
WITH TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountFailedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
CountSuccessfulTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS CountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
CountFailedTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS CountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
)
SELECT t.MerchantID, 
       t.MerchantName, 
       s.TotalAmountSuccessful, 
       f.TotalAmountFailed
FROM TotalAmountSuccessfulByMerchant s
JOIN TotalAmountFailedByMerchant f ON s.MerchantID = f.MerchantID
JOIN CountSuccessfulTransactionsByMerchant cs ON s.MerchantID = cs.MerchantID
JOIN CountFailedTransactionsByMerchant cf ON s.MerchantID = cf.MerchantID
JOIN Transactions t ON s.MerchantID = t.MerchantID
WHERE s.TotalAmountSuccessful > f.TotalAmountFailed
  AND cs.CountSuccessful > cf.CountFailed
GROUP BY t.MerchantID, t.MerchantName, s.TotalAmountSuccessful, f.TotalAmountFailed;
-- 81. Retrieve MerchantIDs where the total Amount of transactions with PaymentMode 'Wallet' exceeds the average total Amount for transactions with PaymentMode 'Card' in the last 12 months, and include the MerchantName.
WITH TotalAmountWalletByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountWallet
    FROM Transactions
    WHERE PaymentMode = 'Wallet'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
TotalAmountCardByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCard
    FROM Transactions
    WHERE PaymentMode = 'Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
AvgTotalAmountCard AS (
    SELECT AVG(TotalAmountCard) AS AvgTotalAmountCard
    FROM TotalAmountCardByMerchant
)
SELECT w.MerchantID, 
       t.MerchantName, 
       w.TotalAmountWallet
FROM TotalAmountWalletByMerchant w
JOIN TotalAmountCardByMerchant c ON w.MerchantID = c.MerchantID
JOIN Transactions t ON w.MerchantID = t.MerchantID
WHERE w.TotalAmountWallet > (SELECT AvgTotalAmountCard FROM AvgTotalAmountCard)
GROUP BY w.MerchantID, t.MerchantName, w.TotalAmountWallet;

-- 82. Find MerchantIDs where the percentage of transactions with Status 'Successful' is higher than the average percentage of transactions with Status 'Successful' for all MerchantIDs over the last 6 months.
WITH TotalTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactions
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
SuccessfulTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS SuccessfulTransactions
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
PercentageSuccessfulByMerchant AS (
    SELECT t.MerchantID, 
           (s.SuccessfulTransactions * 100.0 / t.TotalTransactions) AS PercentageSuccessful
    FROM TotalTransactionsByMerchant t
    JOIN SuccessfulTransactionsByMerchant s ON t.MerchantID = s.MerchantID
),
AvgPercentageSuccessful AS (
    SELECT AVG(PercentageSuccessful) AS AvgPercentageSuccessful
    FROM PercentageSuccessfulByMerchant
)
SELECT MerchantID, 
       PercentageSuccessful
FROM PercentageSuccessfulByMerchant
WHERE PercentageSuccessful > (SELECT AvgPercentageSuccessful FROM AvgPercentageSuccessful);

-- 83. List MerchantNames where the total Amount for transactions with Status 'Failed' is lower than the median total Amount for transactions with Status 'Successful' in the last year.
WITH TotalAmountFailedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
MedianTotalAmountSuccessful AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY TotalAmountSuccessful) AS MedianAmount
    FROM TotalAmountSuccessfulByMerchant
)
SELECT t.MerchantID, 
       t.MerchantName, 
       f.TotalAmountFailed
FROM TotalAmountFailedByMerchant f
JOIN TotalAmountSuccessfulByMerchant s ON f.MerchantID = s.MerchantID
JOIN MedianTotalAmountSuccessful m ON f.TotalAmountFailed < m.MedianAmount
JOIN Transactions t ON f.MerchantID = t.MerchantID
GROUP BY t.MerchantID, t.MerchantName, f.TotalAmountFailed;

-- 84. Retrieve MerchantIDs where the average Commission for transactions with Status 'Completed' is greater than the average Commission for transactions with Status 'Pending' in the last 6 months.
WITH AvgCommissionCompletedByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommissionCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgCommissionPendingByMerchant AS (
    SELECT MerchantID, 
           AVG(Commission) AS AvgCommissionPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.AvgCommissionCompleted AS CompletedCommission, 
       p.AvgCommissionPending AS PendingCommission
FROM AvgCommissionCompletedByMerchant c
JOIN AvgCommissionPendingByMerchant p ON c.MerchantID = p.MerchantID
WHERE c.AvgCommissionCompleted > p.AvgCommissionPending;

-- 85. Find all MerchantIDs where the total Amount of transactions with PaymentMode 'Bank Transfer' is higher than the total Amount of transactions with PaymentMode 'Cash' for the same MerchantID in the last 3 months.
WITH TotalAmountBankTransferByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountBankTransfer
    FROM Transactions
    WHERE PaymentMode = 'Bank Transfer'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
TotalAmountCashByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCash
    FROM Transactions
    WHERE PaymentMode = 'Cash'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT b.MerchantID, 
       b.TotalAmountBankTransfer, 
       c.TotalAmountCash
FROM TotalAmountBankTransferByMerchant b
JOIN TotalAmountCashByMerchant c ON b.MerchantID = c.MerchantID
WHERE b.TotalAmountBankTransfer > c.TotalAmountCash;

-- 86. Retrieve MerchantIDs where the percentage of transactions with Amount less than the 25th percentile Amount is higher than the percentage of transactions with Amount greater than the 75th percentile Amount in the last year.
WITH Percentile25Amount AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS Percentile25
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
Percentile75Amount AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Percentile75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
TransactionCountBelow25Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS CountBelow25
    FROM Transactions
    WHERE Amount < (SELECT Percentile25 FROM Percentile25Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountAbove75Percentile AS (
    SELECT MerchantID, 
           COUNT(*) AS CountAbove75
    FROM Transactions
    WHERE Amount > (SELECT Percentile75 FROM Percentile75Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalTransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactionCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
PercentageBelow25Percentile AS (
    SELECT t.MerchantID, 
           (b.CountBelow25 * 100.0 / tt.TotalTransactionCount) AS PercentageBelow25
    FROM TransactionCountBelow25Percentile b
    JOIN TotalTransactionCountByMerchant tt ON b.MerchantID = tt.MerchantID
),
PercentageAbove75Percentile AS (
    SELECT t.MerchantID, 
           (a.CountAbove75 * 100.0 / tt.TotalTransactionCount) AS PercentageAbove75
    FROM TransactionCountAbove75Percentile a
    JOIN TotalTransactionCountByMerchant tt ON a.MerchantID = tt.MerchantID
)
SELECT p.MerchantID, 
       p.PercentageBelow25
FROM PercentageBelow25Percentile p
JOIN PercentageAbove75Percentile a ON p.MerchantID = a.MerchantID
WHERE p.PercentageBelow25 > a.PercentageAbove75;

-- 87. List MerchantNames where the total Amount for transactions with Status 'Successful' is lower than the 25th percentile total Amount for transactions with Status 'Failed' in the last 6 months.
WITH TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountFailedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
Percentile25AmountFailed AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY TotalAmountFailed) AS Percentile25
    FROM TotalAmountFailedByMerchant
)
SELECT s.MerchantID, 
       s.MerchantName, 
       s.TotalAmountSuccessful
FROM TotalAmountSuccessfulByMerchant s
JOIN TotalAmountFailedByMerchant f ON s.MerchantID = f.MerchantID
JOIN Percentile25AmountFailed p ON s.TotalAmountSuccessful < p.Percentile25
JOIN Transactions t ON s.MerchantID = t.MerchantID
GROUP BY s.MerchantID, s.MerchantName, s.TotalAmountSuccessful;

-- 88. Find MerchantIDs where the total Amount for transactions with PaymentMode 'Credit Card' is higher than the total Amount for transactions with PaymentMode 'Debit Card' in the last 12 months.
WITH TotalAmountCreditCardByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCreditCard
    FROM Transactions
    WHERE PaymentMode = 'Credit Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
),
TotalAmountDebitCardByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountDebitCard
    FROM Transactions
    WHERE PaymentMode = 'Debit Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '12' MONTH
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.TotalAmountCreditCard, 
       d.TotalAmountDebitCard
FROM TotalAmountCreditCardByMerchant c
JOIN TotalAmountDebitCardByMerchant d ON c.MerchantID = d.MerchantID
WHERE c.TotalAmountCreditCard > d.TotalAmountDebitCard;

-- 89. Retrieve MerchantIDs where the average Amount for transactions with Status 'Refunded' is higher than the average Amount for transactions with Status 'Completed' in the last 3 months.
WITH AvgAmountRefundedByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountRefunded
    FROM Transactions
    WHERE Status = 'Refunded'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
AvgAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT r.MerchantID, 
       r.AvgAmountRefunded AS RefundedAvgAmount, 
       c.AvgAmountCompleted AS CompletedAvgAmount
FROM AvgAmountRefundedByMerchant r
JOIN AvgAmountCompletedByMerchant c ON r.MerchantID = c.MerchantID
WHERE r.AvgAmountRefunded > c.AvgAmountCompleted;

-- 90. List MerchantNames where the percentage of transactions with Amount greater than the median Amount is higher than the percentage of transactions with Amount less than the median Amount in the last year.
WITH MedianAmount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
TransactionCountAboveMedian AS (
    SELECT MerchantID, 
           COUNT(*) AS CountAboveMedian
    FROM Transactions
    WHERE Amount > (SELECT MedianAmount FROM MedianAmount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountBelowMedian AS (
    SELECT MerchantID, 
           COUNT(*) AS CountBelowMedian
    FROM Transactions
    WHERE Amount < (SELECT MedianAmount FROM MedianAmount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalTransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactionCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
PercentageAboveMedian AS (
    SELECT t.MerchantID, 
           (a.CountAboveMedian * 100.0 / tt.TotalTransactionCount) AS PercentageAboveMedian
    FROM TransactionCountAboveMedian a
    JOIN TotalTransactionCountByMerchant tt ON a.MerchantID = tt.MerchantID
),
PercentageBelowMedian AS (
    SELECT t.MerchantID, 
           (b.CountBelowMedian * 100.0 / tt.TotalTransactionCount) AS PercentageBelowMedian
    FROM TransactionCountBelowMedian b
    JOIN TotalTransactionCountByMerchant tt ON b.MerchantID = tt.MerchantID
)
SELECT p.MerchantID, 
       p.PercentageAboveMedian
FROM PercentageAboveMedian p
JOIN PercentageBelowMedian b ON p.MerchantID = b.MerchantID
WHERE p.PercentageAboveMedian > b.PercentageBelowMedian;
-- 91. Retrieve MerchantIDs where the total Amount of transactions with Status 'Pending' is higher than the average total Amount for transactions with Status 'Successful' in the last 6 months.
WITH TotalAmountPendingByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
AvgTotalAmountSuccessful AS (
    SELECT AVG(TotalAmountSuccessful) AS AvgTotalAmountSuccessful
    FROM TotalAmountSuccessfulByMerchant
)
SELECT p.MerchantID, 
       p.TotalAmountPending
FROM TotalAmountPendingByMerchant p
JOIN AvgTotalAmountSuccessful a ON p.TotalAmountPending > a.AvgTotalAmountSuccessful;

-- 92. Find MerchantIDs where the average Amount of transactions with PaymentMode 'UPI' is greater than the median Amount of transactions with PaymentMode 'Net Banking' in the last 3 months.
WITH AvgAmountUPIByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountUPI
    FROM Transactions
    WHERE PaymentMode = 'UPI'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
MedianAmountNetBanking AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE PaymentMode = 'Net Banking'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
),
AvgAmountNetBankingByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountNetBanking
    FROM Transactions
    WHERE PaymentMode = 'Net Banking'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT u.MerchantID, 
       u.AvgAmountUPI
FROM AvgAmountUPIByMerchant u
JOIN AvgAmountNetBankingByMerchant n ON u.MerchantID = n.MerchantID
JOIN MedianAmountNetBanking m ON u.AvgAmountUPI > m.MedianAmount;

-- 93. List MerchantNames where the percentage of transactions with Status 'Failed' is higher than the percentage of transactions with Status 'Successful' in the last year.
WITH TotalTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactions
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
FailedTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS FailedTransactions
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
SuccessfulTransactionsByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS SuccessfulTransactions
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
PercentageFailedByMerchant AS (
    SELECT t.MerchantID, 
           (f.FailedTransactions * 100.0 / tt.TotalTransactions) AS PercentageFailed
    FROM FailedTransactionsByMerchant f
    JOIN TotalTransactionsByMerchant tt ON f.MerchantID = tt.MerchantID
),
PercentageSuccessfulByMerchant AS (
    SELECT s.MerchantID, 
           (s.SuccessfulTransactions * 100.0 / tt.TotalTransactions) AS PercentageSuccessful
    FROM SuccessfulTransactionsByMerchant s
    JOIN TotalTransactionsByMerchant tt ON s.MerchantID = tt.MerchantID
)
SELECT p.MerchantID, 
       t.MerchantName, 
       p.PercentageFailed
FROM PercentageFailedByMerchant p
JOIN PercentageSuccessfulByMerchant s ON p.MerchantID = s.MerchantID
JOIN Transactions t ON p.MerchantID = t.MerchantID
WHERE p.PercentageFailed > s.PercentageSuccessful
GROUP BY p.MerchantID, t.MerchantName, p.PercentageFailed;

-- 94. Retrieve MerchantIDs where the total Amount of transactions with Status 'Refunded' is lower than the 75th percentile total Amount of transactions with Status 'Completed' in the last 6 months.
WITH TotalAmountRefundedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountRefunded
    FROM Transactions
    WHERE Status = 'Refunded'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
Percentile75AmountCompleted AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TotalAmountCompleted) AS Percentile75
    FROM TotalAmountCompletedByMerchant
)
SELECT r.MerchantID, 
       r.TotalAmountRefunded
FROM TotalAmountRefundedByMerchant r
JOIN TotalAmountCompletedByMerchant c ON r.MerchantID = c.MerchantID
JOIN Percentile75AmountCompleted p ON r.TotalAmountRefunded < p.Percentile75
JOIN Transactions t ON r.MerchantID = t.MerchantID
GROUP BY r.MerchantID, r.TotalAmountRefunded;

-- 95. Find MerchantIDs where the percentage of transactions with Amount between the 25th and 75th percentiles is higher than the percentage of transactions with Amount outside this range in the last year.
WITH Percentile25Amount AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Amount) AS Percentile25
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
Percentile75Amount AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Amount) AS Percentile75
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
TransactionCountBetweenPercentiles AS (
    SELECT MerchantID, 
           COUNT(*) AS CountBetweenPercentiles
    FROM Transactions
    WHERE Amount >= (SELECT Percentile25 FROM Percentile25Amount)
      AND Amount <= (SELECT Percentile75 FROM Percentile75Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountOutsidePercentiles AS (
    SELECT MerchantID, 
           COUNT(*) AS CountOutsidePercentiles
    FROM Transactions
    WHERE Amount < (SELECT Percentile25 FROM Percentile25Amount)
       OR Amount > (SELECT Percentile75 FROM Percentile75Amount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalTransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactionCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
PercentageBetweenPercentiles AS (
    SELECT t.MerchantID, 
           (b.CountBetweenPercentiles * 100.0 / tt.TotalTransactionCount) AS PercentageBetweenPercentiles
    FROM TransactionCountBetweenPercentiles b
    JOIN TotalTransactionCountByMerchant tt ON b.MerchantID = tt.MerchantID
),
PercentageOutsidePercentiles AS (
    SELECT t.MerchantID, 
           (o.CountOutsidePercentiles * 100.0 / tt.TotalTransactionCount) AS PercentageOutsidePercentiles
    FROM TransactionCountOutsidePercentiles o
    JOIN TotalTransactionCountByMerchant tt ON o.MerchantID = tt.MerchantID
)
SELECT p.MerchantID, 
       p.PercentageBetweenPercentiles
FROM PercentageBetweenPercentiles p
JOIN PercentageOutsidePercentiles o ON p.MerchantID = o.MerchantID
WHERE p.PercentageBetweenPercentiles > o.PercentageOutsidePercentiles;

-- 96. List MerchantIDs where the average Amount of transactions with PaymentMode 'Cash' is higher than the median Amount of transactions with Status 'Successful' in the last 3 months.
WITH AvgAmountCashByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountCash
    FROM Transactions
    WHERE PaymentMode = 'Cash'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
MedianAmountSuccessful AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
),
AvgAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT c.MerchantID, 
       c.AvgAmountCash
FROM AvgAmountCashByMerchant c
JOIN AvgAmountSuccessfulByMerchant s ON c.MerchantID = s.MerchantID
JOIN MedianAmountSuccessful m ON c.AvgAmountCash > m.MedianAmount;

-- 97. Retrieve MerchantIDs where the total Amount of transactions with Status 'Completed' is lower than the 25th percentile total Amount for transactions with Status 'Failed' in the last 6 months.
WITH TotalAmountCompletedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountCompleted
    FROM Transactions
    WHERE Status = 'Completed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
TotalAmountFailedByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountFailed
    FROM Transactions
    WHERE Status = 'Failed'
      AND DateTime >= CURRENT_DATE - INTERVAL '6' MONTH
    GROUP BY MerchantID
),
Percentile25AmountFailed AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY TotalAmountFailed) AS Percentile25
    FROM TotalAmountFailedByMerchant
)
SELECT c.MerchantID, 
       c.TotalAmountCompleted
FROM TotalAmountCompletedByMerchant c
JOIN TotalAmountFailedByMerchant f ON c.MerchantID = f.MerchantID
JOIN Percentile25AmountFailed p ON c.TotalAmountCompleted < p.Percentile25;

-- 98. Find MerchantIDs where the percentage of transactions with Amount greater than the median Amount is lower than the percentage of transactions with Amount less than the median Amount in the last year.
WITH MedianAmount AS (
    SELECT PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
),
TransactionCountAboveMedian AS (
    SELECT MerchantID, 
           COUNT(*) AS CountAboveMedian
    FROM Transactions
    WHERE Amount > (SELECT MedianAmount FROM MedianAmount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TransactionCountBelowMedian AS (
    SELECT MerchantID, 
           COUNT(*) AS CountBelowMedian
    FROM Transactions
    WHERE Amount < (SELECT MedianAmount FROM MedianAmount)
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalTransactionCountByMerchant AS (
    SELECT MerchantID, 
           COUNT(*) AS TotalTransactionCount
    FROM Transactions
    WHERE DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
PercentageAboveMedian AS (
    SELECT t.MerchantID, 
           (a.CountAboveMedian * 100.0 / tt.TotalTransactionCount) AS PercentageAboveMedian
    FROM TransactionCountAboveMedian a
    JOIN TotalTransactionCountByMerchant tt ON a.MerchantID = tt.MerchantID
),
PercentageBelowMedian AS (
    SELECT t.MerchantID, 
           (b.CountBelowMedian * 100.0 / tt.TotalTransactionCount) AS PercentageBelowMedian
    FROM TransactionCountBelowMedian b
    JOIN TotalTransactionCountByMerchant tt ON b.MerchantID = tt.MerchantID
)
SELECT p.MerchantID, 
       p.PercentageBelowMedian
FROM PercentageAboveMedian p
JOIN PercentageBelowMedian b ON p.MerchantID = b.MerchantID
WHERE p.PercentageAboveMedian < b.PercentageBelowMedian;

-- 99. List MerchantIDs where the total Amount of transactions with Status 'Successful' is higher than the 75th percentile total Amount for transactions with Status 'Pending' in the last year.
WITH TotalAmountSuccessfulByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountSuccessful
    FROM Transactions
    WHERE Status = 'Successful'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
TotalAmountPendingByMerchant AS (
    SELECT MerchantID, 
           SUM(Amount) AS TotalAmountPending
    FROM Transactions
    WHERE Status = 'Pending'
      AND DateTime >= CURRENT_DATE - INTERVAL '1' YEAR
    GROUP BY MerchantID
),
Percentile75AmountPending AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY TotalAmountPending) AS Percentile75
    FROM TotalAmountPendingByMerchant
)
SELECT s.MerchantID, 
       s.TotalAmountSuccessful
FROM TotalAmountSuccessfulByMerchant s
JOIN TotalAmountPendingByMerchant p ON s.MerchantID = p.MerchantID
JOIN Percentile75AmountPending pr ON s.TotalAmountSuccessful > pr.Percentile75;

-- 100. Find MerchantIDs where the average Amount for transactions with PaymentMode 'Net Banking' is lower than the median Amount for transactions with PaymentMode 'Credit Card' in the last 3 months.
WITH AvgAmountNetBankingByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountNetBanking
    FROM Transactions
    WHERE PaymentMode = 'Net Banking'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
),
MedianAmountCreditCard AS (
    SELECT Commission_CONT(0.50) WITHIN GROUP (ORDER BY Amount) AS MedianAmount
    FROM payin
    WHERE PaymentMode = 'Credit Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
),
AvgAmountCreditCardByMerchant AS (
    SELECT MerchantID, 
           AVG(Amount) AS AvgAmountCreditCard
    FROM Transactions
    WHERE PaymentMode = 'Credit Card'
      AND DateTime >= CURRENT_DATE - INTERVAL '3' MONTH
    GROUP BY MerchantID
)
SELECT n.MerchantID, 
       n.AvgAmountNetBanking
FROM AvgAmountNetBankingByMerchant n
JOIN AvgAmountCreditCardByMerchant c ON n.MerchantID = c.MerchantID
JOIN MedianAmountCreditCard m ON n.AvgAmountNetBanking < m.MedianAmount;


