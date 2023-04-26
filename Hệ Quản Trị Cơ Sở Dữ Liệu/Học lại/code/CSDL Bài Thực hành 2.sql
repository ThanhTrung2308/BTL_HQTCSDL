-- xoá CSDL QLKH (nếu có)
-- tạo thư mục BT SQL trong ổ D
-- Chạy phần này đầu tiên
Create database QLKH
on primary
(
	name = QLKH,
	filename = 'D:\QLKH.mdf',
	size = 10MB,
	maxsize = Unlimited,
	filegrowth = 2MB
)
log on
(
name = QLKH_log,
	filename = 'D:\QLKH_log.ldf',
	size = 5MB,
	maxsize = Unlimited,
	filegrowth = 1MB
)
-- Chọn CSDL QLKH (ctrl + u)
-- Bôi đen từ đoạn này đến hết rồi chạy
create table KhachHang 
(
	idKH int not null primary key identity(1,1),
	HoTen nvarchar(255),
	GioiTinh nvarchar(255) ,
	DiaChi nvarchar(255),
	Email nvarchar(255) unique,
	SDT nvarchar(255),
	check (GioiTinh in ('Nam','Nu')),
	 check (Email like ('%@%'))
)

insert into KhachHang values
(N'Tấn Phong','Nam',N'Bình Thuận','test1@mail','115'),
(N'Thiên Ân','Nu',N'Đồng Tháp','awan45@li','116'),
(N'Minh Anh','Nam',N'Lâm Đồng','ma123@tu','117'),
(N'Gia Huy','nu',N'Phú Thọ','git@gg','118'),
(N'Minh Quân','Nam',N'Hà Nội','sql@home','119')

create table SanPham 
(	
	idSP int identity (1,1) primary key,
	TenSP nvarchar(255) unique,
	MoTa nvarchar(255),
	DonGia float
)

insert into SanPham values
(N'Kẹo','Dung de an',5000),
(N'Nước Ngọt','Dung de uong',10000),
(N'Bánh','Dung de an',25000),
(N'Gia vị','Dung de an',8000),
(N'Trái cây','Dung de ban',15000)


create table DonHang 
(
	idDH int not null primary key,
	idKH int not null foreign key references KhachHang(idKH),
	NgayDatHang date,
	TongTien float
)

 insert into DonHang values 
 (1001,1,'8-25-2000',0),
 (1002,2,'5-26-2000',0),
 (1003,3,'8-14-2000',0),
 (1004,1,'6-2-2000',0),
 (1005,2,'3-2-2000',0)



 create table SP_DonHang
(
	idDH int foreign key references DonHang(idDH),
	idSP int foreign key references SanPham(idSP),
	SoLuong int,
	ThanhTien float,
	primary key (idDH,idSP)
)

insert into SP_DonHang values 
(1001,1,5,0),
(1001,2,2,0),
(1001,3,4,0),
(1001,4,10,0),
(1002,2,7,0),
(1002,3,8,0),
(1004,1,9,0),
(1004,5,13,0),
(1003,4,6,0),
(1005,1,9,0)

 select * from KhachHang
 select * from SanPham
 select * from DonHang
 select * from SP_DonHang

 create proc TH2_cau1
 as begin
 --nối 2 bảng
 update sp_donhang
 set thanhtien=sp_donhang.soluong*sanpham.dongia from sanpham
 where sp_donhang.idsp=sanpham.idsp
 end

 -- sử dụng select lồng nhau
 update sp_donhang
 set thanhtien=soluong* (select DonGia from SanPham, SP_DonHang
 where SanPham.idSP=SP_DonHang.idSP)
 
 --cau2
create procedure sp_TongTien
as begin
update DonHang
set TongTien=(select sum(spdh.ThanhTien)from SP_DonHang spdh group by(idDH) having spdh.idDH=DonHang.idDH)
end
execute sp_TongTien


exec sp_TongTien

--cau3

create proc sp_ThuNhap 
@nbt date, @nkt date
as begin
select * from DonHang where DonHang.NgayDatHang BETWEEN @nbt and @nkt 
end

exec sp_ThuNhap '05-10-2000', '08-29-2000'

--cau4
create procedure sp_NgayTrongTuan 
@ngaybatky date
as
begin
print DATEPART(weekday, @ngaybatky)
end

exec sp_NgayTrongTuan '3-2-2000'

--cau5
create procedure sp_ThongKe
as select spdh.IDDonHang,

sum(case month(NgayDatHang)when 0 then spdh.IDDonHang  else 0 end)as ThuHai,
sum(case month(ngaydathang )when 1 then spdh.IDDonHang else 0 end)as ThuBa,
sum(case month(ngaydathang )when 2 then spdh.IDDonHang else 0 end)as ThuTu,
sum(case month(ngaydathang )when 3 then spdh.IDDonHang else 0 end)as ThuNam,
sum(case month(ngaydathang )when 5 then spdh.IDDonHang else 0 end)as ThuBay,
sum(case month(ngaydathang )when 6 then spdh.IDDonHang else 0 end)as ChuNhat
from (DonHang as dh inner join SP_DonHang as spdh on dh.IDDonHang=spdh.IDDonHang)
inner join SanPham as sp on sp.IDSanPham=spdh.IDSanPham
group by spdh.IDDonHang
execute sp_ThongKe

--cau6
create procedure sp_SLSP
@TenSP nvarchar(50)
as
select SanPham.idSP,SanPham.TenSP,
SUM(SP_DonHang.SoLuong)AS 'Tong So Luong DA BAN'
from SanPham left join SP_DonHang
on SanPham.IDSanPham=SP_DonHang.IDSanPham
where SanPham.TenSP=@TenSP
group by SanPham.IDSanPham,TenSP

--ham
