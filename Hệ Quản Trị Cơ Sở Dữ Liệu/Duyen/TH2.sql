-- xoá CSDL QLKH (nếu có)
-- tạo thư mục BT SQL trong ổ D
-- Chạy phần này đầu tiên
Create database QLKH
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
 
 --Cau 1:
create proc sp_ThanhTien
as begin
update SP_DonHang
set thanhtien = soluong * (select dongia from SANPHAM p  where p.idSP =SP_DonHang.idSP)
end

exec  sp_ThanhTien;
select * from SP_DonHang

--Cau 2:
create proc sp_TongTien
as begin
update DONHANG
set tongtien = (select SUM(thanhtien) from SP_DonHang sp where sp.idDH = DONHANG.idDH)
end

exec sp_TongTien;
select * from DonHang

--Cau 3:
create proc sp_ThuNhap
@ngaydau date, @ngaycuoi date,
@thunhap float out
as begin
select @thunhap = sum(tongtien) from Donhang where NgayDatHang between @ngaydau and @ngaycuoi
end

declare @kq1 int, @kq2 int
exec sp_ThuNhap '2000-05-26','2000-06-02', @kq1 out;
exec sp_ThuNhap '2000-03-02','2000-08-14', @kq2 out;

if (@kq1 > @kq2)
	print N'Thu nhập cao hơn là: ' + cast (@kq1 as char (50))
else
	print N'Thu nhập cao hơn là: ' + cast (@kq2 as char (50))

--Cau 4:
alter proc sp_NgayTrongTuan
@ngay date
as begin
select (case (DATEPART(WEEKDAY, @ngay))
 when 2 then  N'Thứ hai'
 when 3 then N'Thứ ba'
 when 4 then N'Thứ tư'
 when 5 then N'Thứ năm'
 when 6 then N'Thứ sáu'
 when 7 then N'Thứ bảy'
 when 1 then N'Chủ nhật'
 end)
end

exec sp_NgayTrongTuan '2020-09-30'

--Cau 5:
create proc sp_ThongKe
as begin
	declare cur_Thongke cursor
	scroll
	for
	select NgayDatHang from DonHang
	open cur_Thongke
	declare @ThutrongTuan date, @Thu2 float, @Thu3 float, @Thu4 float, @Thu5 float, @Thu6 float, @Thu7 float, @CN float
	set @Thu2=0;set @Thu3=0; set @Thu4=0; set @Thu5=0; set @Thu6=0; set @Thu7=0; set @CN=0;
	fetch first from cur_Thongke into @ThuTrongTuan
	while(@@FETCH_STATUS=0)
	begin
		if(datename(dw,@ThutrongTuan)='Monday')
			set @Thu2=@Thu2+1
		if(datename(dw,@ThutrongTuan)='Tuesday')
			set @Thu3=@Thu3+1
		if(datename(dw,@ThutrongTuan)='Wednesday')
			set @Thu4=@Thu4+1
		if(datename(dw,@ThutrongTuan)='Thursday')
			set @Thu5=@Thu5+1
		if(datename(dw,@ThutrongTuan)='Friday')
			set @Thu6=@Thu6+1
		if(datename(dw,@ThutrongTuan)='Saturday')
			set @Thu7=@Thu7+1
		if(datename(dw,@ThutrongTuan)='Sunday')
			set @CN=@CN+1
		fetch next from cur_Thongke into @ThuTrongTuan
	end
		close cur_Thongke
		deallocate cur_Thongke
	print N'Thứ hai ' + cast(@Thu2 as char(10))
	print N'Thứ ba ' + cast(@Thu3 as char(10))
	print N'Thứ tư ' + cast(@Thu4 as char(10))
	print N'Thứ năm ' + cast(@Thu5 as char(10))
	print N'Thứ sáu ' + cast(@Thu6 as char(10))
	print N'Thứ bảy ' + cast(@Thu7 as char(10))
	print N'Chủ nhật ' + cast(@CN as char(10))
end
exec sp_ThongKe;

--Cau 6:
create proc sp_SLSP
@tensp nvarchar(50), @slsp int out
as begin 
declare @idsp nvarchar
select @idsp =( select idSP from SanPham where TenSP = @tensp)
select @slsp = Sum(SoLuong) from SP_DonHang where idSP = @idsp
end

declare @tsp nvarchar(50), @sl_sp int 
exec sp_SLSP N'Gia vị', @sl_sp out;
print @sl_sp

--Cau 7:
create proc sp_SPCAO
@Solg int,
@ds cursor varying output
as begin
set @ds = cursor
for
select distinct TenSP from SP_DonHang, SanPham where SP_DonHang.idSP = SanPham.idSP 
and SP_DonHang.idSP in( select idSP from SP_DonHang group by idSP having SUM(SP_DonHang.SoLuong) > @Solg)
Open @ds
end 

declare @myCS cursor
exec sp_SPCAO 10, @ds = @myCS output
fetch next from @myCS
while(@@FETCH_STATUS = 0)
	fetch next from @myCS
close @myCS
deallocate @myCS

--Cau 8:

