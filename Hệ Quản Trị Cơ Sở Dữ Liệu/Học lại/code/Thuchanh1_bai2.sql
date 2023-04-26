
--a
create database QuanLyKhachHang
On Primary(
	Name = QLKH ,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\QLKH.mdf',
	Size = 10MB,
	MaxSize = 50MB,
	FileGrowth = 2MB
)
Log On(
	Name = QLKH_log,
	FileName ='D:\HQTCSDL\NguyenVanCuong\QLKH.ldf' ,
	Size = 5MB ,
	MaxSize = 20MB ,
	FileGrowth = 1MB
)

--b
alter database QuanLyKhachHang
modify file (
name = QLKH,
Size = 15MB
)

--c
alter database QuanLyKhachHang
modify file (
	name = QLKH_log,
	FileGrowth = 0
)

--d
use QuanLyKhachHang
DBCC shrinkfile(
	name = QLKH,
	5
)

--e
alter database QuanLyKhachHang
add file
(
	name = QLKH1,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\QLKH1.ndf',
	FileGrowth = 5MB
)

--f
use QuanLyKhachHang Go
dbcc shrinkfile(
	QLKH1, emptyfile	
)
alter database QuanLyKhachHang
remove file QLKH1

--h
create table KhachHang 
(
	IDKhachHang int identity(1,1) primary key,
	HoTen nvarchar(50),
	GioiTinh nvarchar(20),
	DiaChi nvarchar(100),
	Email nvarchar(50) unique,
	SoDienThoai varchar(12),
	constraint KH_GT check (GioiTinh = N'Nam' or GioiTinh = N'Nữ'),
	constraint KH_Email check (Email like '%@%' ),
)
insert into KhachHang
values(N'Nguyễn Văn Cường', N'Nam', N'Hà Nội', N'ng@gmail.com','0985478996'),
(N'Nguyễn Văn Sơn', N'Nam', N'Nghệ An', N'nddg@gmail.com','0952361452'),
(N'Nguyễn Văn Khánh', N'Nam', N'Hưng Yên', N'nfssfg@gmail.com','0941265874'),
(N'Nguyễn Văn Hiển', N'Nam', N'Hà Nội', N'ngggas@gmail.com','0852636471'),
(N'Nguyễn Văn Vinh', N'Nam', N'Thanh Hóa', N'ngloi@gmail.com','0374523912')

--select * from KhachHang

--i
create table SanPham
(
	IDSanPham int identity(1,1),
	TenSP nvarchar(50),
	MoTa nvarchar(100), 
	DonGia float
)
alter table SanPham add unique (TenSP)
alter table SanPham add primary key (IDSanPham)

insert into SanPham
values(N'Bánh Mì', N'Ăn ngon', 150),
(N'Bánh Gạo', N'Ăn cũng ngon', 100),
(N'Mì Tôm', N'Bình Thường', 50),
(N'Bia', N'Uống là say', 200),
(N'Coca', N'Không', 25)

--j
create table DonHang
(
	IDDonHang int not null primary key,
	IDKhachHang int not null,
	NgayDatHang date,
	TongTien float
)
alter table DonHang add foreign key (IDKhachHang) references KhachHang(IDKhachHang)

insert into DonHang values
(2,2,'01-05-2000',null),
(3,3,'01-08-2000',null),
(4,4,'08-05-2000',null),
(5,4,'01-09-2000',null),
(6,1,'03-05-2000',null),
(7,2,'01-12-2000',null),
(8,3,'01-05-2000',null),
(9,1,'12-05-2000',null),
(10,5,'01-06-2000',null),
(11,1,'01-05-2000',null)

--k
create table SP_DonHang
(
	IDDonHang int,
	IDSanPham int,
	SoLuong int default 1,
	ThanhTien float,
	constraint KhoaChinh primary key (IDDonHang, IDSanPham),
	foreign key (IDDonHang) references DonHang(IDDonHang),
)

drop table SP_DonHang

insert into SP_DonHang(IDDonHang,IDSanPham,SoLuong) 
values
(1,5,3),
(2,3,20),
(3,2,19),
(4,4,12),
(5,2,5)

select *from SP_DonHang