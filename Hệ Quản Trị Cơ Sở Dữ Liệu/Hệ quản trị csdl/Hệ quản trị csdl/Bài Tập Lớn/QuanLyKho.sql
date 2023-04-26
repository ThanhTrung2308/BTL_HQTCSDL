create database QuanLyKho_BTL
go
use QuanLyKho_BTL
go

create table NhaCungCap
(
	ID_NCC char(6)not null primary key,
	TenNCC nchar(50)not null,
	Diachi nvarchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	ThongTin nvarchar(200)not null,
	
)
alter table NhaCungCap
alter column ID_NCC char(6) 
insert into NhaCungCap
	values  ('NCC001', N'Apple',N'American','0987654321','apple@icloud.com',N'Cung cấp sản phẩm từ Apple'),
			('NCC002', N'Samsung',N'Bắc Ninh','0123456789','samsung@gmail.com',N'Cung cấp sản phẩm từ Samsung'),
			('NCC003', N'Xiaomi',N'Trung Quốc','0147852369','xiaomi@gmail.com',N'Cung cấp sản phẩm từ Xiaomi'),
			('NCC004', N'Toshiba', N'Korea', '0321654987', 'toshiba@gmail.com', N'Cung cấp sản phẩm từ Toshiba'),
			('NCC005', N'Sony', N'Japan', '0963258741', 'sony@gmail.com', N'Cung cấp sản phẩm từ Sony'),
			('NCC006', N'Microsoft', N'American', '0321654987', 'microsoft@outlook.com', N'Cung cấp sản phẩm từ Microsoft');

create table MatHang
(
	ID_MH char(5)not null primary key,
	TenMH nchar(50)not null,
	ID_NCC char(5)not null,
	ngaySanXuat date,
	foreign key (ID_NCC) references NhaCungCap(ID_NCC)
)
insert into  MatHang
	values ('MH001',N'Iphone 8','NCC001','2018-07-12'),
			('MH002',N'Máy Giặt','NCC002','2020-11-01'),
			('MH003',N'Xiaomi K30 pro','NCC003','2019-06-13'),
			('MH004',N'Microsoft Surface book','NCC006','2019-03-10'),
			('MH005',N'PSS','NCC005','2018-09-12'),
			('MH006',N'Sony Xperia 1','NCC005','2019-08-20'),
			('MH007',N'Điều hòa 2 chiều Toshiba','NCC004','2020-12-12'),
			('MH008',N'Tivi 4k Super thin','NCC002','2020-04-29'),
			('MH009',N'Galaxy Note 20','NCC002','2020-01-04'),
			('MH010',N'Microsoft office 365','NCC006','2015-12-01'),
			('MH011',N'Iphone 11','NCC001','2020-04-22'),
			('MH012',N'Quạt trần Toshiba','NCC004','2019-09-11'),
			('MH013',N'Sony Alpha A6000','NCC005','2015-08-27'),
			('MH014',N'Iphone 6','NCC001','2016-10-09'),
			('MH015',N'Microsoft Surface Duo','NCC006','2020-02-28'),
			('MH016',N'Tai nghe Sony ZAQR-11','NCC005','2018-06-27'),
			('MH017',N'Samsung Galaxy Watch 3','NCC002','2019-06-09'),
			('MH018',N'Apple Watch Series 5','NCC001','2020-01-01'),
			('MH019',N'Thẻ nhớ Toshiba 128GB','NCC004','2016-09-10'),
			('MH020',N'Bộ phát wifi Router 4C Xiaomi','NCC003','2020-10-13');



create table KhachHang
(
	ID_KH char(5)not null primary key,
	TenKH nchar(50)not null,
	Diachi nchar(200)not null,
	SDT char(12)not null,
	Email char(30)not null,
	NgayHopTac date not null
)
--alter table KhachHang
--drop column ThongTin
insert into KhachHang
	values ('KH001',N'CellphoneS',N'Thái Hà - Hà Nội','0123654789','cellphoneS@gmail.com',N'2015-01-02'),
			('KH002',N'HanoiPhone ',N'Cầu Giấy - Hà Nội','0369258741','hanoiphone@gmail.com',N'2016-02-03'),
			('KH003',N'Thế giới di động',N'Văn Giang - Hưng Yên','0258963147','thegioididong@gmail.com',N'2012-10-13'),
			('KH004',N'Mobile City',N'Long Biên - Hà Nội','0985263741','mobilecity@gmail.com',N'2017-03-30'),
			('KH005',N'Điện máy xanh',N'Đông Sơn - Thanh Hóa','0159263487','dienmayxanh@gmail.com',N'2014-07-19'),
			('KH006',N'TCS',N'Hai Bà Trưng - Hà Nội','0753421869','tcs@gmail.com',N'2015-04-11'),
			('KH007',N'Điện máy Pico',N'Kiến Xương - Thái Bình','0957846123','dienmaypico@gmail.com',N'2019-09-30'),
			('KH008',N'Phong Vũ',N'TP Thanh Hóa - Thanh Hóa','0249563871','phongvu@gmail.com',N'2014-10-12'),
			('KH009',N'Nguyễn Kim',N'Thủy Nguyên - Hải Phòng','0836521974','nguyenkim@gmail.com',N'2018-05-06'),
			('KH010',N'Đại học Thủy Lợi',N'Tây Sơn - Hà Nội','0435640199','dhtn@e.tlu.edu.vn',N'2012-11-20');





create table PhieuNhap
(	
	ID_PN char(5)not null primary key,
	NgayNhap date not null
)
create table TT_PhieuNhap
(
	ID_TTPN char(5)not null primary key,
	ID_PN char(5) not null,
	ID_MH char(5) not null,
	Soluong int not null,
	GiaNhap money not null,
	TinhTrang nchar(200) not null,
	foreign key (ID_PN) references PhieuNhap(ID_PN),
	foreign key (ID_MH) references MatHang(ID_MH)
)

create table PhieuXuat
(	
	ID_PX char(5)not null primary key,
	NgayXuat date
)
create table TT_PhieuXuat
(
	ID_TTPX char(5)not null primary key,
	ID_PX char(5) not null,
	ID_MH char(5) not null,
	ID_KH char(5) not null,
	Soluong int not null,
	GiaXuat money not null,
	TinhTrang nchar(200)
	foreign key (ID_PX) references PhieuXuat(ID_PX),
	foreign key (ID_MH) references MatHang(ID_MH),
	foreign key (ID_KH) references KhachHang(ID_KH)

)
