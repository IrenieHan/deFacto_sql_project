/* TITLE: Lab4
   CREATED BY: Irene Zhu
*/



---Chapter 23 NULL VALUES
249. SELECT productID, productname, productunitprice, SKU FROM tbls_ProductsN WHERE SKU IS NULL;
250. SELECT ProductID, productname, productunitprice, ISNULL(SKU,'Nothing') AS SKUCheck FROM tbls_ProductsN ORDER BY SKU;
251. SELECT productID, productname, (productunitprice*quantityperunit) As Subtotal FROM tbls_ProductsN ORDER BY (productunitprice*quantityperunit) DESC;
252. SELECT SUM(productunitprice*quantityperunit) As Total FROM tbls_ProductsN;
253. SELECT Count(SKU) As CountSKUs FROM tbls_ProductsN;
        SELECT Count(ProductID) As CountSKUs FROM tbls_ProductsN;
        SELECT Count(*) As CountRecords FROM tbls_ProductsN;
254. SELECT productID, productname, productunitprice, SKU FROM tbls_ProductsN WHERE SKU IS NOT NULL;
255. SELECT * INTO temp_tbls_ProductsN FROM tbls_ProductsN;
        UPDATE temp_tbls_ProductsN SET SKU = 'NA' WHERE SKU IS NULL;
      
---Chapter 24 TYPE CONVERSION
258. SELECT cast(245.234 AS TinyInt) AS ConvertedNumber;
        SELECT convert(TinyInt, 245.234 ) AS ConvertedNumber;
        SELECT ProductName, QuantityPerUnit, convert(TinyInt, ProductUnitPrice) AS ProductPrice, UnitsInStock FROM products;
259. SELECT cast('November 21 2014' AS date ) AS ConvertedDate;
        SELECT convert(date, 'November 21 2014' ) AS ConvertedDate;
        SELECT year(cast('November 21 2014' AS date )) AS ConvertedDate;
260. SELECT cast(12456 AS char(5) ) AS ConvertedText;
        SELECT convert(char(5), 12456 ) AS ConvertedText;

---Chapter 25 STRINGS
264. SELECT Upper(lastname) AS LastName, Upper(firstname) AS FirstName, city, state, zip FROM customers;
265. SELECT upper(left(lastname,1))+ substring (lastname, 2, 50) AS LastName, city, state, zip FROM customers;
        SELECT upper(left(lastname,1))+ substring (lastname, 2, len(lastname)) AS LastName, city, state, zip FROM customers;
266. SELECT lower(lastname) AS LastName, lower(firstname) AS FirstName, city, state, zip FROM customers;
267. SELECT productid, productname, left(sku,4) AS SKU4 FROM Products;
268. SELECT productid, productname, right(sku,4) AS SKU4 FROM Products;
269. SELECT productid, productname, len(sku) AS CountSKUChars FROM Products；
270. SELECT productid, productname, sku, charindex('-',sku,1) AS PartSKU FROM Products;
271. SELECT productid, productname, sku, charindex(' ', sku, 1) AS PartSKU FROM Products WHERE charindex (' ', sku, 1) <> 0;
272. SELECT substring (productname, 5, 5) FROM Products;
273. SELECT productid, productname, sku, charindex('-', sku) AS PartSKU FROM Products;
        SELECT productid, productname, sku, left(sku, charindex('-', sku)) AS PartSKU FROM Products;
        SELECT charindex('-', sku) AS PartSKU FROM Products;
        SELECT charindex('-', sku)-1 AS PartSKU FROM Products;
        SELECT productid, productname, sku, left(sku,charindex('-', sku)-1) AS PartSKU FROM Products WHERE charindex('-', sku) > 0;
274. SELECT productid, productname, sku, left(sku, charindex(' ', sku)) AS PartSKU FROM Products WHERE charindex(' ', sku) <> 0;
275. SELECT productid, ltrim(productname) AS LeftTrimmedName, sku FROM Products;
276. SELECT productid, Rtrim(productname) AS RightTrimmedName, sku FROM Products;
277. SELECT productid, (' ' +productname + ' ') AS SpacedName, sku FROM Products;
278. SELECT productid, (space(10)+ productname + space(10)) AS SpacedName, sku FROM Products;
279. SELECT productid, productname, sku FROM Products WHERE left(sku, 4) = 'PDK-';
        SELECT productid, productname, replace(sku, 'pdk-', 'pds-') As skuUpdated FROM Products WHERE left(sku, 4) = 'PDK-';
280. SELECT productid, Reverse(sku) As ReverseSKU FROM Products;

---Chapter 26 DATES
283. SELECT * FROM Orders WHERE OrderDate BETWEEN '2014/1/1' AND '2014/6/30' ORDER BY OrderDate ASC;
        SELECT * FROM Orders WHERE OrderDate>= '2014/1/1' AND OrderDate<= '2014/6/30' ORDER BY OrderDate;
284. SELECT * FROM Orders WHERE OrderDate<= '2014/1/1' OR OrderDate >= '2014/6/30' ORDER BY OrderDate;
285. SELECT GetDate() as CurrentTimeAndDate;
286. SELECT customerID, max(OrderDate) As LatestOrder FROM Orders GROUP BY customerID;
        SELECT lastname, Max(Orders.OrderDate) AS MaxOfOrderDate FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY lastname;
        SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Max(Orders.OrderDate) AS LatestOrderDate FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerID, Customers.LastName, Customers.FirstName;
287. SELECT DateDiff(d, '2014/5/15', '2014/6/30') As NumberOfDays;
288. SELECT datepart(dw, orderdate) As BusinessDay, Count(OrderID) AS NumberOfOrders FROM Orders WHERE year(orderdate) = 2014 AND datepart(q, orderdate) = 2 AND datepart(dw, orderdate) IN (2,3,4,5,6)  GROUP BY datepart(dw, orderdate);
289. SELECT datepart(q, orderdate) As Quarter, datepart(dw, orderdate) As NonBusinessDay, Count(OrderID) AS NumberOfOrders FROM Orders WHERE year(orderdate) = 2014 AND datepart(dw, orderdate) IN (1,7)  GROUP BY datepart(q, orderdate), datepart(dw, orderdate);
290. SELECT * FROM Orders WHERE DatePart(m, [OrderDate]) =6 AND year(Orderdate) = 2014 ORDER BY OrderDate;
        SELECT * FROM Orders WHERE OrderDate BETWEEN '2014/6/1' AND '2014/6/30' ORDER BY OrderDate;
291. SELECT DatePart(d,OrderDate) AS Day, Count(OrderID) AS NumberOfOrders FROM Orders WHERE Year([OrderDate])=2014 AND DatePart(m,[OrderDate]) = 6 GROUP BY DatePart(d,[OrderDate]) ORDER BY DatePart(d,[OrderDate]);
292. SELECT DatePart(ww,[OrderDate]) AS Week, Count(OrderID) AS NumberOfOrders FROM Orders WHERE (((Year([OrderDate]))=2014)) GROUP BY DatePart(ww,[OrderDate]);
293. SELECT DatePart(m,[OrderDate]) As month, DatePart(dw,[OrderDate]) AS Day, Count(OrderID) AS NumberOfOrders FROM Orders WHERE year(OrderDate) = 2014 AND datepart(q, ([OrderDate])) = 1 AND datepart(w, ([OrderDate])) = 2 GROUP BY DatePart(m,[OrderDate]), DatePart(w,[OrderDate]) ORDER BY DatePart(m,[OrderDate]);
294. SELECT Year([orderdate]) AS [Year], DatePart(ww,[OrderDate]) AS Week, Sum(unitprice*quantity) AS OrderTotal FROM View_Invoices WHERE (((DatePart(ww,[OrderDate]))=50))  GROUP BY Year([orderdate]), DatePart(ww,[OrderDate]);
295. SELECT year(OrderDate) AS Year, sum(unitprice*quantity) AS OrderTotal FROM View_Invoices GROUP BY Year(OrderDate);
        SELECT datepart(yyyy, OrderDate) AS Year, SUM(unitprice*quantity) AS OrderTotal FROM View_Invoices GROUP BY datepart(yyyy, OrderDate);
296. SELECT datePart(q,[OrderDate]) AS Quarter, sum(unitprice*quantity) AS OrderTotal FROM View_Invoices WHERE Year(orderdate) = 2014 GROUP BY DatePart(q , [OrderDate]);
297. SELECT month(OrderDate) AS [Month], Sum(unitprice*quantity) AS OrderTotal, Sum(([unitprice]*[quantity])*[Discount]) AS TotalDiscount FROM View_Invoices WHERE year(orderdate) = 2014 GROUP BY month(OrderDate) ORDER BY month([OrderDate]);
        SELECT datename(m,OrderDate) AS [Month], sum(unitprice*quantity) AS OrderTotal, sum(([unitprice]*[quantity])*[Discount]) AS TotalDiscount FROM View_Invoices WHERE year(orderdate) = 2014 GROUP BY datename(m,OrderDate), month([OrderDate]) ORDER BY month([OrderDate]);
        SELECT datepart(m, OrderDate) AS [Month], sum(unitprice*quantity) AS OrderTotal, Sum(([unitprice]*[quantity])*[Discount]) AS TotalDiscount FROM View_Invoices WHERE year(orderdate) = 2014 GROUP BY datepart(m, OrderDate), month([OrderDate]) ORDER BY datepart(m, OrderDate); 
298. SELECT DatePart(dw,[OrderDate]) AS Day, Count(OrderID) AS NumberOfOrders FROM Orders WHERE (((Year([OrderDate]))=2014)) GROUP BY DatePart(dw,[OrderDate])；
      SELECT DateName(dw,[OrderDate]) AS Day, Count(OrderID) AS NumberOfOrders FROM Orders WHERE (((Year([OrderDate]))=2014)) GROUP BY DateName(dw,[OrderDate])；
299. SELECT DatePart(y,OrderDate) AS Day, Count(OrderID) AS NumberOfOrders FROM Orders WHERE Year([OrderDate])=2014 GROUP BY DatePart(y,[OrderDate]) ORDER BY DatePart(y,[OrderDate]);
300. SELECT OrderID, CustomerID, OrderDate FROM Orders WHERE OrderDate Like '%-10-22';
301. SELECT firstname, lastname, DateAdd(yyyy, 20 , DateOfHire) AS Anniversary20yr FROM SalesReps;
302. SELECT firstname, lastname, title, datepart(d, dateofbirth) As DayOfBirth FROM SalesReps WHERE datepart(m, dateofbirth) = 4;
303. SELECT firstname, lastname, DateDiff(yyyy, DateOfHire, GetDate()) AS YearsEmployed FROM SalesReps;
304. SELECT firstname, lastname, title, DateDiff(yyyy, DateOfBirth, GetDate()) As Age FROM SalesReps;
305. SELECT OrderID, datediff(d, orderdate, shippeddate) AS CycleTime FROM Orders WHERE year(orderdate) = 2014 AND month(orderdate) = 9;
306. SELECT OrderID, dateadd(d, 2, orderdate) AS PolicyShipmentDate FROM Orders WHERE year(orderdate) = 2014 AND month(orderdate) = 9;

---Chapter 27 UPDATE STATEMENTS
310. UPDATE tbls_Customers_Upd SET Address = '12 Lark Street' WHERE lastname = 'Demizio' AND firstname = 'Michael';
311. UPDATE tbls_Customers_Upd SET Address = '12 Lark Street', city = 'Albany' WHERE lastname = 'Demizio' AND firstname = 'Michael';
312. UPDATE tbls_Customers_Upd SET zip = '22215' WHERE city = 'Denver';
313. UPDATE tbls_Customers_Upd SET zip = '22730', city = 'Tucson', state = 'AZ' WHERE city = 'Denver';
314. UPDATE View_SupplierPrices SET ProductUnitPrice = ProductUnitPrice * (1+0.05) WHERE supplierID = 1;
315. UPDATE tbls_Products_Upd SET ProductUnitPrice = CASE WHEN supplierid=1 THEN ProductUnitPrice*(1.1) 
WHEN supplierid=2 THEN ProductUnitPrice*(1.05) 
WHEN supplierid=3 THEN ProductUnitPrice*(1.1) 
WHEN supplierid=4 THEN ProductUnitPrice*(1.05)
WHEN supplierid=5 THEN ProductUnitPrice
WHEN supplierid=6 THEN ProductUnitPrice*(1.02) 
WHEN supplierid=7 THEN ProductUnitPrice*(1.03) 
WHEN supplierid=8 THEN ProductUnitPrice*(1.05) 
WHEN supplierid=9 THEN ProductUnitPrice*(1.15) 
WHEN supplierid=10 THEN ProductUnitPrice*(1.1) 
END
316. UPDATE tbls_Products_Upd SET ProductUnitPrice = ProductUnitPrice * (1+0.20) WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE city= 'Boston' or city = 'Denver');

---Chapter 28 DELETE STATEMENTS
320. SELECT * FROM tbls_Orders_Del WHERE orderid = 20 
        DELETE FROM tbls_Orders_Del WHERE orderid = 20;
321. SELECT * FROM tbls_Orders_Del WHERE customerid = 2
        DELETE FROM tbls_Orders_Del WHERE customerid = 2;
322. SELECT * FROM tbls_Orders_Del WHERE orderdate BETWEEN '2012/10/15' AND '2012/10/17' 
        DELETE FROM tbls_Orders_Del WHERE orderdate BETWEEN '2012/10/15' AND '2012/10/17';
323. SELECT * FROM tbls_Orders_Del AS T2 WHERE OrderID <> (SELECT Max(OrderID) FROM tbls_Orders_Del AS T1 WHERE T2.CustomerID = T1.CustomerID AND T2.SalesRepID = T1.SalesRepID AND T2.ShipperID = T1.ShipperID AND T2.OrderDate = T1.OrderDate);
        DELETE tbls_Orders_Del FROM tbls_Orders_Del AS T2 WHERE OrderID <>  (SELECT Min(OrderID) FROM tbls_Orders_Del AS T1 WHERE T2.CustomerID = T1.CustomerID AND T2.SalesRepID = T1.SalesRepID AND T2.ShipperID = T1.ShipperID AND T2.OrderDate = T1.OrderDate);
324. SELECT * FROM tbls_Orders_DEL2  WHERE orderid IN(SELECT OrderID FROM tbls_Orders_DEL2 GROUP BY OrderID, CustomerID, ShipperID, OrderDate HAVING count(*)>1)  
        DELETE FROM tbls_Orders_DEL2 WHERE OrderID IN( SELECT OrderID FROM tbls_Orders_DEL2 GROUP BY OrderID, CustomerID, ShipperID, OrderDate HAVING count(*)>1);
325. SELECT * INTO TempTable1 FROM tbls_Orders_Del WHERE orderdate BETWEEN '2012/8/15' AND '2012/9/15';
        DELETE FROM tbls_Orders_Del WHERE orderdate BETWEEN '2012/8/15' AND '2012/9/15';
326. SELECT * FROM tbls_Orders_DEL WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE city= 'Los Angeles' AND lastname = 'Orlando')
        DELETE FROM tbls_Orders_DEL WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE city= 'Los Angeles' AND lastname = 'Orlando');
327. FROM tbls_Orders_DEL WHERE OrderID IN(SELECT Sum([unitprice]*[quantity]) AS totalOrder FROM ProductsOrders GROUP BY OrderID HAVING Sum([unitprice]*[quantity])>500) 
        DELETE FROM tbls_Orders_DEL WHERE OrderID IN( SELECT Sum([unitprice]*[quantity]) AS totalOrder FROM ProductsOrders GROUP BY OrderID HAVING Sum([unitprice]*[quantity])>500);

