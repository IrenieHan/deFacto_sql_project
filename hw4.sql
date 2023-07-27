/* TITLE: HW4
   CREATED BY: Irene Zhu
*/



---Chapter 23 NULL VALUES
1. SELECT * FROM Parts_Materials WHERE Sourced IS NULL;
2. SELECT Count(ID) AS TotalNulls FROM Parts_Materials WHERE Cost IS NULL;
3. SELECT Product_ID, COUNT(PurchaseNumber) AS NumberOfOrders, AVG(SalesPrice) AS AvgOrder, SUM(SalesPrice) AS TotalAmount FROM Purchases GROUP BY Product_ID;
4. SELECT * FROM Purchases WHERE SalesPrice IS NULL;
5. SELECT Product_ID, COUNT(PurchaseNumber) AS NumberOfOrders, AVG(SalesPrice) AS AvgOrder, SUM(SalesPrice) AS TotalAmount FROM Purchases WHERE SalesPrice IS NOT NULL GROUP BY Product_ID;

---Chapter 24 TYPE CONVERSION
1. SELECT New_Upgrade, Vehicle, CAST(Markup AS Int) AS Markup FROM Upgrades;
2. SELECT New_Upgrade, Vehicle,CONVERT(Int, Markup) ASMarkup FROM Upgrades;
3. SELECT Name, Position, Cast(Hired AS date) AS HiredDate FROM Employee;
4. SELECT Name, Position, YEAR(Hired) AS HiredDate FROM Employee;
5. SELECT New_Upgrade, CAST(Cost AS Int) + CAST(Assembly AS Int) AS TotalCost FROM Upgrades;

---Chapter 25 STRINGS
1. SELECT left(Name, charindex(' ', Name, 1) - 1) AS NewName, Cost FROM Parts_Materials WHERE charindex(' ', Name, 1) <> 0;
2. SELECT PartLabel, REPLACE(Name, 'Inner', 'Interior') AS NewProductName, Cost FROM Parts_Materials;
3. SELECT left(Serial, charindex('-', Serial, 1) - 1) AS NewSerial, Cost FROM  Parts_Materials;
4. SELECT left(Serial, charindex('-', Serial, 1) - 1) AS NewSerial, SUM(Cost) AS TotalCost FROM Parts_Materials GROUP BY left(Serial, charindex('-', Serial, 1) - 1) ORDER BY TotalCost DESC;
5. SELECT right(Serial, 1) AS NewRightSerial, SUM(Cost) AS TotalCost FROM Parts_Materials GROUP BY right(Serial, 1);

---Chapter 26 DATES
1. SELECT * FROM  (SELECT Product_ID, DatePart(ww, Date) AS Week, SalesPrice FROM Purchases WHERE Year = 2017) AS Corsstab PIVOT (SUM(SalesPrice) FOR Week IN ([24], [25], [26], [27], [28])) AS CrossTabTable ORDER BY Product_ID;
2. SELECT Year, DatePart(ww, Date) AS Week, SUM(SalesPrice) AS TotalSales FROM Purchases WHERE DatePart(ww, Date) = 12 GROUP BY Year, DatePart(ww, Date);
3. SELECT Product_ID, SUM(SalesPrice) AS TotalSales FROM Purchases WHERE Date >= '2017-03-01' AND Date <= '2017-05-31' GROUP BY Product_ID ORDER BY SUM(SalesPrice) DESC;
4. SELECT Product_ID, Customer_ID, Date, DATEADD(DAY, 15, Date) AS DeliveryDate FROM Purchases;
5. SELECT Name, Position, DATEDIFF(YEAR, Hired, GETDATE()) AS NumberOfYears FROM Employee WHERE DATEDIFF(YEAR, Hired, GETDATE()) > 7 ORDER BY Name;

---Chapter 27 UPDATE STATEMENTS
1. UPDATE Customer_Upd SET County = 'Schenectady' WHERE NAME = 'Nana Knopf';
2. UPDATE Upgrades_Upd SET Cost = 125 WHERE NEW_Upgrade = 'Automatic Trunk';
3. UPDATE Upgrades_Upd SET Cost = Cost + 25 WHERE Type = 'Base';
4. UPDATE Upgrades_Upd SET Markup = Markup * 1.1 WHERE New_Upgrade = 'Heated Seats';
5. UPDATE Parts_Materials_Upd SET Cost = CASE WHEN Sourced = 'Y' THEN Cost * 1.05 WHEN Sourced = 'N' THEN Cost * 1.1 END;
   UPDATE Parts_Materials_Upd SET Cost = Cost * 1.05 WHERE Sourced = 'Y' 
   UPDATE Parts_Materials_Upd SET Cost = Cost * 1.1 WHERE Sourced = 'N' 

---Chapter 28 DELETE STATEMENTS
1. CREATE TABLE Customer_Copy (ID INT, Label varchar(255), Name varchar(255), First varchar(255), Last varchar(255), Age INT, Generation varchar(255), Salary INT, County varchar(255), State varchar(255))
INSERT INTO Customer_Copy (ID, Label, Name, First, Last, Age, Generation, Salary, County, State)
SELECT ID, Label, Name, First, Last, Age, Generation, Salary, County, State FROM Customer_Del
DELETE FROM Customer_Del WHERE Name = 'Nana Knopf'
2. DELETE FROM New_Vehicles_Del WHERE Description = 'New_Vehicle3';
3. DELETE FROM Customer_Del WHERE Age > 65;
4. DELETE FROM Purchases WHERE Customer_ID IN (SELECT ID FROM Customer_Del WHERE Generation = 'Millennial');
5. DELETE FROM Purchases_Del WHERE Year IN ('2015','2016') AND Product_ID IN (SELECT Product_ID FROM Product WHERE TYPE = 'FAMILY');