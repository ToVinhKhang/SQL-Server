/* PHAN 1 */
/* 1 */
CREATE TABLE LoaiVatTu(
	MaLoai CHAR(5) NOT NULL,
	TenLoai NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_LoaiVatTu_MaLoai PRIMARY KEY (MaLoai)
);

CREATE TABLE VatTu(
	MaHang CHAR(5) NOT NULL UNIQUE,
	TenHang NVARCHAR(100) NOT NULL,
	DonViTinh NVARCHAR(10) DEFAULT N'cái',
	SoLuong INT NOT NULL,
	DonGia INT NOT NULL,
	MaLoai CHAR(5) NOT NULL,
	CONSTRAINT PK_VatTu_MaHang_MaLoai PRIMARY KEY (MaHang,MaLoai),
	CONSTRAINT FK_VatTu_MaLoai_LoaiVatTu FOREIGN KEY(MaLoai) REFERENCES LoaiVatTu(MaLoai)
);

CREATE TABLE KhachHang(
	MaKH CHAR(5) NOT NULL,
	TenKH NVARCHAR(100) NOT NULL,
	DienThoai VARCHAR(12),
	CONSTRAINT PK_KhachHang_MaKH PRIMARY KEY (MaKH),
);

CREATE TABLE HoaDon(
	SoHD CHAR(5) NOT NULL,
	NgayLap DATE NOT NULL,
	MaKH CHAR(5) NOT NULL,
	CONSTRAINT PK_HoaDon_SoHD PRIMARY KEY (SoHD),
	CONSTRAINT FK_HoaDon_MaKH_KhachHang FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH)
);

CREATE TABLE ChiTietHoaDon(
	SoHD CHAR(5) NOT NULL,
	MaHang CHAR(5) NOT NULL,
	SoLuong INT NOT NULL,
	DonGia INT NOT NULL,
);

ALTER TABLE VatTu
ADD CONSTRAINT CHECK_VatTu_SoLuongDonGia
CHECK (SoLuong > 0 AND DonGia > 0)

/* 2 */
ALTER TABLE ChiTietHoaDon
ADD
CONSTRAINT PK_ChiTietHoaDon_SoHD_MaHang PRIMARY KEY (SoHD,MaHang),
CONSTRAINT FK_ChiTietHoaDon_SoHD_HoaDon FOREIGN KEY(SoHD) REFERENCES HoaDon(SoHD),
CONSTRAINT FK_ChiTietHoaDon_MaHang_VatTu FOREIGN KEY(MaHang) REFERENCES VatTu(MaHang)

ALTER TABLE KhachHang
ALTER COLUMN TenKH NVARCHAR(50) NOT NULL

/* 3 */
INSERT INTO LoaiVatTu(MaLoai,TenLoai) VALUES
('VL001',N'Đá ốp tường'),('VL002',N'Đá ốp sàn'),('VL003',N'Gạch ống'),('VL004',N'Gạch ngói'),('VL005',N'Thép cuộn'),
('VL006',N'Sơn tường'),('VL007',N'Cát'),('VL008',N'Đồng hồ điện'),('VL009',N'Xi măng'),('VL010',N'Thép ngang')

INSERT INTO VatTu(MaHang,TenHang,DonViTinh,SoLuong,DonGia,MaLoai) VALUES
('VT001',N'Đá hoa cương',N'cái',300,35000,'VL001'),('VT002',N'Đá thạch anh',N'cái',250,60000,'VL002'),
('VT003',N'Gạch ống chữ nhật',N'khối',500,20000,'VL003'),('VT004',N'Gạch ngói dẹp',N'khối',200,22000,'VL004'),
('VT005',N'Thép cuộn chống gỉ',N'bịch',30,300000,'VL005'),('VT006',N'Sơn ngoài chống thấm',N'thùng',50,120000,'VL006'),
('VT007',N'Cát xây dựng',N'bịch',50,70000,'VL007'),('VT008',N'Đồng hồ đo điện',N'cái',20,220000,'VL008'),
('VT009',N'Xi măng Holcim',N'bịch',30,90000,'VL009'),('VT010',N'Thép ngang đóng cọc',N'cái',40,120000,'VL010')

INSERT INTO KhachHang(MaKH,TenKH,DienThoai) VALUES
('KH001',N'Trần Quốc Toản','0909928568'),('KH002',N'Mai Hữu Bằng','0909123456'),
('KH003',N'Nguyễn Thu Ngân','0909789111'),('KH004',N'Trương Nguyên Vũ','0909321741'),
('KH005',N'Tôn Ngộ Lượng','0909963852'),('KH006',N'Hà Văn Tâm','0909852753'),
('KH007',N'Mai Tài Long','01227629622'),('KH008',N'Trương Huỳnh Anh','0909321951'),
('KH009',N'Phan Cẩm Phả','0909486813'),('KH010',N'Hà Lâm Đồng','01229648533')

INSERT INTO HoaDon(SoHD,NgayLap,MaKH) VALUES
('HD001','1/2/1999','KH001'),('HD002','3/4/1997','KH002'),('HD003','5/6/2000','KH003'),('HD004','7/8/1996','KH004'),('HD005','9/10/2001','KH005'),
('HD006','11/12/1998','KH006'),('HD007','3/6/1998','KH007'),('HD008','6/9/2001','KH008'),('HD009','11/1/1996','KH009'),('HD010','12/2/1999','KH010')

INSERT INTO ChiTietHoaDon(SoHD,MaHang,SoLuong,DonGia) VALUES
('HD001','VT001',30,35000),('HD002','VT002',25,60000),('HD003','VT003',50,20000),('HD004','VT004',20,22000),('HD005','VT005',15,300000),
('HD006','VT006',10,120000),('HD007','VT007',30,70000),('HD008','VT008',1,220000),('HD009','VT009',10,90000),('HD010','VT010',5,120000)

/* 4 */
SELECT * FROM VatTu WHERE (SoLuong >=10 AND DonViTinh = 'thùng')
SELECT KhachHang.MaKH,KhachHang.TenKH FROM KhachHang,HoaDon WHERE (KhachHang.MaKH = HoaDon.MaKH)
SELECT SOHD, MAX(ChiTietHoaDon.SoLuong*DonGia) AS TongTriGiaNhieuNhat FROM ChiTietHoaDon GROUP BY SOHD

/* 5 */
GO
CREATE FUNCTION FunctionCauA()
RETURNS TABLE
AS
	RETURN(SELECT MaHang,TenHang FROM VatTu)

GO
CREATE FUNCTION FunctionCauB (@number int)
RETURNS TABLE
AS
	RETURN(
		SELECT KhachHang.MaKH,KhachHang.TenKH, COUNT(HoaDon.MaKH) AS [SoLanGD] FROM KhachHang,HoaDon
		WHERE KhachHang.MaKH = HoaDon.MaKH GROUP BY KhachHang.MaKH, KhachHang.TenKH
		HAVING COUNT(HoaDon.MaKH) > @number
	)

/*Test FunctionCauA*/
GO
SELECT * FROM [dbo].[FunctionCauA]()
/*Test FunctionCauB*/
GO
SELECT * FROM [dbo].[FunctionCauB](10)

/* 6 */
GO
CREATE PROCEDURE ProcedureCauA(@MaHang CHAR(5),@TenHang NVARCHAR(100),@DonViTinh NVARCHAR(10),@SoLuong INT,@DonGia INT,@MaLoai CHAR(5))
AS
BEGIN
	DECLARE @CheckMaHang int, @CheckMaLoai int
	SELECT @CheckMaHang = count(*) FROM VatTu WHERE MaHang = @MaHang
	SELECT @CheckMaLoai = count(*) FROM LoaiVatTu WHERE MaLoai = @MaLoai
	IF (@CheckMaHang > 0 or @CheckMaLoai = 0)
		print 'Error! Please check your lock constraints again!'
	ELSE IF (@DonViTinh != N'thùng' AND @DonViTinh != N'bịch' AND @DonViTinh != N'cái' AND @DonViTinh != N'khối')
		print 'Error! Your DonViTinh must be [thùng|'+N'bịch|'+N'cái|'+N'khối]!'
	ELSE IF (@SoLuong = 0)
		print 'Error! Your SoLuong must be > 0 !'
	ELSE IF (@DonGia = 0)
		print 'Error! Your DonGia must be > 0 !'
	ELSE
		INSERT INTO VatTu VALUES(@MaHang, @TenHang, @DonViTinh, @SoLuong, @DonGia, @MaLoai)
END

GO
CREATE PROCEDURE ProcedureCauB (@SoHD CHAR(5),@NgayLap DATE,@MaKH CHAR(5))
AS
BEGIN
	DECLARE @CheckSoHD int, @CheckMaKH int
	SELECT @CheckSoHD = count(*) FROM HoaDon WHERE SoHD = @SoHD
	SELECT @CheckMaKH = count(*) FROM KhachHang WHERE MaKH = @MaKH
	IF (@CheckSoHD > 0 or @CheckMaKH = 0)
		print 'Error! Please check your lock constraints again!'
	ELSE
		INSERT INTO HoaDon VALUES(@SoHD, @NgayLap, @MaKH)
END

/* Test ProcedureCauA */
INSERT INTO LoaiVatTu VALUES('VL011',N'Sỏi')
EXEC ProcedureCauA 'VT011',N'Sỏi Sơn Đông',N'bịch',10,90000,'VL011'
/* Test ProcedureCauB */
INSERT INTO KhachHang VALUES('KH011',N'Trần Quang Vinh','01229746961')
EXEC ProcedureCauB 'HD011','1/3/2000','KH011'



