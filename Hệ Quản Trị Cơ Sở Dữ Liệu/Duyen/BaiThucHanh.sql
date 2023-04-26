--Câu 1:
create function f_ThanhTien(@IDDonHang int, @IDSanPham nchar(10))
returns int
as begin
	declare @Tien int
	select @Tien=SoLuong*DonGiaBan*(1-TyLeGiamGia)
	from SP_DonHang where idDH=@IDDonHang and idSP=@IDSanPham
	return @Tien
end
print dbo.f_ThanhTien(1,'SP1');
--Câu 2
create function f_TongTien(@IDDonHang int)
returns int
as begin
	declare @TongTien int
	select @TongTien=sum(dbo.f_ThanhTien(@IDDonHang,idSP))
	from SP_DonHang where idDH=@IDDonHang
	return @TongTien
end
select dbo.f_TongTien(1);
--Câu 3:
alter function f_SP_DonHang(@IDDonHang int)
returns @bang1 table(IDSanPham char(10), TenSanPham nvarchar(45), TenLoaiHang nvarchar(45), TenCongTyCungCap nvarchar(45), SoLuong int,
DonGiaBan int, TyLeGiamGia float, ThanhTien int)
as begin
	insert into @bang1
	select SanPham.idSP, SanPham.TenSP, LoaiHang.TenLoaiHang, NhaCungCap.TenCongTy, SP_DonHang.SoLuong, 
	SP_DonHang.DonGiaBan, SP_DonHang.TyLeGiamGia, dbo.f_ThanhTien(@IDDonHang,SanPham.idSP) as ThanhTien
	from SanPham, LoaiHang, NhaCungCap, SP_DonHang
	where SanPham.idLoaiHang=LoaiHang.idLoaiHang and SanPham.idNCC=NhaCungCap.idNCC
	and SanPham.idSP=SP_DonHang.idSP and SP_DonHang.idDH=@IDDonHang;
	return
end 
select * from dbo.f_SP_DonHang(1);
--Câu 4:
create view v_ChiTietDonHang
as 
select SP_DonHang.idDH, SP_DonHang.idSP, SanPham.TenSP, LoaiHang.TenLoaiHang, NhaCungCap.TenCongTy, SP_DonHang.SoLuong,
SanPham.DonGiaNhap, SP_DonHang.DonGiaBan, SP_DonHang.TyLeGiamGia, dbo.f_ThanhTien(SP_DonHang.idDH,SP_DonHang.idSP) as ThanhTienBan,
dbo.f_ThanhTien(SP_DonHang.idDH,SP_DonHang.idSP)-SanPham.DonGiaNhap*SP_DonHang.SoLuong as TienLai
from SP_DonHang, LoaiHang, NhaCungCap, SanPham
where SanPham.idLoaiHang=LoaiHang.idLoaiHang and SanPham.idNCC=NhaCungCap.idNCC and SanPham.idSP=SP_DonHang.idSP
select * from v_ChiTietDonHang;
--Câu 5:
create view v_TongKetDonHang
as 
	select DonHang.idDH, KhachHang.idKH, KhachHang.HoTen as HoTenKH, KhachHang.GioiTinh, NhanVien.idNV,
	NhanVien.HoTen as HoTenNV, DonHang.NgayDatHang, DonHang.NgayGiaoHang, DonHang.NgayYeuCauChuyen, 
	CtyGiaoHang.idCty, CtyGiaoHang.TenCongTy, count(dbo.v_C1.idSP) as SoMatHang,
	sum(dbo.v_C1.ThanhTienBan) as TongtienHoaDon, sum(dbo.v_C1.TienLai) as TongTienLai
	from DonHang, KhachHang, NhanVien, CtyGiaoHang, dbo.v_C1
	where DonHang.idKH=KhachHang.idKH and DonHang.idNV=NhanVien.idNV and DonHang.idCty=CtyGiaoHang.idCty
	and DonHang.idDH=dbo.v_C1.idDH
	group by DonHang.idDH, KhachHang.idKH, KhachHang.HoTen, KhachHang.GioiTinh, NhanVien.idNV, NhanVien.HoTen,
	DonHang.NgayDatHang, DonHang.NgayGiaoHang, DonHang.NgayYeuCauChuyen, CtyGiaoHang.idCty, CtyGiaoHang.TenCongTy
select * from v_TongKetDonHang;
--Câu 6:
--Tìm nhân viên bán được nhiều đơn hàng nhất:
select count(idDH), idNV
from dbo.v_TongKetDonHang 
group by idNV
having count(idDH)>=all(select count(idDH) from dbo.v_TongKetDonHang group by idNV)
--Đưa ra danh sách các nhân viên theo thứ tự giảm dần của số đơn hàng bán
select count(idDH), idNV
from dbo.v_TongKetDonHang 
group by idNV
order by count(idDH) desc;
--Danh sách công ty giao hàng trể
select distinct TenCongTy from dbo.v_TongKetDonHang
where NgayGiaoHang>NgayYeuCauChuyen
--Danh sách mặt hàng giảm dần theo số tiền lãi
select TenSP from dbo.v_ChiTietDonHang
group by TenSP
order by sum(TienLai) desc;
--Đưa ra loại mặt hàng có số lượng bán nhiều nhất
select TenLoaiHang from dbo.v_ChiTietDonHang
group by TenLoaiHang
having sum(SoLuong)>=all(select sum(SoLuong) from dbo.v_ChiTietDonHang group by TenLoaiHang)
--Câu 7:
create trigger Cau7
on LoaiHang for insert
as
	if (select count(TenLoaiHang) from LoaiHang where TenLoaiHang=(select TenLoaiHang from inserted))>=2
	begin
		print N'Mặt hàng đã tồn tại'
		rollback tran
	end
	else
		print N'Thêm dữ liệu thành công'
select * from LoaiHang;
insert into LoaiHang values('LH4',N'Kẹo Cam',N'Đi bán');
--Câu 8:
alter trigger Cau8
on LoaiHang for update
as
	if(select count(TenLoaiHang) from LoaiHang where TenLoaiHang=(select TenLoaiHang from inserted))>=2
		begin
			print N'Tên Loại hàng đã tồn tại'
			rollback tran
		end
	else if ((select TenLoaiHang from inserted)=(select TenLoaiHang from deleted))
		begin
			print N'Tên Loại hàng bị trùng với tên trước đó'
			rollback tran
		end
	else 
		print N'Cập nhật thành công'
--Câu 9:
select * from NhaCungCap;
select * from SanPham;
create trigger Cau9
on NhaCungCap instead of delete
as
	update NhaCungCap set ConGiaoDich=0 where idNCC=(select idNCC from deleted)
	update SanPham set NgungBan=1 where idNCC=(select idNCC from NhaCungCap where idNCC=(select idNCC from deleted))
	print N'Cập nhật thành công'

delete from NhaCungCap where idNCC='NCC3';
--Câu 10: Thêm cột thành tiền vào bảng SP_DonHang, Viết trigger tự tính gtri của thành tiền= Số Lượng * Đơn Giá * Tỉ lệ Giảm Giá
alter table SP_DonHang
add ThanhTien float;
alter trigger Cau10
on SP_DonHang for insert,update
as
	update SP_DonHang set ThanhTien=SoLuong*DonGiaBan*(1-TyLeGiamGia);
insert into SP_DonHang(idDH,idSP,SoLuong,DonGiaBan,TyLeGiamGia) values(9,'SP4',15,2900,0.01)
select * from SP_DonHang;