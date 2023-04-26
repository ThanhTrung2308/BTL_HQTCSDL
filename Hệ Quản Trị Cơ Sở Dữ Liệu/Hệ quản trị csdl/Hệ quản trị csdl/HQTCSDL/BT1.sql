create database QuanLySinhVien
on primary
(
	Name = DataT,
	Filename = 'F:\HQTCSDL\DataT.mdf',
	size = 10MB,
	maxsize = 50MB,
	filegrowth = 2MB
)
log on
(
	Name = LogT,
	Filename = 'F:\HQTCSDL\LogT.ldf',
	size = 5MB,
	maxsize = 20MB,
	filegrowth = 1MB
);
--b
alter database QuanLySinhVien
modify file
(
	Name = DataT,
	Filename = 'F:\HQTCSDL\DataT.mdf',
	size = 15MB
);
--c
alter database QuanLySinhVien
modify file
(
	Name = DataT,
	Filegrowth = 0
);
--d
use QuanLySinhVien
DBCC SHRINKFILE 
(
	Name = DataT, 5
);
--e
alter database QuanLySinhVien
add file 
(
	Name = DataT_2,
	Filename = 'F:\HQTCSDL\DataT.ndf',
	size = 10MB,
	maxsize = unlimited,
	filegrowth = 5MB
);
--f
use QuanLySinhVien
DBCC SHRINKFILE 
(
	Name = DataT_2, emptyfile
)
go
alter database QuanLySinhVien
remove file DataT_2
--g
create table SInhVien
(
	ID int not null identity(1,1) primary key,
	MaSV char(10) unique,
	Hoten nvarchar(50),
	Ngaysinh date,
	Diachi nvarchar(50),
	Email nvarchar(50) unique,
	gioitinh nvarchar(4) check (gioitinh = N'Nam' or gioitinh = N'Nữ'),
)
--drop table SInhVien;
go 
insert dbo.SInhVien(MaSV,Hoten, Ngaysinh, Diachi, Email, gioitinh)
values
(
	'1851061801', N'Nguyên Văn A', '2000-01-02', N'Hà Nội', '1851061801@tlu.edu.vn', N'Nam')
insert dbo.SInhVien(MaSV,Hoten, Ngaysinh, Diachi, Email, gioitinh)
values
(
	'1851061802', N'Nguyên Văn B', '2000-05-07', N'Hải Phòng', '1851061802@tlu.edu.vn', N'Nam')
insert dbo.SInhVien(MaSV,Hoten, Ngaysinh, Diachi, Email, gioitinh)
values
(
	'1851061803', N'Nguyên Thị C', '2000-06-08', N'Hải Dương', '1851061803@tlu.edu.vn', N'Nữ')
insert dbo.SInhVien(MaSV,Hoten, Ngaysinh, Diachi, Email, gioitinh)
values
(
	'1851061804', N'Nguyên Văn D', '2000-12-20', N'Ninh Bình', '1851061804@tlu.edu.vn', N'Nam')
insert dbo.SInhVien(MaSV,Hoten, Ngaysinh, Diachi, Email, gioitinh)
values
(
	'1851061805', N'Nguyên Thị E', '2000-10-01', N'Phú Thọ', '1851061805@tlu.edu.vn', N'Nữ')
--h
create table MonHoc
(
	ID int not null identity(1,1) primary key,
	MaMon char(10) unique,
	TenMon nvarchar(50) unique,
	Mota nvarchar(200),
)
go
insert dbo.MonHoc(MaMon, TenMon, Mota)
values ('CSDL', N'Cơ Sở Dữ Liệu', N'Làm viêc với phần mêm SQL Server để quản lý dữ liệu')
insert dbo.MonHoc(MaMon, TenMon, Mota)
values ('GT1', N'Giải Tính 1', N'Ôn tập toán cấp III và nâng cao')
insert dbo.MonHoc(MaMon, TenMon, Mota)
values ('DSTT', N'Đại Số Tuyến Tính', N'Làm việc với Ma Trận')
insert dbo.MonHoc(MaMon, TenMon, Mota)
values ('HQTCSDL', N'Hệ Quản Trị Cơ Sở Dữ Liệu', N'Làm viêc với phần mêm SQL Server để quản lý dữ liệu (Nâng cao)')
insert dbo.MonHoc(MaMon, TenMon, Mota)
values ('MMT', N'Mạng Máy Tính', N'.....')
--i

create table KetQua
(
	IDSV int not null,
	IDMH int not null,
	Diem int,
	Primary key(IDSV, IDMH),
	foreign key (IDSV) references SInhVien(ID),
	foreign key (IDMH) references MonHoc(ID),
);
insert into KetQua
values('2', '5', 9),('1', '4', 2),('3', '3', 6),('4', '1', 7.5),('5', '2', 10)
select SInhVien.Hoten, MonHoc.TenMon, KetQua.Diem 
from KetQua, SInhVien, MonHoc
where KetQua.IDSV = SInhVien.ID and MonHoc.ID = KetQua.IDSV
