/* TITLE: Lab1
   CREATED BY: Irene Zhu
*/



---Chapter 5 SELECT STATEMENT
47. SELECT * FROM Customers;
48. SELECT * FROM Orders WHERE 0=1;
49. SELECT lastname, firstname, address, city, state, zip FROM Customers;
50. SELECT state, city, lastname, firstname FROM Customers;
51. SELECT * FROM Customers WHERE city = 'Boston';
52. SELECT companyname, contactname FROM suppliers WHERE state = 'NY';
53. SELECT companyname AS Company, contactname AS [Supplier Contact] FROM suppliers;
54. SELECT 'Dear'+' '+[firstname]+ ' '+'We would like you to know that our full product catalog is on sale in the city of'+' '+[city]+' '+'Please visit our website at:http://www.company.com' AS CustomerLetter FROM customers;
55. SELECT * FROM Customers ORDER BY lastname;
56. SELECT * FROM Customers WHERE city <> 'Boston' ORDER BY lastname;
57. SELECT State, Count(CustomerID) AS NumberOfCustomers FROM Customers WHERE State <> 'NY' GROUP BY State HAVING Count(CustomerID) >10 ORDER BY Count(CustomerID) DESC;
58. CREATE TABLE Customer2( [CustomerID] int identity (1,1) Primary key not null, [Lastname] nvarchar(50), [Firstname] nvarchar(50), [Address] nvarchar(100), [City] nvarchar(50));
	INSERT INTO Customer2 (firstname, lastname, address, city) SELECT firstname, lastname, address, city FROM customers;
59. INSERT INTO Customer2 (firstname, lastname, address, city) SELECT firstname, lastname, address, city FROM customers WHERE State = 'NY';
60. SELECT * INTO Products_Backup FROM Products;
61. SELECT ProductName, UnitsInStock, UnitsOnOrder INTO Products_Subset FROM Products WHERE SupplierID IN (1,2,3,4);
62. SELECT customers.LastName, customers.FirstName, Orders.OrderDate, ProductsOrders.UnitPrice, ProductsOrders.Quantity INTO TempCustomersOrders FROM (customers INNER JOIN Orders ON customers.CustomerID = Orders.CustomerID) INNER JOIN ProductsOrders ON Orders.OrderID = ProductsOrders.OrderID WHERE customers.State = 'NY';
63. SELECT * INTO Products1 FROM Products WHERE 1=2;
64. SELECT ProductID, ProductName, QuantityPerUnit, ProductUnitPrice INTO Product2 FROM Products WHERE 1=2;
65. SELECT Name, Type FROM SysObjects WHERE Type = 'U';
66. SELECT Name, Type FROM SysObjects WHERE Type = 'S';

---Chapter 6 AND/OR OPERATORS
69. SELECT * FROM customers WHERE city = 'New York'OR city = 'Houston';
70. SELECT lastname, firstname, city, state FROM customers WHERE city IN ('Albany','Denver','Houston','Phoenix') ORDER BY lastname ASC;
71. SELECT productname, unitsinstock, unitsonorder FROM products WHERE UnitsInStock > 10 OR UnitsOnOrder > 10;
72. SELECT productname, unitsinstock, unitsonorder FROM products WHERE UnitsInStock >10 UNION SELECT productname, unitsinstock, unitsonorder FROM products WHERE UnitsOnOrder > 10;
73. SELECT lastname, firstname, city, state FROM customers WHERE state = 'NY' AND city = 'Albany';
74. SELECT lastname, firstname, city, state FROM customers WHERE state = 'NY' AND city = 'Albany' OR state = 'NY' AND city = 'New York' ORDER BY lastname;
75. SELECT lastname, firstname, city, state FROM customers WHERE state = 'NY' AND city = 'Albany' OR state = 'TX' AND city = 'Houston' OR state = 'AZ' AND city = 'Phoenix' ORDER BY lastname;

---Chapter 7 ORDER BY CLAUSE
78. SELECT * FROM Customers ORDER BY lastname ASC;
79. SELECT * FROM Customers ORDER BY lastname DESC;
80. SELECT city, lastname, firstname FROM Customers ORDER BY city, lastname ASC;
81. SELECT city, lastname, firstname FROM Customers ORDER BY city ASC, lastname DESC;
82. SELECT lastname, firstname FROM Customers ORDER BY firstname ASC;
83. SELECT productname, unitsinstock FROM products ORDER BY unitsinstock DESC;
84. SELECT orderid, orderdate, shippeddate FROM Orders ORDER BY orderdate DESC;
85. SELECT TOP 5 unitsinstock, productname FROM products ORDER BY unitsinstock DESC;
86. SELECT * FROM View_Conditions WHERE State in ('NY','CA','TX') ORDER BY CASE State When 'NY' then 1 When 'CA' then 2 When 'TX' then 3 Else 4 End;

---Chapter 8 WILDCARD CHARACTERS
89. SELECT * FROM Customers WHERE lastname LIKE 'D%';
90. SELECT * FROM Customers WHERE lastname LIKE 'Da_e%';
	SELECT * FROM Customers WHERE Zip LIKE '12[0-9][0-9][0-9]';
91. SELECT * FROM Customers WHERE lastname LIKE 'C[ru]%';
92. SELECT * FROM Customers WHERE lastname LIKE '[^abcde]%' ORDER BY lastname;
93. SELECT * FROM Customers WHERE lastname LIKE '[^a-p]%' ORDER BY lastname;
94. SELECT * FROM Customers WHERE lastname LIKE '[a-p]%' ORDER BY lastname;

---Chapter 9 LIKE OPERATORS
97. SELECT * FROM tbls_CustomerOrders WHERE lastname LIKE 'M%';
98. SELECT lastname, firstname, city, zip FROM tbls_CustomerOrders WHERE zip LIKE '[1-4]%';
99. SELECT lastname, firstname, orderdate FROM tbls_CustomerOrders WHERE OrderDate LIKE '%-04-%';
100. SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal LIKE 200;
	 SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal = 200;
101. SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal LIKE '[2-3]__' ORDER BY OrderTotal;
	 SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal BETWEEN 200 AND 400 ORDER BY OrderTotal;
	 SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal >= 200 AND OrderTotal <= 400 ORDER BY OrderTotal;
102. SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE OrderTotal <> 200;
103. SELECT lastname, firstname, orderdate, OrderTotal FROM tbls_CustomerOrders WHERE ltrim(firstname) LIKE 'Mary';
104. SELECT lastname, firstname, city, orderdate FROM tbls_CustomerOrders WHERE city LIKE '% % %';
105. SELECT lastname, firstname, city, orderdate FROM tbls_CustomerOrders WHERE city LIKE '%[0-9]%';
106. CREATE INDEX indCity ON tbls_CustomerOrders (city);