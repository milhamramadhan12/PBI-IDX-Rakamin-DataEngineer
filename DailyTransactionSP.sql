ALTER PROCEDURE DailyTransaction
    @start_date date,
    @end_date date
AS
BEGIN
	SELECT CONVERT(date, TransactionDate) AS Date,
	COUNT(*) AS TotalTransaction,
	SUM(Amount) AS TotalAmount
	FROM FactTransaction
	WHERE TransactionDate >= @start_date AND TransactionDate < DATEADD(day, 1, @end_date)
	GROUP BY CONVERT(date, TransactionDate);
END;