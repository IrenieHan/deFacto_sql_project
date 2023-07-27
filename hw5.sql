/* TITLE: HW5
   CREATED BY: Irene Zhu
*/



---Chapter 29 JOINS
1. SELECT * FROM Parts_Materials RIGHT OUTER JOIN Suppliers ON Parts_Materials.Supplier_ID = Suppliers.ID;
2. SELECT Company, Owner, County, Contract_Length, PartLabel, Name FROM Suppliers LEFT OUTER JOIN Parts_Materials ON Suppliers.ID = Parts_Materials.Supplier_ID ORDER BY Contract_Length DESC;
3. SELECT PartLabel, Name, Company, Owner, County, Contract_Length FROM Suppliers RIGHT OUTER JOIN Parts_Materials ON Suppliers.ID = Parts_Materials.Supplier_ID WHERE Company is null AND Owner is null AND County is null AND Contract_Length is null;
4. SELECT * FROM Parts_Materials WHERE Supplier_ID NOT IN (SELECT ID FROM Suppliers);
SELECT * FROM Parts_Materials LEFT JOIN Suppliers ON Parts_Materials.Supplier_ID = Suppliers.ID WHERE Supplier_ID IS NULL;
5. SELECT * FROM Suppliers FULL OUTER JOIN Parts_Materials ON Suppliers.ID =  Parts_Materials.Supplier_ID WHERE Suppliers.ID is null;

---Chapter 30 SUBQUERIES
1. SELECT Name, Position FROM Employee WHERE ID IN (SELECT Employee_ID FROM Purchases WHERE YEAR = 2016 OR YEAR = 2015);
2. SELECT Name, Position FROM Employee WHERE Position = 'Sales' AND ID NOT IN (SELECT Employee_ID FROM Purchases WHERE YEAR = 2017 OR YEAR = 2018);
3. SELECT * FROM Employee WHERE Hired = (SELECT MAX(Hired) FROM Employee);
4. SELECT New_Upgrade, Vehicle, Cost FROM Upgrades WHERE Cost > (SELECT AVG(Cost) FROM Upgrades);
5. SELECT * FROM (SELECT Name, Purchases.Year, PurchaseNumber FROM Employee LEFT JOIN Purchases ON Employee.ID = Purchases.Employee_ID WHERE Position = 'Sales') AS Crosstab PIVOT (COUNT(PurchaseNumber) FOR Year IN([2015],[2016],[2017])) AS CrossTabTable;

---Chapter 31 STORED PROCEDURES
1. CREATE PROCEDURE sp_Chapter31_q1 AS SELECT First, Last, County, State FROM Customer;
execute sp_Chapter31_q1;
2. CREATE PROCEDURE sp_Chapter31_q2 AS SELECT First, Last, State, Salary, Generation FROM Customer WHERE Generation = 'Millennial';
execute sp_Chapter31_q2;
3. CREATE PROCEDURE sp_Chapter31_q3 @County nvarchar(255), @State nvarchar(255) AS SELECT First, Last,County, State FROM Customer WHERE County = @County AND State = @State;
execute sp_Chapter31_q3 @County = 'Albany', @State = 'NY';
4. CREATE PROCEDURE sp_Chapter31_q4 @Last nvarchar(255) AS SELECT ID FROM Employee WHERE Last = @Last;
execute sp_Chapter31_q4 @Last = 'Catt';
5. DROP PROCEDURE sp_Chapter31_q5;
CREATE PROCEDURE sp_Chapter31_q5 @PartLabel nvarchar(255) AS SELECT PartLabel FROM Parts_Materials WHERE PartLabel LIKE @PartLabel;
execute sp_Chapter31_q5 @PartLabel = '%Door%';