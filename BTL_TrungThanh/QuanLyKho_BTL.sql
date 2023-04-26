create database QuanLyKho_BTL
go
use QuanLyKho_BTL
go
-----------------------------------TABLE-------------------------------------
--Bảng NCC
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
--Nhập DL cho NCC
Insert into NhaCungCap
values  ('NCC001', N'Apple', N'American', '0987654321', 'apple@icloud.com', N'Cung cấp sản phẩm từ Apple'),
		('NCC002', N'Samsung', N'Việt Nam', '0123456789', 'samsung@gmail.com', N'Cung cấp sản phẩm từ Samsung'),
		('NCC003', N'Xiaomi', N'China', '0147852369', 'xiaomi@gmail.com', N'Cung cấp sản phẩm từ Xiaomi'),
		('NCC004', N'Toshiba', N'Korea', '0321654987', 'toshiba@gmail.com', N'Cung cấp sản phẩm từ Toshiba'),
		('NCC005', N'Sony', N'Japan', '0963258741', 'sony@gmail.com', N'Cung cấp sản phẩm từ Sony'),
		('NCC006', N'Microsoft', N'American', '0321654987', 'microsoft@outlook.com', N'Cung cấp sản phẩm từ Microsoft');
--Bảng Mặt Hàng
create table MatHang
(
	ID_MH char(5)not null primary key,
	TenMH nchar(50)not null,
	ID_NCC char(6)not null,
	ngaySanXuat date,
	foreign key (ID_NCC) references NhaCungCap(ID_NCC)
)
--Nhập DL cho mặt hàng
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
--Bảng KH
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
--Nhập DL cho KH
Insert into KhachHang
values ('KH001',N'CellphoneS', N'Thái Hà - Hà Nội', '0123654789', 'cellphoneS@gmail.com', N'2015-01-02'),
	('KH002',N'HanoiPhone', N'Cầu Giấy - Hà Nội', '0369258741', 'hanoiphone@gmail.com', N'2016-02-03'),
	('KH003',N'Thế giới đi động', N'Văn giang - Hưng yên', '0258763147', 'thegioididong@gmail.com', N'2012-10-13'),
	('KH004',N'Mobile City', N'Long Biên - Hà Nội', '0985263741', 'mobilecity@gmail.com', N'2017-03-30'),
	('KH005',N'Điện Máy Xanh', N'Đông Sơn - Thanh Hóa', '0159263487', 'dienmayxanh@gmail.com', N'2014-07-19'),
	('KH006',N'TCS', N'Hai Bà Trưng - Hà Nội', '0753421869', 'tcs@gmail.com', N'2015-04-11'),
	('KH007',N'Điện máy Pico', N'Kiến Xương - Thái Bình', '0957846123', 'dienmaypico@gmail.com', N'2019-09-30'),
	('KH008',N'Phong Vũ', N'Thái Hà - Hà Nội', '0249563871', 'phongvu@gmail.com', N'2014-10-12'),
	('KH009',N'Nguyễn Kim', N'Thủy Nguyên - Hải Phòng', '0836521974', 'nguyenkim@gmail.com', N'2018-05-06'),
	('KH010',N'Đại học Thủy Lợi', N'Tây Sơn - Hà Nội', '0435640199', 'dhtl@tlu.edu.vn', N'2012-11-20');
--Bảng Nhân viên
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
--Nhập DL cho Nhân viên
Insert into NhanVien
	values	('NV001',N'Nguyễn Thành Trung',N'Nam',N'Hà Nội','0789254879','ntt@gmail.com',20500000),
			('NV002',N'Dương Văn Thành',N'Nam',N'Lạng Sơn','0145287963','dvt@gmail.com',18500000),
			('NV003',N'Trần Đăng Khoa',N'Nam',N'Ninh Bình','0584693155','tdk@gmail.com',17700000),
			('NV004',N'Nguyễn Phương Thảo',N'Nữ',N'Hà Nội','0647521458','npt@gmail.com',16600000),
			('NV005',N'Trần Ngọc Tân',N'Nam',N'Nam Định','0257894123','tnt@gmail.com',15200000),
			('NV006',N'Nguyễn Thúy Hằng',N'Nữ',N'Thái Bình','0987521423','nth@gmail.com',14600000)	
--Bảng Phiếu nhập		
create table PhieuNhap

(	
	ID_PN char(5)not null primary key,
	ID_NV char(5) not null,
	NgayNhap date not null,
	foreign key (ID_NV) references NhanVien(ID_NV)
)
--Nhập DL cho phiếu nhập
Insert into PhieuNhap
values ('PN001','NV001', '2020-01-15'),
	('PN002','NV002', '2020-02-12'),
	('PN003','NV003', '2020-03-05'),
	('PN004','NV004', '2020-04-20'),
	('PN005','NV005', '2020-05-10'),
	('PN006','NV006', '2020-06-25'),
	('PN007','NV005', '2019-07-02'),
	('PN008','NV006', '2019-08-28'),
	('PN009','NV003', '2019-09-04'),
	('PN010','NV004', '2019-08-26'),
	('PN011','NV002', '2019-07-02'),
	('PN012','NV001', '2019-12-24'),
	('PN013','NV003', '2020-01-12'),
	('PN014','NV004', '2020-02-10'),
	('PN015','NV003', '2020-03-03')
--Bảng thông tin phiếu nhập
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
--Nhập DL cho thông tin phiếu nhập
Insert into TT_PhieuNhap
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
--Bảng Phiếu Xuất
create table PhieuXuat
(	
	ID_PX char(5)not null primary key,
	ID_NV char(5) not null,
	NgayXuat date,
	foreign key (ID_NV) references NhanVien(ID_NV)
)
--Nhập DL cho Phiếu xuất
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
--Bảng TT Phiếu xuất
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
--Nhập Dl cho TT phiếu xuất
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

SELECT * FROM TT_PhieuNhap
SELECT * FROM TT_PhieuXuat
SELECT * FROM KhachHang
SELECT * FROM MatHang
SELECT * FROM NhaCungCap
SELECT * FROM PhieuNhap
SELECT * FROM PhieuXuat
SELECT * FROM NhanVien
------------------------------PROCEDUCE------------------------------
--Procedure tìm kiếm Nhà cung cấp theo Mã nhà cung câp (Thành)
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
exec p_TimKiemNCC 'NCC006'

--Procedure để insert, delete, update vào bảng Nhân Viên (Thành)
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
exec Insert_NV 'NV007',N'Nguyễn Thị Lan',N'Nữ',N'Hưng Yên','0374523912','ntl@gmail.com',18660000
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
exec Update_NV 'NV007',N'Nguyễn Thị Lan',N'Nam',N'Hưng Yên','0374523912','ntl@gmail.com',15660000
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
exec Delete_NV 'NV007'

--Procedure Lấy ra số lượng nhập của một mã hàng bất kì trong năm bất kì (Trung)
alter proc SP_SoluongNhap
@ID_MH char(5),
@NamNhap char(5),
@Soluong int output
as
begin 
--declare @SLN int
select @Soluong = Sum (TT_PhieuNhap.Soluong )
from TT_PhieuNhap, PhieuNhap 
where TT_PhieuNhap.ID_PN = PhieuNhap.ID_PN and
TT_PhieuNhap.ID_MH = @ID_MH and year(PhieuNhap.NgayNhap) =  @NamNhap
--set @Soluong = @SLN
end
----Thực thi----
declare @SoluongNhap int
exec SP_SoluongNhap 'MH011','2020',
	 @SoluongNhap output
print N'Số lượng nhập: '+ cast(@SoLuongNhap as char(10))
-----
--Procedure Lây ra số lượng tồn của mỗi mặt hàng (Trung)
select * from V_SLNhap
----
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
-----
--5.Procedure kiểm tra khi xuất hàng nếu số lượng xuất > số lượng tồn thì không cho phép xuất (Trung)
select * from V_SoLuongTon

create proc SP_XuatKho
@SoLuongXuat int,
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
if(select SoLuongTon from V_SoLuongTon where ID_MH = @ID_MH) < @SoLuongXuat
	begin
	--rollback tran 
	Print N'Không đù số lượng để xuất'
	end
else
	begin
	if exists(select ID_PX from PhieuXuat where ID_PX = @ID_PX)
	begin
		insert into TT_PhieuXuat
		values (@ID_TTPX,@ID_PX,@ID_MH ,@ID_KH ,@SoLuongXuat,@DonGia,@TinhTrang, null,null)
		Print N'Xuất kho thành công'
	end
	else
	begin
		insert into PhieuXuat
		values (@ID_PX, @ID_NV, @NgayXuat)
		insert into TT_PhieuXuat
		values (@ID_TTPX,@ID_PX,@ID_MH ,@ID_KH ,@SoLuongXuat,@DonGia,@TinhTrang, null,null)
		Print N'Xuất kho thành công'
	end
	end
end
--Thực thi---
exec SP_XuatKho 10,'PX011', 'NV003','2020-11-24','X0062','MH018','KH002',15320000,N'Không lỗi'
select * from TT_PhieuXuat where ID_TTPX='X0062'
select * from PhieuXuat where ID_PX='PX011'
--delete from TT_PhieuXuat where ID_TTPX = 'X0062'
--delete from PhieuXuat where ID_PX = 'PX011'

------------------------------VIEW------------------------------
--View v_SLNhap/v_SLXuat hiển thị số lượng nhập/xuất của các mặt hàng (Trung)
create view V_SLNhap
as
select MatHang.ID_MH, MatHang.TenMH, sum(TT_PhieuNhap.Soluong) as SoLuongNhap, DonGiaNhap
from TT_PhieuNhap, MatHang 
where TT_PhieuNhap.ID_MH = MatHang.ID_MH 
group by MatHang.ID_MH,MatHang.TenMH, DonGiaNhap

select * from V_SLNhap
select * from MatHang
-----
create view V_SLXuat
as
select MatHang.ID_MH, MatHang.TenMH, sum(TT_PhieuXuat.Soluong) as SoLuongXuat, DonGiaXuat
from TT_PhieuXuat, MatHang 
where TT_PhieuXuat.ID_MH = MatHang.ID_MH 
group by MatHang.ID_MH,MatHang.TenMH, DonGiaXuat

select * from V_SLXuat
-----
--View V_ChiTietPhieuNhap gồm ID_NV, TenNV,ID_PN, NgayNhap, ID_TTPN, IDMH, TenMH,ID_NCC, TenNCC (Thành)
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

--View Chứa thông tin khách hàng hợp tác trên 5 năm, thông tin lịch sử mua hàng (Thành)
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

--View Chứa thông tin Mặt Hàng Xuất từ tháng 1/2020 đến tháng 1/2021 (Thành)
create view TT_XuatHang
as
select distinct MatHang.*
from PhieuXuat, TT_PhieuXuat, MatHang
where PhieuXuat.ID_PX = TT_PhieuXuat.ID_PX
and TT_PhieuXuat.ID_MH = MatHang.ID_MH
and PhieuXuat.NgayXuat between '2020-05-01' and '2021-05-01' 

--thực thi
select * from TT_XuatHang
-----
--6.View số lượng tồn của từng mặt hàng (Trung)
create view V_SoLuongTon
as 
select MatHang.ID_MH, MatHang.TenMH,
((dbo.V_SLNhap.SoluongNhap) - (dbo.V_SLXuat.SoluongXuat)) as SoLuongTon 
from dbo.V_SLNhap,  dbo.V_SLXuat, MatHang
where dbo.V_SLNhap.ID_MH = dbo.V_SLXuat.ID_MH 
and MatHang.ID_MH = dbo.V_SLNhap.ID_MH 

select * from V_SoLuongTon
-----
--7.View V_ChiTietPhieuXuat gồm ID_NV, TenNV,ID_PX, NgayXuat, ID_TTPX, IDMH, TenMH,ID_KH, TenKH (Trung)
create view V_ChiTietPhieuXuat
as 
select TT_PhieuXuat.ID_TTPX,PhieuXuat.ID_PX,NhanVien.ID_NV,
NhanVien.TenNV,PhieuXuat.NgayXuat,KhachHang.ID_KH,MatHang.ID_MH,
MatHang.TenMH,KhachHang.TenKH
from TT_PhieuXuat,MatHang,KhachHang,NhanVien,PhieuXuat
where PhieuXuat.ID_PX = TT_PhieuXuat.ID_PX
and NhanVien.ID_NV = PhieuXuat.ID_NV 
and MatHang.ID_MH = TT_PhieuXuat.ID_MH
and KhachHang.ID_KH = TT_PhieuXuat.ID_KH
group by NhanVien.ID_NV, NhanVien.TenNV, PhieuXuat.ID_PX, 
PhieuXuat.NgayXuat, TT_PhieuXuat.ID_TTPX,
MatHang.ID_MH, MatHang.TenMH,KhachHang.TenKH,KhachHang.ID_KH
-----
select * from V_ChiTietPhieuXuat
--View chứa tên nhân viên làm việc với tên khách hàng (Thành)
create view v_NV_Kh
as
select NhanVien.TenNV, KhachHang.TenKH from
NhanVien,KhachHang,TT_PhieuXuat,PhieuXuat
where NhanVien.ID_NV = PhieuXuat.ID_NV and PhieuXuat.ID_PX =
TT_PhieuXuat.ID_PX and TT_PhieuXuat.ID_KH = KhachHang.ID_KH
-- thực thi
select * from v_NV_Kh
------------------------------TRIGGER------------------------------
--Trigger tính tổng Tiền giá nhập của từng mã hàng (TG_TongGiaNhap) khi thêm hoặc update dữ liệu (Trung)
Alter table TT_PhieuNhap
add TongGiaNhap money
----
create trigger TongGiaNhap
on TT_PhieuNhap
for Update, insert
as
Update TT_PhieuNhap set TongGiaNhap = Soluong * DonGiaNhap 

--thực thi
select * from TT_PhieuNhap
insert into TT_PhieuNhap
	values ('N0095','PN014','MH014',500,15000000,' 98%' , null)
	--select * from TT_PhieuNhap where ID_PN =  'PN001'
	--delete from TT_PhieuNhap where ID_TTPN = 'N0095'
	--select * from TT_PhieuNhap where ID_MH = 'MH002'
-----------------------------------------------------------------------------------
--Trigger tính tổng Tiền giá xuất của từng mã hàng (TG_TongGiaXuat) khi thêm hoặc update dữ liệu (Thành)
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
---Thực thi---
insert into TT_PhieuXuat
values ('X0098','PX002','MH003','KH001',1300,18990000,N'Không lỗi', null,null)
delete from TT_PhieuXuat where ID_TTPX = 'X0098'
select * from TT_PhieuXuat
select * from KhachHang


--Trigger không thể thêm mặt hàng đã bị trùng.(Trung)
create trigger ThemMatHang
on MatHang
for insert
as
if(( select count(TenMH) from MatHang where TenMH = (select TenMH from inserted))> 1)
begin 
print N'Mặt hàng này đã tồn tại'
rollback tran
end
--Thực thi--
Insert into MatHang
values ('MH025', N'Iphone 6', 'NCC002', '2018-07-12')
-----
delete from MatHang where ID_MH = 'MH025'
select * from MatHang

--Trigger khi cập nhật mặt hàng thì tên mới không được trùng với tên cũ và không trùng với tên nào trong bảng (Thành)
create trigger update_MH
on Mathang
for update
as
if(( select count(TenMH) from MatHang where TenMH = (select TenMH from inserted))> 1)
begin 
print N'Mặt hàng này đã tồn tại'
rollback tran
end
else if(select TenMH from inserted) = (select TenMH from deleted)
begin
print N'Tên vừa sửa trùng với tên cũ';
rollback tran	
end
else
print N'Sửa thành công'
---Thực thi---
update MatHang 
set TenMH=N'Iphone 8' where ID_MH='MH001';
-----
update MatHang 
set TenMH=N'Iphone 12' where TenMH=N'Iphone 8';
-----
update MatHang 
set TenMH=N'Iphone 8' where ID_MH='MH002';

--Trigger không cho cập nhật dữ liệu Phieu Nhap (Trung)
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
--Trigger không cho cập nhật dữ liệu Phieu Xuat (Thành)
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

--7.Trigger khi thêm 1 KH thì ngày hợp tác không được lớn hơn ngày hiện tại (Trung)
create trigger trigg_Ngayhoptac
on KhachHang
for insert
as 
if(select (NgayHopTac) from inserted) > (GETDATE())
begin
print N'Ngày hợp tác không thể lớn hơn ngày hiện tại'
rollback tran
end
---thực thi---
select * from KhachHang
insert into KhachHang 
values ('KH011',N'AVBCCC', N'Tây Sơn - Hà Nội', '0435640991', 'avbcc@gmail.com', N'2022-01-15')
delete from KhachHang where ID_KH='KH011'

------------------------------FUNCTION------------------------------
--4.Function in ra khách hàng theo địa chỉ bất kì (Thành)
create function F_dckh (@dc nchar(50))
returns table
as
return (select * from KhachHang where Diachi Like N'%'+@dc+'%')
-- thực thi
select * from dbo.F_dckh (N'Thái Bình')

--Function trả về số lượng nhập của một mặt hàng bất kì trong khoảng thời gian nhập bất kì (Trung)
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

--Function trả về danh sách Khách hàng mua một mặt hàng bất kì (Thành)
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

--Function tính tổng tiền của một đơn nhập bất kì (Trung)
create function F_TongTien(@ID_PN char(5))
returns money
as
begin
declare @TongGiaNhap money
select @TongGiaNhap = Sum(TT_PhieuNhap.TongGiaNhap)
from TT_PhieuNhap, PhieuNhap
where TT_PhieuNhap.ID_PN = PhieuNhap.ID_PN 
and TT_PhieuNhap.ID_PN = @ID_PN
return @TongGiaNhap
end
----Thực thi----
select dbo.F_TongTien('PN001') as TongGiaPN
-----
--5.Function tính tổng số lượng hàng tồn trong kho(Thành)
create function TongSLHT()
returns int
as
begin 
	declare @tong float
	select @tong=sum(SoLuongTon)from V_SoLuongTon
	return @tong
end
select dbo.TongSLHT() as TongSoHangTonTrongKho

-----
--6.Function cho biết thông tin các mặt hàng được cung cấp bởi NCC bất kì(Trung)
create function TTMH_NCC(@ncc char(100))
returns table 
as
return( select * from MatHang where ID_NCC = @ncc)

---thực thi---
select * from dbo.TTMH_NCC(N'NCC001')

select ID_MH,sum(TT_PhieuNhap.SoLuong) as 'Mat hang nhap nhieu nhat' from TT_PhieuNhap group by ID_MH

select count(ID_MH) as 'So Phieu Nhap', ID_NV
from TT_PhieuNhap,PhieuNhap
where TT_PhieuNhap.ID_PN=PhieuNhap.ID_PN
group by ID_NV
order by count(ID_MH)  desc;
-----
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