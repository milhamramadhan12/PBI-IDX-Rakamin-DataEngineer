ALTER PROCEDURE BalancePerCustomer
    @name VARCHAR(100)
AS
BEGIN
	SELECT C.CustomerName, A.AccountType, A.Balance,
	(A.Balance + SUM(
	CASE
	WHEN TransactionType != 'Deposit' THEN -T.Amount
	ELSE T.Amount
	END)) AS Amount
	FROM FactTransaction T
	JOIN DimAccount A ON T.AccountID = A.AccountID
    JOIN DimCustomer C ON A.CustomerID = C.CustomerID
	WHERE A.Status = 'active'
	GROUP BY C.CustomerName, A.AccountType, A.Balance
	HAVING CustomerName LIKE '%' + @name + '%'
END;