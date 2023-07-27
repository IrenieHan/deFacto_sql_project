/* TITLE: HW2
   CREATED BY: Irene Zhu
*/



---Chapter 10 EQUALITY AND INEQUALITY PREDICATES
1. SELECT * FROM Employee WHERE Status = 'PART-TIME';
2. SELECT * FROM Employee WHERE YEAR(Hired) > 2007 ORDER BY Hired ASC;
3. SELECT * FROM Parts_Materials WHERE Cost BETWEEN 10.00 AND 29.99 ORDER BY Cost ASC;
4. SELECT * FROM Parts_Materials WHERE Cost <>10.99 ORDER BY Cost ASC;
5. SELECT * FROM Parts_Materials WHERE Supplier_ID = 9;

---Chapter 11 BETWEEN OPERATOR
1. SELECT * FROM New_Vehicles WHERE Release_Date LIKE '2019%' AND MONTH(Release_Date) NOT BETWEEN 1 AND 3;
2. SELECT New_Upgrade FROM Upgrades WHERE Cost BETWEEN 100 AND 200 AND Type = 'Middle';
3. SELECT Description, Product_ID, Upgrade_ID, Release_Date, Release_Year FROM New_Vehicles WHERE MONTH(Release_Date)=6 AND Release_Year=2019;
4. SELECT * FROM Upgrades WHERE Assembly BETWEEN 40 AND 100;
5. SELECT Name, Position, Hired, Income FROM Employee WHERE Hired BETWEEN '2010-09-01' AND '2011-10-31' AND Income BETWEEN 45000 AND 55000 ORDER BY Income ASC;

---Chapter 12 IN OPERATOR
1. SELECT Last, State FROM Customer WHERE State IN ('NY','CO','AK','FL');
2. SELECT Customer_ID, Employee_ID, Year, SalesPrice FROM Purchases WHERE Customer_ID IN (5,13,32);
3. SELECT * FROM Employee WHERE Position = 'Sales' AND ID NOT IN (SELECT Employee_ID FROM Purchases WHERE Year IN (2017,2018)) ORDER BY Last;
4. SELECT * FROM Purchases WHERE Customer_ID NOT IN (Select Customer_ID FROM Customer);
5. SELECT * FROM Customer WHERE ID IN (SELECT Customer_ID FROM Purchases WHERE MONTH IN (1,12));

---Chapter 13 DISTINCT PREDICATE
1. SELECT DISTINCT State FROM Suppliers ORDER BY State ASC;
2. SELECT DISTINCT State, COUNT(ID)AS CountNumber FROM Customer GROUP BY State ORDER BY State ASC;
3. SELECT DISTINCT Generation, COUNT(ID) AS CountNumber FROM Customer GROUP BY Generation;
4. SELECT Release_Year, COUNT(Product_ID) AS CountNumber FROM New_Vehicles GROUP BY Release_Year;
5. SELECT New_Upgrade, COUNT(New_Upgrade) AS NumberUpgrades, Cost FROM Upgrades GROUP BY New_Upgrade, Cost;

---Chapter 14 TOP PREDICATE
1. SELECT TOP 5 Quantities_per_Order, Name FROM Parts_Materials ORDER BY Quantities_per_Order DESC;
2. SELECT TOP 15 PERCENT Name, Cost FROM Parts_Materials ORDER BY Cost DESC;
3. SELECT TOP 10 Description, Release_Date FROM New_Vehicles ORDER BY Release_Date DESC;
4. SELECT TOP 10 Product_ID, SUM(SalesPrice) AS TotalSales FROM Purchases GROUP BY Product_ID ORDER BY SUM(SalesPrice) DESC;
5. SELECT TOP 10 Employee_ID, COUNT(PurchaseNumber) AS NumberSales FROM Purchases GROUP BY Employee_ID ORDER BY COUNT(PurchaseNumber) DESC;

---Chapter 15 CALCULATED FIELDS
1. SELECT New_Upgrade, SUM(Cost+Assembly) AS TotalCost FROM Upgrades GROUP BY New_Upgrade;
2. SELECT New_Upgrade, SUM((Markup-Cost-Assembly)) AS TotalProfit FROM Upgrades GROUP BY New_Upgrade; 
3. SELECT New_Upgrade, SUM(Markup-Cost*0.9-Assembly) AS DiscountProfit, SUM(Markup-Cost-Assembly) AS TotalProfit FROM Upgrades GROUP BY New_Upgrade;
4. SELECT New_Upgrade, IIF(SUM(Markup-Cost*0.9-Assembly)>100,'Good Margin','Bad Margin') AS DiscountProfit, SUM(Cost*0.1) AS DiscountMargin From Upgrades GROUP BY New_Upgrade;
5. SELECT New_Upgrade, CASE WHEN Type='base'THEN Cost*(1-0.12) WHEN Type='middle' THEN Cost*(1-0.15) WHEN Type='Elite' THEN Cost*(1-0.17) END AS DiscountedPrice, Cost FROM Upgrades;

---Chapter 16 CONCATENATED FIELDS
1. SELECT Position + ',' + First +','+  Last AS PositionGroup FROM Employee ORDER BY Position ASC;
2. SELECT 'Dear '+Owner+ ', owner of '+Company+'. Because of the recent downturn of the market we requrest a discount of 5%.' AS Supplier_Letter FROM Suppliers;
3. SELECT 'Dear '+Name+', we appreciate your work and dedication, professsionalism, and expertise. Here is to another fantastic 5 years on the team.' AS Employee_Letter_of_Appreciation FROM Employee WHERE YEAR(Hired) <2013;
4. SELECT CASE 
WHEN State = 'NY' THEN 'Dear ' + Name + ', In the near future, be on the lookout for a discount of 15% on future vehicles.'
WHEN State = 'NC' THEN 'Dear ' + Name + ', In the near future, be on the lookout for a discount of 25% on future vehicles.'
WHEN State = 'AZ' THEN 'Dear ' + Name + ', In the near future, be on the lookout for a discount of 20% on future vehicles.'
END
AS CustomerLetter
FROM Customer
WHERE State in ('NY','NC', 'AZ')
ORDER BY Name ASC;
5. SELECT CASE
WHEN Position = 'Consultant' THEN 'Dear '+Name+' , you have worked very hard this year and the company has decided to reward you with a 10% bonus! Thank you for your hard work.'
WHEN Position = 'Principal & Sr VP' THEN 'Dear '+Name+' , you have worked very hard this year and the company has decided to reward you with a 15% bonus! Thank you for your hard work.' 
WHEN Position = 'Sr Consultant' THEN 'Dear '+Name+' , you have worked very hard this year and the company has decided to reward you with a 20% bonus! Thank you for your hard work.'
END 
AS EmployeeBonus
FROM Employee 
WHERE Position IN ('Consultant','Principal & Sr VP','Sr Consultant')
ORDER BY Name ASC;
SELECT * FROM Employee;