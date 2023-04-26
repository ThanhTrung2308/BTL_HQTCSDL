create database QuanLyKho_Final
On Primary(
	Name = QLKH ,
	FileName = 'E:\HQTCSDL\QLK.mdf',
	Size = 10MB,
	MaxSize = 50MB,
	FileGrowth = 2MB
)
Log On(
	Name = QLKH_log,
	FileName ='E:\HQTCSDL\QLK.ldf' ,
	Size = 5MB ,
	MaxSize = 20MB ,
	FileGrowth = 1MB
)

go
use QuanLyKho_Final
go


--Tạo Bảng
create table NhaCungCap
(
	ID_NCC char(6)not null primary key,
	TenNCC nchar(50)not null,
	Diachi nvarchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	ThongTin nvarchar(200)not null,
	constraint check_Email check (Email like '%@%')
	
)
create table MatHang
(
	ID_MH char(5)not null primary key,
	TenMH nchar(50)not null,
	ID_NCC char(6)not null,
	ngaySanXuat date,
	foreign key (ID_NCC) references NhaCungCap(ID_NCC)
)
create table KhachHang
(
	ID_KH char(5)not null primary key,
	TenKH nchar(50)not null,
	Diachi nchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	NgayHopTac date not null,
	constraint check_Email_KH check (Email like '%@%')
)
create table NhanVien
(
ID_NV char(5) not NULL primary key,
TenNV nvarchar(100) not null,
GioiTinh nchar(3) not null,
Diachi nchar(200)not null,
SDT char(12)not null,
Email char(30)not null,
Luong  money not null,
constraint check_Email_NV check (Email like '%@%'),
constraint check_GioiTinh_NV check (Gioitinh = N'Nam' or Gioitinh = N'Nữ')

)
create table PhieuNhap

(	
	ID_PN char(5)not null primary key,
	ID_NV char(5) not null,
	NgayNhap date not null,
	foreign key (ID_NV) references NhanVien(ID_NV)
)
create table TT_PhieuNhap
(
	ID_TTPN char(5)not null primary key,
	ID_PN char(5) not null,
	ID_MH char(5) not null,
	Soluong int not null,
	DonGiaNhap money not null,
	TinhTrang nchar(200) not null,
	foreign key (ID_PN) references PhieuNhap(ID_PN),
	foreign key (ID_MH) references MatHang(ID_MH)
)
create table PhieuXuat
(	
	ID_PX char(5)not null primary key,
	ID_NV char(5) not null,
	NgayXuat date,
	foreign key (ID_NV) references NhanVien(ID_NV)
)
create table TT_PhieuXuat
(
	ID_TTPX char(5)not null primary key,
	ID_PX char(5) not null,
	ID_MH char(5) not null,
	ID_KH char(5) not null,
	Soluong int not null,
	DonGiaXuat money not null,
	TinhTrang nchar(200)
	foreign key (ID_PX) references PhieuXuat(ID_PX),
	foreign key (ID_MH) references MatHang(ID_MH),
	foreign key (ID_KH) references KhachHang(ID_KH)

)
--Thêm dữ liệu
BEGIN
Insert into NhaCungCap
values ('NCC001', N'Apple', N'American', '0987654321', 'apple@icloud.com', N'Cung cấp sản phẩm từ Apple'),
		('NCC002', N'Samsung', N'Việt Nam', '0123456789', 'samsung@gmail.com', N'Cung cấp sản phẩm từ Samsung'),
		('NCC003', N'Xiaomi', N'China', '0147852369', 'xiaomi@gmail.com', N'Cung cấp sản phẩm từ Xiaomi'),
		('NCC004', N'Toshiba', N'Korea', '0321654987', 'toshiba@gmail.com', N'Cung cấp sản phẩm từ Toshiba'),
		('NCC005', N'Sony', N'Japan', '0963258741', 'sony@gmail.com', N'Cung cấp sản phẩm từ Sony'),
		('NCC006', N'Microsoft', N'American', '0321654987', 'microsoft@outlook.com', N'Cung cấp sản phẩm từ Microsoft');
Insert into MatHang
values ('MH001', N'Iphone 8', 'NCC001', '2018-07-12'),
	('MH002', N'Máy Giặt', 'NCC002', '2020-11-01'),
	('MH003', N'Xiaomi K30 Pro', 'NCC003', '2019-06-13'),
	('MH004', N'Microsoft Surface book', 'NCC006', '2019-03-10'),
	('MH005', N'PS5', 'NCC005', '2018-09-12'),
	('MH006', N'Sony Xperia 1', 'NCC005', '2019-08-20'),
	('MH007', N'Điều hòa 2 chiều Toshiba', 'NCC004', '2020-12-12'),
	('MH008', N'Tivi 4k Super thin', 'NCC002', '2020-04-29'),
	('MH009', N'Galaxy Note 20', 'NCC002', '2020-01-04'),
	('MH010', N'Microsoft office 365', 'NCC006', '2015-12-01'),
	('MH011', N'Iphone 11', 'NCC001', '2020-04-22'),
	('MH012', N'Quạt trần Toshiba', 'NCC004', '2019-09-11'),
	('MH013', N'Sony Alpha A6000', 'NCC005', '2015-08-27'),
	('MH014', N'Iphone 6', 'NCC001', '2016-10-09'),
	('MH015', N'Microsoft Surface Duo', 'NCC006', '2020-02-28'),
	('MH016', N'Tai nghe Sony ZAQR-11', 'NCC005', '2018-06-27'),
	('MH017', N'Samsung Galaxy Watch 3', 'NCC002', '2019-06-09'),
	('MH018', N'Apple Watch Series 5', 'NCC001', '2020-01-01'),
	('MH019', N'Thẻ nhớ Toshi 128GB', 'NCC004', '2016-09-10'),
	('MH020', N'Bộ phát Wifi Router 4C Xiaomi', 'NCC003', '2020-10-13');
Insert into KhachHang
values ('KH001',N'CellphoneS', N'Thái Hà - Hà Nội', '0123654789', 'cellphoneS@gmail.com', N'2015-01-02'),
	('KH002',N'HanoiPhone', N'Cầu Giấy - Hà Nội', '0369258741', 'hanoiphone@gmail.com', N'2016-02-03'),
	('KH003',N'Thế giới đi động', N'Văn giang - Hưng yên', '0258763147', 'thegioididong@gmail.com', N'2012-10-13'),
	('KH004',N'Mobile City', N'Long Biên - Hà Nội', '0985263741', 'mobilecity@gmail.com', N'2017-03-30'),
	('KH005',N'Điện Máy Xanh', N'Đông Sơn - Thanh Hóa', '0159263487', 'dienmayxanh@gmail.com', N'2014-07-19'),
	('KH006',N'TCS', N'Hai Bà Trưng - Hà Nội', '0753421869', 'tcs@gmail.com', N'2015-04-11'),
	('KH007',N'Điện máy Pico', N'Kiến Xương - Thái Bình', '0957846123', 'dienmaypico@gmail.com', N'2019-09-30'),
	('KH008',N'Phong Vũ', N'Thành Phố Thanh Hóa - Hà Nội', '0249563871', 'phongvu@gmail.com', N'2014-10-12'),
	('KH009',N'Nguyễn Kim', N'Thủy Nguyên - Hải Phòng', '0836521974', 'nguyenkim@gmail.com', N'2018-05-06'),
	('KH010',N'Đại học Thủy Lợi', N'Tây Sơn - Hà Nội', '0435640199', 'dhtl@tlu.edu.vn', N'2012-11-20');
Insert into NhanVien
	values ('NV001',N'Nguyễn Văn Mạnh',N'Nữ',N'Quảng Ninh','0789254879','ntyn@gmail.com',15660000),
			('NV002',N'Nguyễn Văn Sơn',N'Nam',N'Hưng Yên','0145287963','mhung@gmail.com',18500000),
			('NV003',N'Nguyễn Văn Dũng',N'Nam',N'Thanh Hóa','0584693155','huy@gmail.com',14700000),
			('NV004',N'Trịnh Xuân An Trung',N'Nữ',N'Hà Nội','0647521458','duyen@gmail.com',20500000),
			('NV005',N'Tạ Anh Tú',N'Nam',N'Hà Nội','0257894123','tatu@gmail.com',15200000),
			('NV006',N'Vũ Ngọc Anh',N'Nữ',N'Tuyên Quang','0987521423','anh@gmail.com',18590000)			
Insert into PhieuNhap
values ('PN001','NV001', '2020-01-15'),
	('PN002','NV002', '2020-02-12'),
	('PN003','NV003', '2020-03-05'),
	('PN004','NV004', '2020-04-20'),
	('PN005','NV005', '2020-05-10'),
	('PN006', 'NV006','2020-06-25'),
	('PN007','NV005', '2019-07-02'),
	('PN008', 'NV006','2019-08-28'),
	('PN009','NV003', '2019-09-04'),
	('PN010','NV004', '2019-08-26'),
	('PN011','NV002', '2019-07-02'),
	('PN012','NV001', '2019-12-24'),
	('PN013','NV003', '2020-01-12'),
	('PN014','NV004', '2020-02-10'),
	('PN015','NV003', '2020-03-03')
insert into TT_PhieuNhap
	values ('N0001','PN001','MH001',1500,15000000,N'New'),
			('N0002','PN002','MH002',100,12000000,N'New'),
			('N0003','PN003','MH003',2000,7000000,N'New'),
			('N0004','PN004','MH004',80,50000000,N'New'),
			('N0005','PN005','MH005',500,20000000,N'New'),
			('N0006','PN006','MH006',1000,5000000,N'99%'),
			('N0007','PN007','MH007',500,9000000,N'New'),
			('N0008','PN008','MH008',300,16000000,N'New'),
			('N0009','PN009','MH009',2500,20000000,N'New'),
			('N0010','PN010','MH010',3000,1600000,N'New'),
			('N0011','PN011','MH011',3000,30000000,N'New'),
			('N0012','PN012','MH012',2000,800000,N'New'),
			('N0013','PN013','MH013',700,20000000,N'New'),
			('N0014','PN014','MH014',3000,5000000,N'98%'),
			('N0015','PN015','MH015',1000,35000000,N'New'),
			('N0016','PN001','MH016',5500,3500000,N'New'),
			('N0017','PN002','MH017',1500,4700000,N'New'),
			('N0018','PN003','MH018',470,10990000,N'New'),
			('N0019','PN004','MH019',990,860000,N'New'),
			('N0020','PN005','MH020',1000,370000,N'New'),
			('N0022','PN001','MH003',150,7000000,N'New'),
			('N0023','PN013','MH016',500,3500000,N'New'),
			('N0024','PN015','MH001',1500,15000000,N'New'),
			('N0025','PN014','MH002',100,12000000,N'New'),
			('N0026','PN013','MH003',2000,7000000,N'New'),
			('N0027','PN012','MH004',800,50000000,N'New'),
			('N0028','PN011','MH005',5000,20000000,N'New'),
			('N0029','PN010','MH006',1000,5000000,N'99%'),
			('N0030','PN009','MH007',500,9000000,N'New'),
			('N0031','PN008','MH010',300,1600000,N'New'),
			('N0032','PN007','MH009',2500,20000000,N'New'),
			('N0033','PN006','MH010',3000,1600000,N'New'),
			('N0034','PN005','MH011',3000,30000000,N'New'),
			('N0035','PN004','MH012',2000,800000,N'New'),
			('N0036','PN003','MH013',700,20000000,N'New'),
			('N0037','PN002','MH014',3000,5000000,N'98%'),
			('N0038','PN001','MH015',1000,35000000,N'New'),
			('N0040','PN003','MH017',1500,4700000,N'New'),
			('N0042','PN005','MH019',990,860000,N'New'),
			('N0043','PN006','MH020',1000,370000,N'New'),
			('N0044','PN007','MH018',330,10990000,N'New'),
			('N0045','PN008','MH003',150,7000000,N'New'),
			('N0047','PN010','MH001',1500,15000000,N'New'),
			('N0048','PN011','MH002',100,12000000,N'New'),
			('N0049','PN012','MH003',2000,7000000,N'New'),
			('N0050','PN013','MH004',800,50000000,N'New'),
			('N0051','PN014','MH005',5000,20000000,N'New'),
			('N0052','PN015','MH006',1000,5000000,N'99%'),
			('N0053','PN008','MH007',500,9000000,N'New'),
			('N0054','PN007','MH008',300,16000000,N'New'),
			('N0055','PN006','MH009',2500,20000000,N'New'),
			('N0056','PN005','MH010',3000,1600000,N'New'),
			('N0057','PN004','MH011',3000,30000000,N'New'),
			('N0058','PN003','MH012',2000,800000,N'New'),
			('N0059','PN002','MH013',700,20000000,N'New'),
			('N0060','PN001','MH014',3000,5000000,N'98%'),
			('N0061','PN009','MH015',1000,35000000,N'New'),
			('N0063','PN011','MH017',1500,4700000,N'New'),
			('N0065','PN013','MH019',990,860000,N'New'),
			('N0068','PN002','MH003',150,7000000,N'New'),
			('N0071','PN008','MH002',100,12000000,N'New'),
			('N0072','PN010','MH003',2000,7000000,N'New'),
			('N0073','PN012','MH001',800,15000000,N'New'),
			('N0076','PN013','MH007',500,9000000,N'New'),
			('N0077','PN011','MH008',300,16000000,N'New'),
			('N0079','PN007','MH010',3000,1600000,N'New'),
			('N0080','PN005','MH004',3000,50000000,N'New'),
			('N0081','PN003','MH005',5000,20000000,N'New'),
			('N0082','PN001','MH013',700,20000000,N'New'),
			('N0083','PN013','MH014',3000,5000000,N'98%'),
			('N0086','PN010','MH017',1500,4700000,N'New'),
			('N0088','PN008','MH019',990,860000,N'New'),
			('N0089','PN007','MH020',2000,370000,N'New'),
			('N0091','PN005','MH003',150,7000000,N'New')
insert into PhieuXuat
	values ('PX001','NV001', '2020-01-20'),
	('PX002','NV002', '2020-02-17'),
	('PX003','NV003','2020-03-12'),
	('PX004','NV005', '2020-04-27'),
	('PX005','NV004', '2020-05-18'),
	('PX006','NV002', '2020-06-27'),
	('PX007','NV006', '2019-07-08'),
	('PX008','NV001', '2020-03-28'),
	('PX009', 'NV003','2019-09-11'),
	('PX010','NV005', '2019-11-24')
	insert into TT_PhieuXuat
	values ('X0001','PX001','MH001','KH001',1300,18990000,N'Không lỗi'),
			('X0002','PX002','MH002','KH002',100,17650000,N'Không lỗi'),
			('X0003','PX003','MH003','KH003',1960,9850000,N'Không lỗi'),
			('X0004','PX004','MH004','KH004',750,56000000,N'Không lỗi'),
			('X0005','PX005','MH005','KH005',3670,28354000,N'Không lỗi'),
			('X0006','PX006','MH006','KH006',1000,5960000,N'Đã qua sử dụng'),
			('X0007','PX007','MH007','KH007',380,15230000,N'Không lỗi'),
			('X0009','PX009','MH009','KH009',2000,23900000,N'Không lỗi'),
			('X0010','PX010','MH010','KH010',3000,2000000,N'Không lỗi'),
			('X0011','PX001','MH011','KH001',1900,38670000,N'Không lỗi'),
			('X0012','PX002','MH012','KH002',2000,880000,N'Không lỗi'),
			('X0013','PX003','MH013','KH003',650,30000000,N'Không lỗi'),
			('X0014','PX004','MH014','KH004',3000,7500000,N'Đã qua sử dụng'),
			('X0015','PX005','MH015','KH005',1000,40000000,N'Không lỗi'),
			('X0016','PX007','MH017','KH007',1500,8600000,N'Không lỗi'),
			('X0017','PX008','MH018','KH008',368,15320000,N'Không lỗi'),
			('X0018','PX009','MH019','KH009',853,1500000,N'Không lỗi'),
			('X0019','PX010','MH020','KH010',1000,678000,N'Không lỗi'),
			('X0020','PX002','MH001','KH010',1300,18990000,N'Không lỗi'),
			('X0021','PX004','MH002','KH009',100,17650000,N'Không lỗi'),
			('X0022','PX006','MH003','KH007',1960,9850000,N'Không lỗi'),
			('X0023','PX008','MH004','KH008',750,56000000,N'Không lỗi'),
			('X0024','PX010','MH005','KH004',3670,28354000,N'Không lỗi'),
			('X0025','PX003','MH006','KH005',1000,5960000,N'Đã qua sử dụng'),
			('X0026','PX005','MH007','KH006',380,15230000,N'Không lỗi'),
			('X0027','PX007','MH008','KH002',210,22000000,N'Không lỗi'),
			('X0028','PX001','MH010','KH003',3000,2000000,N'Không lỗi'),
			('X0029','PX003','MH011','KH005',1900,38670000,N'Không lỗi'),
			('X0030','PX005','MH012','KH006',2000,880000,N'Không lỗi'),
			('X0031','PX007','MH013','KH007',650,30000000,N'Không lỗi'),
			('X0032','PX009','MH014','KH008',3000,7500000,N'Đã qua sử dụng'),
			('X0033','PX004','MH015','KH009',1000,40000000,N'Không lỗi'),
			('X0034','PX002','MH017','KH001',1500,8600000,N'Không lỗi'),
			('X0035','PX010','MH018','KH002',368,15320000,N'Không lỗi'),
			('X0036','PX001','MH019','KH003',853,1500000,N'Không lỗi'),
			('X0037','PX008','MH020','KH004',1000,678000,N'Không lỗi'),
			('X0038','PX010','MH001','KH001',1300,18990000,N'Không lỗi'),
			('X0039','PX009','MH002','KH002',100,17650000,N'Không lỗi'),
			('X0040','PX008','MH003','KH003',1960,9850000,N'Không lỗi'),
			('X0041','PX007','MH004','KH004',750,56000000,N'Không lỗi'),
			('X0042','PX006','MH005','KH005',3670,28354000,N'Không lỗi'),
			('X0043','PX005','MH006','KH006',1000,5960000,N'Đã qua sử dụng'),
			('X0044','PX004','MH007','KH007',380,15230000,N'Không lỗi'),
			('X0045','PX003','MH008','KH008',210,22000000,N'Không lỗi'),
			('X0046','PX002','MH009','KH009',2000,23900000,N'Không lỗi'),
			('X0047','PX003','MH002','KH002',100,17650000,N'Không lỗi'),
			('X0048','PX005','MH003','KH003',1960,9850000,N'Không lỗi'),
			('X0049','PX006','MH004','KH004',750,56000000,N'Không lỗi'),
			('X0050','PX008','MH005','KH005',3670,28354000,N'Không lỗi'),
			('X0052','PX010','MH007','KH007',380,15230000,N'Không lỗi'),
			('X0053','PX001','MH008','KH008',210,22000000,N'Không lỗi'),
			('X0054','PX004','MH009','KH009',2000,23900000,N'Không lỗi'),
			('X0055','PX007','MH010','KH010',3000,2000000,N'Không lỗi'),
			('X0056','PX002','MH013','KH003',650,30000000,N'Không lỗi'),
			('X0057','PX001','MH014','KH004',3000,7500000,N'Đã qua sử dụng'),
			('X0058','PX004','MH016','KH006',5000,5000000,N'Không lỗi'),
			('X0059','PX009','MH017','KH007',1500,8600000,N'Không lỗi'),
			('X0060','PX008','MH019','KH009',853,1500000,N'Không lỗi'),
			('X0061','PX007','MH020','KH010',1000,678000,N'Không lỗi')
END

                                                    --Cursor--
--in ra thông tin nhân viên có mức lương cao nhất
declare contro_NV cursor
dynamic scroll
for
	select TenNV, Luong from NhanVien
Open contro_NV

declare @ten nvarchar(100), @luong money, @tenmax nvarchar(100), @luongmax money
set @luongmax = 0
fetch next from contro_NV into @ten, @luong
while (@@FETCH_STATUS=0)
begin
if(@luongmax<@luong)
	begin
		set @luongmax = @luong
		set @tenmax = @ten
	end
FETCH NEXT  FROM contro_NV INTO @ten, @luong
end 

PRINT N'Nhân Viên: ' + @tenmax + N', có lương cao nhất là : ' + cast(@luongmax AS CHAR(20))

CLOSE contro_NV
DEALLOCATE contro_NV

----------------------------------TRIGGER------------------------------------
BEGIN
-----------------------------
--Trigger tính tổng Tiền giá nhập của từng mã hàng (TG_TongGiaNhap) khi thêm hoặc update dữ liệu
Alter table TT_PhieuNhap
add TongGiaNhap money
----
create trigger TongGiaNhap
on TT_PhieuNhap
for Update, insert
as
Update TT_PhieuNhap set TongGiaNhap = Soluong * DonGiaNhap 
select * from TT_PhieuNhap
--thực thi
insert into TT_PhieuNhap
	values ('N0095','PN002','MH002',100,12000000,' 98%' , null)
	--select * from TT_PhieuNhap where ID_PN =  'PN001'
	--delete from TT_PhieuNhap where ID_TTPN = 'N0095'
	--select * from TT_PhieuNhap where ID_MH = 'MH002'
-----------------------------------------------------------------------------------
alter table TT_PhieuXuat
add TyLeGiamGia float
alter table TT_PhieuXuat
add TongGiaXuat float
----
create trigger TongGiaXuat
on TT_PhieuXuat
for update, insert
as
	update TT_PhieuXuat set TyLeGiamGia = 0.03 where TinhTrang = N'Đã qua sử dụng'
	update TT_PhieuXuat set TyLeGiamGia = 0.01 where TinhTrang = N'Không lỗi'
	update TT_PhieuXuat set TongGiaXuat = Soluong*DonGiaXuat*(1-TyLeGiamGia)

insert into TT_PhieuXuat
values ('X0098','PX002','MH003','KH001',1300,18990000,N'Không lỗi', null,null)
delete from TT_PhieuXuat where ID_TTPX = 'X0098'
select * from TT_PhieuXuat
select * from KhachHang


--Trigger không thể thêm mặt hàng đã bị trùng // cập nhật tên phải khác tên mặt hàng trước đó
create trigger ThemMatHang
on MatHang
for update, insert
as
if( select count(TenMH) from MatHang where TenMH = (select TenMH from inserted))>=2
begin 
print N'Mặt hàng này đã tồn tại'
rollback tran
end
else if(select TenMH from inserted) = (select TenMH from deleted)
begin
print N'Tên mặt hàng phải sửa khác tên ban đầu'
rollback tran
end
else
print N'Thực thi thành công'
--Thực thi--
Insert into MatHang
values ('MH025', N'Iphone 8', 'NCC001', '2018-07-12')
delete from MatHang where ID_MH = 'MH021'

--Trigger không cho cập nhật dữ liệu Phieu Xuat và Phieu Nhap
create trigger KCN_PN
on PhieuNhap 
for update
as 
if UPDATE(ID_NV) or UPDATE(ID_PN) or UPDATE(NgayNhap)
Begin
Print N'Không thể thay đổi giá trị trong Bảng Phiếu Nhập'
rollback tran
end
--thực thi--
Update PhieuNhap set ID_NV = 'NV001' where ID_PN = 'PN003'
select * from PhieuNhap
-----------------------------------------------
create trigger KCN_PX
on PhieuXuat
for update
as 
if UPDATE(ID_NV) or UPDATE(ID_PX) or UPDATE(NgayXuat)
Begin
Print N'Không thể thay đổi giá trị trong Bảng Phiếu Xuất'
rollback tran
end
--thực thi---
Update PhieuXuat set ID_NV = 'NV003' where ID_PX = 'PX003'
select * from PhieuXuat
--------------------------------------------------
END
-----------------------------------VIEW--------------------------------------
BEGIN
--View V_ChiTietPhieuNhap gồm ID_NV, TenNV,ID_PN, NgayNhap, ID_TTPN, IDMH, TenMH,ID_NCC, TenNCC
create view V_ChiTietPhieuNhap
as
select NhanVien.ID_NV, NhanVien.TenNV, PhieuNhap.ID_PN, 
PhieuNhap.NgayNhap, TT_PhieuNhap.ID_TTPN,
MatHang.ID_MH, MatHang.TenMH, NhaCungCap.ID_NCC, 
NhaCungCap.TenNCC
from TT_PhieuNhap, PhieuNhap , MatHang, NhanVien, NhaCungCap
where PhieuNhap.ID_PN = TT_PhieuNhap.ID_PN
and NhanVien.ID_NV = PhieuNhap.ID_NV 
and MatHang.ID_MH = TT_PhieuNhap.ID_MH
and NhaCungCap.ID_NCC = MatHang.ID_NCC
group by NhanVien.ID_NV, NhanVien.TenNV, PhieuNhap.ID_PN, 
PhieuNhap.NgayNhap, TT_PhieuNhap.ID_TTPN,
MatHang.ID_MH, MatHang.TenMH, NhaCungCap.ID_NCC, 
NhaCungCap.TenNCC

select * from V_ChiTietPhieuNhap

--View Chứa thông tin khách hàng hợp tác trên 5 năm, thông tin lịch sử mua hàng
Create view TT_KhachHang
as
select KhachHang.ID_KH, KhachHang.TenKH, KhachHang.Diachi, 
KhachHang.SDT, KhachHang.Email, TT_PhieuXuat.ID_PX, TT_PhieuXuat.ID_MH,
MatHang.TenMH, TT_PhieuXuat.TinhTrang
from KhachHang, TT_PhieuXuat, MatHang
where TT_PhieuXuat.ID_MH = MatHang.ID_MH 
and KhachHang.ID_KH = TT_PhieuXuat.ID_KH 
and (year(getdate()) - year(NgayHopTac)) >= 5
group by KhachHang.ID_KH, KhachHang.TenKH, KhachHang.Diachi, 
KhachHang.SDT, KhachHang.Email, TT_PhieuXuat.ID_PX, 
TT_PhieuXuat.ID_MH, MatHang.TenMH, TT_PhieuXuat.TinhTrang

select * from TT_KhachHang

--View Chưa thông tin Mặt Hàng Xuất từ tháng 1/2019 đến tháng 1/2020 
alter view TT_XuatHang
as
select distinct MatHang.*
from PhieuXuat, TT_PhieuXuat, MatHang
where PhieuXuat.ID_PX = TT_PhieuXuat.ID_PX
and TT_PhieuXuat.ID_MH = MatHang.ID_MH
and PhieuXuat.NgayXuat between '2020-05-01' and '2021-05-01' 

--thực thi
select * from TT_XuatHang

END
---------------------------------PROCEDURE-----------------------------------
BEGIN
--Procedure tìm kiếm Nhà cung cấp theo Mã nhà cung câp
create proc p_TimKiemNCC
@ID_NCC char(6)
as
begin
if(not exists(select * from NhaCungCap where ID_NCC = @ID_NCC))
	Print N'Mã nhà cung cấp không tồn tại'

else
	select * from NhaCungCap where ID_NCC = @ID_NCC
end
----Thực thi----
exec p_TimKiemNCC 'NCC005'

--Procedure để insert, delete, update vào bảng Nhân Viên
---Insert---
Create proc Insert_NV
@ID_NV char(5),@TenNV nvarchar(100), @GioiTinh nchar(3),
@Diachi nchar(200), @SDT char(12), @Email char(30), @Luong money
as
begin
if(exists (select ID_NV from NhanVien where ID_NV = @ID_NV))
begin
	print N'Mã Nhân Viên đã tồn tại'
	rollback tran
	end
else 
insert into NhanVien(ID_NV , TenNV, GioiTinh, Diachi , SDT, Email, Luong)
values(@ID_NV, @TenNV, @GioiTinh, @Diachi, @SDT, @Email, @Luong)
end

----Thực thi----
exec Insert_NV 'NV007',N'Nguyễn Văn Cường',N'Nam',N'Hưng Yên','0374523912','nvc@gmail.com',18660000

select * from NhanVien
---Update---
Create proc Update_NV
@ID_NV char(5),@TenNV nvarchar(100), @GioiTinh nchar(3),
@Diachi nchar(200), @SDT char(12), @Email char(30), @Luong money
as 
begin
if(exists (select ID_NV from NhanVien where ID_NV = @ID_NV))
begin
Update NhanVien 
set ID_NV = @ID_NV, 
TenNV = @TenNV, 
GioiTinh = @GioiTinh, 
Diachi = @Diachi, 
SDT = @SDT, 
Email = @Email, 
Luong = @Luong
where ID_NV = @ID_NV
end
else
print N'Mã Nhân Viên không tồn tại'
end
----Thực thi----
exec Update_NV 'NV007',N'Nguyễn Văn Cường TH4',N'Nam',N'Hà Nội','0984896177','ncv@gmail.com',15660000
---Delete---
Create proc Delete_NV
@ID_NV char(5)
as 
begin
if(exists (select ID_NV from NhanVien where ID_NV = @ID_NV))
begin
delete from NhanVien 
where ID_NV = @ID_NV
end
else
	print N'Mã Nhân Viên không tồn tại'
end
----Thực thi----
exec Delete_NV 'NV009'

--Procedure Lấy ra số lượng nhập của một mã hàng bất kì trong năm bất kì
create proc SP_SoluongNhap
@ID_MH char(5),
@NamNhap char(5),
@Soluong int output
as
begin 
declare @SLN int
select @SLN = Sum (TT_PhieuNhap.Soluong )
from TT_PhieuNhap, PhieuNhap 
where TT_PhieuNhap.ID_PN = PhieuNhap.ID_PN and
TT_PhieuNhap.ID_MH = @ID_MH and year(PhieuNhap.NgayNhap) =  @NamNhap
set @Soluong = @SLN
end
----Thực thi----
declare @SoluongNhap int
exec SP_SoluongNhap 'MH011', '2020',
	 @SoluongNhap output
print N'Số lượng nhập: '+ cast(@SoLuongNhap as char(10))


--Procedure Lây ra số lượng tồn của mỗi mặt hàng 
create view V_SLNhap
as
select MatHang.ID_MH, MatHang.TenMH, sum(TT_PhieuNhap.Soluong) as SoLuongNhap, DonGiaNhap
from TT_PhieuNhap, MatHang 
where TT_PhieuNhap.ID_MH = MatHang.ID_MH 
group by MatHang.ID_MH,MatHang.TenMH, DonGiaNhap

select * from V_SLNhap
----
create view V_SLXuat
as
select MatHang.ID_MH, MatHang.TenMH, sum(TT_PhieuXuat.Soluong) as SoLuongXuat, DonGiaXuat
from TT_PhieuXuat, MatHang 
where TT_PhieuXuat.ID_MH = MatHang.ID_MH 
group by MatHang.ID_MH,MatHang.TenMH, DonGiaXuat

select * from V_SLXuat
-----
create proc SP_SoLuongTon
as
begin
select MatHang.ID_MH, MatHang.TenMH,
((dbo.V_SLNhap.SoluongNhap) - (dbo.V_SLXuat.SoluongXuat)) as SoLuongTon 
from dbo.V_SLNhap,  dbo.V_SLXuat, MatHang
where dbo.V_SLNhap.ID_MH = dbo.V_SLXuat.ID_MH 
and MatHang.ID_MH = dbo.V_SLNhap.ID_MH 
order by MatHang.ID_MH asc
end

exec SP_SoLuongTon
END

---------------------------------FUNCTION------------------------------------
BEGIN

--Function trả về số lượng nhập của một mặt hàng bất kì trong khoảng thời gian nhập bất kì

create function sln (@ID_MH char(5), @NgayBD date, @NgayKT date)
returns int 
as 
begin
declare @SLN int
select @SLN = Sum (TT_PhieuNhap.Soluong )
from TT_PhieuNhap, PhieuNhap 
where TT_PhieuNhap.ID_PN = PhieuNhap.ID_PN and
TT_PhieuNhap.ID_MH = @ID_MH and PhieuNhap.NgayNhap between @NgayBD and @NgayKT
return @SLN
end
----Thực thi----
select dbo.sln('MH001', '2019-01-01', getdate() ) as SoLuongNhap

--Function trả về danh sách Khách hàng mua một mặt hàng bất kì
Create function dskh(@ID_MH nchar(50))
returns @DSKH table(TenKH nchar(50))
as
begin
insert into @DSKH
select distinct KhachHang.TenKH
from TT_PhieuXuat, KhachHang
where KhachHang.ID_KH = TT_PhieuXuat.ID_KH and
ID_MH = @ID_MH
return
end
----Thực thi----
select * from dskh('MH005')

--Function tính tổng tiền của một đơn nhập bất kì của năm bất kì
create function F_TongTien(@ID_PN char(5), @Nam date)
returns money
as
begin
declare @TongGiaNhap money
select @TongGiaNhap = Sum(TT_PhieuNhap.TongGiaNhap)
from TT_PhieuNhap, PhieuNhap
where TT_PhieuNhap.ID_PN = PhieuNhap.ID_PN 
and TT_PhieuNhap.ID_PN = @ID_PN
and year(PhieuNhap.NgayNhap) = year(@Nam)
return @TongGiaNhap
end
----Thực thi----
select dbo.F_TongTien('PN005', getdate() ) as TongGiaPN
END

-------------------------------TRANSACTION-----------------------------------
BEGIN
--Tạo giao dịch xuất kho 
create view SoLuongTon
as 
select MatHang.ID_MH, MatHang.TenMH,
((dbo.V_SLNhap.SoluongNhap) - (dbo.V_SLXuat.SoluongXuat)) as SoLuongTon 
from dbo.V_SLNhap,  dbo.V_SLXuat, MatHang
where dbo.V_SLNhap.ID_MH = dbo.V_SLXuat.ID_MH 
and MatHang.ID_MH = dbo.V_SLNhap.ID_MH 

-----
create proc GiaoDichXuatKho
@CheckSLX int,
@ID_PX char(5),
@ID_NV char(5),
@NgayXuat date,
@ID_TTPX char(5),
@ID_MH char(5),
@ID_KH char(5),
@DonGia money,
@TinhTrang nchar(200)
as
begin 
begin Tran XuatKho
if(select SoLuongTon from SoLuongTon where ID_MH = @ID_MH) < @CheckSLX
	begin
	rollback tran Xuatkho
	Print N'Không đù số lượng để xuất'
	end
else
	begin
	if exists(select ID_PX from PhieuXuat where ID_PX = @ID_PX)
	begin
		insert into TT_PhieuXuat
		values (@ID_TTPX,@ID_PX,@ID_MH ,@ID_KH ,@CheckSLX,@DonGia,@TinhTrang, null,null)
		commit tran XuatKho
		Print N'Xuất kho thành công'
	end
	else
	begin
		insert into PhieuXuat
		values (@ID_PX, @ID_NV, @NgayXuat)
		insert into TT_PhieuXuat
		values (@ID_TTPX,@ID_PX,@ID_MH ,@ID_KH ,@CheckSLX,@DonGia,@TinhTrang, null,null)
		
		commit tran XuatKho
		Print N'Xuất kho thành công'
	end
	end
end
--Thực thi---
exec GiaoDichXuatKho 5000,'PX011', 'NV003','2020-11-24','X0062','MH011','KH002',38670000,N'Không lỗi'

--delete from TT_PhieuXuat where ID_TTPX = 'X0062'
--delete from PhieuXuat where ID_PX = 'PX011'

--select *from TT_PhieuXuat where ID_PX = 'PX002'
--update TT_PhieuXuat set ID_PX = 'PX001' where ID_MH like 'MH001' and ID_TTPX like 'X0001'
--select * from PhieuXuat
--exec SP_SoLuongTon

--Tạo giao dịch chuyển Mặt hàng của phiếu xuất này sang phiếu xuất khác

create proc GiaoDichChuyen
@ID_PX_Cu char(5),
@ID_PX_Moi char(5),
@ID_MH char(5),
@ID_TTPX char(5)
as
begin
begin tran ChuyenMH
if not exists(select ID_PX from TT_PhieuXuat where ID_PX = @ID_PX_Cu)
	begin
		rollback tran ChuyenMH
		Print N'Phiếu Xuất không tồn tại'
	end
else if exists(select ID_PX from TT_PhieuXuat where ID_PX = @ID_PX_Cu) and 
	not exists(select ID_MH from TT_PhieuXuat where ID_PX = @ID_PX_Cu and ID_TTPX = @ID_TTPX)
	begin
		rollback tran ChuyenMH
		Print N'Mặt hàng không tồn tại trong Phiếu xuất'
	end
else
	begin
		Update TT_PhieuXuat set ID_PX = @ID_PX_Moi where ID_MH = @ID_MH and ID_TTPX = @ID_TTPX
		commit tran ChuyenMH
		Print N'Chuyển mặt hàng thành công'

	end
end
--Thực thi---
exec GiaoDichChuyen 'PX001','PX002', 'MH001', 'X0001'

--update TT_PhieuXuat set ID_PX = 'PX001' where ID_MH like 'MH001' and ID_TTPX like 'X0001'
--select * from TT_PhieuXuat where ID_TTPX = 'X0001' and ID_MH = 'MH001'
--select * from TT_PhieuXuat where ID_PX = 'PX001'
END