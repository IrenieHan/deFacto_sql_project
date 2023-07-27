/* TITLE: Lab2
   CREATED BY: Irene Zhu
*/



---Chapter 10 EQUALITY AND INEQUALITY PREDICATES
109. SELECT * FROM Customers WHERE lastname = 'Delaney';
110. SELECT * FROM Orders WHERE OrderID = 972;
111. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE OrderDate > '2013-06-30' ORDER BY OrderDate;
112. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE OrderDate >= '2013-06-30' ORDER BY OrderDate;
113. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE ShippingCost < 35 ORDER BY ShippingCost DESC;
114. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE ShippingCost <= 35 ORDER BY ShippingCost DESC;
115. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE ShippingCost <> 35 ORDER BY ShippingCost DESC;
116. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE OrderDate > '2013-06-30' AND ShippingCost < 35 ORDER BY ShippingCost DESC;

---Chapter 11 BETWEEN OPERATOR
119. SELECT ProductName, ProductUnitPrice FROM Products WHERE ProductUnitPrice BETWEEN 15 AND 18 ORDER BY ProductUnitPrice;
120. SELECT OrderID, OrderDate, ShippedDate FROM Orders WHERE OrderDate BETWEEN '2012-06-15' AND '2013-06-15' ORDER BY OrderDate DESC;
121. SELECT OrderID, OrderDate, ShippedDate FROM Orders WHERE YEAR(OrderDate) BETWEEN 2013 AND 2014 ORDER BY OrderDate DESC;
122. SELECT ProductName, ProductUnitPrice FROM Products WHERE ProductUnitPrice NOT BETWEEN 10 AND 40 ORDER BY ProductUnitPrice ASC;
123. SELECT ProductName, ProductUnitPrice FROM Products WHERE ProductUnitPrice BETWEEN 15 AND 18 ORDER BY ProductUnitPrice ASC;
	 SELECT ProductName, ProductUnitPrice FROM Products WHERE ProductUnitPrice >= 15 AND ProductUnitPrice <= 18 ORDER BY ProductUnitPrice ASC;

---Chapter 12 IN OPERATOR
126. SELECT LastName, FirstName, City FROM Customers WHERE City IN ('New York','Boston','Chicago','Los Angeles','Dallas');
127. SELECT LastName, FirstName, City FROM Customers WHERE City NOT IN ('New York','Boston','Chicago','Los Angeles','Dallas');
128. SELECT ProductName, QuantityPerUnit,ProductUnitPrice FROM Products WHERE ProductUnitPrice IN (15,19,22,23,42);
129. SELECT OrderID, OrderDate, ShippedDate, ShippingCost FROM Orders WHERE OrderDate IN ('2012-6-1','2012-7-1','2012-8-1');
130. SELECT FirstName, LastName, Address FROM Customers WHERE 'Mary' IN (FirstName, LastName, Address);
131. SELECT OrderID, OrderDate, ShippedDate FROM Orders WHERE OrderID IN (SELECT OrderID FROM ProductsOrders WHERE (Discount)=0);
132. SELECT OrderID, OrderDate, ShippedDate FROM Orders WHERE OrderID IN (SELECT OrderID FROM ProductsOrders GROUP BY OrderID HAVING SUM(Discount)=0);
133. SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders WHERE OrderDate BETWEEN '2013-6-1' AND '2013-12-31');
134. SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders WHERE YEAR(OrderDate)=2013);

---Chapter 13 DISTINCT PREDICATE
137. SELECT City FROM Customers;
138. SELECT DISTINCT City FROM Customers;
139. SELECT FirstName, State FROM Customers WHERE FirstName = 'John';
	 SELECT DISTINCT FirstName, State FROM Customers WHERE FirstName = 'John';
140. SELECT ContactTitle, Count(ContactTitle) AS CountNumber FROM Suppliers GROUP BY ContactTitle;

---Chapter 14 TOP PREDICATE
143. SELECT TOP 5 ProductName, UnitsInStock, UnitsOnOrder FROM Products;
144. SELECT TOP 5 ProductName, UnitsInStock, UnitsOnOrder FROM Products ORDER BY UnitsInStock DESC;
145. SELECT TOP 10 PERCENT ProductName, ProductUnitPrice FROM Products ORDER BY ProductUnitPrice DESC;
146. SELECT TOP 5 LastName, FirstName, DateofHire FROM SalesReps ORDER BY DateofHire DESC;
147. SELECT TOP 10 OrderID,SUM(([UnitPrice]*[Quantity]))AS OrderAmount FROM ProductsOrders GROUP BY OrderID ORDER BY SUM(([UnitPrice]*[Quantity]));
148. SELECT TOP 10 OrderID, ProductID, (UnitPrice*Quantity) AS OrderAmount FROM ProductsOrders WHERE (ProductID=2) ORDER BY (UnitPrice*Quantity) DESC;

---Chapter 15 CALCULATED FIELDS
151. SELECT ProductName, (ProductUnitPrice+2) AS ProductPrice FROM Products;
152. SELECT ProductName, (ProductUnitPrice*1.02) AS ProductPrice FROM Products;
153. SELECT ProductName, UnitsInStock,UnitsOnOrder, (UnitsInStock+UnitsOnOrder)AS TotalUnits FROM Products;
154. SELECT OrderID, SUM([UnitPrice]*[Quantity]) AS OrderSubtotal FROM ProductsOrders GROUP BY OrderID;
155. SELECT ProductName, (ProductUnitPrice*(1-0.2)) AS PromotionalPrice FROM Products;
156. SELECT (ProductUnitPrice*(1+0.2)) AS ProductPrice FROM Products;
	 SELECT FORMAT((ProductUnitPrice *(1+0.2)),'$#,#.00') AS ProductPrice FROM Products;
157. SELECT ProductName, CASE WHEN SupplierID = 1 THEN ProductUnitPrice*(1-0.2) WHEN SupplierID =2 THEN ProductUnitPrice*(1-0.15) WHEN SupplierID = 3 THEN ProductUnitPrice*(1-0.18) WHEN SupplierID = 4 THEN ProductUnitPrice*(1-0.25) ELSE ProductUnitPrice*(1-0.1) END AS ProductPrice FROM Products;
158. SELECT SalesReps.LastName,IIF(SUM([UnitPrice]*[Quantity])>5000,'Bonus','No Bonus') AS Bonus FROM (SalesReps INNER JOIN Orders ON SalesReps.SalesRepID = Orders.SalesRepID) INNER JOIN ProductsOrders ON Orders.OrderID = ProductsOrders.OrderID WHERE (((Orders.OrderDate) BETWEEN '2014/1/1' AND '2014/12/31')) GROUP BY SalesReps.LastName;
159. SELECT OrderID, SUM(([UnitPrice]*[Quantity])*[Discount]) AS OrderDiscount FROM ProductsOrders GROUP BY OrderID;
160. SELECT AVG([UnitPrice]*[Quantity]*[Discount]) AS AverageOrderDiscount FROM ProductsOrders;
	 SELECT AVG([UnitPrice]*[Quantity]) AS AverageOrderAmount FROM ProductsOrders;
	 SELECT CAST(AVG([UnitPrice]*[Quantity]*[Discount])AS int) AS AverageOrderDiscount FROM ProductsOrders;
	 SELECT CONVERT(int,AVG([UnitPrice]*[Quantity]*[Discount])) AS AverageOrderDiscount FROM ProductsOrders;
161. SELECT OrderID, SUM((UnitPrice*Quantity)*(1-Discount)) AS OrderTotal INTO ArchivedOrders FROM ProductsOrders GROUP BY OrderID;

---Chapter 16 CONCATENATED FIELDS
164. SELECT (Address+City+State+Zip) AS FullAddress FROM Customers;
165. SELECT (Address+' '+City+' '+State+' '+Zip) AS FullAddress FROM Customers;
166. SELECT 'Dear'+' '+(LastName+' '+FirstName)+'.'+' '+'It is our pleasure to announce that we reviewed your resume,and we have set up an interview time for you. Can you please verify that your address is'+' '+(Address+' '+City+' '+State+' '+Zip)+' '+'to send you corporate policy details and directions?' AS CustomerLetter FROM Customers;
167. SELECT 'Dear'+' '+(LastName+' '+left(FirstName,1))+'.'+' '+'Please complete the enclosed forms so that we can ship your order to your country.' AS CustomerLetter FROM Customers;
168. SELECT 'Dear'+' '+upper(left(LastName,1))+substring(LastName,2,50)+' '+FirstName+'.' +' '+'Please complete the enclosed forms so that we can ship your order to your country.' AS CustomerLetter FROM Customers;
169. SELECT concat(OrderDate,' with ',ShippingCost,' shippiing cost') AS LetterToTheCusomer FROM Orders;
170. SELECT IIF(([State]='NY'),[CompanyName]+''+[ContactTitle]+''+[ContactName],[ContactTitle]+''+[ContactName]) AS MailTo FROM Suppliers;
171. SELECT CASE WHEN City='Boston' THEN 'Dear'+''+[ContactName]+','+''+'for our current sale we offer a 10% discount in'+''+[City] WHEN City='Dallas' THEN 'Dear'+''+[ContactName]+','+''+'for our current sale we offer a 25% discount in'+''+[City] WHEN City='New York' THEN 'Dear'+''+[ContactName]+','+''+'for our current sale we offer a 30% discount in'+''+[City] END AS SupplierLetter FROM Suppliers;