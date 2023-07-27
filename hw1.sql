/* TITLE: HW1
   CREATED BY: Irene Zhu
*/



---Chapter 5 SELECT STATEMENT
1. CREATE TABLE Product_Backup([ID] int not null, [Description] nvarchar(255), [MPG_HWY] float, [MPG_City] float, [Type] nvarchar(255));
	INSERT INTO Product_Backup(ID,Description,MPG_HWY,MPG_City,Type) SELECT ID,Description,MPG_HWY,MPG_City,Type FROM Product;
2. CREATE TABLE Product_Backup2([Description] nvarchar(255), [Type] nvarchar(255));
	INSERT INTO Product_Backup2(Description, Type) SELECT Description, Type FROM Product WHERE Type IN ('Family','Utility','Sport');
3. CREATE TABLE Product3([ID] int identity (1,1) Primary key not null, [Description] nvarchar(255), [MPG_HWY] float, [MPG_City] float, [Type] nvarchar(255));
4. SET identity_insert Product3 ON INSERT INTO Product3(ID, Description, MPG_HWY, MPG_City, Type) SELECT ID,Description,MPG_HWY,MPG_City,Type FROM Product WHERE MPG_HWY > 30;
5. SELECT ID,Description,MPG_HWY,MPG_City,Type FROM Product WHERE MPG_HWY >30 ORDER BY Description ASC;

---Chapter 6 AND/OR OPERATORS
1. SELECT * FROM Customer WHERE State='NY' OR State='CO' OR State='TX' OR State='AZ';
2. SELECT * FROM Customer WHERE State IN ('NY','CO','TX','AZ' );
3. SELECT * FROM Customer WHERE State='NY' UNION SELECT * FROM Customer WHERE State='CO' UNION SELECT * FROM Customer WHERE State='TX' UNION SELECT * FROM Customer WHERE State='AZ';
4. SELECT * FROM Customer WHERE State NOT IN ('NY','CO','TX','AZ');
5. SELECT * FROM Customer WHERE Generation != 'Millennial';

---Chapter 7 ORDER BY CLAUSE
1. SELECT State,County,Last,First FROM Customer ORDER BY State, County ASC;
2. SELECT TOP 10 Product_ID,Upgrade_ID,Release_Year,Release_Date FROM New_Vehicles ORDER BY Release_Date ASC;
3. SELECT TOP 10 New_Upgrade, Cost FROM Upgrades ORDER BY Cost DESC;
4. SELECT Name,Position,Hired FROM Employee ORDER BY Hired ASC;
5. SELECT Name,County,State FROM Customer ORDER BY CASE State WHEN 'MA' THEN 1 WHEN 'NY' THEN 2 WHEN 'FL' THEN 3 WHEN 'CA' THEN 4 ELSE 5 END;

---Chapter 8 WILDCARD CHARACTERS
1. SELECT Name,Age,Generation,Salary FROM Customer WHERE Last LIKE 'D%';
2. SELECT Name,Age,Generation,Salary FROM Customer WHERE Last LIKE '[A-F]%';
3. SELECT Name,Age,Generation,Salary FROM Customer WHERE Last LIKE '[^A-F]%' ORDER BY Last;
4. SELECT * FROM Employee WHERE Position LIKE '%ant';
5. SELECT * FROM Employee WHERE Status LIKE '%em%';

---Chapter 9 LIKE OPERATORS
1. SELECT Name,Age,Generation,State FROM Customer WHERE Generation !='Baby Boomer';
2. SELECT PartLabel,Name,Cost FROM Parts_Materials WHERE Name LIKE '%side%';
3. SELECT * FROM Customer WHERE Last LIKE 'H%' ORDER BY First ASC;
4. CREATE INDEX IndDescription ON New_Vehicles(Description);
5. SELECT New_Upgrade,Vehicle,Markup FROM Upgrades WHERE Markup BETWEEN 300 AND 399 OR Markup BETWEEN 1000 AND 1999 ORDER BY Markup ASC;