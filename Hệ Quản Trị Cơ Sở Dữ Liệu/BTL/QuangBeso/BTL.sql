create database QLSALON

create table NHANVIEN
(
MaNV char(10) primary key,
HoTen nvarchar (30),
GioiTinh nchar(5) CHECK (GioiTinh=N'Nam' OR GioiTinh=N'Nữ'),
Tuoi int,
QueQuan nvarchar(30),
NhiemVu nvarchar(30),
LuongCung INT,
sdt char(10)
)
create table BANGCONG 
(
MaNV char(10) REFERENCES NHANVIEN(MaNV),
TienHoaHong INT,
LuongCung INT,
Thang INT,
Cong FLOAT,
TongLuong INT
)
create table KHUYENMAI
(
Hang nvarchar(10) PRIMARY KEY,
TiLeKM FLOAT,
MucTieuTren INT
)
Create table KHACH
(
MaKH char(10) primary key,
HoTen nvarchar(50),
DiaChi nvarchar(50),
sdt char(10),
TongTieu INT,
Hang NVARCHAR(10) REFERENCES KHUYENMAI(Hang)
)
create table DICHVU
(
MaDV char(10) primary key,
TenDV nvarchar(30),
ChietKhauNV float,
DonGia int
)
create table HOADON
(
MaHD INT identity(1,1)  primary key,
MaKH char(10) REFERENCES KHACH(MaKH),
MaNV char(10) REFERENCES NHANVIEN(MaNV),
NgayHD date,
Hang nvarchar(10) REFERENCES KHUYENMAI(Hang),
ThanhTien INT
)
create table CHITIETHD
(
MaHD int REFERENCES HOADON(MaHD),
MaDV char (10) REFERENCES DICHVU(MaDV),
DonGia INT
)
create table DIEMDANH
(
	MaNV CHAR(10) REFERENCES NHANVIEN(MaNV),
	CheckIn DATETIME,
	CheckOut DATETIME,
	Cong FLOAT
)
----------------------------------------------------------------




--Insert dữ liệu bảng nhân viên
INSERT INTO NHANVIEN 
VALUES 
('NV01','Mai Vinh Quang','Nam',20,N'Lào Cai',N'Thợ chính',5000000,'0915563292'),
('NV02',N'Hà Gia Phong','Nam',20,N'Quảng Ninh',N'Thợ chính',5000000,'0333666999'),
('NV03',N'Nguyễn Thanh Tùng','Nam',20,N'Hà Nội',N'Thợ chính',5000000, '0868888999'),
('NV04',N'Nguyễn Đức Hạnh','Nam',20,N'Hà Nội',N'Thợ chính',5000000, '0999888777'),
('NV05',N'Nguyễn Thị Yến Nhi',N'Nữ',20,N'Quảng Ninh',N'Thanh toán',4600000,'0335888666'),
('NV06',N'Ngô Thị Duyên',N'Nữ',20,N'Hà Nội',N'Thanh Toán',4600000,'0345666888')


--Insert dữ liệu bảng khuyễn mãi 
INSERT INTO KHUYENMAI 
VALUES (N'Thân thiết',0,0),
(N'Bạc',0.05,200000),
(N'Vàng',0.1,500000),
(N'Bạch kim',0.2,2000000)



--insert dữ liệu bảng Khách 
INSERT INTO KHACH
(MaKH,HoTen,DiaChi,sdt)
VALUES
('KH01',N'Lê Đức Anh',N'Hà Nội','0123224326'),
('KH02',N'Nguyễn Văn Cường',N'Hưng Yên','0394606513'),
('KH03',N'Đinh Tất Hiển',N'Ninh Bình','0338994066'),
('KH04',N'Nguyễn Tử Trung',N'Ninh Bình','0124606513'),
('KH05',N'Ngô Chúc Sinh',N'Lào Cai','0365884663'),
('KH06',N'Mai Quang Trung',N'Lào Cai','0982668883'),
('KH07',N'Nguyễn Xuân Quý',N'Thanh Hóa','0324668992'),
('KH08',N'Trương Việt Thắng',N'Hòa Bình','0668886995'),
('KH09',N'Ngô Thị Huệ',N'Thái Nguyên','0368896689'),
('KH10',N'Mai Phương Loan',N'Thanh Hóa','0912888993'),
('KH11',N'Nguyễn Mạnh Hùng',N'Hưng Yên','0335999883'),
('KH12',N'Nguyễn Quỳnh Châu',N'Hà Nội','0668983389'),
('KH13',N'Nguyễn Tuấn Long',N'Nam Định','0668993889'),
('KH14',N'Đỗ Tiến Đạt',N'Quảng Ninh','0689983389'),
('KH15',N'Đoàn Hữu Mạnh',N'Nam Định','0394808513'),
('KH16',N'Đoàn Hữu Linh',N'Hà Nội','0384909636')


--Insert dữ liệu vào bảng dịch vụ 
INSERT INTO DICHVU 
VALUES ('DV11',N'Nặn mụn',0.5,50000),
('DV01',N'Cắt tóc',0.5,70000),
('DV02',N'Gội đầu',0.5,50000),
('DV03',N'Nhuộm tóc',0.2,100000),
('DV04',N'Uốn tóc',0.3,200000),
('DV05',N'Ép tóc',0.3,150000),
('DV06',N'Tẩy tóc',0.3,100000),
('DV07',N'Combo gội đầu mát xa ',0.5,100000),
('DV08',N'Combo cắt gội mát xa',0.5,150000),
('DV09',N'Combo làm tóc Shine Part',0.2,600000),
('DV10',N'Combo làm xoăn sóng',0.2,800000),
('DV12',N'Combo uấn Premlock',0.2,700000),
('DV13',N'Combo Man Braid',0.2,1600000)


--Insert dữ liệu vào bảng hóa đơn
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH02','NV01')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH01','NV02')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH03','NV03')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH05','NV04')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH04','NV03')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH06','NV04')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH08','NV02')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH07','NV01')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH10','NV01')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH11','NV04')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH14','NV02')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH13','NV03')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH15','NV02')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH12','NV04')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH16','NV01')
INSERT INTO HOADON (MaKH,MaNV) 
VALUES ('KH09','NV02')

--Insert dữ liệu bảng chi tiết HD
INSERT INTO CHITIETHD(MaHD,MaDV)
VALUES(32,'DV08')
INSERT INTO CHITIETHD(MaHD,MaDV)
VALUES(32,'DV04')
INSERT INTO CHITIETHD(MaHD,MaDV)
VALUES(32,'DV05')
INSERT INTO CHITIETHD(MaHD,MaDV)
VALUES(32,'DV11')



--Trigger set thành tiền (Quang)
CREATE TRIGGER Thanh_Tien
ON CHITIETHD AFTER INSERT
AS
BEGIN
	BEGIN TRAN
UPDATE CHITIETHD 
SET DonGia = (SELECT DonGia FROM DICHVU 
              WHERE MaDV=(SELECT MaDV FROM INSERTED)) 
WHERE MaDV=(SELECT MaDV FROM INSERTED) AND MaHD=(SELECT MaHD FROM INSERTED)
DECLARE @KM FLOAT
SET @KM=(SELECT TiLeKM FROM KHUYENMAI,HOADON 
         WHERE KHUYENMAI.Hang =HOADON.Hang AND HOADON.MaHD=(SELECT MaHD FROM INSERTED))
UPDATE HOADON
SET ThanhTien = (SELECT SUM (DonGia*(1-@KM )) FROM CHITIETHD 
                 GROUP BY MaHD HAVING MaHD=(SELECT MaHD FROM INSERTED))
WHERE MaHD=(SELECT MaHD FROM INSERTED)
IF @@ERROR <>0
ROLLBACK TRAN
ELSE
COMMIT TRAN
END
--trigger Ngay HD (Quang)
CREATE TRIGGER NgayHD
ON HOADON FOR INSERT
AS
BEGIN
UPDATE HOADON SET ThanhTien=0 WHERE MaHD=(SELECT MaHD FROM INSERTED)
UPDATE HOADON SET NgayHD=GETDATE() WHERE MaHD=(SELECT MaHD FROM INSERTED)
UPDATE HOADON SET Hang = (SELECT Hang FROM KHACH 
                          WHERE MaKH=(SELECT MaKH FROM INSERTED))
WHERE MaHD=(SELECT MaHD FROM INSERTED)
END
--Trigger set hang (Phong)
CREATE TRIGGER set_Hang
ON KHACH FOR INSERT
AS
UPDATE KHACH 
SET Hang = N'Thân thiết',TongTieu = 0
--Trigger set tổng tiêu (Phong)
CREATE TRIGGER Tong_Tieu
ON HOADON FOR UPDATE
AS
BEGIN
UPDATE KHACH
SET TongTieu= (SELECT SUM (ThanhTien) FROM HOADON 
               WHERE MaKH=(SELECT MaKH FROM INSERTED))
WHERE MaKH=(SELECT MaKH FROM INSERTED)
DECLARE @Hang INT,@Bac INT,@Vang INT,@BachKim INT
SELECT @Bac=(SELECT MucTieuTren FROM KHUYENMAI WHERE Hang=N'Bạc')
SELECT @Vang=(SELECT MucTieuTren FROM KHUYENMAI WHERE Hang=N'Vàng')
SELECT @BachKim=(SELECT MucTieuTren FROM KHUYENMAI WHERE Hang=N'Bạch kim')
SET @Hang= (SELECT TongTieu FROM KHACH WHERE MaKH=(SELECT MaKH FROM INSERTED))
IF @Hang >@BachKim
	UPDATE KHACH
	SET Hang=N'Bạch Kim'
	WHERE MaKH=(SELECT MaKH FROM INSERTED)
ELSE IF @Hang BETWEEN @Bac AND @Vang
	UPDATE KHACH
	SET Hang=N'Bạc'
	WHERE MaKH=(SELECT MaKH FROM INSERTED)
ELSE IF @Hang BETWEEN @Vang AND @BachKim
	UPDATE KHACH
	SET Hang=N'Vàng'
	WHERE MaKH=(SELECT MaKH FROM INSERTED)
ELSE IF @Hang BETWEEN 0 AND @Bac 
	UPDATE KHACH
	SET Hang=N'Thân thiết'
	WHERE MaKH=(SELECT MaKH FROM INSERTED)
ELSE
	ROLLBACK TRAN
END
--Trigger bảng điểm danh (Quang)
CREATE TRIGGER DD
ON DIEMDANH FOR INSERT
AS BEGIN
	BEGIN TRAN
	DECLARE @MaNV CHAR(10)
	SET @MaNV=(SELECT MaNV FROM INSERTED)
   	IF EXISTS (SELECT * FROM DIEMDANH WHERE MaNV=@MaNV AND CheckIn IS NOT NULL AND CheckOut IS NULL)
   	BEGIN
   		PRINT N' Check out thành công cho '+@MaNV
   		UPDATE DIEMDANH
   		SET
   		CheckOut=GETDATE() WHERE MaNV=@MaNV AND CheckIn IS NOT NULL AND CheckOut IS NULL	
   		DELETE FROM DIEMDANH WHERE MaNV=@MaNV AND CheckIn IS NULL AND CheckOut IS NULL
   		COMMIT TRAN
   	END
   	ELSE 
   	BEGIN
   		PRINT N' Check in thành công cho '+@MaNV
   		UPDATE DIEMDANH SET CheckIn=GETDATE() WHERE MaNV=@MaNV AND CheckIn IS NULL AND CheckOut IS NULL
   		COMMIT TRAN
   	END 
END
-- Trigger set công (Phong)
CREATE TRIGGER Cong
ON DIEMDANH FOR update
AS BEGIN
	DECLARE @x int
	SET @x=(SELECT DATEDIFF(HOUR,CheckIn,CheckOut) FROM DIEMDANH 
	        WHERE MaNV=(SELECT MaNV FROM INSERTED ) AND CheckOut=(SELECT CheckOut FROM INSERTED))
   	IF @x>7
   	UPDATE DIEMDANH SET Cong=1 WHERE MaNV=(SELECT MaNV FROM INSERTED ) AND CheckOut=(SELECT CheckOut FROM INSERTED)
   	ELSE IF @x>4 
   	UPDATE DIEMDANH SET Cong=0.5 WHERE MaNV=(SELECT MaNV FROM INSERTED ) AND CheckOut=(SELECT CheckOut FROM INSERTED)
   	ELSE 
   	UPDATE DIEMDANH SET Cong=0 WHERE MaNV=(SELECT MaNV FROM INSERTED ) AND CheckOut=(SELECT CheckOut FROM INSERTED)
END
-- Trigger o BANGCONG (Quang)
CREATE TRIGGER BC
ON BANGCONG AFTER INSERT
AS 
BEGIN
	DECLARE @HoaHong INT,@Thang INT,@MaNV CHAR(5),@LuongCung INT
	SET @Thang=(SELECT Thang FROM INSERTED)
	SET @MaNV=(SELECT MaNV FROM INSERTED)
	SET @LuongCung=(SELECT LuongCung FROM NHANVIEN WHERE MaNV=@MaNV)
	EXEC Luong_Nhan_Vien @Thang,@MaNV,@HoaHong OUTPUT
	IF @HoaHong IS NULL
	SET @HoaHong=0
	UPDATE BANGCONG SET TienHoaHong=@HoaHong,LuongCung=@LuongCung
	WHERE MaNV=@MaNV AND @Thang=Thang
	UPDATE BANGCONG SET Cong=(SELECT SUM(Cong) 
	                          FROM  DIEMDANH WHERE MaNV=@MaNV AND DATEPART(MONTH,CheckIn)=@Thang)
	WHERE MaNV=@MaNV AND Thang=@Thang
	UPDATE BANGCONG SET TongLuong = LuongCung/26*Cong+TienHoaHong WHERE MaNV=@MaNV AND Thang=@Thang
END

INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV01',10)
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV02',11)
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV03',11)
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV04',11)
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV05',11)
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV06',11)
SELECT * FROM BANGCONG
DELETE FROM BANGCONG WHERE MaNV='NV01' and Thang=10
----------------------------------------------------------------




--View chi tiết tiền hoa hồng (Phong)
CREATE VIEW HoaHong
AS 
SELECT HOADON.MaHD,MaNV,NgayHD,CHITIETHD.MaDV,CHITIETHD.DonGia,ChietKhauNV 
FROM CHITIETHD,HOADON,DICHVU 
WHERE CHITIETHD.MaHD=HOADON.MaHD AND CHITIETHD.MaDV=DICHVU.MaDV
SELECT * FROM HoaHong
--View thống kê dịch vụ được sử dụng (Quang)
CREATE VIEW DV
AS
SELECT MaDV,COUNT(MaDV) AS SoLan,DATEPART(MONTH,NgayHD) AS Thang FROM CHITIETHD,HOADON 
WHERE HOADON.MaHD=CHITIETHD.MaHD  GROUP BY MaDV ,DATEPART(MONTH,NgayHD)
SELECT * FROM DV
--Viewwwww khách hàng hạng thân thiết 
CREATE VIEW Khach_V
AS 
   	SELECT * FROM KHACH WHERE Hang=N'Vàng'
SELECT * FROM Khach_V
--View hóa đơn bán trong tháng 10 (Phong)
CREATE VIEW HD_T11
AS
	SELECT * FROM HOADON WHERE DATEPART(MONTH,NgayHD)=11
SELECT * FROM HD_T11
----------------------------------------------------------------





--Thủ tục tính lương (Quang)
CREATE PROC Luong_Nhan_Vien
@Thang INT,
@MaNV CHAR(5),
@TienHoaHong INT OUTPUT
AS BEGIN
   	SET @TienHoaHong=(SELECT SUM(ChietKhauNV*DICHVU.DonGia) 
   	                  FROM DICHVU,CHITIETHD 
   	                  WHERE DICHVU.MaDV=CHITIETHD.MaDV and MaHD IN (SELECT MaHD FROM HOADON 
   	                                                                WHERE MaNV=@MaNV AND DATEPART(MONTH,NgayHD)=@Thang))
END

--Thủ tục xóa nhân viên (Phong)
CREATE PROC Xoa_NV
@MaNV CHAR(10)
AS BEGIN
   	BEGIN TRAN
   		IF not EXISTS (SELECT MaNV FROM NHANVIEN WHERE MaNV=@MaNV)
   			BEGIN
   				PRINT N'Mã nhân viên không tồn tại'
   				ROLLBACK TRAN
   			END
   		ELSE
   			BEGIN
   		     	DELETE FROM NHANVIEN WHERE MaNV=@MaNV
   		     	PRINT N'Xóa thành công '+@MaNV
   		     	COMMIT TRAN
   			END
END
EXEC Xoa_NV 'NV11'
----------------------------------------------------------------






--Function tính doanh thu (Quang)
CREATE FUNCTION Doanh_Thu
(@Thang INT)
RETURNS INT
AS BEGIN
   	RETURN ((SELECT SUM(ThanhTien) FROM HOADON 
   	                 WHERE DATEPART (MONTH, NgayHD)=@Thang))
END 	         
SELECT dbo.Doanh_Thu(11)
--Hàm in ra khách hàng có địa chỉ bất kỳ (Phong)
CREATE FUNCTION TT_KH (@DiaChi NVARCHAR(30))
RETURNS TABLE 
AS
RETURN SELECT * FROM KHACH WHERE DiaChi= @DiaChi
SELECT * FROM dbo.TT_KH(N'Quảng Ninh')




----------------------------------------------------------------
SELECT * FROM NHANVIEN
SELECT * FROM CHITIETHD
SELECT * FROM HOADON
SELECT * FROM DICHVU
SELECT * FROM KHACH
SELECT * FROM KHUYENMAI
SELECT * FROM BANGCONG
SELECT * FROM DIEMDANH
SELECT * FROM HoaHong
SELECT * FROM DV
SELECT * FROM HD_T11
-----------------
DECLARE @HoaHong int
EXEC Luong_Nhan_Vien 10,'NV01',@HoaHong output
SELECT @HoaHong
----------------
INSERT INTO DIEMDANH(MaNV) VALUES ('NV01')
----------------
INSERT INTO BANGCONG (MaNV,Thang) VALUES ('NV01',11)
----------------
EXEC Xoa_NV 'NV11'
