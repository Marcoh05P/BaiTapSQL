USE Northwind
go

--Cau 13
SELECT OrderID, ContactName,  FirstName, Orderdate, ShipCountry, ShippedDate, Freight 
FROM Orders o, Customers c, Employees e
WHERE (ShipCountry = 'USA' and Freight > 300) or (ShipCountry = 'Argentina' and Freight < 5)
and o.CustomerID = c.CustomerID and o.EmployeeID=e.EmployeeID

--Cau14
SELECT OrderID, OrderDate, ContactName,  FirstName, Freight, Freight * 1.1 as 'New-Freight'
FROM Orders o, Customers c, Employees e
WHERE OrderDate between '04/01/1997' and '04/30/1997'
and o.CustomerID = c.CustomerID and o.EmployeeID=e.EmployeeID

--Cau 15
SELECT ProductID, ProductName, ContactName, UnitPrice, 	UnitsInStock, 	UnitPrice*UnitsInStock as 'Total', Fax
FROM Products p, Suppliers s
WHERE (p.SupplierID = s.SupplierID) and Discontinued = 'True'

--Cau 16
SELECT TitleOfCourtesy + ' ' + left(LastName, 1) + ' '+ FirstName as 'Name', HireDate, Title, BirthDate, HomePhone
FROM Employees
WHERE year(HireDate)<1993

--Cau 17
SELECT OrderID, OrderDate, 'Customer' = CompanyName, 'Employee'=LastName
FROM Orders o, Customers c, Employees e
WHERE month(OrderDate) = 4 and o.CustomerID = c.CustomerID and o.EmployeeID = e.EmployeeID

--Cau 18
SELECT OrderID, OrderDate, 'Customer' = CompanyName, 'Employee'=LastName
FROM Orders o, Customers c, Employees e
WHERE year(OrderDate) % 2 = 0 and o.CustomerID = c.CustomerID and o.EmployeeID = e.EmployeeID

--Cau 19
SELECT OrderID, OrderDate, 'Customer' = CompanyName, 'Employee'=LastName
FROM Orders o, Customers c, Employees e
WHERE day(OrderDate) in(5, 13, 14, 23) and o.CustomerID = c.CustomerID and o.EmployeeID = e.EmployeeID

--Cau 20
SELECT od.OrderID, ProductName, od.UnitPrice, od.Quantity, 'ThanhTien' = od.UnitPrice*od.Quantity, Discount, 'TienGiamGia' = (od.UnitPrice*od.Quantity) * od.Discount, 'TienPhaiTra' = od.UnitPrice*od.Quantity * ( 1- od.Discount)
FROM [Order Details] od, Products p, Orders o
WHERE od.OrderID = o.OrderID and od.ProductID = p.ProductID and year(o.OrderDate) = 1997

--Cau 21
SELECT od.OrderID, ProductName, od.UnitPrice, od.Quantity, 'ThanhTien' = od.UnitPrice*od.Quantity, Discount,'TienGiamGia' = (od.UnitPrice*od.Quantity) * od.Discount, 'TienPhaiTra' = od.UnitPrice*od.Quantity * ( 1- od.Discount)
FROM [Order Details] od, Products p, Orders o
WHERE Discount> 0 and od.UnitPrice*od.Quantity * ( 1- od.Discount) < 50 and od.OrderID = o.OrderID and od.ProductID = p.ProductID and year(o.OrderDate) = 1997

--Cau 22
SELECT 'SoSP' = count(ProductID), 'DonGiaCaoNhat' = max(UnitPrice), 'DonGiaThapNhat' = min(UnitPrice), 'DonGiaTrungBinh' = avg(UnitPrice)
FROM Products

--Cau 23
SELECT CategoryID, 'SoSP' = count(ProductID), 'DonGiaCaoNhat' = max(UnitPrice), 'DonGiaThapNhat' = min(UnitPrice), 'DonGiaTrungBinh' = avg(UnitPrice)
FROM Products
GROUP BY CategoryID

--Cau 24
SELECT ShipCountry, 'SoDonDatHang' = count(OrderID)
FROM Orders
WHERE ShipCountry in ('Belgium', 'Canada', 'UK')
GROUP BY ShipCountry

--Cau 25
SELECT *
FROM Categories
WHERE CategoryID in (
					SELECT CategoryID
					FROM Products
					GROUP BY CategoryID
					HAVING AVG(UnitPrice)>30
					)

--Cau 26
SELECT CategoryID, 'DonGiaTrungBinh' = avg(UnitPrice)
FROM Products
WHERE UnitPrice>30
GROUP BY CategoryID

--Cau 27
SELECT CategoryName, 'SalesTotal'=round(sum(od.UnitPrice*Quantity*(1-Discount)),1)
FROM Orders o, [Order Details] od, Products p, Categories c
WHERE year(o.OrderDate) = 1996 and c.CategoryID = p.CategoryID and p.ProductID=od.ProductID and od.OrderID = o.OrderID
GROUP BY CategoryName

--Cau 28
SELECT CompanyName, 'Freight' = round(sum(Freight), 1), 'SalesTotal' = round(sum(UnitPrice * Quantity * ( 1 - Discount)),1), 'Precent' = round(sum(Freight) / sum(UnitPrice * Quantity * ( 1 - Discount)),1)
FROM Customers c, Orders o, [Order Details] d
WHERE year(OrderDate) = 1997 and c.CustomerID = o.CustomerID and o.OrderID = d.OrderID
GROUP BY CompanyName

--Cau 29
DECLARE @key nvarchar(40)
SET @key = 'C%'

SELECT CustomerID, CompanyName, ContactName, Address, City, Country, Phone,Fax
FROM Customers
WHERE CompanyName like @key

--Cau 30
DECLARE	@From datetime, @To datetime
SET @From = '01/01/1997'
SET @To = '12/31/1997'

SELECT OrderID, ContactName, ShipCountry, OrderDate
FROM Orders o, Customers c
WHERE OrderDate between @From and @To and o.CustomerID=c.CustomerID

--Cau 31
DECLARE @CountryName nvarchar(50), @Year int
SET @CountryName = 'Italy'
SET @Year = 1997

SELECT *
FROM Customers c, Orders o
WHERE o.ShipCountry = @CountryName and year(OrderDate) = @Year and c.CustomerID = o.CustomerID

--Cau 32
DECLARE @CategoryID int
SET @CategoryID = '5'

SELECT ProductName, d.UnitPrice, ContactName
FROM [Order Details] d, Products p, Suppliers s
WHERE CategoryID = @CategoryID
--Cau 35



