--database QLSV

alter view KetQuaThi
as
select SinhVien.MaSV, SinhVien.HoTen, MONHOC.MaMH as alo, 
	MONHOC.TenMH, DIEM.Diem 
	from SINHVIEN
left join DIEM on SINHVIEN.MaSV = DIEM.MaSV
left join MONHOC on DIEM.MaMH = MONHOC.MaMH


select * from KetQuaThi

create view ViewSV(MaSV,HoTen,Tuoi)
as
Select MaSV,HoTen, DATEDIFF(yyyy, NgaySinh, getDate())
From SINHVIEN

select * from ViewSV where ViewSV. Tuoi = (select MAX(Tuoi) from ViewSV)

alter view Viewdtb(MaSV,TenSV,Diem)
as
select SinhVien.MaSV, SinhVien.HoTen, AVG(Diem)
	from SINHVIEN,Diem
	where SinhVien.MaSV = Diem.MaSV group by SinhVien.MaSV, hoten

select * from Viewdtb
	
select * from Viewdtb where Viewdtb.Diem = (select MAX(Diem) from Viewdtb)
select * from Viewdtb where Viewdtb.Diem = (select min(Diem) from Viewdtb)


create view KQTHI (Masv, hoten, maMon, tenm, Diem)
as
select SinhVien.masv, SinhVien.hoten, MonHoc.mamh, MonHoc.tenmh, Diem.diem from SinhVien, MonHoc, Diem
where SinhVien.masv = Diem.masv and Diem.mamh = MonHoc.mamh

insert into KQTHI(MaSV,HoTen)
values (20,N'Nguyễn Quỳnh Châu')

select * from KQTHI
select * from SinhVien


-- database QLKH1
ALTER TABLE SanPham
ADD dvtinh nvarchar(50)

create view MatHang (maHang, TenHang, MaCongTy, TenCongTyCungCap, MaLoaiHang, TenLoaiHang,SoLuong, DonViTinh, GiaHang)
as select sp.idSP, sp.TenSP, ncc.idNCC, ncc.TenCongTy, lh.idLoaiHang, lh.TenLoaiHang,sp.SoLuongChoCungCap,sp.dvtinh, sp.DonGiaNhap
from SanPham sp, LoaiHang lh, NhaCungCap ncc
where sp.idNCC = ncc.idNCC
and sp.idLoaiHang = lh.idLoaiHang

