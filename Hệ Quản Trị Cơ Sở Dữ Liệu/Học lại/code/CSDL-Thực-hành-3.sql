-- xoá CSDL QLKH (nếu có)
drop database QLKH
-- tạo thư mục BT SQL trong ổ D
-- Chạy phần này đầu tiên
Create database QLBH
on primary
(
	name = QLKH,
	filename = 'D:\BT SQL\QLKH.mdf',
	size = 10MB,
	maxsize = Unlimited,
	filegrowth = 2MB
)
log on
(
name = QLKH_log,
	filename = 'D:\BT SQL\QLKH_log.ldf',
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

select*from NhaCungCap
select*from LoaiHang
select*from CtyGiaoHang
select*from NhanVien
select*from DonHang
select*from SP_DonHang
select*from KhachHang
select*from SanPham
--c1--
create function f_ThanhTien (@idDonHang int, @idSanPham nvarchar(8))
returns float
as
begin
	declare @thanhTien float
	select @thanhTien = SoLuong*DonGiaBan *(1-TyLeGiamGia)
	from SP_DonHang where idDH = @idDonHang and idSP = @idSanPham
	return @thanhTien
end


print dbo.f_ThanhTien(1, N'SP3')

--2
create function f_TongTien (@idDonHang int)
returns float
as begin 
	declare @TongTien float
	select @TongTien=sum(dbo.f_ThanhTien(@idDonHang, idSP)) from SP_DonHang
	where idDH = @idDonHang group by idDH
	return @tongtien
end
print dbo.f_TongTien(1)
--3

alter function f_SP_DonHang (@idDonHang int)
returns @ctsp table(IDSanPham nvarchar(8), TenLoaiHang nvarchar(255), TenCongTyCungCap nvarchar(255),
SoLuong int, DonGiaBan float,TyLeGiamGia float,ThanhTien float)
as begin 
	insert into @ctsp
	select SanPham.idSP, SanPham.TenSP,NhaCungCap.TenCongTy,SP_DonHang.SoLuong,SP_DonHang.DonGiaBan,
					SP_DonHang.TyLeGiamGia,dbo.f_ThanhTien(@idDonHang,SP_DonHang.idSP)
	from SanPham,SP_DonHang,NhaCungCap,DonHang
	where SanPham.idSP=SP_DonHang.idSP and SanPham.idNCC=NhaCungCap.idNCC and SP_DonHang.idDH=DonHang.idDH 
			and SP_DonHang.idDH=@idDonHang
return
end

select * from f_SP_DonHang (2)
	
--bai1:create view MatHang(MaHang,TenHang,MaCongTy,
--TenCongTyCungCap,MaLoaiHang,TenLoaiHang,SoLuong,DonViTinh,GiaHang)-
create view _MatHang (MaHang, TenHang,MaCongTy, TenCongTyCungCap, MaLoaiHang,
TenLoaiHang, SoLuong, DonViTinh, GiaHang)
as
select sanpham.idSP, TenSP, Nhacungcap.idNCC, TenCongTy, LoaiHang.idLoaiHang, TenLoaiHang, SoLuong, null, DonGiaBan
from LoaiHang, NhaCungCap, SanPham, SP_DonHang
where sanpham.idSP = SP_DonHang.idSP
and NhaCungCap.idNCC = SanPham. idNCC
and LoaiHang.idLoaiHang = SanPham.idLoaiHang


select * from _MatHang
--b2:tao view View_DonDatHang(SoHoaDon,MaKH,TenctyKH,Hotennv,
--Ngaydathang,Ngaygiao,ngaychuyen,noigiao,MaHang,tenHang,
--sl,giaban,mucgiamgia)

create view view_đondathang2(sohoadon, makhachhang, tencongtykhachhang, hovatennhanvien, ngaydathang, ngaygiaohang, ngaychuyenhang, noigiaohang, mahang, tenhang, soluong, giaban, mucgiamgia)
as
select DonHang.idDH,idKH,idCTy, NhanVien.HoTen, DonHang.NgayDatHang,NgayGiaoHang, NgayYeuCauChuyen, DiaChiGiaoHang, SanPham.idSP, TenSP, SP_DonHang.SoLuong, DonGiaBan, TyLeGiamGia
from DonHang,NhanVien,SanPham,SP_DonHang
where DonHang.idDH=SP_DonHang.idDH and NhanVien.idNV=DonHang.idNV and SanPham.idSP=SP_DonHang.idSP
--c4:
create view v_ChiTietDonHang( IDDonHang , IDSanPhamn, TenSanPham , TenLoaiHang, TenCTCC, SoLuongBan, DonGiaNhap , DonGiaBan , 
								TyLeGiamGia, ThanTienBan, TienLai )
as 
	select SP_DonHang.idDH, Sanpham.idSP, SanPham.TenSP, LoaiHang.TenLoaiHang, NhaCungCap.TenCongTy, SP_DonHang.SoLuong, 
	SanPham.DonGiaNhap, SP_DonHang.DonGiaBan, SP_DonHang.TyLeGiamGia,  dbo.f_ThanhTien(DonHang.IDDH,SP_DonHang.idSP), 
	(dbo.f_ThanhTien(DonHang.IDDH,SP_DonHang.idSP)-(SanPham.DonGiaNhap*SP_DonHang.SoLuong))
	from SanPham,SP_DonHang,NhaCungCap,DonHang,LoaiHang
	where SanPham.idSP=SP_DonHang.idSP and SanPham.idNCC=NhaCungCap.idNCC and SP_DonHang.idDH=DonHang.idDH 
			and LoaiHang.idLoaiHang=SanPham.idLoaiHang
select * from v_ChiTietDonHang
--c5:
create VIEW cau5
AS
SELECT dbo.SP_DonHang.idDH,dbo.DonHang.idKH ,
dbo.KhachHang.HoTen,dbo.KhachHang.GioiTinh,DonHang.idNV,NhanVien.HoTen AS tennv,

dbo.DonHang.NgayDatHang,dbo.DonHang.NgayGiaoHang,dbo.DonHang.NgayYeuCauChuyen,CtyGiaoHang.idCty,CtyGiaoHang.TenCongTy,
COUNT(dbo.SP_DonHang.idSP) AS somathang,dbo.f_tongtien(dbo.SP_DonHang.idDH) AS tongtien


,dbo.f_tongtien(dbo.SP_DonHang.idDH) - SUM(SoLuong * SanPham.DonGiaNhap) AS tienlai

FROM dbo.SP_DonHang,dbo.DonHang,dbo.KhachHang,NhanVien,CtyGiaoHang,dbo.SanPham
WHERE NhanVien.idNV = DonHang.idNV AND DonHang.idCty = CtyGiaoHang.idCty AND dbo.SP_DonHang.idDH = dbo.DonHang.idDH
AND dbo.DonHang.idKH = dbo.KhachHang.idKH AND dbo.SanPham.idSP = dbo.SP_DonHang.idSP
GROUP BY dbo.SP_DonHang.idDH,dbo.DonHang.idKH ,dbo.KhachHang.HoTen,dbo.KhachHang.GioiTinh,DonHang.idNV,NhanVien.HoTen,
dbo.DonHang.NgayDatHang,dbo.DonHang.NgayGiaoHang,dbo.DonHang.NgayYeuCauChuyen,CtyGiaoHang.idCty,CtyGiaoHang.TenCongTy

SELECT * FROM cau5
--c6:

--c7:	
create  trigger insert_trigger_mathang
on LoaiHang
for insert
as
if (select count(*) from  LoaiHang where TenLoaiHang = (select TenLoaiHang from inserted)) >1
	begin
	print N'Loại mặt hàng đã tồn tại'
	rollback tran
	end
else print N'Them thanh cong'

insert into LoaiHang values
('LH4',N'Rau củ quả',N'Nhà  trồng')
insert into LoaiHang values
('LH4',N'Hải sản',N'Nhà nuôi')

select * from LoaiHang
--c8:
create trigger check_update_name_LoaiHang
on LOAIHANG
for update 
as
if  ((select TenLoaihang from inserted) = (select TenLoaiHang from deleted )) or ((select TenLoaihang from inserted ) in (select TenLoaiHang from LoaiHang ))
	begin
	rollback tran 
	print N'Tên SP sau khi sửa không được trùng'
	end
else print N'Sứa tên SP thành công'
--c9:
create trigger cau9
On NhaCungCap
instead of delete
as begin 
update NhaCungCap set ConGiaoDich = 0 where idNCC = (select idNCC from deleted)
update SanPham set NgungBan = 1 where idNCC = (select idNCC from deleted)
end