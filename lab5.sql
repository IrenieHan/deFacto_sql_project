/* TITLE: Lab5
   CREATED BY: Irene Zhu
*/



---Chapter 29 JOINS
330. SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID from tbls_Orders);
        SELECT FirstName, LastName, Address, OrderDate, ShippingCost FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
        SELECT FirstName, LastName, Address FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY FirstName, LastName, Address ORDER BY LastName;
331. SELECT lastname, firstname, Address, OrderDate, ShippingCost FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
332. SELECT lastname, firstname, Address, OrderDate, ShippingCost FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID; 
333. SELECT LastName, FirstName, Address, OrderDate, ShippingCost FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
334. SELECT * FROM Suppliers CROSS JOIN Products;
        SELECT * FROM Suppliers, Products;
335. SELECT salesreps.lastname, salesreps.city, Companyname, suppliers.city FROM Suppliers cross join salesreps where suppliers.city = salesreps.city;
336. SELECT salesreps.lastname, salesreps.city, Companyname, suppliers.city FROM Suppliers inner join salesreps ON Suppliers.City = SalesReps.City;
338. SELECT p1.productID, p1.productname, p2.productname as Component1 FROM tbls_Products_Joins AS p1 inner JOIN tbls_Products_Joins AS p2 ON p2.Comp1 = p1.ProductID;
339. SELECT p1.productID, p1.productname, p2.productname as Component1 FROM tbls_Products_Joins AS p1 left JOIN tbls_Products_Joins AS p2 ON p2.Comp1 = p1.ProductID;

---Chapter 30 SUBQUERIES
342. SELECT * FROM Customers WHERE CustomerID IN (Select CustomerID FROM Orders WHERE (DatePart(q,[OrderDate])=4 AND Year([orderdate])=2014));
343. SELECT * FROM Customers C WHERE EXISTS (Select CustomerID FROM Orders O WHERE C.CustomerID = O.CustomerID AND (DatePart(q,[OrderDate])=4 AND Year([orderdate])=2014));
344. SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM tbls_Orders WHERE OrderDate BETWEEN '2014/1/1' AND '2014/6/30');
345. SELECT * FROM Customers C WHERE NOT EXISTS (Select CustomerID FROM tbls_Orders O WHERE C.CustomerID = O.CustomerID AND OrderDate BETWEEN '2014/1/1' AND '2014/6/30');
346. SELECT * FROM tbls_orders WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);
347. SELECT * FROM Orders WHERE shippeddate = (SELECT max(ShippedDate) FROM Orders);
348. SELECT * FROM customers WHERE exists (SELECT * FROM salesreps WHERE customers.city = salesreps.city);
349. SELECT productname, ProductUnitPrice FROM Products WHERE ProductUnitPrice > (SELECT avg(ProductUnitPrice) FROM Products) ORDER BY ProductUnitPrice DESC;
350. SELECT * FROM orders O WHERE EXISTS (SELECT orderid, Sum([unitprice]*[quantity]) FROM ProductsOrders WHERE O.OrderID = P.OrderID GROUP BY orderid HAVING (Sum([unitprice]*[quantity]))>500);
351. SELECT * FROM orders WHERE orderid IN (SELECT orderid FROM ProductsOrders WHERE Discount =0);
352. UPDATE tbls_Products_Upd SET ProductUnitPrice = ProductUnitPrice * (1+0.20) WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE city= 'Boston' or city = 'Dallas');
353. DELETE FROM tbls_Orders_DEL WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE city= 'Los Angeles' OR city = 'Orlando');
354. SELECT OrderID, 
(SELECT Count(*) FROM ProductsOrders P WHERE O.OrderID=P.OrderID AND (discount = 0) ) AS '0%', 
(SELECT Count(*) FROM ProductsOrders P WHERE O.OrderID=P.OrderID AND (discount = 0.15) ) AS '15%', 
(SELECT Count(*) FROM ProductsOrders P WHERE O.OrderID=P.OrderID AND (discount = 0.20) ) AS '20%' 
FROM Orders AS O;

---Chapter 31 STORED PROCEDURES
357. CREATE PROCEDURE sp_GetProductData AS SELECT ProductName, QuantityPerUnit, ProductUnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, SKU FROM Products 
execute sp_GetProductData or exec sp_GetProductData;
358. CREATE PROCEDURE sp_Param_UnitsInStock @UnitsInStock smallint AS SELECT ProductName, QuantityPerUnit, ProductUnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, SKU FROM Products WHERE UnitsInStock = @UnitsInStock 
execute sp_Param_UnitsInStock @UnitsInStock = 15;
359. CREATE PROCEDURE sp_Param_Multiple @UnitsInStock smallint, @UnitsOnOrder smallint AS SELECT ProductName, QuantityPerUnit, ProductUnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, SKU FROM Products WHERE UnitsInStock = @UnitsInStock AND UnitsOnOrder = @UnitsOnOrder 
execute sp_Param_Multiple @UnitsInStock = 50, @UnitsOnOrder = 0;
360. CREATE PROCEDURE sp_Param_GetSupplierID @ProductID int, @SupplierID int output AS SELECT @SupplierID = SupplierID FROM Products WHERE ProductID = @ProductID Declare @SupplierID int
execute sp_Param_GetSupplierID @ProductID = 15, @SupplierID = @SupplierID out Select @SupplierID AS SupplierID;
361. CREATE PROCEDURE sp_Cond_Inventory @UnitPrice money, @Discount decimal(2,2) AS IF @UnitPrice > (Select AVG(ProductUnitPrice) FROM Products) BEGIN Select ProductName, QuantityPerUnit, ProductUnitPrice as OriginalPrice, ProductUnitPrice* (1- @Discount) AS NewPrice, SKU FROM Products END ELSE BEGIN Select ProductName, QuantityPerUnit, ProductUnitPrice as OriginalPrice, ProductUnitPrice * (1- .05) As NewPrice, SKU FROM Products END 
execute sp_Cond_Inventory @UnitPrice = 40, @Discount = 0.3 
execute sp_Cond_Inventory @UnitPrice = 10, @Discount = 0.2;
362. CREATE PROCEDURE sp_UpdProducts @SupplierID int, @PriceChange decimal (2, 2) AS  UPDATE tbls_Products_Upd SET ProductUnitPrice = ProductUnitPrice * (1+ @PriceChange) WHERE SupplierID = @SupplierID 
execute sp_UpdProducts @SupplierID = 1, @PriceChange = 0.03;
363. CREATE PROCEDURE sp_ErrorHandling @ProductID int, @SupplierID int, @ProductName text AS BEGIN TRY INSERT INTO tbls_Products_sp (ProductID, SupplierID, ProductName) VALUES (@ProductID, @SupplierID, @ProductName)
END TRY BEGIN CATCH PRINT 'Supplier does not exist ' END CATCH 
execute sp_ErrorHandling @ProductID = 71, @SupplierID = 11, @ProductName = 'Chocolate' 
execute sp_ErrorHandling @ProductID = 72, @SupplierID = 9, @ProductName = 'Chocolate';