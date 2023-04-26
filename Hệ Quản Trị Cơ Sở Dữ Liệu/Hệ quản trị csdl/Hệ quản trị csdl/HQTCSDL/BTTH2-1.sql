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

 --1
 create proc sp_ThanhTien
 as begin 
 update SP_DonHang
 set ThanhTien = SoLuong * (select DonGia from SanPham where SP_DonHang.idSP = SanPham.idSP);
 end
 exec sp_ThanhTien
 --select * from DonHang
 --drop proc TongTien
 --2
  create proc sp_TongTien
 as begin 
 update DonHang
 set TongTien =  (select Sum(ThanhTien)From SP_DonHang where SP_DonHang.idDH = DonHang.idDH )
 end
 exec sp_TongTien
 --3
create proc sp_ThuNhap
@Ngaydau date, 
@ngaycuoi date,
@KQ float output
 as begin 
 select @KQ = sum( TongTien)  from DonHang where NgayDatHang between @Ngaydau and @ngaycuoi
 end
 go
 declare @Tong1 float , @Tong2 float 
 exec sp_ThuNhap '2000-08-14', '2000-08-25', @Tong1 output
 exec sp_ThuNhap '2000-05-26', '2000-08-25', @Tong2 output
 if(@Tong1 > @Tong2)
	 print N'Thu Nhập: ' + cast(@Tong1 as char(10))
else 
	print N'Thu Nhập: ' + cast(@Tong2 as char(10))
go
 --select * from DonHang
 --drop proc sp_ThuNhap

 --4
 create proc sp_NgayTrongTuan
 @ngay date
 as begin
 select datename(dw, @ngay) as N'Ngày Trong Tuần'
 end
 --
 create proc sp_NgayTrongTuan_1
 @ngay date
 as begin
 select (case  DATEPART(weekday, @ngay)
			when 1 then N'Chủ Nhật'
			when 2 then N'Thứ Hai'
			when 3 then N'Thứ Ba'
			when 4 then N'Thứ Tư'
			when 5 then N'Thứ Năm'
			when 6 then N'Thứ Sáu'
			when 7 then N'Thứ Bảy'
			end )
 end
 exec sp_NgayTrongTuan '2020-09-30'

 --5
 create proc sp_ThongKe
 as begin 
	 declare cur_Tk cursor
	 scroll
	 for
	 select NgayDatHang from DonHang
	 Open cur_Tk ;
	 declare @NgayTrongTuan date, @Thu2 Float, @Thu3 Float, @Thu4 Float, @Thu5 Float, @Thu6 Float, @Thu7 Float, @CN Float
	 set @Thu2 = 0; set @Thu3 = 0; set @Thu4 = 0; set @Thu5 = 0; set @Thu6 = 0; set @Thu7 = 0; set @CN = 0
	 fetch first from cur_Tk into @NgayTrongTuan
	 while (@@FETCH_STATUS = 0)
	 begin 
	 if(datename(dw,@NgayTrongTuan) = 'Monday')
		 set @Thu2 = @Thu2 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Tuesday')
		set @Thu3 = @Thu3 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Wednesday')
		set @Thu4 = @Thu4 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Thursday')
		set @Thu5 = @Thu5 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Friday')
		set @Thu6 = @Thu6 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Saturday')
		set @Thu7 = @Thu7 + 1
	 if(datename(dw,@NgayTrongTuan) = 'Sunday')
		set @CN = @CN + 1
		fetch next from cur_Tk into @NgayTrongTuan
	 end
	 
	 print N'Thứ Hai: ' + cast(@Thu2 as char(5))
	 print N'Thứ Ba: ' + cast(@Thu3 as char(5))
	 print N'Thứ Tư: ' + cast(@Thu4 as char(5))
	 print N'Thứ Năm: ' + cast(@Thu5 as char(5))
	 print N'Thứ Sáu: ' + cast(@Thu6 as char(5))
	 print N'Thứ Bảy: ' + cast(@Thu7 as char(5))
	 print N'Chủ Nhật: ' + cast(@CN as char(5))
	 close cur_Tk
	 deallocate cur_Tk
	end
exec sp_ThongKe
--drop proc sp_SPCAO
--6
create proc sp_SLSP
@Tensp nvarchar(10)
as begin
select sum(SoLuong) from SP_DonHang, SanPham where SanPham.idSP = SP_DonHang.idSP and SanPham.TenSP = @Tensp
end
exec sp_SLSP N'Gia vị'

--7
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

create proc cursor_test
as begin
declare contro cursor
scroll
for
select * from KhachHang
open cursor_test
declare @SoKH int
fetch first from cursor_test
while(@@FETCH_STATUS =0)
begin
set @SoKH = @SoKH +1
fetch next from cursor_test
end
print N'So kh' + cast(@SoKH as char(5))
close cursor_test
deallocate cursor_test
end
exec cursor_test

alter proc Contro
as begin
declare contro cursor
scroll
for
select * from sinhvien
open contro;
declare @SoSV int;
set @SoSV = 0;
fetch first from contro
while(@@FETCH_STATUS = 0)
begin
set @SoSV = @SoSV +1
fetch next from contro
end
print N'SoSV ' + cast(@SoSV as char(5))
close contro
deallocate contro
end
exec Contro
