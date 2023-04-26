use  QLKH
go
--cau1
create trigger cau1_trig on KhachHang for delete
as
if(select count(*) from deleted) >=2
	begin
	print N'Khong duoc phep xoa nhieu hon 2 ban gi'
	rollback tran
	end
else print N'Ban da xoa thanh cong'

--cau2
create trigger cau2_trig on KhachHang for insert
as
if (select count(*) from KhachHang where DiaChi =(select DiaChi from inserted)) > 1
  begin 
   print N'Mã khách hàng bị trùng'
   rollback tran
  end
else print N'Them thanh cong'


insert into KhachHang
(HoTen, GioiTinh, DiaChi, Email, SDT) values 
(N'Nguyen Cusongsss', N'Nam', N'Hưng Yên', N'Ngffffdun@gggggmaddil.com', N'098459fg68255')

select * from KhachHang
--cau3
Create trigger Cau3_trig
on KhachHang
for insert
as
if (select GioiTinh from inserted) != N'Nam' 
	or (select GioiTinh from inserted) != N'Nữ'
Begin
	print N'Giới tính không đúng'
	rollback tran
end
else print N'Bạn đã thêm thành công'

insert into KhachHang
(HoTen, GioiTinh, DiaChi, Email, SDT) values 
(N'Nguyen Cusongsss', N'Nam', N'Hưng Yên', N'Ngmadd', N'0985')

--cau4
create trigger checktuoi
On KhacHang
for insert
as
if (SELECT DATEDIFF(YEAR,GETDATE(dd),SinhVien.NgaySinh) from SinhVien)<18
and (SELECT DATEDIFF(YEAR,GETDATE(),SinhVien.NgaySinh) from SinhVien)>30
begin 
print N'Tuoi cua sinh vien khong hop le'
rollback tran
end
else print N'Them thanh cong'

print getdate(dd)

--cau5
alter trigger cau5_trig
on diem for insert
as
	update sv
	set dtb=(SELECT AVG(Diem)
	from SV,Diem
	where sv.MaSV=diem.MaSV
	and SV.MaSV=(SELECT MaSV from inserted))
	where SV.MaSV=(SELECT MaSV from inserted)

insert into Diem
values('SV2','MH2',8)

select*from Diem
select * from SV