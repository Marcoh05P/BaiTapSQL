-- BAI THUC HANH 4
CREATE DATABASE ThucHanhDDL
USE ThucHanhDDL
GO

-- Cau 1
CREATE TABLE Khoa
(
	MaKhoa char(4) primary key,
	TenKhoa nvarchar(20) not null,
	NgayThanhLap date,
	NoiDungDaoTao nvarchar(200),
	GhiChu nvarchar(MAX)
)

-- Cau 2
CREATE TABLE Lop
(
	MaLop char(6) primary key,
	TenLop nvarchar(20) not null,
	KhoaHoc nvarchar(4),
	GVCN nvarchar(50),
	MaKhoa char(4),
	GhiChu nvarchar(MAX)
)

ALTER TABLE Lop
	ADD CONSTRAINT fk_Lop_MaKhoa
		Foreign Key (MaKhoa) references Khoa(MaKhoa)

-- Cau 3
CREATE TABLE SinhVien
(
	MaSV char(8) primary key,
	HoSV nvarchar(50) not null,
	TenSV nvarchar(200) not null,
	GioiTinh nvarchar(4),
	NgaySinh date,
	QueQuan nvarchar(200),
	DiaChi nvarchar(100),
	MaLop char(6) Foreign Key (MaLop) references Lop(MaLop),
	GhiChu nvarchar(MAX)
)

-- Cau 4
CREATE TABLE MonHoc
(
	MaMH int Identity(1,1) Primary Key,
	TenMH NVarChar(20) not null,
	NoiDungMH NVarChar(200),
	MaKhoa Char(4) Foreign Key (MaKhoa) references Khoa(MaKhoa),
	SoTC int,
	SoTiet int,
	GhiChu NVarChar(MAX)
)

-- Cau 5
CREATE TABLE Hoc
(
	MaSV Char(8) Foreign Key (MaSV) references SinhVien(MaSV),
	MaMH int Identity(1,1) Foreign Key (MaMH) references MonHoc(MaMH),
	NgayDangKy date,
	NgayThi date,
	DiemTB Decimal(8, 2),
	GhiChu NVarChar(MAX),
	Primary Key( MaSV, MaMH, NgayDangKy)
)

-- Cau 6
ALTER TABLE SinhVien
	ADD CMND VarChar(9)

-- Cau 7
ALTER TABLE SinhVien
	ADD DTDD VarChar(10)

-- Cau 8
ALTER TABLE SinhVien
	ALTER COLUMN DTDD VarChar(12)

-- Cau 9
ALTER TABLE SinhVien
	DROP COLUMN DTDD

-- Cau 10
ALTER TABLE Hoc
	ADD CONSTRAINT CHK_Hoc_DiemTB
		Check (DiemTB between 0 and 10)

-- Cau 11
ALTER TABLE Hoc
	ADD CONSTRAINT CHK_Hoc_NgayThi
		Check (NgayThi > getdate())

ALTER TABLE Hoc
	ADD CONSTRAINT DF_Hoc_NgayDangKy
		Default (getdate()) for NgayDangKy

-- Cau 12
ALTER TABLE SinhVien
	ADD CONSTRAINT UQ_SinhVien_CMND
		UNIQUE (CMND)







--Lấy tên các ràng buộc
Select  SysObjects.[Name] As [Constraint Name] ,
        Tab.[Name] as [Table Name],
        Col.[Name] As [Column Name]
From SysObjects Inner Join 
	(Select [Name],[ID] From SysObjects) As Tab
	On Tab.[ID] = Sysobjects.[Parent_Obj] 
	Inner Join sysconstraints On sysconstraints.Constid = Sysobjects.[ID] 
	Inner Join SysColumns Col On Col.[ColID] = sysconstraints.[ColID] And Col.[ID] = Tab.[ID]
order by [Tab].[Name]
 
--Lấy tên các Proceduce
SELECT name, 
       type
  FROM dbo.sysobjects
 WHERE (type = 'P')
