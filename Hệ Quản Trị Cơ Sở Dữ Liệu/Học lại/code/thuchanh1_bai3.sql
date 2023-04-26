--a
update SP_DonHang
set ThanhTien = SP_DonHang.SoLuong*SanPham.DonGia
from SP_DonHang, SanPham
where SP_DonHang.IDDonHang = SanPham.IDSanPham

select * from SP_DonHang

--b
update DonHang
set TongTien = (select sum(SP_DonHang.ThanhTien) from SP_DonHang, DonHang where DonHang.IDDonHang=SP_DonHang.IDDonHang )
from SP_DonHang, DonHang
where SP_DonHang.IDDonHang = DonHang.IDDonHang


--c 
select reverse(left((reverse(HoTen)),CHARINDEX(' ',reverse(HoTen))-1))
from KhachHang


--d



--