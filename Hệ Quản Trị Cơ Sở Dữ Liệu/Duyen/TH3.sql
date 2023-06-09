
-- nhớ xoá CSDL QLKH cũ
drop database QLKH
-- tạo thư mục BT SQL trong ổ D
-- Chạy phần này đầu tiên
Create database QLKH1
on primary
(
	name = QLKH,
	filename = 'D:\HQTCSDL\QLKH1.mdf',
	size = 10MB,
	maxsize = Unlimited,
	filegrowth = 2MB
)
log on
(
name = QLKH_log,
	filename = 'D:\HQTCSDL\QLKH_log.ldf',
	size = 5MB,
	maxsize = Unlimited,
	filegrowth = 1MB
)
-- Chọn CSDL QLKH (ctrl + u)
-- Bôi đen từ đoạn này đến hết rồi chạy
create table NhaCungCap
(
	idNCC nvarchar(8) primary key,
	TenCongTy nvarchar(255),
	DiaChi	nvarchar(255),
	SDT nvarchar(255),
	Website nvarchar(255),
	ConGiaoDich bit
)

create table LoaiHang
(
	idLoaiHang nvarchar(8) primary key,
	TenLoaiHang nvarchar(255),
	MoTa nvarchar(255)
)

create table CtyGiaoHang
(
	idCty nvarchar(8) primary key,
	TenCongTy nvarchar(255),
	SDT nvarchar(255),
	DiaChi nvarchar(255)
)


create table KhachHang 
(
	idKH nvarchar(8) primary key,
	HoTen nvarchar(255),
	GioiTinh nvarchar(255) ,
	DiaChi nvarchar(255),
	Email nvarchar(255) unique,
	SDT nvarchar(255),
	check (GioiTinh in ('Nam','Nu')),
	check (Email like ('%@%'))
)


create table NhanVien
(
	idNV nvarchar(8) primary key,
	HoTen nvarchar(255),
	NgaySinh date,
	GioiTinh nvarchar(255),
	NgayBatDauLam date,
	DiaChi nvarchar(255),
	Email nvarchar(255),
	SDT nvarchar(255),
)

create table SanPham 
(	
	idSP nvarchar(8) primary key,
	TenSP nvarchar(255) unique,
	idNCC nvarchar(8) foreign key references NhaCungCap(idNCC),
	idLoaiHang nvarchar(8) foreign key references LoaiHang(idLoaiHang),
	DonGiaNhap int,
	SoLuongCon int,
	SoLuongChoCungCap int,
	MoTa nvarchar(255),
	NgungBan bit
)

create table  DonHang
(
	idDH int primary key identity (1,1),
	idKH nvarchar(8) foreign key references KhachHang(idKH),
	idNV nvarchar(8) foreign key references NhanVien(idNV),
	NgayDatHang date,
	NgayGiaoHang date,
	NgayYeuCauChuyen date,
	idCty nvarchar(8) foreign key references CtyGiaoHang(idCty),
	DiaChiGiaoHang nvarchar(255)
)

create table SP_DonHang
(
	idDH int foreign key references DonHang(idDH),
	idSP  nvarchar(8) foreign key references SanPham(idSP),
	SoLuong int,
	DonGiaBan float,
	TyLeGiamGia float,
	primary key (idDH,idSP)
)


insert into NhaCungCap values
('NCC1',N'Rau' ,N'Hà Nội' ,'1199' ,'rau.com',1),
('NCC2',N'Bánh Ngọt',N'Hải Phòng','1133','banhngon.com',1),
('NCC3',N'Kẹo Mút',N'Đà Nẵng','1256','keode.com',1)

insert into LoaiHang values
('LH1',N'Rau củ quả',N'Nhà  trồng'),
('LH2',N'Bánh',N'Nhà  Làm'),
('LH3',N'Kẹo',N'Đi buôn')

insert into CtyGiaoHang values
('CTY1',N'Xe máy','0099',N'Hà Nội'),
('CTY2',N'Ô tô','0081',N'Đà Nẵng'),
('CTY3',N'Xe đạp','1248',N'Hà Nội'),
('CTY4',N'Xe ngựa','6328',N'Hải Phòng')

insert into KhachHang values
('KH1',N'Tấn Phong','Nam',N'Bình Thuận','test1@mail','115'),
('KH2',N'Thiên Ân','Nu',N'Đồng Tháp','awan45@li','116'),
('KH3',N'Minh Anh','Nam',N'Lâm Đồng','ma123@tu','117'),
('KH4',N'Gia Huy','nu',N'Phú Thọ','git@gg','118'),
('KH5',N'Minh Quân','Nam',N'Hà Nội','sql@home','119')

insert into NhanVien values
('NV1',N'Chiến Thắng','2000-5-19','Nam','2019-12-31',N'Hà Nội','CT@email','14'),
('NV2',N'Đức Cường','2000-6-11','Nam','2019-11-30',N'Hà Nội','DC@email','13'),
('NV3',N'Thuận An','2000-7-13','Nam','2018-6-5',N'Hà Nội','TA@email','17'),
('NV4',N'Thuận Nhân','2000-2-26','Nam','2020-9-14',N'Hà Nội','TT@email','19'),
('NV5',N'Minh Trí','2000-1-15','Nam','2018-4-3',N'Hà Nội','MT@email','04')

insert into SanPham values 
('SP1',N'Mướp','NCC1','LH1',1500,100,5,N'Nấu',''),
('SP2',N'Bí Đao','NCC1','LH1',1700,100,10,N'Nấu',''),
('SP3',N'Bánh Quy','NCC2','LH2',1250,100,51,N'Cắt',''),
('SP4',N'Bánh Gato','NCC2','LH2',1350,100,22,N'Cắt',''),
('SP5',N'Bánh Nướng','NCC2','LH2',1600,100,8,N'Cắt',''),
('SP6',N'Kẹo Que','NCC3','LH3',1750,100,1,N'Ăn',''),
('SP7',N'Kẹo Mút','NCC3','LH3',1900,100,40,N'Ăn',''),
('SP8',N'Kẹo Dẻo','NCC3','LH3',1860,100,72,N'Ăn','')

insert into DonHang values 
('KH1','NV5','2015-3-4','2015-10-14','2015-10-14','CTY1',N'Bình Thuận'),
('KH3','NV1','2015-4-4','2015-11-08','2015-11-09','CTY3',N'Đồng Tháp'),
('KH4','NV4','2015-7-14','2015-11-19','2015-11-18','CTY2',N'Lâm Đồng'),
('KH2','NV1','2015-6-14','2015-11-27','2015-11-27','CTY2',N'Hải Phòng'),
('KH5','NV3','2015-3-13','2015-12-01','2015-8-21','CTY2',N'Kon Tum'),
('KH1','NV2','2015-9-12','2015-12-24','2015-12-23','CTY1',N'Quảng Bình'),
('KH1','NV2','2015-7-12','2015-12-26','2015-11-14','CTY3',N'Trà Vinh'),
('KH5','NV4','2015-9-4','2015-12-27','2015-9-25','CTY3',N'Phú Yên'),
('KH3','NV5','2015-6-6','2015-12-28','2015-12-31','CTY3',N'Long An')

insert into SP_DonHang values 

(1,'SP1',15,2000,0.01),
(1,'SP2',15,2100,0.02),
(1,'SP3',15,2300,0.03),
(1,'SP4',15,2500,0.01),
(1,'SP5',15,1900,0.03),
(1,'SP8',15,1950,0.04),
(2,'SP7',15,2300,0.05),
(2,'SP2',15,2100,0.09),
(3,'SP3',15,1950,0.08),
(3,'SP4',15,2000,0.07),
(3,'SP1',15,2150,0.04),
(4,'SP2',15,1800,0.02),
(4,'SP3',15,2300,0.01),
(4,'SP5',15,2500,0.05),
(4,'SP8',15,2600,0.1),
(4,'SP7',15,2700,0.31),
(4,'SP6',15,2900,0.6),
(5,'SP1',15,2800,0.09),
(6,'SP2',15,2400,0.01),
(6,'SP3',15,2300,0.02),
(7,'SP6',15,2100,0.01),
(7,'SP7',15,2200,0.01),
(7,'SP8',15,2400,0.01),
(8,'SP4',15,2900,0.01),
(9,'SP2',15,2300,0.01)



SELECT * FROM dbo.CtyGiaoHang
SELECT * FROM dbo.DonHang
SELECT * FROM dbo.NhaCungCap
SELECT * FROM dbo.SP_DonHang
SELECT * FROM dbo.NhanVien
SELECT * FROM dbo.LoaiHang
SELECT * FROM dbo.KhachHang
SELECT * FROM dbo.SanPham

--Cau 1:
alter function f_ThanhTien (@iddh nvarchar(10), @idsp nvarchar(10))
returns int
as begin
declare @thanhtien int
select @thanhtien = soluong * DonGiaBan * (1-TyLeGiamGia)
from SP_DonHang
where idDH = @iddh and idSP = @idsp
return @thanhtien 
end

select dbo.f_ThanhTien ('1','SP1')

--Cau 2:
create function f_TongTien (@iddh nvarchar(10))
returns int
as begin
declare @tongtien int
select @tongtien = (select sum(soluong * DonGiaBan * (1-TyLeGiamGia)) from SP_DonHang where idDH = @iddh)
return @tongtien
end

select dbo.f_TongTien ('1')

--Cau 3:
create function f_SP_DonHang (@iddh nvarchar(10))
returns @cau3 table(idSP nvarchar(8), tensp nvarchar(255) , tenloaihang nvarchar(255), tencongtycungcap nvarchar(255),
 soluong int, dongiaban float, tylegiamgia float, thanhtien int)
as begin
insert into @cau3
select s.idSP, tensp,tenloaihang, tencongty ,soluong,dongiaban,tylegiamgia,thanhtien =dbo.f_ThanhTien(@iddh, sp.idSP)
from NhaCungCap ncc, SanPham s, LoaiHang l, SP_DonHang sp
where ncc.idNCC = s.idNCC and s.idLoaiHang = l.idLoaiHang and sp.idSP = s.idSP
return 
end

select * from f_SP_DonHang  ('1') 

--Cau 4:
create view v_ChiTietDonHang (IDDonHang, IDSanPham, TenSanPham, TenLoaiHang, TenCongTyCungCap, SoLuongBan, DonGiaNhap,
DonGiaBan, TyLeGiamGia, ThanhTienBan, TienLai)
as
select d.idDH, s.idSP,s.TenSP, l.TenLoaiHang, ncc.TenCongTy, sp.SoLuong, s.DonGiaNhap, sp.DonGiaBan, sp.TyLeGiamGia,
ThanhTienBan = dbo.f_ThanhTien (d.idDH, sp.idSP), TienLai = dbo.f_ThanhTien (d.idDH, sp.idSP) - sp.SoLuong*s.DonGiaNhap
from NhaCungCap ncc, SanPham s, LoaiHang l, SP_DonHang sp, DonHang d
where ncc.idNCC = s.idNCC and s.idLoaiHang = l.idLoaiHang and sp.idSP = s.idSP and d.idDH = sp.idDH       

select * from  v_ChiTietDonHang

--Cau 5:
 create view v_TongKetDonHang (IDDonhang, IDKhachHang, HoTenKhachHang, GioiTingKhachHang, IDNhanVien, HoTenNhanVien,
 NgayDatHang, NgayGiaohang, NgayYeuCauChuyen, IDCongTyGiaoHang, TenCongTyGiaoHang, SoMatHang, TongTienHoaDon,
 TongTienLai)
 as
 select d.idDH, k.idKH, k.HoTen, k.GioiTinh, n.idNV, n.HoTen, d.NgayDatHang, d.NgayGiaoHang, d.NgayYeuCauChuyen, c.idCty,
 c.TenCongTy,
 SoMatHang = COUNT(idsp) from SP_DonHang group by idDH,
 sum(dbo.f_ThanhTien (sp.idDH, sp.idSp))as TongTienHoaDon,
 sum (v_ChiTietDonHang.TienLai) as TongTienLai
 from KhachHang k, NhanVien n, DonHang d, CtyGiaoHang c, SP_DonHang sp
 where k.idKH = d.idKH and d.idNV = n.idNV and c.idCty = d.idCty and d.idDH = sp.idDH
 
 --Cau 6:
 --Cau 7:
 alter trigger cau7
 on LoaiHang for insert
 as
 begin
 if ((select COUNT(tenloaihang) from LoaiHang where TenLoaiHang = (select TenLoaiHang from inserted ))>=2)
 begin
	print N'Đã có tên loại hàng'
	rollback tran
 end
 end
 
 insert into LoaiHang values ('LH6',N'Bánh',N'Đi buôn')
 select * from LoaiHang
 
 --Cau 8:
 alter trigger cau8
 on LoaiHang for update
 as 
 if update(tenloaihang)
 begin
 if ((select tenloaihang from inserted) like (select tenloaihang from deleted))
 begin
 print N'Tên sau trùng tên trước'
 rollback tran
 end
 if ((select COUNT(tenloaihang) from LoaiHang where TenLoaiHang = (select TenLoaiHang from inserted ))>=2)
 begin
	print N'Đã có tên loại hàng'
	rollback tran
 end
 end
 
 update LoaiHang
 set TenLoaiHang = N'Bánh mỳ' where idLoaiHang = 'LH5'
 select * from LoaiHang
 
 --Cau 9:
 create trigger cau9
 on NhaCungCap for delete
 as
 begin
 update NhaCungCap set ConGiaoDich = 0 where idNCC = (select idNCC from deleted)
 update SanPham set NgungBan = 1 where idNCC = (select idNCC from deleted)
 end 
 
 
 
 
 
 
 
