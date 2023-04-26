create database QuanLyNV_1

create table Phong
(
	MaP char(5) not null primary key,
	TenP nvarchar(50)
)
insert into Phong
values  ('KT', N'Kế Toán'),
		('LT', N'Lễ Tân'),
		('TK', N'Thiết Kế')
create table Nhanvien
(
	MaNV  char(5) not null primary key,
	Hoten nvarchar(50),
	Ngaysinh date,
	Diachi nvarchar(100),
	MaP char(5),
	Luong int,
	MaTP char(5)
	foreign key (MaP) references Phong(MaP)
)
insert into Nhanvien
values  ('NV12', N'Nguyễn Văn Q', '1999-06-07', N'Quảng Ninh', 'LT', 5500000, 'TP002'),
('NV13', N'Nguyễn Văn Ư', '1999-07-12', N'Bắc Giang', 'LT', 5500000, 'TP002'),
('NV14', N'Nguyễn Văn F', '1999-07-12', N'Bắc Giang', 'LT', 5500000, 'TP002')
('NV01', N'Nguyễn Văn A', '1999-01-01', N'Hà Nội', 'KT', 5500000, 'TP002'),
('NV02', N'Nguyễn Văn B', '1999-02-15', N'Hà Nội', 'KT', 5500000, 'TP002'),
('NV03', N'Nguyễn Văn C', '1999-03-16', N'Thanh Hóa', 'KT', 5500000, 'TP002'),
('NV04', N'Nguyễn Văn D', '1999-04-20', N'Hưng Yên', 'LT', 5500000, 'TP002'),
('NV05', N'Nguyễn Văn E', '1999-05-08', N'Bắc Ninh', 'LT', 5500000, 'TP002'),
('NV06', N'Nguyễn Văn F', '1999-06-07', N'Quảng Ninh', 'TK', 5500000, 'TP002'),
('NV07', N'Nguyễn Văn G', '1999-07-12', N'Bắc Giang', 'TK', 5500000, 'TP002'),
('NV08', N'Nguyễn Văn H', '1999-06-07', N'Quảng Ninh', 'TK', 5500000, 'TP002'),
('NV09', N'Nguyễn Văn J', '1999-06-07', N'Quảng Ninh', 'TK', 5500000, 'TP002'),
('NV10', N'Nguyễn Văn K', '1999-07-12', N'Bắc Giang', 'TK', 5500000, 'TP002'),
('NV11', N'Nguyễn Văn L', '1999-07-12', N'Bắc Giang', 'TK', 5500000, 'TP002'),

create table Duan
(
	MaDA char(5) not null primary key,
	Ngaybatdau date,
	Ngayketthuc date
)
insert into Duan
values  ('DA01', '2020-9-01','2020-9-20'),
('DA02', '2020-9-20','2020-10-10'),
('DA03', '2020-9-21','2020-10-28')
select * from NV_DA

create table NV_DA
(
	MaDA char(5),
	MaNV char(5),
	foreign key (MaNV) references Nhanvien(MaNV),
	foreign key (MaDA) references Duan(MaDA)
)
insert into NV_DA
values ('DA01', 'NV06'),
('DA01', 'NV07'), 
('DA02', 'NV08'),
('DA02', 'NV09'),
('DA03', 'NV10'),
('DA03', 'NV11')

--1
create proc DSNV
@MaP char(5)
as
begin
select Nhanvien.* from Nhanvien where MaP = @MaP
end
--thực thi
exec DSNV 'KT'

--2
create proc TongNV
@MaP char(5),
@TongNV int output
as begin
select @TongNV = Count(MaNV) from Nhanvien where MaP = @MaP
end
-- Thực thi
declare @tongNV int
exec TongNV 'KT', @TongNV output
print N'Tổng NV có mã phòng KT: ' + cast( @TongNV as char(4))

--3
create proc ChuyenP
@MaC char(5),
@MaM char (5)
as begin
update Nhanvien
set MaP = @MaM where MaP = @MaC
end
--thực thi
declare @MaC char(5), @MaM char(5)
exec ChuyenP @MaC = 'LT', @MaM = 'KT'

select * from Nhanvien

--4-5-6
create table HCN
(
	sox int,
	soy int
)
insert into HCN values (7,null,null,null)
alter table HCN
add Tong int

create proc hoandoi
as begin 
update HCN
set sox = soy, soy = sox
end
--thực thi
exec hoandoi 

create proc Tong
as begin 
update HCN
set Tong = sox + soy
end
--thực thi
exec Tong

create proc Dientich
as begin
update HCN
set Dientich = sox * soy where sox is not null or soy is not null
end
--thực thi
exec Dientich

select * from HCN
--7
create proc TongNV_P
@MaP char(5),
@TongNV int output
as begin
select @TongNV = Count(MaNV) from Nhanvien where MaP = @MaP
end
-- Thực thi
declare @MaP char(5),  @tongNV_P int
set @MaP = 'KT'
exec TongNV 'KT', @tongNV_P output
print N'Tổng NV có mã phòng ' + @MaP + ': ' + cast( @tongNV_P as char(4))

--8
create proc NV_DA_DS
@MaDA char(5)
as
begin
select Nhanvien.* from NV_DA,Nhanvien where NV_DA.MaNV = Nhanvien.MaNV and NV_DA.MaDA = @MaDA
end
--thực thi
exec NV_DA_DS 'DA01'

--9
update Nhanvien
set Thu = (select datepart(dw, Nhanvien.ngaysinh)
--select * from Nhanvien
create proc NOD
@Thu nchar(10)
as begin
select * from Nhanvien where Thu = @Thu
end
exec NOD 'tuesday'

--10
create proc DSNV_KT
@MaP char(5)
as
begin

if(exists(select Nhanvien.* from Nhanvien where MaP = @MaP))
	select Nhanvien.* from Nhanvien where MaP = @MaP
else
	select Nhanvien.* from Nhanvien ORDER BY (CASE MaP
											WHEN 'LT' THEN 1
											WHEN 'TK' THEN 2
											WHEN 'KT' THEN 3
											ELSE 100 END) ASC, MaP DESC;
end
--thực thi
exec DSNV_KT 'KJT'
CREATE VIEW Mlem as
select MaNV, Hoten, Diachi
from Nhanvien

insert into Mlem(MaNV,Hoten) values ('TEPS', N'Nguyễn Thị Nhung')
select * from Nhanvien