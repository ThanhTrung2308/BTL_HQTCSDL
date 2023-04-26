create DATABASE BaiTapLonNhom15
CREATE TABLE MayBAy(
	MaMayBay NCHAR(5) NOT NULL PRIMARY KEY,
	TenMayBay NCHAR(30) NOT NULL , 
	HangSanXuat NCHAR(30) ,
	SoLuongGhe1 INT ,
	SoLuongGhe2 INT ,
)

CREATE TABLE KhachHang (
	MaKH NCHAR(5) NOT NULL PRIMARY KEY,
	TenKH NCHAR(30),
	SDT nchar(30),
	NgaySinh date,
	GioiTinh NCHAR(3),
	DiaChi NCHAR(40),
	CMNDHoChieu NCHAR(20),
	QuocTich NCHAR(20)

)
CREATE TABLE NhanVien (
	MaNV NCHAR(5) NOT NULL PRIMARY KEY,
	TenNhanVien NCHAR(30),
	GioiTinh NCHAR(3),
	DiaChi NCHAR(30),
	NgaySinh date,
	SoDT NCHAR(10),
	ChucVu NCHAR(10),
	TaiKhoan NCHAR(50),
	MatKhau NCHAR(50)
)
CREATE TABLE DuongDi(

	MaDD NCHAR(5) NOT NULL PRIMARY KEY,
	DiemDen NCHAR(30),
	DiemDi NCHAR(30),
	Manv NCHAR(5) NOT NULL ,
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
CREATE TABLE ChuyenBay(
	MaChuyenBay NCHAR(5) NOT NULL PRIMARY KEY ,
	MaMayBay NCHAR(5) NOT NULL ,
	MaDD NCHAR(5) NOT NULL,
	Manv NCHAR(5) NOT NULL ,
	NgayDi DATE ,
	NgayDen DATE ,
	GioDi NCHAR(10),
	GhiChu NCHAR(50),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	FOREIGN KEY (MaDD) REFERENCES DuongDi(MaDD),
	FOREIGN KEY (MaMayBay) REFERENCES MayBay(MaMayBay)
)
CREATE TABLE ThongTinVe (
	MaVe NCHAR(5) NOT NULL PRIMARY KEY,
	MaCHuyenBay  NCHAR(5) NOT NULL,
	Loaive NCHAR(5),
	GiaVe FLOAT,
	FOREIGN KEY (MaChuyenBay) REFERENCES chuyenBay(MaChuyenBay)
)

CREATE TABLE HoaDon (
	MaHoaDon NCHAR(5) NOT NULL primary key ,
	NgayBan date,
	MaNV NCHAR(5) NOT NULL,
	MaKH NCHAR(5) NOT NULL ,
	MaVe nchar(5) not null,
	TongTien int,
	foreign key (mave) references thongtinve(mave),
	FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)

 --- PHẦN 1 TRIGGER 

-- trigger kiểm tra tuổi nhân viên cho phép từ 18 đến 60  - bảng Nhân Viên 
DROP TRIGGER checktuoi
CREATE TRIGGER checktuoi
on nhanvien 
AFTER INSERT 
AS 
IF (( SELECT DATEDIFF(yy,ngaysinh,GETDATE())   FROM Inserted    ) BETWEEN 18 AND 60)
	PRINT N'Tuổi Hợp Lệ '
ELSE 
	BEGIN 
		PRINT N'Xem lại tuổi '
		ROLLBACK TRAN
	END

-- trigger kiểm tra số điện thoại Bảng nhân viên 
DROP TRIGGER dbo.checksdt
CREATE TRIGGER checksdt 
ON NhanVien 
AFTER INSERT 
as
 
IF ((SELECT LEN(SoDT) FROM inserted) != 10 )
	BEGIN 
	PRINT N'Kiểm Tra Lại Số Điện Thoai'
	ROLLBACK TRAN 
	 END 
ELSE 
	PRINT N'số điện thoại hợp lệ  '

INSERT dbo.NhanVien
        ( MaNV ,
          TenNhanVien ,
          DiaChi ,
          NgaySinh ,
          SoDT ,
          ChucVu ,
          TaiKhoan ,
          MatKhau ,
          GioiTinh
        )
VALUES  ( N'NV100' , -- MaNV - nchar(5)
          N'Bùi Toại Nguyện' , -- TenNhanVien - nchar(30)
          N'Hòa Bình' , -- DiaChi - nchar(30)
          '2000-10-10' , -- NgaySinh - date
          N'082880375' , -- SoDT - nchar(10)
          N'Nhân Viên' , -- ChucVu - nchar(10)
          N'nguyen' , -- TaiKhoan - nchar(50)
          N'' , -- MatKhau - nchar(50)
          N'Nam'  -- GioiTinh - nchar(3)
        ) 

-- trigger Kiểm Tra Tuổi Khách Hàng 
DROP TRIGGER ChecktuoiKH
	CREATE TRIGGER ChecktuoiKH
	ON KhachHang 
	AFTER INSERT 
	AS  
	IF (( SELECT DATEDIFF(yy,ngaysinh,GETDATE())   FROM Inserted    ) >100 OR (SELECT DATEDIFF(yy,ngaysinh,GETDATE())   FROM Inserted ) < 1 )
		BEGIN 
			PRINT N'Xem lai tuổi khách hàng!'
			ROLLBACK TRAN 
		END 
	ELSE 
		PRINT N'Tuổi Đúng !'
	 
INSERT dbo.KhachHang
	        ( MaKH ,
	          TenKH ,
	          SDT ,
	          NgaySinh ,
	          DiaChi ,
	          CMNDHoChieu ,
	          QuocTich ,
	          GioiTinh
	        )
	VALUES  ( N'KH108' , -- MaKH - nchar(5)
	          N'Bùi Toại Nguyện' , -- TenKH - nchar(30)
	          N'0828803754' , -- SDT - nchar(30)
	          '2000-10-10' , -- NgaySinh - date
	          N'Hòa Bình ' , -- DiaChi - nchar(40)
	          N'113730521' , -- CMNDHoChieu - nchar(20)
	          N'Việt Nam ' , -- QuocTich - nchar(20)
	          N'Nam'  -- GioiTinh - nchar(3)
	        )

-- Trigger kiểm tra Số ĐIện thoại khách hàng 
DROP TRIGGER checksdtKH
	CREATE TRIGGER checksdtKH
	ON KhachHang 
	AFTER INSERT 
	as
	IF ((SELECT LEN(SDT) FROM inserted) != 10 )
	BEGIN 
	PRINT N'Kiểm Tra Lại Số Điện Thoai'
	ROLLBACK TRAN 
		END 
	ELSE 
	PRINT N'Số Điện Thoại Đúng ! '
		
	
--triger Kiểm tra ngày đi nhỏ hơn ngày đến cua Chuyến Bay

	DROP  TRIGGER KiemTraNDND
	CREATE TRIGGER KiemTraNDND
	ON Chuyenbay
	FOR  INSERT 
	AS  
	IF ((SELECT ngaydi  FROM inserted ) >  (SELECT ngayden  FROM inserted ) )
	BEGIN 
		PRINT N'ngày đi ngày đến không hợp lệ  '
		ROLLBACK TRAN 
	END 
	ELSE 
	PRINT N'Ngày đi đến  hợp lệ '
	
	   
	--Test
	INSERT dbo.ChuyenBay
	        ( MaChuyenBay ,
	          MaMayBay ,
	          MaDD ,
	          Manv ,
	          NgayDi ,
	          NgayDen ,
	          GioDi ,
	          GhiChu
	        )
	VALUES  ( N'CB101' , -- MaChuyenBay - nchar(5)
	          N'MB01' , -- MaMayBay - nchar(5)
	          N'DD02' , -- MaDD - nchar(5)
	          N'NV01' , -- Manv - nchar(5)
	          '2020-11-08' , -- NgayDi - date
	          '2020-11-07' , -- NgayDen - date
	          N'14:05' , -- GioDi - nchar(10)
	          N''  -- GhiChu - nchar(50)
	        )


	-- kiểm tra xem nếu hết vé loại thì không cho tạo vé nữa 
	DROP TRIGGER KiemTraGhe1
	CREATE TRIGGER KiemTraGhe1 
	ON ThongTinVe 
	AFTER INSERT 
	AS 
	
	IF((SELECT loaive FROM inserted ) = 'eco')
	BEGIN 
			
	IF(			(SELECT count(*) FROM ThongTinVe  WHERE Loaive ='eco' AND MaCHuyenBay = (SELECT MaCHuyenBay FROM inserted )) > 
			(SELECT maybay.SoLuongGhe1 FROM dbo.ChuyenBay,dbo.MayBAy
			WHERE (SELECT MaCHuyenBay FROM inserted) = dbo.ChuyenBay.MaChuyenBay 
			AND dbo.ChuyenBay.MaMayBay= maybay.MaMayBay 
			 )	)
			BEGIN 
			PRINT N'quá số ghế Economy'
			ROLLBACK TRAN 
			END 
	ELSE 
	PRINT N'Thành Công '
			END
	INSERT dbo.ThongTinVe
	        ( MaVe, MaCHuyenBay, Loaive, GiaVe )
	VALUES  ( N'MV201', -- MaVe - nchar(5)
	          N'CB200', -- MaCHuyenBay - nchar(5)
	          N'bu', -- Loaive - nchar(5)
	          111  -- GiaVe - float
	          )


		
		
	--- 2 kiếm tra xem nếu hết vé loại 2 thì không cho thêm nữa 
	DROP TRIGGER KiemTraGhe2
	CREATE TRIGGER KiemTraGhe2
	ON ThongTinVe 
	AFTER INSERT 
	AS 
	
	IF((SELECT loaive FROM inserted ) = 'bu')
	BEGIN 
			
	IF(			(SELECT count(*) FROM ThongTinVe  WHERE Loaive ='bu' AND MaCHuyenBay = (SELECT MaCHuyenBay FROM inserted )) > 
			(SELECT maybay.SoLuongGhe2 FROM dbo.ChuyenBay,dbo.MayBAy
			WHERE (SELECT MaCHuyenBay FROM inserted) = dbo.ChuyenBay.MaChuyenBay 
			AND dbo.ChuyenBay.MaMayBay= maybay.MaMayBay 
			 )	)
			BEGIN 
			PRINT N'quá số ghế Business'
			ROLLBACK TRAN 
			END 
	ELSE 
	PRINT N'Thành Công '
			END

          


--- 2 PHẦN PHÂN QUYỀN 

	sp_addrole 'QUANLY' -- thêm nhóm quyền role tên ADMIN 
	sp_addrole 'MEMBER' -- thêm nhóm quyền role tên MEMBER 

-- thêm các quyền cho quản lí và member 
	GRANT SELECT,INSERT,UPDATE,DELETE ON NhanVien  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON KhachHang  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON ThongTinVe  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON HoaDon  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON MayBay  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON ChuyenBay  TO QUANLY
	GRANT SELECT,INSERT,UPDATE,DELETE ON dbo.DuongDi  TO QUANLY
	GRANT EXECUTE ON dbo.addQuyen  TO QUANLY
	GRANT EXECUTE ON dbo.sp_timkiem  TO QUANLY
	GRANT EXECUTE ON dbo.sp_xoaquyen TO QUANLY
	GRANT EXECUTE ON dbo. sp_timkiemVe TO QUANLY

	GRANT SELECT ON dbo.NhanVien TO MEMBER
	GRANT SELECT ON KhachHang TO MEMBER
	GRANT SELECT ON MayBAy TO MEMBER
	GRANT SELECT ON ChuyenBay TO MEMBER
	GRANT SELECT ON HoaDon TO MEMBER
	GRANT SELECT ON DuongDI TO MEMBER
	GRANT SELECT ON dbo.ThongTinVe TO MEMBER
	-- -- tạo thủ tục để phân quyền 

	go
	CREATE PROC addQuyen (@tk varchar(50)  ,@mk varchar(50)  ,@chucvu nchar(50))
	AS 
	BEGIN

    EXECUTE sp_addlogin @tk, @mk  
	execute  sp_grantdbaccess @tk, @tk
	IF (@chucvu = 'QUANLY')
	EXECUTE sp_addrolemember 'QUANLY',@tk 
	ELSE 
	EXECUTE sp_addrolemember 'MEMBER',@tk

-- thu lại quyền 

	CREATE PROC xoaquyen @tk NCHAR(50)
	AS
	BEGIN 
	EXECUTE sp_droplogin @tk
	EXECUTE sp_dropuser @tk 
	END


--3 PHẦN THỦ TỤC 
-- tạo proc tìm kiếm 
CREATE PROC sp_timkiem @key nchar(30)
 AS BEGIN 

 select MaNV, TenNhanVien, ChucVu,SoDT,DiaChi,NgaySinh from NhanVien 
	where TenNhanVien like  N'%'+@key+'%' OR MaNV = @key 
	END 
----  tạo proc tìm kiếm theo vé 
	CREATE PROC sp_timkiemVe @mave NCHAR(5)
	AS BEGIN
    

	SELECT MaVe, LoaiVe, GiaVe, DiemDi, DiemDen from ThongTinVe as ttv INNER JOIN dbo.ChuyenBay AS cb ON ttv.MaCHuyenBay = cb.MaChuyenBay 
	INNER JOIN dbo.DuongDi AS dd ON dd.MaDD = cb.MaDD WHERE MaVe=  @maVe
	END 
      
       
-- PHẦN HÀM Viêt hàm để in ra số lượng ghế trống loai 1 
CREATE FUNCTION GheTrongLoai1 (@MaChuyenBay  nchar(30))
RETURNS int 
AS BEGIN
DECLARE @SoLuongLoai1 INT
DECLARE @soluongGhe INT 
DECLARE @slGheDaBan INT 
SELECT @SoLuongLoai1 = SoLuongGhe1 FROM MayBay  WHERE MaMayBay= (SELECT MaMayBay FROM ChuyenBay WHERE MaChuyenBay = @MaChuyenBay  )
SELECT @slGheDaBan = COUNT(*) FROM dbo.HoaDon,dbo.ThongTinVe
WHERE dbo.ThongTinVe.MaVe= HoaDon.MaVe AND Loaive = 'eco' AND dbo.ThongTinVe.MaCHuyenBay = @MaChuyenBay 

SET @soluongGhe = @SoLuongLoai1 - @slGheDaBan

RETURN @soluongGhe
END

PRINT CAST(dbo.GheTrongLoai2('CB02') AS NCHAR(5))


-- ghế loại 2
CREATE FUNCTION GheTrongLoai2 (@MaChuyenBay  nchar(30))
RETURNS int  
AS BEGIN
DECLARE @SoLuongLoai2 INT
DECLARE @soluongGhe INT 
DECLARE @slGheDaBan INT 
SELECT @SoLuongLoai2 = SoLuongGhe2 FROM MayBay  WHERE MaMayBay= (SELECT MaMayBay FROM ChuyenBay WHERE MaChuyenBay = @MaChuyenBay  )
SELECT @slGheDaBan = COUNT(*) FROM dbo.HoaDon,dbo.ThongTinVe
WHERE dbo.ThongTinVe.MaVe= HoaDon.MaVe AND Loaive = 'bu' AND dbo.ThongTinVe.MaCHuyenBay = @MaChuyenBay 

SET @soluongGhe = @SoLuongLoai2 - @slGheDaBan

RETURN @soluongGhe
END




-- Phần View 
--1 view hóa đơn 
CREATE VIEW viewhoadon

AS

SELECT HD.MaHoaDon ,KH.MaKH , Kh.TenKH ,KH.SDT ,HD.NgayBan , HD.MaNV , DD.DiemDi  , DD.DiemDen, CB.NgayDi , CB.NgayDen  ,TTV.Loaive,TTV.GiaVe
FROM HoaDon HD,KhachHang KH,dbo.ChuyenBay CB,dbo.DuongDi DD,ThongTinVe TTV,dbo.NhanVien NV

WHERE 
HD.MaKH= KH.MaKH AND HD.MaVe = TTV.MaVe AND TTV.MaCHuyenBay= CB.MaChuyenBay AND Cb.MAdd= DD.MaDD AND NV.MaNV = HD.MaNV


--2 view In ra Các Chuyến Bay đã thêm 
CREATE VIEW viewchuyenbay AS 
select cb.MaChuyenBay, cb.NgayDi , cb.NgayDen , cb.GioDi ,
mb.SoLuongGhe1 , mb.SoLuongGhe2 , dd.DiemDi , dd.DiemDen ,cb.GhiChu 
from ChuyenBay AS cb INNER JOIN dbo.MayBay AS mb ON cb.MaMayBay = mb.MaMayBay INNER JOIN dbo.DuongDi AS dd ON cb.MaDD = dd.MaDD

--3 view in ra các đường đi 
CREATE VIEW viewduongdi AS 
select MaDD, DiemDi, DiemDen, Manv, (rtrim(DiemDi)+'-'+rtrim(DiemDen)) AS LoTrinh from DuongDi

---4 view in ra thông tin vé 
CREATE VIEW VIEWthongtinve as
select MaVe, LoaiVe, GiaVe, DiemDi, DiemDen from ThongTinVe as ttv INNER JOIN 
dbo.ChuyenBay AS cb ON ttv.MaCHuyenBay = cb.MaChuyenBay INNER JOIN dbo.DuongDi AS dd ON dd.MaDD = cb.MaDD



