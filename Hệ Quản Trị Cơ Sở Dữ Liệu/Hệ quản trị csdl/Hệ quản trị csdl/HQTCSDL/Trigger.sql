create trigger Update_ThanhTien
on SanPham
after update
as begin
update ThanhTien


create trigger BT1
on SanPham 
for update
as
	update SP_DonHang set ThanhTien= SoLuong * (select DonGia from inserted) 
	where IdSanPham = (select IdSanPham from inserted);
	update DonHang set TongTien = (select sum(ThanhTien) from inserted) where idDH = (select idDH from inserted)
--2

create trigger BT2
on SP_DonHang
for insert
as 
if(exists (select IDKhachHang from KhachHang where IDKhachHang = (select IDKhachHang from inserted)) or
	exists (select IDSanPham from SanPham where IDSanPham = (select IDSanPham from inserted)))
begin
print N'Chèn dữ liệu thành công'
end

--3
create trigger BT3
on KhachHang
for delete
as 
begin
delete from DonHang where idKH= (select idKH from deleted)
delete from SP_DonHang where idDH = (select idDH from deleted)
print N'Xóa Thành Công'
end
delete from KhachHang where idKH like 'KH1'

select * from KhachHang where idKH like 'KH1'
select * from DonHang where idKH like 'KH1'
select * from SP_DonHang where idDH = 1 or idDH = 6 or idDH = 7