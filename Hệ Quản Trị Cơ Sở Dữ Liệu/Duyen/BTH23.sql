--Cau1 
create proc sp_ThanhTien
as begin 
	update Sp_DonHang
	set ThanhTien=SoLuong*(select DonGia from SanPham where SanPham.idSP=Sp_DonHang.idSP);
end
exec sp_ThanhTien;
--Cau 2
create proc sp_TongTien
as begin
	update DonHang
	set Tongtien=(select sum(ThanhTien) from Sp_DonHang where Sp_DonHang.idDH=DonHang.idDH);
end
exec sp_TongTien
--Cau 3
create proc sp_ThuNhap @NgayDau date, @NgayCuoi date, @KQ float out
as begin
	select @KQ= sum(TongTien) from DonHang where NgayDatHang between @NgayDau and @NgayCuoi;
end
declare @TongTien1 float, @TongTien2 float;
exec sp_ThuNhap'2000-05-26','2000-08-14',@TongTien1 out;
exec sp_ThuNhap'2000-03-02','2000-08-25',@TongTien2 out;
if(@TongTien1>@TongTien2)
	print @TongTien1
else
	print @TongTien2
--Cau 4
create proc sp_NgayTrongTuan
@Ngay date
as begin
	select(
	case datepart(weekday,@Ngay)
	when 1 then N'Chủ Nhật'
	when 2 then N'Thứ hai'
	when 3 then N'Thứ ba'
	when 4 then N'Thứ tư'
	when 5 then N'Thứ năm'
	when 6 then N'Thứ sáu'
	when 7 then N'Thứ bảy'
	end
	)
end
exec sp_NgayTrongTuan'2020-09-30';
--Câu 5
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
--Câu 6
create proc sp_SLSP
@Ten nvarchar(30)
as begin
 select sum(SoLuong) from SP_DonHang where idSP=(
 select idSP from SanPham where SanPham.TenSP=@Ten)
end
exec sp_SLSP N'Gia vị';
--Câu 7
create proc sp_SPCao 
@So int, @curSP cursor varying out
as begin
set @curSP=cursor
for 
select distinct TenSP from SP_DonHang, SanPham where SP_DonHang.idSP=SanPham.idSP
and SP_DonHang.idSP in (select  idSP from SP_DonHang  group by idSP  having sum(SP_DonHang.SoLuong) > @So)
open @curSP
end
declare @myCursor cursor
exec sp_SPCao 4,@curSP=@myCursor out
fetch next from @myCursor
while(@@FETCH_STATUS=0)
fetch next from @myCursor
close @myCursor
deallocate @myCursor

