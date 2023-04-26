begin tran chuyenlop
if(exists (select * from SinhVien where masv = 1 and malop = '60TH'))
	begin
		update SinhVien set malop = '59PM' where masv = 1
		update Lop set SoSV = SoSV + 1 where malop = '59PM'
		update Lop set SoSV = SoSV - 1 where malop = '60TH'
	end
else print N'K tồn tại SV đó'
commit tran


begin tran chuyenkhoan
if (exists (select sotk from taikhoan where sotk = N'A')) and (exists (select sotk from taikhoan where sotk = N'B'))
begin
	if( select sodu from TAIKHOAN where soTK = N'A') > 200
		begin
			update TAIKHOAN set sodu = sodu - 200 where soTK= N'A'
			update TAIKHOAN set sodu = sodu + 200 where soTK= N'B'

			commit tran 
			print N'Giao dich thanh cong'
		end
		else
			print N'K đủ số dư'
end
print N'K tim thay tai khoan'



begin tran ck
	update TAIKHOAN set sodu = sodu - 200 where soTK= 1
	update TAIKHOAN set sodu = sodu + 200 where soTK= 2
if ( select sodu from TAIKHOAN where soTK = 1) < 200
	begin 
		rollback tran 
		print N'Khong du tien'
	end 
else 
begin 
	commit tran 
	print N'Giao dich tc'
	end