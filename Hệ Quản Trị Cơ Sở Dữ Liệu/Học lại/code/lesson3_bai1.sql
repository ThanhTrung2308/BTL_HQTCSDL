
/*declare @ngaysinh as date
set @ngaysinh = '05/21/1999'

print N'Tôi sinh ngày ' + cast(datepart(dd,@ngaysinh) as char(2) )
+ N' Tháng ' + cast(datepart(mm,@ngaysinh) as char(2) ) + N' năm '
+ cast(datepart(yy,@ngaysinh) as char(5))*/

create database SQLSV

create table SinhVien
(
	masv int primary key,
	hoten nvarchar(50),
	malop nvarchar(50),
	gioitinh nvarchar(10),
	ngaysinh date,
	constraint KH_GT check (gioitinh = N'Nam' or gioitinh = N'Nữ')
)

insert into SinhVien values
(9,N'Nguyễn Văn kiên', N'TH4',N'Nam','01/08/1998'),
(2,N'Nguyễn Văn A', N'TH4',N'Nữ','01/08/2000'),
(3,N'Nguyễn Văn B', N'TH5',N'Nam','02/09/2000'),
(4,N'Nguyễn Văn C', N'TH5',N'Nữ','05/12/2000'),
(5,N'Nguyễn Văn D', N'TH6',N'Nam','03/06/2000'),
(6,N'Nguyễn Văn E', N'TH6',N'Nữ','04/08/2000'),
(7,N'Nguyễn Văn F', N'TH7',N'Nam','02/08/2000'),
(8,N'Nguyễn Văn G', N'TH7',N'Nữ','01/12/2000')

create table MonHoc
(
	mamh int primary key,
	tenmh nvarchar(50),
)

insert into MonHoc values
(1,'CSDL'),
(2,N'Toán'),(3,N'Văn'),
(4,N'Lập Trình'),
(5,N'Tiếng Anh')

create table Diem(
	masv int foreign key references SinhVien(masv),
	mamh int foreign key references MonHoc(mamh),
	diem float,
	lanth int
)


insert into Diem values
(6,1,9,2),(6,2,8,2),(6,3,1,3),(6,4,10,1),(6,5,5,2),
(1,1,9,1),(1,2,8,1),(1,3,1,2),(1,4,10,1),(1,5,5,2),
(1,1,2,2),(1,2,8,1),(1,3,1,2),(1,4,10,1),(1,5,5,2),
(3,1,8,1),(3,2,5.5,2),(3,3,1,1),(3,4,10,2),(3,5,5,3),
(2,1,8,2),(2,2,10,1),(2,3,5,1),(2,4,8.5,1),(2,5,9,1)

--cau1:
declare @SiSo as int
select @SiSo = count(hoten) from SinhVien where malop like N'TH4'

print N'Số SV của lớp TH4 là ' + convert(char(12), @SiSo)

--cau2
declare @SVnu as int
select @SVnu = count(hoten) from SinhVien where malop like N'TH4' and gioitinh like N'Nữ'

print N'Số SV nữ của lớp TH4 là ' + convert(char(12), @SVnu)

--cau3

declare @DiemCSDL as float
declare @XepLoai nvarchar(50)
select @DiemCSDL =  Diem.diem from SinhVien, Diem, MonHoc where SinhVien.masv = Diem.masv 
and SinhVien.hoten = N'Nguyễn Văn A' and MonHoc.mamh = Diem.mamh
and MonHoc.tenmh = N'CSDL'
--c1
if (@DiemCSDL <4)
	print N'Đạt Điểm F'
else if (@DiemCSDL <6.5)
	print N'Đạt điểm D'
else if (@DiemCSDL <7.5)
	print N'Đạt điểm C'
else if (@DiemCSDL <8.5)
	print N'Đạt điểm B'
else if(@DiemCSDL < 10)
	print N'Đạt điểm A'
--c2
select @XepLoai =(
	Case
		when @DiemCSDL < 4 then N'Đạt Điểm F'
		when @DiemCSDL < 6.5 then N'Đạt Điểm D'
		when @DiemCSDL < 7.5 then N'Đạt Điểm C'
		when @DiemCSDL < 8.5 then N'Đạt Điểm B'
		when @DiemCSDL < 10 then N'Đạt Điểm A'
End)
print @XepLoai



--cau4
declare @SVthang1 as int
select @SVthang1 = count(hoten) from SinhVien where datepart(mm,ngaysinh)  = 1

print N'Số SV sinh tháng 1 là ' + convert(char(12), @SVthang1)


DECLARE con_tro_sv CURSOR
DYNAMIC SCROLL 
FOR
	select * from SinhVien

OPEN con_tro_sv

DECLARE @soSV int;
SET @soSV = 0;

FETCH FIRST FROM con_tro_sv
WHILE (@@FETCH_STATUS = 0)
BEGIN
SET @soSV = @soSV + 1
FETCH NEXT FROM con_tro_sv
END

PRINT  N'Số sinh viên là: ' + cast(@soSV as char(4))
CLOSE con_tro_sv
DEALLOCATE con_tro_sv

--y2
DECLARE con_tro_sv CURSOR
DYNAMIC SCROLL 
FOR
SELECT SINHVIEN.masv,dbo.DIEM.Diem FROM dbo.SINHVIEN,dbo.DIEM WHERE hoten = N'Nguyễn Văn A' 
AND dbo.SINHVIEN.masv = Diem.MaSV and MaMH = 1
OPEN con_tro_sv
DECLARE @msv CHAR(5),@d FLOAT
FETCH NEXT  FROM con_tro_sv INTO @msv,@d
WHILE (@@FETCH_STATUS = 0)
BEGIN

PRINT N'Sinh vien A có mã sv là: ' + @msv +N'đạt điểm '  + CAST(@d AS CHAR(10))
FETCH NEXT  FROM con_tro_sv INTO @msv,@d
END 

CLOSE con_tro_sv
DEALLOCATE con_tro_sv


--VD1 về thủ tục k có tham số

create proc LISTVD1
as begin
select hoten, tenmh, diem from SinhVien, MonHoc, Diem
where SinhVien.masv  = Diem.masv and MonHoc.mamh = Diem.mamh
end

--gọi thủ tục
exec LISTVD1

--VD2 thủ tục có tham số đầu vào
--cho biết thông tin sinh viên của một lớp nếu biết mã lớp
create proc VD2 
@ml char(5)
as begin
if exists (select * from SinhVien where malop=@ml)
	select * from SinhVien where malop = @ml
else print N'class is not exists' +@ml
end
-- gọi thủ tục VD2
exec VD2 'TH4'

create proc VD3 
@tSV nvarchar(50), @tMH nvarchar(50)
as begin
if exists (select * from SinhVien,MonHoc,Diem where SinhVien.masv = Diem.masv 
and Diem.mamh = MonHoc.mamh and
SinhVien.hoten like @tSV and MonHoc.tenmh like @tMH)

	select * from SinhVien,MonHoc,Diem where SinhVien.masv = Diem.masv 
	and Diem.mamh = MonHoc.mamh and
	SinhVien.hoten like @tSV and MonHoc.tenmh like @tMH
else print N'Thông tin không tồn tại' 
end
-- gọi thủ tục VD3
exec VD3 N'Nguyễn Văn A' ,N'CSDLs'


create procedure sp_SV_Top
@tenMon nvarchar(50),
@maxDiem float OUTPUT,
@tenSV nvarchar(50) OUTPUT

as
Begin
declare @maMon int
select @maMon = MonHoc.mamh from MonHoc where MonHoc.tenmh like @tenMon

select @maxDiem = max(Diem.diem) from Diem where Diem.mamh = @maMon

select @tenSV =  SinhVien.hoten from SinhVien, Diem
where SinhVien.masv = Diem.masv
and Diem.diem = @maxDiem
and Diem.mamh = @maMon
end




declare @tenSV nvarchar(50), @diemcaonhat float
exec sp_SV_Top N'CSDL', @diemcaonhat OUTPUT, @tenSV OUTPUT
print @tenSV
print @diemcaonhat


--con trỏ
create procedure test
@Gioitinh nvarchar(10),
@dssv cursor varying output 
as
begin
set @dssv = cursor
for 
select*from SinhVien where Gioitinh = @Gioitinh
Open @dssv
end

declare @mytest cursor 
exec test N'Nữ',@dssv=@mytest output 
fetch next from @mytest
while(@@FETCH_STATUS = 0)
fetch next from @mytest
close @mytest
deallocate @mytest



--lesson4
--Câu1
--a
declare contro_sv cursor
dynamic scroll
for
	select * from SinhVien
open contro_sv;

declare @soSV int;
set @soSV = 0;
fetch first from contro_sv
while (@@FETCH_STATUS = 0)
	begin 
		set @soSV = @soSV +1;
		fetch next from contro_sv
	end
	print N'Số sv :' + cast(@soSV as char(2));
CLOSE contro_sv;
deallocate contro_sv;

--b
DECLARE diemtb CURSOR
DYNAMIC SCROLL 
FOR

SELECT dbo.SINHVIEN.hoten,AVG(dbo.DIEM.Diem) FROM dbo.SINHVIEN,dbo.DIEM WHERE dbo.SINHVIEN.masv = dbo.Diem.MaSV
GROUP BY dbo.SINHVIEN.masv,hoten 
OPEN diemtb
DECLARE @dtb FLOAT,@ten NVARCHAR(50)
FETCH NEXT  FROM diemtb INTO @ten,@dtb
WHILE (@@FETCH_STATUS = 0)
BEGIN
PRINT N'Sinh vien ' + @ten + N' có điểm trung bình là : ' + cast(@dtb AS CHAR(10))
FETCH NEXT  FROM diemtb INTO @ten,@dtb
END 

CLOSE diemtb
DEALLOCATE diemtb


--bai2
DECLARE diemtb CURSOR
DYNAMIC SCROLL 
FOR
SELECT dbo.SINHVIEN.hoten,AVG(dbo.DIEM.Diem) FROM dbo.SINHVIEN,dbo.DIEM WHERE dbo.SINHVIEN.masv = dbo.Diem.MaSV GROUP BY dbo.SINHVIEN.masv,hoten 

OPEN diemtb
DECLARE @dtb FLOAT,@ten NVARCHAR(50), @maxDiem float, @tenMax nvarchar(50)
set @maxDiem = 0
FETCH NEXT  FROM diemtb INTO @ten,@dtb
WHILE (@@FETCH_STATUS = 0)
BEGIN
if(@maxDiem<@dtb)
		begin
	set @maxDiem = @dtb
	set @tenMax = @ten
	end

FETCH NEXT  FROM diemtb INTO @ten,@dtb
END 
PRINT N'Sinh vien ' + @tenMax + N' có điểm cao nhất là : ' + cast(@maxDiem AS CHAR(10))

CLOSE diemtb
DEALLOCATE diemtb


--cau3
create proc sosv
@malop nvarchar(30),
@soSV int output
as
begin
declare contro_sv cursor
dynamic scroll
for
	select * from SinhVien where malop=@malop
open contro_sv;

set @soSV = 0;
fetch first from contro_sv
while (@@FETCH_STATUS = 0)
	begin 
		
		set @soSV = @soSV +1;
		fetch next from contro_sv
	end
	print 'Lop '+ @malop+' co so sv la: ' + cast(@soSV as char(4))
CLOSE contro_sv;
deallocate contro_sv;
end

declare @malop nvarchar(30),@soSV int

execute 'TH4',
		@soSV output

--cau1
create function sumSV(@tenLop nvarchar(30))
returns int
as
begin
	declare @SL int
	select @SL = COUNT(masv) from SinhVien
	return @SL
end

select malop from SinhVien sv where dbo.sumSV(malop) >dbo.sumSV(N'TH4')
--cau2
create function diemSV(@tenSV nvarchar(30))
returns float
as
begin
	declare @diemTB float
	select @diemTB = AVG(dbo.DIEM.Diem) FROM dbo.SINHVIEN,dbo.DIEM WHERE dbo.SINHVIEN.masv = dbo.Diem.MaSV 
	and dbo.SinhVien.hoten like @tenSV
GROUP BY dbo.SINHVIEN.masv,hoten 
	return @diemTB
end

select * from SINHVIEN,DIEM
where dbo.diemSV(SINHVIEN.hoten)>=8 

--cau3
create function slsv_thilai(@mamh char(10)) 
returns int
as begin 
	declare @sl int
	select @sl = count(masv) from Diem
	where Diem.mamh = @mamh and Diem.diem < 4

	return @sl
end

alter proc thilai
as begin
	select distinct  Diem.mamh, tenmh from Diem, MonHoc
	where MonHoc.mamh = Diem.mamh and dbo.slsv_thilai(Diem.mamh) = 0
end

exec thilai


--cau4
CREATE FUNCTION sinhvien_lop()
RETURNS @bien TABLE (malop NCHAR(5),sosv int)
AS BEGIN
       INSERT INTO @bien
	   SELECT malop,COUNT(masv)
	   FROM SINHVIEN
	   GROUP BY malop
	   RETURN 
   END

   select * from sinhvien_lop()

DECLARE @max INT;
SELECT @max = MAX(sosv) FROM sinhvien_lop();

SELECT * FROM dbo.sinhvien_lop() WHERE sosv = @max

--cau5
declare @min int
select @min = min(select count(HoTen) from dbo.BangSV(N'CSDL'))






create function DSSV_MH(@tenMon nvarchar(30))
 returns @bien TABLE(MaSV int, HoTen nvarchar(30))
 as
 begin
	insert into @bien
	select SINHVIEN.MaSV,SINHVIEN.HoTen
	from SINHVIEN, DIEM, MONHOC
	where SINHVIEN.MaSV = DIEM.MaSV
	and DIEM.MaMH = MONHOC.MaMH
	and MONHOC.TenMH = @tenMon
	return
end
select * from DSSV_MH(N'CSDL')


-----------------------------
--TH4-c1
DECLARE con_tro_sv CURSOR
DYNAMIC SCROLL 
FOR
	select malop,COUNT(masv) from SinhVien group by malop

OPEN con_tro_sv

DECLARE @soSV int, @malop nvarchar(10), @malopMax nvarchar(10), @soSVMax int;

FETCH FIRST FROM con_tro_sv into @malop, @soSV
set @soSVMax = 0
WHILE (@@FETCH_STATUS = 0)
BEGIN
if(@soSVMax<@soSV)
		begin
	set @soSVMax = @soSV
	set @malopMax = @malop
	end
PRINT  N'Lớp ' +cast(@malop as nvarchar(10)) +  N' Số sinh viên là: ' + cast(@soSV as char(4))
FETCH NEXT FROM con_tro_sv into @malop, @soSV
END
PRINT  N'Lớp ' +cast(@malopMax as nvarchar(10)) +  N' Số sinh viên đông nhất là là: ' + cast(@soSVMax as char(4))
CLOSE con_tro_sv
DEALLOCATE con_tro_sv

--TH4--c2

CREATE FUNCTION sv_dtb(@maSV int)
RETURNs int
AS BEGIN
 DECLARE @dtb INT;
 SELECT @dtb = AVG(Diem) FROM DIEM,SINHVIEN
 WHERE SINHVIEN.MaSV=DIEM.MaSV
 and SINHVIEN.MaSV=@maSV
 RETURN @dtb
END

SELECT dbo.sv_dtb(8)

--TH4--c3
create view hs_gioi(tensv,diemtb)
as
select hoten, dbo.sv_dtb(masv) as diemtb from SinhVien where dbo.sv_dtb(masv) > 5.0

select * from hs_gioi

--TH4--4a
Alter FUNCTION svthilai()
RETURNS @bang TABLE(monhoc NCHAR(5),sosv int)
AS
BEGIN
   INSERT INTO @bang
   SELECT dbo.MONHOC.TenMH,COUNT(dbo.Diem.MaSV)
   FROM dbo.MONHOC,dbo.Diem 
   WHERE dbo.MONHOC.MaMH = dbo.Diem.MaMH AND dbo.Diem.Diem < 4
   GROUP BY dbo.Diem.MaMH,TenMH
   return
END
----
SELECT * FROM dbo.svthilai() WHERE
sosv = (SELECT MIN(sosv) FROM dbo.svthilai())

--TH4--5
CREATE PROCEDURE hocbong
@masv int
AS 
BEGIN
DECLARE @dtb FLOAT
SELECT @dtb = AVG(Diem) FROM dbo.DIEM
WHERE dbo.DIEM.maSV = @masv
IF(@dtb > 8.5)
PRINT N' sinh viên đat học bổng 2000000'
ELSE IF(7 < @dtb)
PRINT N' sinh viên đat học bổng 1000000'
ELSE 
PRINT N' sinh viên không đat học bổng '
END

EXECUTE dbo.hocbong 1


	

