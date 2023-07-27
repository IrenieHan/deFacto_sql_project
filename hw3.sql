/* TITLE: HW3
   CREATED BY: Irene Zhu
*/



---Chapter 17 GROUP BY CLAUSE
1. SELECT Product_ID, COUNT(Product_ID) AS TotalProductUnitsSold FROM Purchases GROUP BY Product_ID ORDER BY COUNT(Product_ID) DESC;
2. SELECT Product_ID, SUM(SalesPrice) AS TotalSales FROM Purchases GROUP BY Product_ID ORDER BY SUM(SalesPrice) DESC;
3. SELECT Employee_ID, MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice FROM Purchases GROUP BY Employee_ID;
4. SELECT Employee_ID, MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice FROM Purchases WHERE Employee_ID NOT IN (109,111,113) GROUP BY Employee_ID HAVING AVG(SalesPrice) >= 38000 ORDER BY AVG(SalesPrice) DESC ;
5. SELECT Product_ID, Employee_ID, SUM(SalesPrice) AS TotalSales FROM Purchases GROUP BY Product_ID, Employee_ID;

---Chapter 18 AGGREGATE FUNCTIONS
1. SELECT Supplier_ID, COUNT(ID) AS PartCount FROM Parts_Materials GROUP BY Supplier_ID ORDER BY COUNT(ID) DESC;
2. SELECT MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice, SUM(SalesPrice) AS TotalSales FROM Purchases;
3. SELECT Product_ID, MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice, SUM(SalesPrice) AS TotalSales FROM Purchases GROUP BY Product_ID ORDER BY Product_ID ASC;
4. SELECT Product_ID, MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice, SUM(SalesPrice) AS TotalSales FROM Purchases WHERE Product_ID NOT IN ('1','2','3','4','5','6','7','8','9') GROUP BY Product_ID ORDER BY Product_ID ASC;
5. SELECT Product_ID, MIN(SalesPrice) AS MinSalesPrice, AVG(SalesPrice) AS AvgSalesPrice, MAX(SalesPrice) AS MaxSalesPrice, SUM(SalesPrice) AS TotalSales FROM Purchases WHERE Product_ID NOT IN ('1','2','3','4','5','6','7','8','9') GROUP BY Product_ID HAVING SUM(SalesPrice) > 3000000 ORDER BY Product_ID ASC;

---Chapter 19 CROSSTABBING
1. SELECT * FROM (
SELECT Product_ID, Year, SalesPrice FROM Purchases) as Crosstab
Pivot (sum(SalesPrice) FOR Year in ([2015],[2016],[2017]))
as Crosstabtable ORDER BY Product_ID ASC;
2. SELECT * FROM (
SELECT Product_ID, Year, SalesPrice FROM Purchases) as Crosstab
Pivot (sum(SalesPrice) FOR Year in ([2015],[2016],[2017]))
as Crosstabtable WHERE Product_ID NOT IN (3,5,8) ORDER BY Product_ID ASC;
3. SELECT * FROM (
SELECT Product_ID, Year, iif(SalesPrice>40000, SalesPrice*0.9, SalesPrice*0.95) AS SalesPrice FROM Purchases WHERE Product_ID NOT IN (3,5,8)) as Crosstab
Pivot (sum(SalesPrice) FOR Year in ([2015],[2016],[2017]))
as Crosstabtable  ORDER BY Product_ID ASC;
4. SELECT * FROM (
SELECT Product_ID, Year, iif(SalesPrice>40000, SalesPrice*0.9, SalesPrice*0.95) AS SalesPrice FROM Purchases WHERE Product_ID NOT IN (3,5,8)) as Crosstab
Pivot (sum(SalesPrice) FOR Year in ([2016],[2017]))
as Crosstabtable  ORDER BY Product_ID ASC;
5. SELECT * FROM (
SELECT CASE
WHEN SalesPrice > 45000 THEN 'Price > 45000'
WHEN SalesPrice BETWEEN 25000 AND 35000 THEN 'Price 25,000-35,000'
WHEN SalesPrice < 25000 THEN 'Price < 25000'
WHEN SalesPrice BETWEEN 35001 AND 45000 THEN 'Price 35,001-45,000'
END as PriceRange, Year, SalesPrice FROM Purchases)
as Crosstab
Pivot (sum(SalesPrice) FOR YEAR in ([2015],[2016],[2017]))
as Crosstabtable;

---Chapter 20 CONDITIONAL DATA MANIPULATION
1. SELECT PartLabel, Name, iif(PartLabel IN ('Door1','Door2','Door4'), Cost *0.8, Cost) AS ProductCost FROM Parts_Materials;
2. SELECT PartLabel, Name, CASE
WHEN PartLabel IN ('Door1','Door2','Door4') THEN Cost*0.8
ELSE Cost 
END
AS ProductCost FROM Parts_Materials;
3. SELECT PartLabel, Name, Quantities_per_order, CASE
WHEN Quantities_per_order <=2 THEN Cost*0.9
WHEN Quantities_per_order BETWEEN 3 AND 7 THEN Cost*0.8
WHEN Quantities_per_order >=8 THEN Cost*0.7
END AS NewProductPrice FROM Parts_Materials;
4. SELECT PartLabel, Name, Quantities_per_order, CASE
WHEN Cost*Quantities_per_order <30 THEN Cost*0.75
WHEN Cost*Quantities_per_order BETWEEN 30 AND 100 THEN Cost*0.7
WHEN Cost*Quantities_per_order >100 THEN Cost*0.65
END AS ProductPrice FROM Parts_Materials;
5. SELECT PartLabel, Name, Quantities_per_order, CASE
WHEN Cost*Quantities_per_order <30 THEN '25%'
WHEN Cost*Quantities_per_order BETWEEN 30 AND 100 THEN '30%'
WHEN Cost*Quantities_per_order >100 THEN '35%'
END AS ProductDiscount FROM Parts_Materials;

---Chapter21 UNION OPERATORS
1. SELECT Owner, County, State FROM Suppliers UNION SELECT Name, County, State FROM Customer ORDER BY State ASC;
2. CREATE Table LocationTable([Owner] nvarchar(255),[County] nvarchar(255), [State] nvarchar(255))
INSERT INTO LocationTable(Owner, County, State)
SELECT Owner, County, State FROM Suppliers UNION SELECT Name AS Owner, County, State FROM Customer;
SELECT Owner, County, State INTO LocationTable FROM Suppliers UNION SELECT Name, County, State FROM Customer ORDER BY State ASC;
3. SELECT 'Upgrade' AS Feature, Vehicle, count(Vehicle) AS NumberOfVehicles FROM Upgrades GROUP BY Vehicle HAVING Vehicle IS NOT NULL
UNION SELECT 'Warranty' AS Feature, Vehicle, count(Vehicle) AS NumberOfVehicles FROM Warranty GROUP BY Vehicle HAVING Vehicle IS NOT NULL; 
4. SELECT Vehicle, count(Vehicle) AS NumberOfVehicles, 'upgrades' AS TypeOfFeatures FROM Upgrades GROUP BY Vehicle HAVING Vehicle IS NOT NULL
UNION SELECT Vehicle, count(Vehicle) AS NumberOfVehicles, 'warranty' AS TypeOfFeatures FROM Warranty GROUP BY Vehicle HAVING Vehicle IS NOT NULL; 
5. SELECT Vehicle, count(type) as NumberOfVehicles, 'Upgrades' as TypeOfFeature FROM Upgrades WHERE Vehicle is not null GROUP BY Vehicle HAVING COUNT(Type)>=5 UNION SELECT Vehicle, count(warranty) as NumberOfVehicles, 'Warranty' as TypeOfFeature FROM Warranty WHERE Vehicle is not null AND Price BETWEEN 100 AND 200 GROUP BY Vehicle;

---Chapter 22 UNRELATED RECORDS
1. SELECT * FROM Customer WHERE ID NOT IN (SELECT Customer_ID FROM Purchases);
2. SELECT Name, Age, Generation FROM Customer WHERE ID NOT IN (SELECT Customer_ID FROM Purchases WHERE Year IN (2017,2018));
3. DELETE FROM Purchases WHERE Product_ID NOT IN (SELECT ID FROM Product);
4. SELECT * FROM Product WHERE ID IN (SELECT Product_ID FROM Purchases);
5. SELECT * FROM Purchases WHERE Customer_ID IN (SELECT ID FROM Customer WHERE Age BETWEEN 35 AND 45);