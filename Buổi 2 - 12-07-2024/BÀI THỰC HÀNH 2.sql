--BAI THUC HANH 2

--Cau 3
use Northwind
select CustomerID, CompanyName, ContactName, Address, City, ContactTitle
from Customers
where (ContactTitle = 'Sales Manager' and Country = 'USA') or (ContactTitle = 'Owner' and Country = 'Mexico')

--Cau 4
use Northwind
select CustomerID, CompanyName, ContactName, Address, City, ContactTitle
from Customers
where (ContactTitle like '%Manager' and Country = 'USA') or (ContactTitle != 'Owner' and Country = 'Mexico')

--Cau 6
use Northwind
set dateformat dmy
select OrderID, OrderDate, CustomerID, EmployeeID
from Orders
where OrderDate between '01/02/1997' and '28/02/1997'

--Cau 7
use Northwind
set dateformat dmy
select OrderID, OrderDate, Freight 
from Orders
where ShipCountry = 'UK' and EmployeeID ='2' and year(OrderDate) = '1997'

--Cau 8
use Northwind
select ProductID, ProductName 
from Products
where ProductName like 'Ch%'


--Cau 9
use Northwind
select ProductID, UnitPrice, UnitsInStock
from Products
where Discontinued = '0' and UnitsInStock > 0

--Cau 10
use Northwind
select CompanyName, ContactName, Country, Phone, Fax
from Customers
where Country != 'USA'

--Cau 11
use Northwind
select CompanyName, ContactName, Country, Phone, Fax
from Customers
where Country not in('Brazil', 'Italy', 'Spain', 'Venezuela', 'UK')

--Cau 12
