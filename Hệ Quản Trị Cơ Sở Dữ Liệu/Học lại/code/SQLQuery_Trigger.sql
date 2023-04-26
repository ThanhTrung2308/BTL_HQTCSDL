create trigger insert_trigger_KH
on KhachHang
for insert
as print N'bạn đã chèn thành công'

SET IDENTITY_INSERT KhachHang ON
insert into KhachHang(idkhachhang, hoten, gioitinh, diachi, email, sodienthoai) values 
(8,N'Phạm Trường Giang',N'Nam',N'Hà Nam',N'assss@gmail.com',3213232);


---------------------------------------------------------------------------------------------------------------------------
create trigger del_trigger_KH
on KhachHang
for delete
as print N'bạn đã xóa thành công'

delete from KhachHang where idkhachhang = 6

---------------------------------------------------------------------------------------------------------------------------
create trigger up_trigger_KH
on KhachHang
for update
as print N'bạn đã cập nhật thành công'

select * from KhachHang
update KhachHang set hoten= N'Đạt  ' where idkhachhang = 5


---------------------------------------------------------------------------------------------------------------------------
/*Thêm 2 khách hàng mới cùng tên là A */
insert into KhachHang(idkhachhang, hoten, gioitinh, diachi, email, sodienthoai) values 
(6,N'A',N'Nam',N'Hà Nam',N'asdassss@gmail.com',222222222),
(7,N'A',N'Nam',N'Hà Nội',N'ff@gmail.com',333333);
/*Câu 1: viết 1 trigger không cho phép xóa cùng lúc >=2 bản ghi*/
create trigger cau1 on KhachHang for delete
as
if (select count(*) from deleted ) >=2
	begin
	print N'Không được phép xóa nhiều hơn 2 bản ghi'
	rollback tran
	end
else print N'Bạn đã xóa thành công'

delete from KhachHang where hoten = N'A'
select * from KhachHang
/*Câu 2: Viết 1 trigger để đảm bảo rằng khi thêm 1 khách hàng mới thì Địa chỉ phải chưa từng tồn tại trong CSDL*/
alter trigger cau2 on Khachhang for insert
as
if  (select count(*) from  KhachHang where diachi=(select diachi from inserted))>1
	begin	
	print N'Không thể thêm vì địa chỉ đã tồn tại'
	rollback tran
	end
else print N'Thêm thành công'

SET IDENTITY_INSERT KhachHang ON
insert into KhachHang(idkhachhang, hoten, gioitinh, diachi, email, sodienthoai) values (9,N'B',N'Nam',N'Hà Nam',N'as1221ss@gmail.com',332112);
insert into KhachHang(idkhachhang, hoten, gioitinh, diachi, email, sodienthoai) values (9,N'B',N'Nam',N'Tây Sơn',N'as1221ss@gmail.com',332112);
select * from KhachHang


/*Câu 3: trong CSDL QLD , viết 1 trigger để thêm 1 SV thì giới tính là 'nam' hoặc 'nữ'*/
alter trigger cau3 on SinhVien for insert
as
if ( select gioitinh from inserted ) = N'Nam' or ( select gioitinh from inserted ) =  N'Nữ'
	begin
	print N'Bạn đã chèn thành công' 
	end
else 
begin
print N'Không được phép chèn '
rollback tran
end

insert into SinhVien(masv, hoten, malop, gioitinh, ngaysinh) values (9,N'Nguyễn Thái Bình',58,N'lam','1998-06-15');

select * from SinhVien
delete from SinhVien where masv = 9
/*Câu 4: viết 1 trigger để khi thêm mới 1 SV thì đảm bảo rằng tuổi của SV đó <=30 và >18 (biết rằng trong bảng SINHVIEN có cột NgaySinh)*/
 alter Trigger insert_trigger_SV
 on SinhVien
 for insert 
 as
 if (select DATEDIFF(year, ngaysinh, GetDate()) from inserted) >18 and (select DATEDIFF(YEAR, ngaysinh, GetDate()) from  inserted)<=30
	begin
	print N'Bạn đã chèn thành công' 
	end
else 
begin
print N'Không được phép chèn '
rollback tran
end

insert into SinhVien(masv, hoten, malop, gioitinh, ngaysinh) values (9,N'Nguyễn Thái Bình',58,N'Nam',getdate());

select * from SinhVien
delete from SinhVien where masv = 9

/*Câu 5: thêm cột DTB vào bảng SV . viết 1 trigger để tự động cập nhật điểm trung bình của sv khi thêm điểm của sv đó vào bảng Diem*/

alter table SinhVien add  diemtrungbinh float ;

create trigger cau5_trig on Diem 
for insert
as
if((select masv from inserted) is not null)
begin
	update SinhVien
	set diemtrungbinh=(SELECT AVG(Diem.diem)
	from SinhVien,Diem
	where SinhVien.masv=Diem.masv
	and SinhVien.masv=(SELECT masv from inserted))
	where SinhVien.masv=(SELECT masv from inserted)
end

insert into Diem(masv, mamh, diem, lanthi)
values(7,1,7,1)
	
select*from Diem
select * from SinhVien
