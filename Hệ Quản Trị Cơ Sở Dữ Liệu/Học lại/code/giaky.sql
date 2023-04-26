create database GiuaKi
On primary(
	Name = GK,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\GK.mdf',
	Size = 10MB,
	MaxSize = 50MB,
	FileGrowth = 2MB
)
Log On(
	Name = GK_Log,
	FileName ='D:\HQTCSDL\NguyenVanCuong\GK.ldf' ,
	Size = 5MB ,
	MaxSize = 20MB ,
	FileGrowth = 1MB
)
--3
alter database GiuaKi
modify file (
name = GK,
Size = 15MB
)
--4
alter database GiuaKi
modify file (
	name = GK_Log,
	FileGrowth = 0
)
--5
use GiuaKi
DBCC shrinkfile(
	name = GK,
	5
)

--6
alter database GiuaKi
add file
(
	name = GK1,
	FileName = 'D:\HQTCSDL\NguyenVanCuong\GK1.ndf',
	Size = 10MB,
	FileGrowth = 5MB
)
--7
use GiuaKi Go
dbcc shrinkfile(
	GK1, emptyfile	
)
alter database GiuaKi
remove file GK1

--8
--9
create table Khoa
(
	makhoa int identity(1,1) primary key,
	tenkhoa nvarchar(20),
	socanbo int
)
insert into Khoa values
('CNTT', 10),('KT', 2),('XD', 6),
('ANTT', 7),('GD', 4),('CK', 3)
create table Lop
(
	malop int identity(1,1) primary key,
	tenlop nvarchar(20),
	makhoa int foreign key references Khoa(makhoa)
)
insert into Lop values
(N'TH4',1),(N'KT5',2),(N'TH5',1),
(N'TH3',1),(N'KT1',2),(N'KT3',2),
(N'GD1',5),(N'GD8',5),(N'XD1',3),
(N'XD3',3),(N'ANTT1',4),(N'CK1',6)
create table SinhVien
(
	masv int identity(1,1) primary key,
	hoten nvarchar(50),
	gioitinh nvarchar(10),
	ngaysinh date,
	malop int foreign key references Lop(malop),
	hocbong nvarchar(10),
	tinh nvarchar(10),
	check (gioitinh in (N'Nam',N'Nữ'))
)
insert into SinhVien values
(N'Hùng', N'Nam', '05-21-2000', 2, N'Giỏi', N'Hà Nội'),
(N'Huy', N'Nam', '05-21-1999', 3, N'Khá', N'Hưng Yên'),
(N'Thành', N'Nữ', '12-21-2000', 4, N'Giỏi', N'Thanh Hóa'),
(N'Tồ', N'Nam', '05-21-2000', 6, N'Giỏi', N'Hà Nội'),
(N'Moon', N'Nam', '05-01-1998', 5, N'Trung Bình', N'Hà Nam'),
(N'Á Lồ', N'Nam', '06-21-2000', 5, N'Giỏi', N'Lào Cai')
create table MonHoc
(
	mamh int identity(1,1) primary key,
	tenmh nvarchar(10),
	sotinchi int
)
insert into MonHoc values
(N'CSDL', 2),(N'Toán', 1),(N'Văn', 3),
(N'kinh Tế', 2),(N'Cơ Khí', 2),(N'Xây Dựng', 2)

create table KetQua
(
	masv int foreign key references SinhVien(masv),
	mamh int foreign key references MonHoc(mamh),
	diemthi float
)
insert into KetQua values
(1,1,9.5),(1,2,9),(1,3,6),(1,4,8),(1,5,7),(2,1,7),(2,2,6),
(2,3,9.5),(2,4,5),(2,5,6),(2,6,6),(3,1,1),(3,2,8.5),(3,3,2),
(4,1,1),(4,2,8),(4,3,9.5),(4,4,2),(5,1,2),(5,2,9.5),(6,1,9.5)


--13
create proc proc_ds_sv
@tenlop nvarchar(10)
as begin
select * from Lop, SinhVien where Lop.malop = SinhVien.malop
and Lop.tenlop like @tenlop
end

exec proc_ds_sv N'TH5'

--14
create proc proc_tong_sv
@makhoa nvarchar(10),
@tong_sv int output
as begin
select @tong_sv = sum(sv.masv) from SinhVien sv, Lop l, Khoa k
where k.makhoa = l.makhoa and l.malop =  sv.masv and k.makhoa = @makhoa
end

declare @sosv int
exec proc_tong_sv 1 , @sosv output
print N'Tổng số sv là : ' + cast(@sosv AS CHAR(10))

--15
create function fn_