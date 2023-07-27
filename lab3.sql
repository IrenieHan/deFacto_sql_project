/* TITLE: Lab3
   CREATED BY: Irene Zhu
*/


---Chapter 17 GROUP BY CLAUSE
174.  SELECT LastName, SUM(Quantity) AS TotalUnits FROM tbls_customersgr GROUP BY LastName; 
175.  SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal FROM tbls_customersgr GROUP BY LastName; 
176. SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal, AVG(UnitPrice*Quantity) AS AvgOrder FROM tbls_customersgr GROUP BY LastName; 
177. SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal FROM tbls_customersgr WHERE OrderID <> 509 GROUP BY LastName; 
178. SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal FROM tbls_customersgr GROUP BY LastName HAVING SUM(UnitPrice*Quantity)>100; 
179. SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal FROM tbls_customersgr WHERE Productname <> 'Chocolate Chip Brownie' GROUP BY LastName HAVING SUM(UnitPrice*Quantity)>100; 
180. SELECT LastName, SUM(UnitPrice*Quantity) AS OrderTotal FROM tbls_customersgr WHERE OrderID <> 509 GROUP BY LastName HAVING SUM(UnitPrice*Quantity)>100 ORDER BY Lastname DESC;
181. SELECT OrderID, Avg(UnitPrice*Quantity) AS AverageOrderAmount FROM tbls_customersgr GROUP BY OrderID; 
182. SELECT LastName, OrderID, SUM([UnitPrice]*[Quantity]) AS OrderTotal FROM tbls_customersgr GROUP BY LastName, OrderID;

---Chapter 18 AGGREGATE FUNCTIONS
185. SELECT COUNT(OrderID) AS NumberofOrders FROM tbls_customersag;
186. SELECT COUNT(LastName) AS NumberofCustomers FROM tbls_customersag; 
       SELECT COUNT(*) as NumberofCustomers FROM tbls_customersag; 
       SELECT COUNT(distinct LastName) AS CountUniqueCustomers FROM tbls_customersag; 
187. SELECT COUNT( Distinct OrderID ) AS NumberofOrders FROM tbls_customersag;
188. SELECT LastName, COUNT(OrderID) AS NumberofOrders FROM tbls_customersag GROUP BY LastName;
189. SELECT LastName, COUNT(OrderID) AS NumberofOrders, AVG(UnitPrice*Quantity) AS AvgOrderAmount FROM tbls_customersag GROUP BY LastName; 
190. SELECT Lastname, COUNT(OrderID) as NumberofOrders, AVG(UnitPrice*Quantity) AS AvgOrderAmount FROM tbls_customersag WHERE LastName NOT IN ('Johnson', 'Madsen') GROUP BY LastName;
191. SELECT LastName, COUNT(OrderID) as Num, AVG(UnitPrice*Quantity) AS Avg, SUM(UnitPrice*Quantity) AS Total FROM tbls_customersag WHERE LastName NOT IN ('Johnson', 'Madsen') GROUP BY LastName;
192. SELECT LastName, COUNT(OrderID) as Num, MIN(UnitPrice*Quantity) AS Min, AVG(UnitPrice*Quantity) AS Avg, SUM(UnitPrice*Quantity) AS Total FROM tbls_customersag WHERE LastName NOT IN ('Johnson', 'Madsen') GROUP BY LastName;
193. SELECT LastName, COUNT(OrderID) as Num, MIN(UnitPrice*Quantity) AS Min, AVG(unitprice*quantity) AS Avg, MAX(UnitPrice*Quantity) AS Max, SUM(UnitPrice*Quantity) AS Total FROM tbls_customersag WHERE LastName NOT IN ('Johnson', 'Madsen') GROUP BY LastName;
194. SELECT lastname, count(orderid) as Num, min(unitprice*quantity) AS Min, avg(unitprice*quantity) AS Avg, max(unitprice*quantity) AS Max, sum(unitprice*quantity) AS Total, stdev(unitprice*quantity) As stdev, var(unitprice*quantity) as var FROM tbls_customersag WHERE lastname NOT IN ('Johnson', 'Madsen') GROUP BY lastname
195. SELECT lastname, count(orderid) as Num, min(unitprice*quantity) AS Min, avg(unitprice*quantity) AS Avg, max(unitprice*quantity) AS Max, sum(unitprice*quantity) AS Total FROM tbls_customersag WHERE productID NOT IN (13,56,30) GROUP BY lastname HAVING sum(unitprice*quantity) > 100 AND avg(unitprice*quantity) > 40 AND convert(smallint, stdev(unitprice*quantity)) < 20;

---Chapter 19 CROSSTABBING
198. SELECT * FROM (SELECT CustomerState, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
199. SELECT * FROM (SELECT CustomerCity, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014]) ) AS CrossTabTable;
200. SELECT * FROM (SELECT CustomerLastName, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
201. SELECT * FROM (SELECT CustomerLastName + ' ' + CustomerFirstName AS CustomerName, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
202. SELECT * FROM (SELECT CustomerState, OrderYear, OrderTotal FROM View_CrosstabBase WHERE CustomerState IN ('CA', 'NY', 'FL')) AS Crosstab PIVOT(sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
203. SELECT * FROM (SELECT CustomerState, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2013], [2014])) AS CrossTabTable;
204. SELECT * FROM (SELECT CustomerState, OrderYear, OrderTotal FROM View_CrosstabBase WHERE CustomerCity NOT IN ('Albany')) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
205. SELECT * FROM (SELECT CustomerState, OrderYear, iif(ordertotal>=10000, ordertotal*0.9, OrderTotal*0.95) AS Ordertotal FROM View_CrosstabBase) AS Crosstab PIVOT (Sum(Ordertotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;
206. SELECT * FROM (SELECT 
CASE WHEN unitprice >= 25 THEN 'Expensive Products Total Sales' WHEN unitprice < 25 THEN 'Inexpensive Product Total Sales' END 
AS UnitPrice, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;

---Chapter 20 CONDITIONAL DATA MANIPULATION
209. SELECT ProductID, ProductName, QuantityPerUnit, iif([productid]=14,[productunitprice]*0.5,[productunitprice]) AS ProductPrice FROM Products;
        SELECT ProductID, ProductName, QuantityPerUnit, case WHEN productid = 14 THEN productunitprice*0.5 WHEN productid <>14 THEN productunitprice END AS ProductPrice FROM Products;
210. SELECT State, lastname, firstname, OrderTotal, IIf([state]= 'NY' Or [state]= 'CA' Or [state]= 'TX',0.20,0.10) AS Discount FROM View_Conditions;
        SELECT State, lastname, firstname, OrderTotal, CASE WHEN state= 'NY' Or state= 'CA' Or state = 'TX' THEN 0.20 ELSE 0.10 END AS Discount FROM View_Conditions;
211. SELECT lastname, firstname, OrderTotal, iif(ordertotal<200,0, iif(ordertotal>=200 And ordertotal<300, 0.05, iif(ordertotal>=300 And ordertotal<500, 0.10, 0.25))) AS Discount FROM View_Conditions;
        SELECT lastname, firstname, ordertotal, CASE
WHEN ordertotal < 200 THEN 0 WHEN ordertotal>= 200 and ordertotal < 300 THEN 0.05 
WHEN ordertotal> 300 and ordertotal <= 500 THEN 0.10 
WHEN ordertotal> 500 THEN 0.25
END AS Discount FROM View_Conditions;
212. SELECT state, lastname, firstname, ordertotal, CASE WHEN state = 'NY' THEN 0.20 
WHEN state = 'AZ' THEN 0.15 
WHEN state = 'CO' THEN 0.12 
WHEN state = 'FL' THEN 0.18 
WHEN state = 'MA' THEN 0.18 
ELSE 0.10 
END AS Discount FROM View_Conditions;
213. SELECT OrderID, lastname, firstname, State, CASE WHEN ordertotal>= 200 and ordertotal < 300 THEN 
WHEN ordertotal> 300 and ordertotal <= 500 THEN 
WHEN ordertotal> 500 THEN ELSE ordertotal 
END AS DiscountedOrders FROM View_conditions WHERE state in ('AZ', 'CO', 'TX', 'FL') ORDER BY ordertotal DESC; 
214. SELECT ProductName, UnitsInStock, UnitsOnOrder, CASE WHEN ProductUnitPrice*QuantityPerUnit < 500 THEN 'Economical' WHEN ProductUnitPrice*QuantityPerUnit >= 500 AND ProductUnitPrice*QuantityPerUnit<1000 THEN 'Moderate' WHEN ProductUnitPrice*QuantityPerUnit >= 1000 THEN 'Expensive' END as PricingCategory FROM Products ORDER BY ProductUnitPrice*QuantityPerUnit DESC;
215. SELECT LastName, Year(OrderDate) AS OrderYear, SUM(
CASE 
WHEN (UnitPrice*quantity) < 5000 THEN (UnitPrice*quantity)*(0.1) + 500 WHEN (UnitPrice*quantity) >= 5000 AND (UnitPrice*quantity) <10000 THEN (UnitPrice*quantity)*(0.15) + 1000 WHEN (UnitPrice*quantity) >= 10000 AND (UnitPrice*quantity) <15000 THEN (UnitPrice*quantity)*(0.2) + 3000 WHEN (UnitPrice*quantity) >= 15000 THEN (UnitPrice*quantity)*(0.25) + 5000 END) AS CommissionAndBonus  FROM SalesReps INNER JOIN (Orders INNER JOIN ProductsOrders ON Orders.OrderID = ProductsOrders.OrderID) ON SalesReps.SalesRepID = Orders.SalesRepID 
GROUP BY LastName, Year(OrderDate) HAVING Year(OrderDate)=2014 ORDER BY Sum(UnitPrice*quantity) DESC;
216. UPDATE tbls_Products_Upd SET ProductUnitPrice = CASE WHEN supplierid=1 THEN ProductUnitPrice*(1.1)
WHEN supplierid=2 THEN ProductUnitPrice*(1.08)
WHEN supplierid=3 THEN ProductUnitPrice*(1.07)
WHEN supplierid=4 THEN ProductUnitPrice*(1.05)
WHEN supplierid=5 THEN ProductUnitPrice*(1.03)
WHEN supplierid=6 THEN ProductUnitPrice*(1.02)
WHEN supplierid=7 THEN ProductUnitPrice*(1.03)
WHEN supplierid=8 THEN ProductUnitPrice*(1.07)
WHEN supplierid=9 THEN ProductUnitPrice*(1.11)
WHEN supplierid=10 THEN ProductUnitPrice*(1.08)
END;
217. SELECT * FROM (SELECT CASE WHEN CustomerCity IN ('New York', 'Los Angeles') THEN ‘BigCities’
WHEN CustomerCity NOT IN ('New York', 'Los Angeles') THEN ‘SmallCitites’ 
END 
AS UnitPrice, OrderYear, OrderTotal FROM View_CrosstabBase) AS Crosstab PIVOT (sum(OrderTotal) FOR OrderYear IN ([2012], [2013], [2014])) AS CrossTabTable;

---Chapter21 UNION OPERATORS
220. SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 UNION SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2;
221. SELECT lastname, firstname, city, state, zip FROM customers UNION SELECT companyname, contactname, city, state, zip FROM suppliers;
222. SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 UNION SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2 
UNION SELECT companyname, contactname, city, state, zip FROM suppliers;
223. SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 UNION ALL SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2;
224. SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 UNION SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2 
ORDER BY lastname;
225. SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 WHERE state = 'NY' UNION 
SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2 WHERE state ='TX' ORDER BY state;
226. SELECT lastname, firstname, city, state, zip, CustomerID FROM tbls_customers_un1 UNION SELECT 
'zTotal customer count', '', '', '', '', Count(CustomerID) FROM tbls_customers_un1 ORDER BY lastname ASC;
227. SELECT lastname, firstname, city, state, zip INTO Temp_UnionTable1 FROM tbls_customers_un1 UNION SELECT lastname, firstname, city, state, zip 
FROM tbls_customers_un2;
228. CREATE TABLE TempTable_Union_InsertInto (CustomerID int PRIMARY KEY identity (1,1), lastname varchar (50), firstname varchar (50), city varchar (50), state varchar (50), zip varchar (10)); 
INSERT INTO TempTable_Union_InsertInto (lastname, firstname, city, state, zip) SELECT lastname, firstname, city, state, zip FROM tbls_customers_un1 WHERE state = 'NY' 
UNION SELECT lastname, firstname, city, state, zip FROM tbls_customers_un2 WHERE state = 'NY' ;
229. SELECT 'Main' As DisCenter, state, count(CustomerID) AS Customers FROM customers GROUP BY state UNION 
SELECT 'Regional' As Center, state, Count(CustomerID) AS Customers FROM tbls_customers_un2 GROUP BY state ORDER BY STATE;
230. SELECT 'Main' As DisCenter, state, count(CustomerID) AS Customers FROM tbls_customers_un1 WHERE State in (SELECT state from tbls_customers_un2) GROUP BY state 
UNION SELECT 'Regional' As Center, state, Count(CustomerID) AS Customers FROM tbls_customers_un2 GROUP BY state ORDER BY STATE;
231. SELECT lastname, firstname, city, state, zip, 'customer' AS TypeOfContact FROM customers UNION SELECT companyname, contactname, city, state, zip, 'supplier' 
FROM suppliers;

---Chapter 22 UNRELATED RECORDS
234. SELECT OrderID, Count(*) AS NumberofDuplicates FROM tbls_Orders GROUP BY OrderID HAVING count(*)>1;
235. SELECT OrderID, CustomerID, Count(*) AS NumberofDuplicates FROM tbls_Orders GROUP BY OrderID, CustomerID HAVING count(*)>1;
236. SELECT Count(*) AS NumberofDuplicates, OrderID, CustomerID, SalesRepID, ShipperID, OrderDate, RequiredDate, ShippedDate, ShippingCost FROM tbls_Orders GROUP BY OrderID, CustomerID, SalesRepID, ShipperID, OrderDate, RequiredDate, ShippedDate, ShippingCost HAVING count(*)>1;
237. SELECT * FROM tbls_Orders WHERE OrderID IN( SELECT OrderID FROM tbls_Orders GROUP BY OrderID HAVING count(*)>1) ORDER BY OrderID;
239. SELECT * FROM tbls_Orders WHERE CustomerID NOT IN (SELECT CustomerID from Customers);
240. SELECT * FROM tbls_Orders LEFT JOIN Customers ON tbls_Orders.CustomerID = Customers.CustomerID WHERE Customers.CustomerID Is Null;
241. SELECT * INTO tbls_Orders1 FROM tbls_Orders;
        DELETE FROM tbls_Orders1 WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers); 
242. SELECT * INTO tbls_Orders2 FROM tbls_Orders;
        DELETE tbls_Orders2 FROM tbls_Orders2 LEFT JOIN Customers ON tbls_Orders2.CustomerID = Customers.CustomerID WHERE (Customers.CustomerID Is Null);
243. SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID from tbls_Orders);
244. SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM tbls_Orders WHERE OrderDate BETWEEN '2013/1/1' AND '2013/12/31');
245. SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID from tbls_Orders);
246. SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID from tbls_Orders WHERE DatePart(q , OrderDate) = 4 AND year(OrderDate) = 2013);