Create database QLTV
use QLTV
Create table NhanVien
(
	MaNhanVien int primary key not null,
	MatKhau nvarchar(20),
	HoTen nvarchar(30) not null,
	SDT int not null,
	DiaChi nvarchar(50) not null,
	CMT int unique,
	Luong int not null,
	NgaySinh date not null,
	GioiTinh nvarchar(4) not null,
	Check(GioiTinh = N'Nam' Or GioiTinh=N'Nữ'),
	ChucVu nvarchar(10) not null,
	Check (ChucVu=N'QuanLy' Or ChucVu=N'ThuThu' Or ChucVu=N'ThuKho')
)
Create table Sach
(
	MaSach nvarchar(20) primary key not null,
	TenSach nvarchar(20) not null,
	TheLoai nvarchar(20) not null,
	NhaXuatBan nvarchar(30)not null,
	NamXuatBan date not null,
	TacGia nvarchar(4) not null
)
Create table DocGia
(
	MaDocGia int primary key not null,
	HoTen nvarchar(20) not null,
	SDT int not null,
	DiaChi nvarchar(50) not null,
	CMT int unique,
	NgaySinh date not null,
	GioiTinh nvarchar(4) not null,
	Check(GioiTinh = N'Nam' Or GioiTinh=N'Nữ')
)
Create table PhieuMuon
(
	MaPhieu int primary key not null,
	MaSach nvarchar(20) not null,
	TenSach nvarchar(20) not null,
	MaDocGia int not null ,
	TenDocGia nvarchar(30) not null,
	NgayMuon date not null,
	HanTra date not null,
	TienMuon int not null,
	TienCoc int not null,
	Foreign key (MaSach) References Sach(MaSach), 
	Foreign key (MaDocGia) References DocGia(MaDocGia)
)
Create table PhieuTra
(
	MaPhieuTra int primary key not null,
	MaPhieuMuon int not null,
	MaDocGia int not null,
	TenDocGia nvarchar(30) not null,
	NgayMuon date not null,
	HanTra date not null,
	NgayTra date not null,
	TienCoc int not null,
	Foreign key (MaDocGia) References DocGia(MaDocGia),
	Foreign key (MaPhieuMuon) References PhieuMuon(MaPhieu)
)

--Phân Quyền
go
sp_addrole 'QuanLy' -- thêm nhóm quyền role tên ADMIN 
go
sp_addrole 'ThuThu' -- thêm nhóm quyền role tên ThuThu
go
sp_addrole 'ThuKho' -- thêm nhóm quyền role tên ThuKho

--Thêm quyền
GRANT SELECT,INSERT,UPDATE,DELETE ON NhanVien  TO QUANLY
GRANT SELECT,INSERT,UPDATE,DELETE ON Sach  TO QUANLY
GRANT SELECT,INSERT,UPDATE,DELETE ON DocGia  TO QUANLY
GRANT SELECT,INSERT,UPDATE,DELETE ON PhieuMuon  TO QUANLY
GRANT SELECT,INSERT,UPDATE,DELETE ON PhieuTra  TO QUANLY

GRANT SELECT,INSERT,UPDATE,DELETE ON Sach  TO ThuKho

GRANT SELECT,INSERT,UPDATE,DELETE ON DocGia  TO ThuThu
GRANT SELECT,INSERT,UPDATE,DELETE ON PhieuMuon  TO ThuThu
GRANT SELECT,INSERT,UPDATE,DELETE ON PhieuTra  TO ThuThu
GRANT SELECT ON Sach  TO ThuThu
--Tạo thủ tục phân quyền
go
	CREATE PROC addQuyen (@MaNhanVien varchar(50)  ,@mk varchar(50)  ,@chucvu nchar(50))
	AS 
	BEGIN
    EXECUTE sp_addlogin @MaNhanVien, @mk  
	execute  sp_grantdbaccess @MaNhanVien, @MaNhanVien
	IF (@chucvu = 'QUANLY')
	EXECUTE sp_addrolemember 'QuanLy',@MaNhanVien 
	ELSE IF (@chucvu = 'ThuKho')
	EXECUTE sp_addrolemember 'ThuKho',@MaNhanVien
	ELSE
	EXECUTE sp_addrolemember 'ThuThu',@MaNhanVien
	End
-- thu lại quyền 
go	
	CREATE PROC xoaquyen (@tk NCHAR(50))
	AS
	BEGIN 
	EXECUTE sp_droplogin @tk
	EXECUTE sp_dropuser @tk 
	END


--1.View
--1.1:View độc giả mượn sách quá hạn chưa trả
go
Create View ViewMuonSachQuaHan(MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh)
As
Select DocGia.MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh From DocGia 
	left join PhieuTra On PhieuTra.MaDocGia=DocGia.MaDocGia
		WHERE CAST(GETDATE()) > HanTra
--1.2: View sách chưa từng có người mượn
go
Create View ViewSachChuaDuocMuon(MaSach,TenSach,TheLoai,NhaXuatBan,TacGia)
As
Select Sach.MaSach,Sach.TenSach,TheLoai,NhaXuatBan,TacGia From Sach
	left join PhieuMuon On PhieuMuon.MaSach!=Sach.MaSach
--1.3 View Danh mục sach đang có độc giả mượn
go
--1.4: View Hiển thị thông tin các cuốn sách của NXB "Giao dục"
go
Create View ViewThongTinSach(MaSach,TenSach,TheLoai,NhaXuatBan,TacGia)
As
Select Sach.MaSach,Sach.TenSach,TheLoai,NhaXuatBan,TacGia From Sach
	Where NhaXuatBan='Giáo dục'
--1.5:View Đưa ra thông tin gồm mã nv, họ tên và địa chỉ của tất cả các nhân viên

--1.6:view Đưa ra thông tin của các nhân viên(Thủ thư,thủ kho) có địa chỉ ở "Hà Nội"
go
Create View ViewThongTinNhanVien(MaNhanVien,HoTen,SDT,DiaChi,CMT,Luong,NgaySinh,GioiTinh,ChucVu)
As 
Select NhanVien.MaNhanVien,HoTen,SDT,DiaChi,CMT,Luong,NgaySinh,GioiTinh,ChucVu from NhanVien
	Where NhanVien.DiaChi='Hà Nội'
--1.7.view đưa ra thông tin sách thể loại "Kinh dị" đang được mượn
go
Create View ViewThongTinTheLoaiSach(MaSach,TenSach,TheLoai,NhaXuatBan,TacGia)
As
Select Sach.MaSach,Sach.TenSach,TheLoai,NhaXuatBan,TacGia From Sach
	Where TheLoai='Kinh dị'
--1.8.view đưa ra thông tin những độc giả đang mượn trên 5 cuốn sách
Go
Create view ViewDocGiaMuon5CuonSach (MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh)
As
Select DocGia.MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh from DocGia
	Left join PhieuMuon On PhieuMuon.MaDocGia=DocGia.MaDocGia
	left join PhieuTra On PhieuTra.MaPhieuMuon!=PhieuMuon.MaPhieu
		Where PhieuMuon.SoLuong >=5
--1.9.view hiển thị thông tin độc giả mượn sách vào ngày 1/1/2021
Go
Create view ViewDocGiaMuonSachNgay (MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh)
As
Select DocGia.MaDocGia,HoTen,SDT,DiaChi,CMT,NgaySinh,GioiTinh from DocGia
	left join PhieuMuon On PhieuMuon.MaDocGia=DocGia.MaDocGia
		Where PhieuMuon.NgayMuon='1/1/2021'

--2.Trigger
--2.1.Tạo trigger quản lý thêm nhân viên mới vào ngày sinh của nhân viên không >= 45 tuổi 
go
create trigger checkTuoiNhanVien
on NhanVien after insert as
if((select DATEDIFF(YYYY,NgaySinh,GETDATE()) from inserted) >= 45)
    begin
        print 'Loi! Tuoi nhan vien khong duoc lon hon 45'
        rollback transaction
    end
else 
	print 'Them thanh cong'

--2.2.Tạo trigger hiển thị thông báo mỗi khi cập nhật thành công 1 bản ghi của bảng Độc giả
go
create trigger UpdateDocGia
on NhanVien for update as
	Print 'Cap nhat thanh cong'

--2.3.Tạo trigger tính tiền phạt 
go
create trigger triggerSachQuaHan
on PhieuTra after insert as
if((select NgayTra from inserted) > (select HanTra from inserted))
	begin 
		Print 'Sach da qua han'
	end

--2.4.Tạo trigger kiểm tra nếu Thủ kho muốn sửa thông tin của độc giả thì không cho phép và hiển thị thông báo
--2.5.Tạo trigger kiểm tra nếu Thủ thư muốn sửa thông tin của sách thì không cho phép và hiển thị thông báo
--2.6. Tạo trigger để tránh xóa 2 bản ghi trong bảng Thủ thư,Thủ kho đồng thời.
go
create trigger XoaNhanVien 
on NhanVien for delete as 
if((select count(MaNhanVien) from deleted) >=2)
    begin
        print 'Khong the xoa 2 ban ghi dong thoi'
        rollback transaction
    end

--2.7.Tạo trigger đảm bảo rằng Ngày sinh không lớn hơn ngày hiện tại.
go
create trigger NgaySinhNhanVien 
on NhanVien after insert as 
if((select NgaySinh from inserted) > GETDATE())
    begin
        print 'Ngay sinh khong the lon hon ngay hien tai'
        rollback transaction
    end
--2.9.Tạo trigger không cho độc giả mượn thêm sách nếu như độc giả đó đang mượn >=5 cuốn sách quá hạn chưa trả.
go
create trigger triggerKhongChoMuonSach
on PhieuMuon after insert as


--Thủ tục
----3.1.Viết thủ tục thêm độc giả
go
create proc sp_insertDocgia(@MaDocGia int,@HoTen nvarchar(20) ,@SDT int ,@DiaChi nvarchar(50) ,@CMT int ,@NgaySinh date ,@GioiTinh nvarchar(4) )
as
begin
INSERT INTO DocGia 
VALUES(@MaDocGia ,@HoTen ,@SDT  ,@DiaChi  ,@CMT  ,@NgaySinh  ,@GioiTinh )
end

----3.1.Viết thủ tục thêm Nhân viên
go
create proc sp_insertNhanVien(@MaNhanVien int,@HoTen nvarchar(30),@SDT int,@DiaChi nvarchar(50),@CMT int,@Luong int,@NgaySinh date,@GioiTinh nvarchar(4),@ChucVu nvarchar(10))
as
begin
INSERT INTO NHANVIEN 
VALUES(@MaNhanVien,@HoTen,@SDT,@DiaChi,@CMT,@Luong,@NgaySinh,@GioiTinh,@ChucVu )
end

--3.2.viết thủ tục xóa sách
go
create proc sp_deleteSach(@MaSach nvarchar(20))
as
begin
delete from Sach
where @MaSach=MaSach
end

--3.3.viết thủ tục trả về thông tin sách đang được mượn nhiều nhất với mã sách là tham số truyền vào.  
go
create proc sp_sachmuonhieunhat(@masach nvarchar(20))
as
begin
declare @maphieumuon int
select @maphieumuon =PhieuMuon.MaPhieu from PhieuMuon
where PhieuMuon.MaSach= @masach
declare @max float
select @max = COUNT(MaSach) from PhieuMuon
where PhieuMuon.MaPhieu=@maphieumuon
select Sach.TenSach,TheLoai,NhaXuatBan,NamXuatBan,TacGia from Sach,PhieuMuon
where Sach.MaSach = PhieuMuon.MaSach
and PhieuMuon.MaSach=@max
and PhieuMuon.MaPhieu=@maphieumuon
end

--3.4.viết thủ tục tính số độc giả mượn sách trong 1 ngày
go
create proc sp_sachmuon(@Ngay date,@sosach int output )
as
begin
	select @sosach=Count(PhieuMuon.MaPhieu) from PhieuMuon Where NgayMuon=@Ngay
end

--3.5.viết thủ tục tính tổng số sách có trong thư viện với mã sách là tham số truyền vào
go
create proc sp_tongsach(@masach nvarchar(20),@tongsach int output)
as
begin
select @tongsach= COUNT(Masach) from Sach
where Sach.MaSach=@masach
end

--Hàm
--4.1.Viết hàm tính tổng số độc giả
go
create function fu_sldg ()
returns int
as
begin
declare @sldg int
select @sldg =COUNT(MaDocGia) from DocGia
return @sldg
end

--4.2.Viết hàm trả về danh sách độc giả chưa từng mượn sách

--4.3.viết hàm tính số lượng phiếu mượn có ngày mượn là tham số truyền vào
go
create function fu_slpm (@ngaymuon date)
returns int
as
begin
declare @sl int
select @sl =COUNT(MaPhieu) from PhieuMuon
where PhieuMuon.NgayMuon=@ngaymuon
return @sl
end
----4.4.viết hàm trả về danh sách độc giả mượn sách với tên sách là tham số truyền vào
go
create function fu_dsdg (@tensach nvarchar(20))
returns @bien table (MaDocGia int,HoTen nvarchar(20) ,SDT int ,DiaChi nvarchar(50) ,CMT int ,NgaySinh date ,GioiTinh nvarchar(4) )
as
begin
insert into @bien
select DocGia.MaDocGia,Hoten,SDT,DiaChi,CMT,NgaySinh,GioiTinh from DocGia 
left join PhieuMuon on PhieuMuon.MaDocGia=DocGia.MaDocGia
where PhieuMuon.TenSach=@tensach
return
end

--4.5.viết hàm trả về danh sách độc giả phải trả sách vào 1 ngày nào đó
go
create function dst (@ngaytra date)
returns @bien table(MaDocGia int,HoTen nvarchar(20) ,SDT int ,DiaChi nvarchar(50) ,CMT int ,NgaySinh date ,GioiTinh nvarchar(4) )
as
begin
insert into @bien
	select DocGia.MaDocGia,Hoten,SDT,DiaChi,CMT,NgaySinh,GioiTinh from DocGia 
	left join PhieuMuon on PhieuMuon.MaDocGia=DocGia.MaDocGia
	where PhieuMuon.HanTra=@ngaytra
	return
end

--4.7.viết hàm tính tổng số đã và đang mượn của một độc giả nào đó với mã độc giả là tham số truyền vào.
go
create function fu_tongsosach (@MaDocGia int)
returns int
as
begin
	Declare @TSS int;
	select @TSS=COUNT(PhieuMuon.MaPhieu) from PhieuMuon Where PhieuMuon.MaDocGia=@MaDocGia
	return @TSS
end

--4.8.viết hàm tính tổng số lương của nhân viên
go
create function fu_tongsonhanvien ()
returns int
as
begin
	Declare @TSNV int;
	select @TSNV=COUNT(NhanVien.MaNhanVien) from NhanVien
	return @TSNV
end

--4.9.viết hàm hiển thị danh sách thông tin phiếu mượn sắp đến hạn trả trước ngày hạn 1 ngày.


