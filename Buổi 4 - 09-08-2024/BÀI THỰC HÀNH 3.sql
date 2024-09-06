--BÀI THỰC HÀNH 3
USE Northwind
GO

					-- MAKE-TABLE QUERY

--Cau 1
SELECT * INTO CacKhachHangMy
FROM Customers

SELECT * 
FROM CacKhachHangMy

--Cau 2
SELECT TOP 5 e.EmployeeID, 'Name' = e.FirstName + ' ' + e.LastName, 'SoDonHang' = count(OrderID)
	INTO NamNhanVienGioi
FROM Orders o, Employees e
WHERE o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY 3 DESC

SELECT *
FROM NamNhanVienGioi

--Cau 3
SELECT TOP 10 c.CustomerID, 'Address' = Address + ', ' + City + ', '+Country, 'SoLuongDonHang' = COUNT(OrderID)
	INTO MuoiKhachHang
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, CompanyName, Address, City, Country
ORDER BY 3 DESC

SELECT *
FROM MuoiKhachHang

--Cau 4
SELECT TOP 5 ShipCountry, 'SoLuongDonHang' = COUNT(ProductID)
	INTO Top5QGMuaHang
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
GROUP BY ShipCountry
ORDER BY 2 DESC

SELECT *
FROM Top5QGMuaHang

--Cau 5
SELECT TOP 5 ShipCountry, 'SoLuongDonHang' = COUNT(ProductID)
	INTO NamQGItMuaHang
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
GROUP BY ShipCountry
ORDER BY 2 ASC

SELECT *
FROM NamQGItMuaHang

					-- UPDATE QUERY
SELECT *
	INTO Customers2
FROM Customers


SELECT *
FROM Customers2

--Cau 1
UPDATE Customers2
SET
	Country = N'Mỹ'
WHERE Country = 'USA'

--Cau 2
UPDATE Customers2
SET Country = (CASE
					WHEN Country = 'Germany' THEN N'Đức'
					WHEN Country = 'France' THEN N'Pháp'
				END)
WHERE Country in ('Germany', 'France')

--Cau 6
UPDATE Customers2
SET PostalCode = '18'+ RIGHT(PostalCode, LEN(PostalCode) - 2)
WHERE Country = 'Germany'

					-- APPEND QUERY
-- Them 1 dong du lieu
--Cau 1
INSERT INTO Categories(CategoryName, Description)
VALUES 
	(N'Văn phòng phẩm', N'Sách, vở, giấy, bút, mực')

SELECT *
FROM Categories

--Cau 4
SELECT *
FROM Employees
INSERT INTO Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City,Country,HomePhone)
VALUES
	(N'Hùng', N'Hoàng', 'Software Engineer', 'Mr.', '02/25/2005', '08/09/2024', N'Nhà Bè', N'Hồ Chí Minh', N'Việt Nam', '0706823664') 

-- Them nhieu hang du lieu
SELECT *
	INTO KhachHang
FROM Customers

DELETE FROM KhachHang
--Cau 6
INSERT KhachHang
SELECT *
FROM Customers
WHERE Country = 'USA'

--Cau 7
INSERT KhachHang
SELECT *
FROM Customers
WHERE CustomerID in (
						SELECT TOP 10 c.CustomerID
						FROM Customers c, Orders o
						WHERE c.CustomerID = o.CustomerID
						GROUP BY c.CustomerID
						ORDER BY count(OrderID) DESC
					)

SELECT *
FROM KhachHang

					-- CROSS-TAB QUERY
--Cau 1
SELECT ProductName, ISNULL([1996], 0), ISNULL([1997], 0), ISNULL([1998], 0)
FROM (
		SELECT p.ProductName, YEAR(OrderDate) as 'Nam', Quantity
		FROM Orders o, [Order Details] od, Products p
		WHERE o.OrderID= od.OrderID and od.ProductID=p.ProductID and YEAR(OrderDate) between 1996 and 1998
	)A
pivot
(
	sum(Quantity) for Nam in([1996], [1997], [1998])
)B

--Cau 5
SELECT CompanyName as 'Company Name', ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) as 'SumTotal', ISNULL([1], 0) as 'Qrt 1', ISNULL([2], 0) as 'Qrt 2', ISNULL([3], 0) as 'Qrt 3', ISNULL([4], 0) as 'Qrt 4'
FROM (
		SELECT CompanyName, UnitPrice*Quantity*(1-Discount) as 'TriGia', DATEPART(q, OrderDate) as 'Quy' 
		FROM Customers c, Orders o, [Order Details] od
		WHERE c.CustomerID = o.CustomerID and od.OrderID = o.OrderID and YEAR(OrderDate) = 1996
	) A
pivot
(
	sum(TriGia) for Quy in ([1], [2], [3], [4])
)B

--Cau 6
SELECT CategoryName, ISNULL([1], 0) + ISNULL([2], 0) + ISNULL([3], 0) + ISNULL([4], 0) as 'SumTotal', ISNULL([1], 0) as 'Qrt 1', ISNULL([2], 0) as 'Qrt 2', ISNULL([3], 0) as 'Qrt 3', ISNULL([4], 0) as 'Qrt 4'
FROM (
		SELECT CategoryName, od.UnitPrice*Quantity*(1-Discount) as 'TriGia',
			DATEPART(q, OrderDate) as 'Quy'
		FROM Orders o, [Order Details] od, Products p, Categories c
		WHERE o.OrderID = od.OrderID and p.ProductID = od.ProductID and p.CategoryID = c.CategoryID and
				YEAR(OrderDate) = 1997
	)A
pivot
(
	sum(TriGia) for Quy in ([1], [2], [3], [4])
)B
