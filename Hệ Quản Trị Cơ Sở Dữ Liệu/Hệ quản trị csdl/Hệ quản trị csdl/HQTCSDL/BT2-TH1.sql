create database QLKhachHang
on primary
(
	Name = DataK,
	Filename = 'F:\HQTCSDL\DataK.mdf',
	size = 10MB,
	maxsize = 50MB,
	filegrowth = 2MB
)
log on
(
	Name = LogK,
	Filename = 'F:\HQTCSDL\LogK.ldf',
	size = 5MB,
	maxsize = 20MB,
	filegrowth = 1MB
);
alter database QLKhachHang
modify file
(
	Name = DataK,
	Filename = 'F:\HQTCSDL\DataK.mdf',
	size = 15MB
);
--c
alter database QLKhachHang
modify file
(
	Name = DataK,
	Filegrowth = 0
);
--d
use  QLKhachHang
DBCC SHRINKFILE 
(
	Name = DataK, 5
);
--e
alter database QLKhachHang
add file 
(
	Name = DataK_2,
	Filename = 'F:\HQTCSDL\DataK.ndf',
	size = 10MB,
	maxsize = unlimited,
	filegrowth = 5MB
);
--f
use QLKhachHang
DBCC SHRINKFILE 
(
	Name = DataK_2, emptyfile
)
go
alter database  QLKhachHang
remove file DataK_2
--h
create table KhackHang
(
	IDKhackHang int not null identity(1,1) primary key,
	Hoten nvarchar(50),
	Diachi nvarchar(50),
	GioiTinh nvarchar(4) check (gioitinh = N'Nam' or gioitinh = N'Nữ'),
	Email nvarchar(50) unique,
	SoDienThoai char(11),
	constraint check_Email check (Email like '%@%')
)
--drop table KhackHang;
go 
insert dbo.KhackHang(Hoten,Diachi,GioiTinh,Email,SoDienThoai)
values(N'Nguyễn Văn A',N'Hà Nội', N'Nam','nguyenvana@gmail.com','0123456780' )
insert dbo.KhackHang(Hoten,Diachi,GioiTinh,Email,SoDienThoai)
values(N'Nguyễn Thị B',N'Bắc Giang', N'Nữ','nguyenthib@gmail.com','0123456781' )
insert dbo.KhackHang(Hoten,Diachi,GioiTinh,Email,SoDienThoai)
values(N'Nguyễn Văn C',N'Quảng Ninh', N'Nam','nguyenvanc@gmail.com','0123236789' )
insert dbo.KhackHang(Hoten,Diachi,GioiTinh,Email,SoDienThoai)
values(N'Nguyễn Thị D',N'Hưng Yên', N'Nữ','nguyenthid@gmail.com','0123451189' )
insert dbo.KhackHang(Hoten,Diachi,GioiTinh,Email,SoDienThoai)
values(N'Nguyễn Văn E',N'Thanh Hóa', N'Nam','nguyenvane@gmail.com','0123456987' )

select * from KhackHang
--i
create table SanPham
(
	IDSanPham int not null identity(1,1),
	TenSP nvarchar(50) unique,
	Mota nvarchar(200),
	DonGia int,
)
alter table SanPham
add constraint SP_unique unique (TenSP),
constraint PK_ID primary key (IDSanPham)

go
insert dbo.SanPham(TenSP,Mota,DonGia)
values (N'Dầu Gội Đầu Clear', N'Gội Đi không rụng tóc đâu', '70000')
insert dbo.SanPham(TenSP,Mota,DonGia)
values (N'Dầu Gội Đầu Romano', N'Gội Đi chắc không rụng tóc đâu', '55000')
insert dbo.SanPham(TenSP,Mota,DonGia)
values (N'Dầu Gội Đầu X-Men', N'Gội Đi chắc chắn không rụng tóc đâu', '100000')
insert dbo.SanPham(TenSP,Mota,DonGia)
values (N'Dầu Gội Đầu Neo', N'Gội Đi sẽ không rụng tóc đâu', '90000')
insert dbo.SanPham(TenSP,Mota,DonGia)
values (N'Dầu Gội Đầu Rechoice', N'Gội Đi mà, không rụng tóc đâu', '80000')

select * from SanPham
--i

create table DonHang
(
	IDDonHang int identity(1,1) not null,
	IDKhackHang int,
	NgayDatHang date,
	TongTien float,
);
alter table DonHang
add constraint DH_ID unique (IDDonHang),
constraint FK_IDKH foreign key (IDKhackHang) references KhackHang(IDKhackHang)

go
insert dbo.DonHang(IDKhackHang,NgayDatHang,TongTien)
values ('1','2020-09-01','')
insert dbo.DonHang(IDKhackHang,NgayDatHang,TongTien)
values ('3','2020-09-02','')
insert dbo.DonHang(IDKhackHang,NgayDatHang,TongTien)
values ('5','2020-09-03','')
insert dbo.DonHang(IDKhackHang,NgayDatHang,TongTien)
values ('2','2020-09-04','')
insert dbo.DonHang(IDKhackHang,NgayDatHang,TongTien)
values ('4','2020-09-05','')

select * from DonHang
create table SP_DonHang
(
	IDDonHang int not null,
	IDSanPham int not null,
	SoLuong int default 1,
	ThanhTien float,
	foreign key (IDDonHang) references DonHang(IDDonHang),
	foreign key (IDSanPham) references SanPham(IDSanPham),
	primary key (IDDonHang, IDSanPham)
)
go
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(1,2,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(2,3,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(3,4,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(4,5,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(5,1,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(1,3,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(2,4,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(3,5,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(4,1,10,'')
insert SP_DonHang(IDDonHang,IDSanPham,SoLuong,ThanhTien)
values(5,2,10,'')


--a
update SP_DonHang
set ThanhTien = SoLuong*(select DonGia from SanPham where SanPham.IDSanPham = SP_DonHang.IDSanPham)
--b
update DonHang
set TongTien = (select Sum(ThanhTien)From SP_DonHang where SP_DonHang.IDDonHang = DonHang.IDDonHang)
select * from DonHang
select * from SP_DonHang
--c
declare @Ten nvarchar(10);
set @Ten = N'Nguyễn Văn A'
print Right(RTrim(@Ten), charIndex(' ',RTrim(@Ten))-1)
Select @Ten

--d
select SanPham.* 
from SanPham, SP_DonHang, KhackHang, DonHang
where SP_DonHang.IDSanPham = SanPham.IDSanPham and KhackHang.IDKhackHang = DonHang.IDKhackHang and SP_DonHang.IDDonHang = DonHang.IDDonHang and KhackHang.Hoten like N'Nguyễn Văn A'
--e
select  DonHang.TongTien
from SanPham, SP_DonHang, KhackHang, DonHang
where SP_DonHang.IDSanPham = SanPham.IDSanPham and KhackHang.IDKhackHang = DonHang.IDKhackHang and SP_DonHang.IDDonHang = DonHang.IDDonHang and KhackHang.Hoten like N'Nguyễn Văn A'

