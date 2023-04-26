create database QuanLyKho
go
use QuanLyKho
go
create table DonViTinh
(
	ID_DVT char(5) not null primary key,
	DinhDang char(5)not null
)

create table NhaCungCap
(
	ID_NCC char(5)not null primary key,
	TenNCC nchar(50)not null,
	Diachi nvarchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	ThongTin nvarchar(200)not null,
	NgayHopTac date not null
)

create table MatHang
(
	ID_MH char(5)not null primary key,
	TenMH nchar(50)not null,
	ID_DVT char(5)not null,
	ID_NCC char(5)not null,
	foreign key (ID_DVT) references DonViTinh(ID_DVT),	
	foreign key (ID_NCC) references NhaCungCap(ID_NCC)
)
alter table MatHang
add NgaySS date;
create table KhachHang
(
	ID_KH char(5)not null primary key,
	TenKH nchar(50)not null,
	Diachi nchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	ThongTin nvarchar(200)not null,
	NgayHopTac date not null
)
create table PhieuNhap
(	
	ID_PN char(5)not null primary key,
	NgayNhap date not null
)
create table TT_PhieuNhap
(
	ID_TTPN char(5)not null primary key,
	ID_PN char(5) not null,
	ID_MH char(5) not null,
	Soluong int not null,
	GiaNhap money not null,
	TinhTrang nchar(200) not null,
	foreign key (ID_PN) references PhieuNhap(ID_PN),
	foreign key (ID_MH) references MatHang(ID_MH)
)

create table PhieuXuat
(	
	ID_PX char(5)not null primary key,
	NgayXuat date
)
create table TT_PhieuXuat
(
	ID_TTPX char(5)not null primary key,
	ID_PX char(5) not null,
	ID_MH char(5) not null,
	ID_KH char(5) not null,
	Soluong int not null,
	GiaXuat money not null,
	TinhTrang nchar(200)
	foreign key (ID_PX) references PhieuXuat(ID_PX),
	foreign key (ID_MH) references MatHang(ID_MH),
	foreign key (ID_KH) references KhachHang(ID_KH)

)
select Sum(TT_PhieuNhap.GiaNhap) as TongTienNhap
from PhieuNhap, TT_PhieuNhap 
where PhieuNhap.ID_PN = TT_PhieuNhap.ID_PN and year(PhieuNhap.NgayNhap) = 2020

select Sum(GiaNhap) as Tong_Tien_Nhap from TT_PhieuNhap