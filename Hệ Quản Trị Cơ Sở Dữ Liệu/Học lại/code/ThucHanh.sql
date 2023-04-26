create database QuanLySinhVien
On Primary(
	Name = QLSV ,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\QLSV.mdf',
	Size = 10MB,
	MaxSize = 50MB,
	FileGrowth = 2MB
)
Log On(
	Name = QLSV_log,
	FileName ='D:\HQTCSDL\NguyenVanCuong\QLSV.ldf' ,
	Size = 5MB ,
	MaxSize = 20MB ,
	FileGrowth = 1MB
)


--b
alter database QuanLySinhVien
modify file (
name = QLSV,
Size = 15MB
)

--c
alter database QuanLySinhVien
modify file (
	name = QLSV_log,
	FileGrowth = 0
)

--d
use QuanLySinhVien
DBCC shrinkfile(
	name = QLSV,
	5
)

--e
alter database QuanLySinhVien
add file
(
	name = QLSV1,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\QLSV1.ndf',
	FileGrowth = 5MB
)
--f
use QuanLySinhVien Go
dbcc shrinkfile(
	QLSV1, emptyfile	
)
alter database QuanLySinhVien
remove file QLSV1
--g
create table SinhVien 
(
	ID int identity(1,1) primary key,
	NgaySinh date ,
	MaSV char(10) unique,
	HoTen nvarchar(50),
	GioiTinh nvarchar(20),
	DiaChi nvarchar(100),
	Email nvarchar(50) unique
)

alter table SinhVien add constraint SinhVien_GioiTinh_C check(GioiTinh = N'Nam' or GioiTinh = N'Nữ')

insert into SinhVien
values('01-01-2000', 'SV1', N'Nguyễn Văn Cường', N'Nam', N'Hà Nội', N'ng@gmail.com'),
('02-01-2000', 'SV2', N'Nguyễn Văn Sơn', N'Nam', N'Hà Nội', N'nddg@gmail.com'),
('01-05-2000', 'SV3', N'Nguyễn Văn Khánh', N'Nam', N'Hà Nội', N'nfssfg@gmail.com'),
('01-01-2000', 'SV4', N'Nguyễn Văn Hiển', N'Nam', N'Hà Nội', N'ngggas@gmail.com'),
('08-06-2000', 'SV5', N'Nguyễn Văn Vinh', N'Nam', N'Hà Nội', N'ngloi@gmail.com')
--h

create table MonHoc
(
	ID int identity(1,1),
	MaMon nvarchar(50) primary key,
	TenMon nvarchar(50) unique,
	MoTa nvarchar(200)
)
insert into MonHoc
values ('1','Toan','khong'),
		('2','Ly','khong'),
		('3','Hoa','khong'),
		('4','Anh','khong'),
		('5','Van','khong');
--i
create table KetQua(
	IDSV int foreign key references SinhVien (ID),
	IDMON nvarchar(50) foreign key references MonHoc(MaMon),
	Diem int,
)
insert into KetQua
values (1,1,8),
		(1,2,7),
		(1,3,9),
		(2,1,8),
		(2,2,6),
		(2,3,10),
		(3,1,8),
		(4,1,8),
		(5,2,7),
		(5,3,10);
