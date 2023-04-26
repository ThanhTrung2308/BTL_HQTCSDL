drop database QLD

create database QLD;
use  QLD;
go
create table SinhVien
(
	masv int  not null primary key,
	hoten	nvarchar(30),	
	malop int ,
	gioitinh nvarchar(3),
	ngaysinh date
)

go
create table MonHoc
(
	mamh int  not null primary key,
	tenmh nvarchar(30)
)

go
create table Diem
(
	masv int,
	mamh int,
	diem int,
	primary key (masv,mamh),
	foreign key (masv) references SinhVien(masv),
	foreign key (mamh) references MonHoc(mamh)
)
go

alter table Diem add diem float;
alter table Diem add lanthi int;

insert into SinhVien(masv, hoten, malop, gioitinh, ngaysinh) values 
	(1,N'Phạm Trường Giang',60,'Nam','1999-12-27'),
	(2,N'Trần Quang Đức',60,'Nam','1999-5-21'),
	(3,N'Cao Văn Cường',60,'Nam','1999-2-7'),
	(4,N'Trần Thùy Linh',60,'Nữ','1999-10-11'),
	(5,N'Nguyễn Thị Diệu Hương',60,'Nữ','1999-6-25');


insert into MonHoc(mamh, tenmh) values 
	(1,'CSDL'),
	(2,'HQTCSDL'),
	(3,'CN WEB');

insert into Diem(masv, mamh, diem) values
	(1,1,9),
	(1,2,9),
	(1,3,9),
	(2,1,8),
	(3,2,6);


-- câu 1
declare @soSV int;
select @soSV = count(masv) 
from SinhVien
where malop=60;

print N'Số Sinh Viên của lớp 60TH là :' + convert(char(3),@soSV);

-- câu 2
declare @soSV int;
select @soSV = count(masv) 
from SinhVien
where malop=60 and gioitinh='Nữ';

print N'Số Sinh Viên Nữ của lớp 60TH là :' + convert(char(3),@soSV);

-- câu 3
/*cách 1*/
declare @DiemThi real;
select @DiemThi = diem
from Diem , SinhVien
where SinhVien.masv=Diem.masv and SinhVien.hoten=N'Phạm Trường Giang' ;
declare @XepLoai nvarchar(20);

select @XepLoai =
(CASE	
	when @DiemThi< 4 then N'Đạt điểm F'
	when @DiemThi >= 4 and @DiemThi<6.5 then N'Đạt điểm D'
	when @DiemThi>=6.5 and @DiemThi<7.5 then N'Đạt điểm C'
	when @DiemThi>=7.5 and @DiemThi<8.5 then N'Đạt điểm B'
	when @DiemThi>=8.5 then N'Đạt điểm A'
End)

print N'Sinh Viên Phạm Trường Giang :' + @XepLoai;

/*cách 2*/
declare @DiemThi real;
select @DiemThi = diem
from Diem , SinhVien
where SinhVien.masv=Diem.masv and SinhVien.hoten=N'Phạm Trường Giang' ;

if (@DiemThi <4)
	print N'Sinh viên Phạm Trường Giang Đạt điểm F'
else if (@DiemThi <6.5)
	print N'Sinh viên Phạm Trường Giang Đạt điểm D'
else if (@DiemThi <7.5)
	print N'Sinh viên Phạm Trường Giang Đạt điểm C'
else if (@DiemThi <8.5)
	print N'Sinh viên Phạm Trường Giang Đạt điểm B'
else 
	print N'Sinh viên Phạm Trường Giang Đạt điểm A';

-- câu 4
declare @SVthang1 as int
select @SVthang1 = count(masv) from SinhVien where datepart(mm,ngaysinh) = 1

print N'Số SV sinh tháng 1 là : ' + convert(char(2), @SVthang1)

--------- ví dụ biến với while 
declare @biendem int;
set @biendem =1;
while (@biendem <10)
	begin
		print N'Số hiện tại:' + cast(@biendem as char(2));
		set @biendem = @biendem +1
	End

---------- hiển thị điểm thi cao nhất môn csdl của sinh viên sv1
-- print " SV1 có điểm thi môn csdl cao nhất là: ...."




















------- kiểm tra xem có sinh viên Phạm Trường Giang không

if exists (select * from SinhVien where hoten=N'Phạm Trường Giang')
	print N'Có sinh viên PTG'
	else print N'không có sinh viên PTG'

-----------------------------------------Biến Con trỏ -----------------------------------------------------------------------------------------------------------------------
------- hiển thị điểm thi của sv A
--- sinh viên a có masv 1 đạt điểm :4
--- sinh viên a có masv 2 đạt điểm :6
-- đầu tiên tạo 1 con trỏ chứa những sinh viên có tên là Phạm Trường Giang
-- duyệt con trỏ để hiển thị dữ liệu ra 
declare con_tro_sv cursor
dynamic scroll
for
	select SinhVien.masv,SinhVien.hoten,Diem.diem  
	from Diem , SinhVien
	where Diem.masv = SinhVien.masv and hoten = N'Phạm Trường Giang' and mamh = 1;

open con_tro_sv;

declare @diem int , @hoten nvarchar(50) , @masv int;
fetch first from con_tro_sv into @masv,@hoten,@diem
while (@@FETCH_STATUS=0)
begin	
	print N'sinh viên ' + @hoten + N' có mã sinh viên ' + cast(@masv as char(2)) +N' đạt điểm ' + cast(@diem as char(4))
	fetch next from con_tro_sv into  @masv,@hoten,@diem
end

close con_tro_sv;

DEALLOCATE con_tro_sv;

------ đếm số sinh viên 
---Sử dụng con trỏ và lệnh print để hiển thị : "Số Sinh Viên là : ....."
declare con_tro_sv cursor
dynamic scroll
for
	select * from SinhVien;

open con_tro_sv;

declare @sosv int;
set @sosv =0;
fetch first from con_tro_sv
while (@@FETCH_STATUS=0)
begin
	set @sosv = @sosv +1 
	fetch next from con_tro_sv
end
print N'Số sinh viên: ' + cast(@sosv as char(4));

close con_tro_sv;

DEALLOCATE con_tro_sv;





---------------------------------thủ tục----------------------------------------------------------------------------------------------
------vd1 về thủ tục ko có tham số 
------hiển thị tên sv , tên môn học ,điểm thi 
create proc listvd1
as begin
select hoten,tenmh,diem from SinhVien,MonHoc,Diem
where SinhVien.masv=Diem.masv and MonHoc.mamh=Diem.mamh
end
-- gọi thủ tục vd1
exec listvd1


--vd2 : thủ tục có tham số truyền vào
--cho biết thông tin sv của 1 lớp nếu biết mã lớp

drop proc vd2

create proc vd2
@ml char(5)
as begin
if exists (select * from SinhVien where malop=@ml)
	select * from SinhVien where malop=@ml
else print N'không tồn tại lớp ' + @ml
end
-- gọi thủ tục vd2
exec vd2 '1'

exec vd2 '60'


--vd3 : viết 1 thủ tục cho biết điểm của sinhvien tham số vào là tên sinh viên và tên môn học
drop proc vd3
--
create proc vd3
@hoten nvarchar(50) ,
@tenmon nvarchar(20)
as begin
if exists (select  SinhVien.hoten , MonHoc.tenmh  , Diem.diem from SinhVien , Diem ,MonHoc
where SinhVien.masv=Diem.masv and Diem.mamh = MonHoc.mamh and SinhVien.hoten=@hoten and MonHoc.tenmh=@tenmon)
	select  SinhVien.hoten , MonHoc.tenmh  , Diem.diem from SinhVien , Diem ,MonHoc
	where SinhVien.masv=Diem.masv and Diem.mamh = MonHoc.mamh and SinhVien.hoten=@hoten and MonHoc.tenmh=@tenmon
else print N'Thông tin không tồn tại'
end
--
exec vd3 N'Phạm Trường Giang' , N'CSDL'

--viết thủ tục trả về điểm cao nhất và tên sinh viên đạt điểm cao nhất với môn thi được truyền vào qua tham số
create procedure sp_SV_KetQuaTotNhat
@tenMon nvarchar(30),
@maxDiem float output,
@tenSV nvarchar(30) output
as
begin
declare @maMon int
select @maMon = MonHoc.mamh from MonHoc where MonHoc.tenmh=@tenMon
select @maxDiem = max(diem) from Diem where Diem.mamh=@maMon

select @tenSV=SinhVien.hoten from SinhVien , Diem
where SinhVien.masv= Diem.masv and Diem.diem = @maxDiem and Diem.mamh=@maMon
end
-- cách sử dụng thủ tục khi có tham số output , phải khai báo 2 biến output trước
declare @tenSV nvarchar(30) , @maxDiem float
exec  sp_SV_KetQuaTotNhat N'CSDL',@maxDiem output, @tenSV output
 print @tensv
 print @maxDiem
 ---------------------thủ tục kiểu con trỏ ------------------
 --vd : viết thủ tục trả về biến kiểu con trỏ chứa danh sách các sinh viên có giới tính được truyền vào qua tham số
 create procedure TTCursor
 @gioitinh nvarchar(3),
 @dsSV cursor varying output
 as
 begin
 set @dsSV = Cursor
 for
 select * from SinhVien where gioitinh=@gioitinh
open @dsSV
end
--
declare @myCursor cursor
exec TTCursor N'Nam' , @dsSV=@myCursor output
fetch next from @myCursor
while (@@FETCH_STATUS=0)
	fetch next from @myCursor
close @myCursor
deallocate @myCursor
----------------------------------------------------------------------------------------------------------------------------
--- Câu 1
--a.Tạo một con trỏ chứa toàn bộ bản ghi trong bảng SINHVIEN. Duyệt từng bản ghi trong con trỏ đó.
declare con_tro_sv cursor
dynamic scroll
for
	select * from SinhVien;

open con_tro_sv;

declare @soSV int;
set @soSV = 0;
fetch first from con_tro_sv
while (@@FETCH_STATUS = 0)
	begin 
		
		set @soSV = @soSV +1;
		fetch next from con_tro_sv
	end
	print N'Số sv :' + cast(@soSV as char(2));
CLOSE con_tro_sv;
deallocate con_tro_sv;

--b. Tạo 1 con trỏ để in điểm trung bình của mỗi sinh viên theo định dạng: Sinh viên … có điểm trung bình là…
declare con_tro_sv cursor
dynamic scroll
for
	select SinhVien.hoten,AVG(Diem.diem )
	from Diem , SinhVien
	where Diem.masv = SinhVien.masv 
	group by SinhVien.masv , hoten

open con_tro_sv;

declare @diemtb float , @hoten nvarchar(50)  
fetch first from con_tro_sv into @hoten,@diemtb
while (@@FETCH_STATUS=0)
begin	
	print N'sinh viên ' + @hoten +N' có điểm trung bình ' + cast(@diemtb as char(4))
	fetch next from con_tro_sv into  @hoten,@diemtb
end

close con_tro_sv;

DEALLOCATE con_tro_sv;
--------- câu 2 : In ra màn hình tên của những sinh viên có điểm trung bình cao nhất. (gợi ý: sử dụng con trỏ chứa masv, tensv, dtb. Duyệt từng bản ghi trong con trỏ để kiểm tra nếu SV có dtb cao nhất thì hiển thị tên Sv đó ra)
DECLARE diemtb CURSOR
DYNAMIC SCROLL 
FOR
SELECT SINHVIEN.hoten,AVG(dbo.DIEM.Diem) FROM SINHVIEN,DIEM WHERE SINHVIEN.masv = Diem.masv GROUP BY SINHVIEN.masv,hoten 

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
PRINT N'Sinh viên ' + @tenMax + N' có điểm trung binh cao nhất là : ' + cast(@maxDiem AS CHAR(10))

CLOSE diemtb
DEALLOCATE diemtb

---Câu 3: Viết 1 thủ tục hiển thị số SV của mỗi lớp.
create proc sp_SinhVien
as begin
select count(masv) as 'Số sinh viên' , malop from SinhVien
group by malop
end
--
exec sp_SinhVien

--Câu 4: Viết 1 thủ tục cho biết điểm trung bình của 1 lớp bất kỳ.
create proc sp_SinhVien4
@malop nvarchar(3)
as begin
select avg(Diem.diem) as 'Điểm trung bình' , SinhVien.malop  from Diem , SinhVien where Diem.masv = SinhVien.masv and SinhVien.malop = @malop
group by malop
end
--
exec sp_SinhVien4 N'59'

-----Câu 5 : Viết 1 thủ tục cho biết điểm thi trung bình 1 môn học của 1 lớp bất kỳ. (tham số vào là mamh, malop).
create proc sp_SinhVien5
@mamh nvarchar(30) ,
@malop nvarchar(20)
as begin
if exists (select  MonHoc.tenmh  , avg(Diem.diem) as 'Điểm trung bình ' from   Diem ,MonHoc ,SinhVien
where  Diem.mamh = MonHoc.mamh and SinhVien.masv= Diem.masv and SinhVien.malop=@malop and MonHoc.mamh=@mamh group by MonHoc.tenmh)
	select  MonHoc.tenmh  , avg(Diem.diem) as 'Điểm trung bình ' from   Diem ,MonHoc , SinhVien
	where  Diem.mamh = MonHoc.mamh and SinhVien.masv= Diem.masv and SinhVien.malop=@malop and MonHoc.mamh=@mamh
	group by MonHoc.tenmh
else print N'Thông tin không tồn tại'
end
-- 
exec sp_SinhVien5 N'1',N'60'


-- Câu 6*: Giả sử SV đc phép thi lại nhiều lần 1 môn. Cho biết điểm thi cao nhất môn CSDL của Phạm Trường Giang.

create procedure sp_SinhVien6
@tensv nvarchar(30),
@tenmh nvarchar(30)
as begin
if exists (select  MonHoc.tenmh  , max(Diem.diem) as 'Điểm cao nhất  ' from   Diem ,MonHoc ,SinhVien
where  Diem.mamh = MonHoc.mamh and SinhVien.masv= Diem.masv and SinhVien.hoten=@tensv and MonHoc.tenmh=@tenmh group by MonHoc.tenmh, Diem.lanthi)
	select  MonHoc.tenmh  , max(Diem.diem) as 'Điểm cao nhất ' from   Diem ,MonHoc , SinhVien
	where  Diem.mamh = MonHoc.mamh and SinhVien.masv= Diem.masv and SinhVien.hoten=@tensv and MonHoc.tenmh=@tenmh
	group by MonHoc.tenmh ,Diem.lanthi
else print N'Thông tin không tồn tại'
end
-- drop procedure sp_SinhVien6

exec sp_SinhVien6 N'Phạm Trường Giang' , N'CSDl'
select * from Diem
--Câu 7*: Giả sử SV đc phép thi lại nhiều lần 1 môn. Viết 1 thủ tục cho biết điểm thi cao nhất của 1 SV nào đó cho 1 môn học nào đó.

