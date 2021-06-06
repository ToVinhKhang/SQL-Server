/*--------------------------------*/
/*PHAN 1: TAO CSDL TREN SQL SERVER*/
/*--------------------------------*/

/*------------*/
/*CREATE TABLE*/
/*------------*/

/* Cau 1 */
CREATE TABLE NhanVien(
	MSNV CHAR(5) NOT NULL,
	HoTen NVARCHAR(80) NOT NULL,
	NgaySinh DATE,
	GioiTinh NVARCHAR(5) NOT NULL,
	CMND VARCHAR(12) NOT NULL UNIQUE,
	DiaChi NVARCHAR(100),
	Email VARCHAR(100),
	constraint PK_NhanVien_MSNV primary key(MSNV),
);

ALTER TABLE NhanVien
ADD constraint CHECK_MSNV
CHECK ((MSNV LIKE 'SA[0-9][0-9][0-9]') OR (MSNV LIKE 'PG[0-9][0-9][0-9]') OR (MSNV LIKE 'SL[0-9][0-9][0-9]') OR (MSNV LIKE 'TP[0-9][0-9][0-9]') OR (MSNV LIKE 'TD[0-9][0-9][0-9]') OR (MSNV LIKE 'VP[0-9][0-9][0-9]'))

/* Cau 2 */
CREATE TABLE DienThoaiNV(
	MSNV INT IDENTITY(1,1),
	DienThoai CHAR(15) NOT NULL,
	constraint PK_DienThoaiNV_MSNV_DienThoai primary key(MSNV,DienThoai),
);

ALTER TABLE DienThoaiNV
ADD constraint CHECK_DienThoai
CHECK (DienThoai LIKE '+84([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])')

/* Cau 3 */
CREATE TABLE ThoSuaAnh(
	MS_ThoSuaAnh CHAR(5) NOT NULL,
	constraint PK_ThoSuaAnh_MSTSA primary key(MS_ThoSuaAnh),
	constraint FK_ThoSuaAnh_MSTSA_NHANVIEN foreign key(MS_ThoSuaAnh) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 4 */
CREATE TABLE Photographer_ChupKiSu(
	MS_PhotographerKiSu CHAR(5) NOT NULL,
	KienThucPS CHAR(1),
	KinhNghiem INT,
	constraint PK_Photographer_ChupKiSu_MSPKS primary key(MS_PhotographerKiSu),
	constraint FK_Photographer_ChupKiSu_MSPKS_NHANVIEN foreign key(MS_PhotographerKiSu) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 5 */
CREATE TABLE Photographer_ChupAlbumCuoi(
	MS_PhotographerAlbum CHAR(5) NOT NULL,
	KienThucPS CHAR(1),
	KinhNghiem INT,
	constraint PK_Photographer_ChupAlbumCuoi_MSPAB primary key(MS_PhotographerAlbum),
	constraint FK_Photographer_ChupAlbumCuoi_MSPAB_NHANVIEN foreign key(MS_PhotographerAlbum) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 6 */
CREATE TABLE Stylist(
	MS_Stylist CHAR(5) NOT NULL,
	constraint PK_Stylist_MSSTL primary key(MS_Stylist),
	constraint FK_Stylist_MSSTL_NHANVIEN foreign key(MS_Stylist) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 7 */
CREATE TABLE ThoPhu(
	MS_ThoPhu CHAR(5) NOT NULL,
	constraint PK_ThoPhu_MSTPh primary key(MS_ThoPhu),
	constraint FK_ThoPhu_MSTPh_NHANVIEN foreign key(MS_ThoPhu) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 8 */
CREATE TABLE CVTrangDiem(
	MS_CVTrangDiem CHAR(5) NOT NULL,
	GiaCoDau INT,
	GiaNguoiNha INT,
	constraint PK_CVTrangDiem_MSCVTD primary key(MS_CVTrangDiem),
	constraint FK_CVTrangDiem_MSCVTD_NHANVIEN foreign key(MS_CVTrangDiem) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 9 */
CREATE TABLE PhongCach_CVTrangDiem(
	MS_CVTrangDiem CHAR(5) NOT NULL,
	PhongCach NVARCHAR(20),
	constraint PK_PhongCach_CVTrangDiem_MSCVTD_PhongCach primary key(MS_CVTrangDiem,PhongCach),
	constraint FK_PhongCach_CVTrangDiem_MSCVTD_CVTrangDiem foreign key(MS_CVTrangDiem) references CVTrangDiem(MS_CVTrangDiem) on DELETE cascade on UPDATE cascade,
);

/* Cau 10 */
CREATE TABLE NVVanPhong(
	MS_VanPhong CHAR(5) NOT NULL,
	ViTri NVARCHAR(20),
	KiNang NVARCHAR(20),
	constraint PK_NVVanPhong_MSNVVP primary key(MS_VanPhong),
	constraint FK_NVVanPhong_MSVPh_NHANVIEN foreign key(MS_VanPhong) references NhanVien(MSNV) on DELETE cascade on UPDATE cascade,
);

/* Cau 11 */
CREATE TABLE KhachHang(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSKH AS (CAST('KH' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	DiaChi NVARCHAR(100),
	NgayCuoi DATE NOT NULL,
	HoTenCR NVARCHAR(50) NOT NULL,
	HoTenCD NVARCHAR(50) NOT NULL,
	NgaySinhCR DATE,
	NgaySinhCd DATE,
	DienThoaiCR VARCHAR(15),
	DienThoaiCD VARCHAR(15),
	EmailCR VARCHAR(50),
	EmailCD VARCHAR(50),
	constraint PK_KhachHang_MSKH primary key(MSKH),
);

ALTER TABLE KhachHang
ADD constraint CHECK_NgayCuoi
CHECK (NgayCuoi > GETDATE())

ALTER TABLE KhachHang
ADD constraint CHECK_DienThoaiChuanCuaCR
CHECK (DienThoaiCR LIKE '+84([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])')

ALTER TABLE KhachHang
ADD constraint CHECK_DienThoaiChuanCuaCD
CHECK (DienThoaiCd LIKE '+84([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])')

ALTER TABLE KhachHang
ADD constraint CHECK_DienThoaiCDCR
CHECK (((DienThoaiCR != NULL) AND (DienThoaiCD != NULL)) OR ((DienThoaiCR = NULL) AND (DienThoaiCD != NULL)) OR ((DienThoaiCR != NULL) AND (DienThoaiCD = NULL)))

ALTER TABLE KhachHang
ADD constraint CHECK_EmailCDCR
CHECK (((EmailCR != NULL) AND (EmailCD != NULL) AND EmailCR LIKE '%@%' AND EmailCD LIKE '%@%') OR ((EmailCR = NULL) AND (EmailCD != NULL) AND EmailCD LIKE '%@%') OR ((EmailCR != NULL) AND (EmailCD = NULL) AND EmailCR LIKE '%@%'))

/* Cau 12 */
CREATE TABLE HopDong(
	ID INT NOT NULL IDENTITY(1,1),
	MSHD AS (CAST('HD' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	ThoiDiemKi DATE NOT NULL,
	TongGia INT NOT NULL,
	MSKH CHAR(5) NOT NULL,
	MS_VanPhong CHAR(5) NOT NULL,
	constraint PK_HopDong_MSHD primary key(MSHD),
	constraint FK_HopDong_MSKH_KhachHang foreign key(MSKH) references KhachHang(MSKH) ,
	constraint FK_HopDong_MSVPh_NVVanPhong foreign key(MS_VanPhong) references NVVanPhong(MS_VanPhong),
);

/* Cau 13 */
CREATE TABLE HopDong_LanThanhToan(
	MSHD CHAR(5) NOT NULL,
	ThoiDiem DATE,
	SoTien INT,
	constraint PK_HopDong_LanThanhToan_MSHD_ThoiDiem primary key(MSHD,ThoiDiem),
	constraint FK_HopDong_LanThanhToan_MSHD_HopDong foreign key(MSHD) references HopDong(MSHD) on DELETE cascade on UPDATE cascade,
);

ALTER TABLE HopDong_LanThanhToan
ADD constraint CHECK_ThoiDiem
CHECK (ThoiDiem > GETDATE())

/* Cau 15 */
CREATE TABLE AoVest(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSVest AS (CAST('Ve' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	Kieu NVARCHAR(10),
	Mau NVARCHAR(10),
	KichCo VARCHAR(3) NOT NULL,
	Soluong INT DEFAULT 0,
	GiaThue INT,
	constraint PK_AoVest_MSVest primary key(MSVest),
);

ALTER TABLE AoVest
ADD constraint CHECK_KichCo
CHECK (KichCo = 'XS' OR  KichCo = 'S' OR KichCo = 'M' OR KichCo = 'L' OR  KichCo = 'XL' OR KichCo = 'XXL')

/* Cau 14 */
CREATE TABLE DVAlbumCuoi(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSDVAlbum AS (CAST('DVA' AS CHAR(3)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	MSHD CHAR(5) NOT NULL,
	MS_PhotographerAlbum CHAR(5) NOT NULL,
	MS_Stylist CHAR(5) NOT NULL,
	MS_ThoPhu CHAR(5) NOT NULL,
	MS_CVTrangDiem CHAR(5) NOT NULL,
	MSVest1 CHAR(5),
	MSVest2 CHAR(5),
	TongGia INT NOT NULL,
	constraint PK_DVAlbumCuoi_MSDVAlbum primary key(MSDVAlbum),
	constraint FK_DVAlbumCuoi_MSHD_HopDong foreign key(MSHD) references HopDong(MSHD),
	constraint FK_DVAlbumCuoi_MS_PhotographerAlbum_Photographer_ChupAlbumCuoi foreign key(MS_PhotographerAlbum) references Photographer_ChupAlbumCuoi(MS_PhotographerAlbum),
	constraint FK_DVAlbumCuoi_MS_Stylist_Stylist foreign key(MS_Stylist) references Stylist(MS_Stylist),
	constraint FK_DVAlbumCuoi_MS_ThoPhu_ThoPhu foreign key(MS_ThoPhu) references ThoPhu(MS_ThoPhu),
	constraint FK_DVAlbumCuoi_MS_CVTrangDiem_CVTrangDiem foreign key(MS_CVTrangDiem) references CVTrangDiem(MS_CVTrangDiem),
);

ALTER TABLE DVAlbumCuoi
ADD constraint CHECK_MSVest
CHECK (((MSVest1 != NULL) AND (MSVest2 != NULL)) AND (MSVest1 != MSVest2))

/* Cau 16 */
CREATE TABLE DaoCu(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSDC AS (CAST('DC' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	Ten NVARCHAR(100),
	Gia INT,
	Soluong INT DEFAULT 0,
	constraint PK_DaoCu_MSDC primary key(MSDC),
);

/* Cau 17 */
CREATE TABLE DVAlbum_DaoCu(
	MSDVAlbum CHAR(6) NOT NULL,
	MSDC CHAR(5) NOT NULL,
	constraint PK_DVAlbum_DaoCu_MSDVAlbum_MSDC primary key(MSDVAlbum,MSDC),
	constraint FK_DVAlbum_DaoCu_MSDVAlbum_DVAlbumCuoi foreign key(MSDVAlbum) references DVAlbumCuoi(MSDVAlbum),
	constraint FK_DVAlbum_DaoCu_MSDC_DaoCu foreign key(MSDC) references DaoCu(MSDC),
);

/* Cau 18 */
CREATE TABLE DiaDiem(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSDD AS (CAST('DD' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	Ten NVARCHAR(100) NOT NULL UNIQUE,
	Gia INT,
	ViTri NVARCHAR(20),
	TongThoiGianChup FLOAT,
	GiaBoSung INT,
	GiaGoc INT,
	constraint PK_DiaDiem_MSDD primary key(MSDD),
);

/* Cau 19 */
CREATE TABLE DVAlbum_DiaDiem(
	MSDVAlbum CHAR(6) NOT NULL,
	MSDD CHAR(5) NOT NULL,
	ThoiDiemChup DATE,
	constraint PK_DVAlbum_DiaDiem_MSDVAlbum_MSDD primary key(MSDVAlbum,MSDD),
	constraint FK_DVAlbum_DiaDiem_DaoCu_MSDVAlbum_DVAlbumCuoi foreign key(MSDVAlbum) references DVAlbumCuoi(MSDVAlbum),
	constraint FK_DVAlbum_DiaDiem_DaoCu_MSDC_DaoCu foreign key(MSDD) references DiaDiem(MSDD),
);

/* Cau 20 */
CREATE TABLE GocChup(
	MSDD CHAR(5) NOT NULL,
	TenGocChup NVARCHAR(100) NOT NULL UNIQUE,
	constraint PK_GocChup_MSDD_TenGocChup primary key(MSDD,TenGocChup),
	constraint FK_GocChup_MSDVAlbum_DVAlbumCuoi foreign key(MSDD) references DiaDiem(MSDD),
);

/* Cau 22 */
CREATE TABLE Vay(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSV AS (CAST('Va' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	Ten NVARCHAR(100) NOT NULL,
	Kieu NVARCHAR(30) NOT NULL,
	HinhAnh VARCHAR(100) NOT NULL,
	Mau NVARCHAR(10) NOT NULL,
	ChatLieu VARCHAR(20) NOT NULL,
	NguonGoc VARCHAR(20) NOT NULL,
	TinhTrang CHAR(1) NOT NULL,
	constraint PK_Vay_MSV primary key(MSV),
);

ALTER TABLE Vay
ADD constraint CHECK_TinhTrang
CHECK (TinhTrang = 'B' OR  TinhTrang = 'T' OR TinhTrang = 'K' OR TinhTrang = 'G' OR  TinhTrang = 'U')

/* Cau 23 */
CREATE TABLE VayChupHinh(
	MSVChup CHAR(5) NOT NULL,
	constraint PK_VayChupHinh_MSVChup primary key(MSVChup),
	constraint FK_VayChupHinh_MSVChup_Vay foreign key(MSVChup) references Vay(MSV),
);

/* Cau 21 */
CREATE TABLE DV_Goc_Vay(
	MSDVAlbum CHAR(6) NOT NULL,
	MSDD CHAR(5) NOT NULL,
	TenGocChup NVARCHAR(100) NOT NULL,
	MSVChup CHAR(5) NOT NULL,
	GocBoSung CHAR(1),
	constraint PK_DV_Goc_Vay_MSDVAlbum_MSDD_TenGocChup primary key(MSDVAlbum,MSDD,TenGocChup),
	constraint FK_DV_Goc_Vay_MSDVAlbum_DVAlbumCuoi foreign key(MSDVAlbum) references DVAlbumCuoi(MSDVAlbum),
	constraint FK_DV_Goc_Vay_MSDD_DiaDiem foreign key(MSDD) references DiaDiem(MSDD),
	constraint FK_DV_Goc_Vay_TenGocChup_GocChup foreign key(TenGocChup) references GocChup(TenGocChup),
	constraint FK_DV_Goc_Vay_MSVChup_VayChupHinh foreign key(MSVChup) references VayChupHinh(MSVChup),
);

/* Cau 28 */
CREATE TABLE DVVayCuoi(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSDVVay AS (CAST('DVV' AS CHAR(3)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	MSHD CHAR(5) NOT NULL,
	TongGia INT NOT NULL,
	constraint PK_DVVayCuoi_MSDVVay primary key(MSDVVay),
	constraint FK_VayNgayCuoi_MSHD_HopDong foreign key(MSHD) references HopDong(MSHD),
);

/* Cau 24 */
CREATE TABLE VayNgayCuoi(
	MSVCuoi CHAR(5) NOT NULL,
	GiaThue INT NOT NULL,
	GiaBan INT NOT NULL,
	SoLanThue INT DEFAULT 0,
	MSDVVay CHAR(6) NOT NULL,
	NgayBan DATE NOT NULL,
	Discount INT NOT NULL,
	
	constraint PK_VayNgayCuoi_MSVCuoi primary key(MSVCuoi),
	constraint FK_VayNgayCuoi_MSVCuoi_Vay foreign key(MSVCuoi) references Vay(MSV),
	constraint FK_VayNgayCuoi_MSDVVay_DVVayCuoi foreign key(MSDVVay) references DVVayCuoi(MSDVVay),
);

ALTER TABLE VayNgayCuoi
ADD constraint CHECK_GiaBanGiaThue
CHECK (GiaBan > GiaThue)

/* Cau 26 */
CREATE TABLE Bia(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSBia AS (CAST('Bia' AS CHAR(3)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	Ten NVARCHAR(100) NOT NULL,
	Gia INT NOT NULL,
	Mau NVARCHAR(20),
	ChatLieu VARCHAR(10) NOT NULL,
	constraint PK_Bia_MSBia primary key(MSBia),
);

/* Cau 27 */
CREATE TABLE GiayIn(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSGiay AS (CAST('Giay' AS CHAR(4)) + CAST(ID AS CHAR(4))) PERSISTED NOT NULL,
	ChatLieu NVARCHAR(50) NOT NULL,
	Gia INT NOT NULL,
	SoTo INT NOT NULL,
	constraint PK_GiayIn_MSGiay primary key(MSGiay),
);

/* Cau 25 */
CREATE TABLE Album(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSAlbum AS (CAST('Al' AS CHAR(2)) + CAST(ID AS CHAR(3))) PERSISTED NOT NULL,
	SoTo INT NOT NULL,
	MSDVAlbum CHAR(6) NOT NULL,
	MSBia CHAR(6) NOT NULL,
	MSGiay CHAR(8) NOT NULL,
	
	constraint PK_Album_MSAlbum primary key(MSAlbum),
	constraint FK_Album_MSDVAlbum_DVAlbumCuoi foreign key(MSDVAlbum) references DVAlbumCuoi(MSDVAlbum),
	constraint FK_Album_MSBiay_Bia foreign key(MSBia) references Bia(MSBia),
	constraint FK_Album_MSBiay_GiayIn foreign key(MSGiay) references GiayIn(MSGiay),
);

ALTER TABLE Album
ADD constraint CHECK_SoTo
CHECK (SoTo > 14)

/* Cau 29 */
CREATE TABLE DVVayCuoi_Thue(
	MSDVVay CHAR(6) NOT NULL,
	MSVCuoi CHAR(5) NOT NULL,
	NgayBatDau DATE NOT NULL,
	NgayKetThuc DATE NOT NULL,

	constraint PK_DVVayCuoi_Thue_MSDVVay_MSVCuoi primary key(MSDVVay,MSVCuoi),
	constraint FK_DVVayCuoi_Thue_MSDVVay_DVAlbumCuoi foreign key(MSDVVay) references DVVayCuoi(MSDVVay),
	constraint FK_DVVayCuoi_Thue_MSVCuoi_Bia foreign key(MSVCuoi) references VayNgayCuoi(MSVCuoi),
);

ALTER TABLE DVVayCuoi_Thue
ADD constraint CHECK_NgayBatDauNgayKetThuc
CHECK (NgayKetThuc > NgayBatDau)

/* Cau 30 */
CREATE TABLE DVNgayCuoi(
	ID INT NOT NULL IDENTITY(1,1) ,
	MSDVNgay AS (CAST('DVN' AS CHAR(3)) + CAST(ID AS CHAR(4))) PERSISTED NOT NULL,
	SoLuongNguoiNha INT DEFAULT 0,
	DiaDiem NVARCHAR(100) NOT NULL,
	ThoiDiem TIME NOT NULL,
	Gia INT NOT NULL,
	MSHD CHAR(5) NOT NULL,
	MS_PhotographerKiSu CHAR(5) NOT NULL,
	MS_ThoPhu CHAR(5) NOT NULL,
	TongGia INT NOT NULL,

	constraint PK_DVNgayCuoi_MSDVNgay primary key(MSDVNgay),
	constraint FK_DVNgayCuoi_MSHD_HopDong foreign key(MSHD) references HopDong(MSHD),
	constraint FK_DVNgayCuoi_MS_PhotographerKiSu_Photographer_ChupKiSu foreign key(MS_PhotographerKiSu) references Photographer_ChupKiSu(MS_PhotographerKiSu),
	constraint FK_DVNgayCuoi_MS_ThoPhu_ThoPhu foreign key(MS_ThoPhu) references ThoPhu(MS_ThoPhu),
);

/* Cau 31 */
CREATE TABLE NgayCuoi_TrangDiem(
	MSDVNgay CHAR(7) NOT NULL,
	MS_CVTrangDiem CHAR(5) NOT NULL,
	ThoiDiem TIME NOT NULL,
	CoDauNguoiNha CHAR(1) NOT NULL,

	constraint PK_NgayCuoi_TrangDiem_MSDVNgay_MS_CVTrangDiem_ThoiDiem primary key(MSDVNgay,MS_CVTrangDiem,ThoiDiem),
	constraint FK_NgayCuoi_TrangDiem_MSDVNgay_DVNgayCuoi foreign key(MSDVNgay) references DVNgayCuoi(MSDVNgay),
	constraint FK_NgayCuoi_TrangDiem_MS_CVTrangDiem_CVTrangDiem foreign key(MS_CVTrangDiem) references CVTrangDiem(MS_CVTrangDiem),
);

/*------------------*/
/*PHAN 2: TRIGGER	*/
/*------------------*/

GO
CREATE TRIGGER Trig_DVVayCuoi_Thue ON DVVayCuoi_Thue
FOR INSERT,UPDATE
AS
BEGIN
	UPDATE VayNgayCuoi
		SET SoLanThue=SoLanThue+1 WHERE MSVCuoi IN 
			(SELECT VNC.MSVCuoi FROM inserted, VayNgayCuoi AS VNC where VNC.MSVCuoi = inserted.MSVcuoi) 
		AND MSVCuoi IN 
			(SELECT V.MSV FROM inserted , Vay AS V WHERE V.MSV=inserted.MSVCuoi AND TinhTrang='K')
	UPDATE Vay
		SET TinhTrang='T' WHERE MSV IN 
			(SELECT VNC.MSVCuoi FROM inserted, VayNgayCuoi AS VNC WHERE inserted.MSVCuoi = VNC.MSVCuoi)
		AND TinhTrang='K'
	UPDATE VayNgayCuoi
		SET Discount=5*SoLanThue WHERE MSVCuoi IN 
			(SELECT NC.MSVCuoi FROM inserted,VayNgayCuoi AS NC WHERE NC.MSVCuoi = inserted.MSVCuoi)
END

/*--------------------------*/
/*PHAN 3: THAO TAC TREN CSDL*/
/*--------------------------*/

/*------*/
/*INSERT*/
/*------*/

/*INSERT CAU 1*/
GO
SET DATEFORMAT DMY
INSERT INTO NhanVien(MSNV, HoTen, NgaySinh, GioiTinh, CMND, DiaChi, Email) VALUES
('SA518',N'TÔ VĨNH KHANG','1/2/2000','NAM','026053180',N'19 NGUYỄN HỮU THỌ Q7','vinhkhang1969@gmail.com'),
('PG123',N'CHÂU NHUẬN PHÁT','8/3/1999','NAM','021233182',N'230 NGUYỄN HUỆ Q1','nhuanphat@gmail.com'),
('SL456',N'TÀO TUYẾT CẦN','9/4/1998','NAM','026078980',N'147 LÝ CHÍNH THẮNG Q3','taotuyetcan@gmail.com'),
('TP789',N'NGUYỄN KIM HUYỀN','10/5/2000',N'NỮ','026014780',N'213 NGUYỄN TRÃI Q5','thienthuat@gmail.com'),
('TD147',N'TRẦN HƯNG LONG','11/6/2000','NAM','026053369',N'347 HẬU GIANG Q6','longtran@gmail.com'),
('VP369',N'PHAN THANH TOÀN','12/7/1999','NAM','028053159',N'91 BÌNH THỚI Q11','toan123456@gmail.com'),
('PG000',N'CHÂU CHÍ CÔNG','8/3/1999','NAM','027786238',N'20 HÀM NGHI Q1','chicong@gmail.com'),
('SL111',N'HỒNG LÂU MỘNG','9/4/1998',N'NỮ','026345638',N'14 LÝ NAM ĐẾ Q10','hongmong9x@gmail.com'),
('SA987',N'TRẦN MỸ LỆ','9/12/1998',N'NỮ','026745874',N'113 CAO LỖ Q8','myletran98@gmail.com'),
('TP159',N'NGUYỄN QUÝ PHI','15/5/2000',N'NỮ','021597538',N'21 LÃNH BINH THĂNG Q11','quyphing155@gmail.com'),
('TD753',N'TRẦN HẠO NAM','11/8/2000','NAM','026053001',N'388 SƯ VẠN HẠNH Q10','namtran2k@gmail.com'),
('VP258',N'BÙI GIA HUỆ','2/2/1999',N'NỮ','028777892',N'97 HÀN HẢI NGUYÊN Q11','buihue99@gmail.com'),
('SA222',N'TRƯƠNG THẾ ANH','11/12/2000','NAM','026053280147',N'01BIS NGUYỄN THỊ MINH KHAI Q1','theanh@gmail.com'),
('PG333',N'QUÁCH GIA LÂN','3/3/1999','NAM','026053742134',N'23 LÝ THÁI TỔ Q10','gialan@gmail.com'),
('SL444',N'HÀ QUẾ PHƯƠNG','9/6/1998',N'NỮ','016053180142',N'14 LỮ GIA Q11','quephuong@gmail.com'),
('TP555',N'TRẦN QUỲNH NHƯ','5/5/2000',N'NỮ','023053180141',N'883 NGUYỄN KIM Q5','quhnhu@gmail.com'),
('TD666',N'TRỊNH KHANG MINH','2/6/2000',N'NAM','046053180478',N'114 HẬU GIANG Q5','khangminhtrinh@gmail.com'),
('VP777',N'BÙI QUANG KHẢI','1/7/1999','NAM','022053180147',N'71 BÌNH THỚI Q5','khaikler@gmail.com'),
('PG888',N'HÀ ANH TUẤN','8/4/1999','NAM','027784788',N'85 HÀM NGHI Q1','anhtuanha@gmail.com'),
('SL999',N'PHAN PHƯỚC THỊNH','9/2/1998','NAM','026314238',N'140 LÝ NAM ĐẾ Q5','hanphuocthinh@gmail.com'),
('SA141',N'ĐẶNG NGỌC TRÂM','9/1/1998',N'NỮ','024563180128',N'187 QUỐC LỘ 50 Q8','dangtram@gmail.com'),
('TP171',N'LÂM CHÍ SIÊU','15/4/2000','NAM','021597982',N'14 LÃNH BINH THĂNG Q11','chisieuuu@gmail.com'),
('TD181',N'LÂM TÂM NHƯ','12/3/2000','NAM','026053003',N'38 LÊ VĂN QUỚI Q.Bình Tân','tammmnhuuu@gmail.com'),
('VP191',N'TÔN BẢO TRÍ','2/7/1999','NAM','028787897',N'78 NGÔ TẤT TỐ Q.Bình Thạnh','tribaoro@gmail.com'),
('SA282',N'PHẠM VĂN ĐỨC','1/1/1998','NAM','026053117',N'12 Hà Huy Tập Q.Phú Nhuận','vanduck@gmail.com'),
('PG488',N'LƯƠNG CHÍ KHANG','4/4/1999','NAM','021233199',N'09 Man Thiện Q9','chikhangg@gmail.com'),
('SL986',N'TRƯƠNG QUỲNH NGHI','1/4/1998',N'NỮ','026078973',N'122 LÝ CHÍNH THẮNG Q3','nghiquynhtr@gmail.com'),
('TP119',N'NGUYỄN XUÂN NHI','7/7/2000',N'NỮ','026014789',N'878 NGUYỄN TRÃI Q5','xuannhing@gmail.com'),
('TD334',N'CAO BÁ QUÁT','3/8/2000','NAM','036053361',N'347 HẬU GIANG Q6','caobaquat@gmail.com'),
('VP809',N'BÙI TƯ TOÀN','2/3/1999','NAM','048053159',N'91 HẬU GIANG Q6','buitutoan@gmail.com'),
('PG020',N'MAI TUẤN QUANG','9/3/1999','NAM','057786231',N'200 HẬU GIANG Q6','maituanquang@gmail.com'),
('SL778',N'CAO XUÂN BÁCH','1/2/1998','NAM','066345632',N'140 HẬU GIANG Q6','caobach@gmail.com'),
('SA662',N'LƯ THU YẾN','4/3/1998',N'NỮ','076745874',N'11 NGUYỄN HỮU CẢNH Q7','thuyenn@gmail.com'),
('TP553',N'LÂM THỊ MY','7/5/2000',N'NỮ','023597538',N'28 ONG ÍCH KHIÊM Q11','lammy@gmail.com'),
('TD551',N'TRẦN ANH KIỆT','4/5/2000','NAM','086053016',N'78 THỦ THIÊM Q2','anhkiettr@gmail.com'),
('VP003',N'QUANG MINH ĐẠT','2/7/1999','NAM','018777745',N'11 THỦ THIÊM Q2','minhdat@gmail.com'),
('PG184',N'MAI TÀI PHẾN','1/3/1998','NAM','057726232',N'202 BÙI TƯ TOÀN Q7','phentaimai@gmail.com'),
('PG921',N'LÂM THANH PHONG','5/3/1997','NAM','057586237',N'17 TÔN ĐỨC THẮNG Q1','phongphoto@gmail.com'),
('PG801',N'TIÊU LÂM TRƯỜNG','1/3/1999','NAM','050126232',N'209 BẾN VÂN ĐỒN Q4','tltruong@gmail.com'),
('PG802',N'TÔ HỮU BẰNG','8/3/1997','NAM','057026237',N'17 THỦ THIÊM Q2','hubangto@gmail.com'),
('PG101',N'QUANG ĐĂNG QUANG','12/12/1998','NAM','050326232',N'472 BÙI BẰNG ĐOÀN Q7','qdquang@gmail.com'),
('PG102',N'QUÁCH LUÂN LƯU','5/8/1999','NAM','057046237',N'27 NGUYỄN TRÃI Q1','quachluanluu@gmail.com')

/*INSERT CAU 2*/
INSERT INTO DienThoaiNV (DienThoai) VALUES
('+84(0909928568)'),('+84(0928159765)'),('+84(0986461323)'),('+84(0919476136)'),('+84(0909561981)'),('+84(0918119194)'),
('+84(0979861313)'),('+84(0915155262)'),('+84(0998989464)'),('+84(0936369746)'),('+84(0909928001)'),('+84(0928159004)'),
('+84(0980561323)'),('+84(0919004222)'),('+84(0909521116)'),('+84(0918131699)'),('+84(0915161626)'),('+84(0912229988)'),
('+84(0947444477)'),('+84(0936364423)'),('+84(0901230200)'),('+84(0922064746)'),('+84(0980134795)'),('+84(0920034592)'),
('+84(0903191992)'),('+84(0900319798)'),('+84(0903223499)'),('+84(0906306194)'),('+84(0923599444)'),('+84(0932603000)'),
('+84(0909787878)'),('+84(0928989898)'),('+84(0923232323)'),('+84(0978787887)'),('+84(0914147474)'),('+84(0925289636)')

/*INSERT CAU 3*/
INSERT INTO ThoSuaAnh (MS_ThoSuaAnh) VALUES
('SA518'),('SA987'),('SA222'),('SA141'),('SA282'),('SA662')

/*INSERT CAU 4*/
INSERT INTO Photographer_ChupKiSu(MS_PhotographerKiSu, KienThucPS, KinhNghiem) VALUES
('PG123','0',1),('PG000','1',2),('PG333','1',4),('PG888','0',3),('PG801','1',4),('PG802','1',1)

/*INSERT CAU 5*/
INSERT INTO Photographer_ChupAlbumCuoi(MS_PhotographerAlbum, KienThucPS, KinhNghiem) VALUES
('PG488','0',5),('PG020','1',6),('PG184','0',1),('PG921','1',3),('PG101','0',1),('PG102','1',3)

/*INSERT CAU 6*/
INSERT INTO Stylist (MS_Stylist) VALUES
('SL456'),('SL111'),('SA222'),('SL444'),('SL999'),('SL986')

/*INSERT CAU 7*/
INSERT INTO ThoPhu (MS_ThoPhu) VALUES
('TP789'),('TP159'),('TP555'),('TP171'),('TP119'),('TP553')

/*INSERT CAU 8*/
INSERT INTO CVTrangDiem (MS_CVTrangDiem, GiaCoDau, GiaNguoiNha) VALUES
('TD147',3000000,1000000),('TD753',2000000,1200000),('TD666',2200000,1100000),('TD181',1900000,1300000),('TD334',1800000,1400000),('TD551',1500000,1500000)

/*INSERT CAU 9*/
INSERT INTO PhongCach_CVTrangDiem(MS_CVTrangDiem, PhongCach) VALUES
('TD147',N'Đám tiệc'),('TD753',N'Đám tiệc'),('TD181',N'Hóa trang'),('TD334',N'Hóa trang'),('TD551',N'Hóa trang'),('TD666',N'Đám tiệc')

/*INSERT CAU 10*/
INSERT INTO NVVanPhong (MS_VanPhong, ViTri, KiNang) VALUES
('VP369',N'Trưởng phòng',N'Quản lí nhân sự'),('VP258',N'Phó phòng',N'Quản lí nhân sự'),('VP777',N'Thư kí',N'Kế toán'),('VP191',N'Thư kí',N'Kiểm toán'),('VP809',N'Thư kí',N'Phiên dịch Tiếng Hoa'),('VP003',N'Thư kí',N'Phiên dịch Tiếng Anh')

/*INSERT CAU 11*/
INSERT INTO KhachHang (DiaChi,NgayCuoi, HoTenCR, NgaySinhCR, DienThoaiCR, EmailCR, HoTenCD, NgaySinhCD, DienThoaiCD, EmailCD) VALUES
(N'72 LÂM VĂN BỀN Q4','10/11/2020',N'BÙI XUÂN KIỆN','1/2/1998','+84(0925289622)','kienbuicr@gmail.com',N'NGUYỄN HUYỀN TRANG','2/7/1999','+84(0925289789)',''),
(N'28 NGUYỄN TRI PHƯƠNG Q10','7/12/2020',N'NGUYỄN HOÀNG LONG','4/9/1999','+84(0925289123)','hoangdragon11@gmail.com',N'TRẦN QUỲNH PHƯƠNG','4/5/1999','+84(0925000789)',''),
(N'69 NGUYỄN THỊ THẬP Q7','8/9/2020',N'PHAN TRỌNG TÍN','3/5/1997','+84(0925289456)','trongtin97@gmail.com',N'ĐÀO TUYẾT MY','7/4/2000','+84(0925280089)','mydao@gmail.com'),
(N'14 AN DƯƠNG VƯƠNG Q5','12/12/2020',N'NGUYỄN TIỆP KHẮC','2/6/1997','+84(0925289753)','tiepkhac9x@gmail.com',N'LA MỘNG TUYỀN','12/3/1999','+84(0925289700)',''),
(N'08 CAO LỖ Q8','1/1/2021',N'VƯƠNG QUỐC HOÀNG','1/8/1999','+84(0925289951)','quochoangvg2@gmail.com',N'HỨA THU THẢO','10/2/2001','+84(0920097893)','thaocute2k1@gmail.com'),
(N'100 HẬU GIANG Q6','10/12/2020',N'TRẦN TRỌNG PHÚ','9/8/1998','+84(0925389100)','',N'NGUYỄN LINH CHI','2/2/2000','+84(0920297701)','linhbexinhxinh@gmail.com')

/*INSERT CAU 12*/
INSERT INTO HopDong (ThoiDiemKi, TongGia, MSKH, MS_VanPhong) VALUES
('4/7/2020',220000000,'KH1','VP369'),('5/6/2020',180000000,'KH2','VP777'),('9/8/2020',195000000,'KH3','VP191'),
('2/9/2020',238000000,'KH4','VP809'),('4/10/2020',99500000,'KH5','VP003'),('3/9/2020',169000000,'KH6','VP258')

/*INSERT CAU 13*/
INSERT INTO HopDong_LanThanhToan (MSHD, ThoiDiem, SoTien) VALUES
('HD1','4/7/2020',220000000),('HD2','5/6/2020',180000000),('HD3','9/8/2020',195000000),
('HD4','2/9/2020',238000000),('HD5','4/10/2020',99500000),('HD6','3/9/2020',169000000)

/*INSERT CAU 14*/
INSERT INTO DVAlbumCuoi (MSHD, MS_PhotographerAlbum, MS_Stylist, MS_ThoPhu, MS_CVTrangDiem, MSVest1, MSVest2, TongGia) VALUES
('HD1','PG488','SL456','TP789','TD147','Ve1','Ve2',500000),('HD2','PG020','SL111','TP159','TD753','Ve3','Ve4',550000),
('HD3','PG184','SA222','TP555','TD181','Ve5','Ve6',420000),('HD4','PG921','SL444','TP171','TD334','Ve7','Ve8',380000),
('HD5','PG101','SL999','TP119','TD551','Ve9','Ve10',350000),('HD6','PG102','SL986','TP553','TD666','Ve11','Ve12',480000)

/*INSERT CAU 15*/
INSERT INTO AoVest (Kieu, Mau, KichCo, SoLuong, GiaThue) VALUES
(N'Lịch lãm',N'Nâu','XL',12,500000),(N'Lịch lãm',N'Đen','L',15,450000),(N'Trẻ trung',N'Đen','XS',20,200000),(N'Trẻ trung',N'Tím','XL',10,300000),
(N'Trẻ trung',N'Xanh','L',5,250000),(N'Quyến rũ',N'Trắng','L',10,500000),(N'Quyến rũ',N'Đen','L',8,400000),(N'Quyến rũ',N'Nâu','XXL',9,300000),
(N'Quyến rũ',N'Đỏ','M',5,300000),(N'Quý tộc ',N'Nâu','XL',2,800000),(N'Quý tộc',N'Vàng','S',1,900000),(N'Trang nhã',N'Trắng','XS',4,350000)

/*INSERT CAU 16*/
INSERT INTO DaoCu (Ten, Gia, SoLuong) VALUES
(N'Đèn chiếu sáng',600000,10),(N'Đèn ngũ sắc',750000,2),(N'Loa cỡ lớn',1000000,4),(N'Loa cỡ nhỏ',800000,6),(N'Fly cam',3000000,1),(N'Máy phun sương',750000,1)

/*INSERT CAU 17*/
INSERT INTO DVAlbum_DaoCu(MSDVAlbum, MSDC) VALUES
('DVA1','DC1'),('DVA2','DC2'),('DVA3','DC3'),('DVA4','DC4'),('DVA5','DC5'),('DVA6','DC6')

/*INSERT CAU 18*/
INSERT INTO DiaDiem (Ten, Gia, ViTri, TongThoiGianChup, GiaBoSung, GiaGoc) VALUES
(N'Phong Nha Kẽ Bàng',1000000,N'Quảng Bình',0.5,200000,800000),(N'Phố Cổ Hội An',1800000,N'Quảng Nam',1.5,500000,1300000),
(N'Cung Đình Huế',1500000,N'Thừa Thiên Huế',2.0,500000,1000000),(N'Landmark 81',600000,N'Q.Bình Thạnh',1.0,100000,500000),
(N'Núi Bà Đen',800000,N'Tây Ninh',2.5,0,800000),(N'Hòn Thơm Suối Tranh',2500000,N'Phú Quốc',0.5,800000,1700000)

/*INSERT CAU 19*/
INSERT INTO DVAlbum_DiaDiem (MSDVAlbum, MSDD, ThoiDiemChup) VALUES
('DVA1','DD1','7/9/2020'),('DVA2','DD2','12/10/2020'),('DVA3','DD3','2/8/2020'),
('DVA4','DD4','11/11/2020'),('DVA5','DD5','12/12/2020'),('DVA6','DD6','7/8/2020')

/*INSERT CAU 20*/
INSERT INTO GocChup (MSDD, TenGocChup) VALUES
('DD1',N'Hang động'),('DD2',N'Phố cổ'),('DD3',N'Điện miến'),('DD4',N'Tầng 79'),('DD5',N'Sườn núi'),('DD6',N'Biển và thác')

/*INSERT CAU 22*/
INSERT INTO Vay (Ten, Kieu, HinhAnh, Mau, ChatLieu, NguonGoc, TinhTrang) VALUES
(N'Váy cưới 1',N'Cổ điển','images/vay/classic01.jpg',N'Trắng','Satin',N'Pháp','T'),
(N'Váy cưới 2',N'Hiện đại','images/vay/modern02.jpg',N'Đen','Organza',N'Hàn','K'),
(N'Váy cưới 3',N'Hiện đại','images/vay/modern03.jpg',N'Đỏ','Chiffon',N'Ý','U'),
(N'Váy cưới 4',N'Cổ điển','images/vay/classic04.jpg',N'Đỏ','Tulle',N'Hàn','G'),
(N'Váy cưới 5',N'Hiện đại','images/vay/modern05.jpg',N'Tím','Charmeuse',N'Anh','B'),
(N'Váy cưới 6',N'Cổ điển','images/vay/classic06.jpg',N'Trắng','Lace ',N'Úc','T')

/*INSERT CAU 23*/
INSERT INTO VayChupHinh (MSVChup) VALUES
('Va1'),('Va2'),('Va3'),('Va4'),('Va5'),('Va6')

/*INSERT CAU 21*/
INSERT INTO DV_Goc_Vay (MSDVAlbum, MSDD, TenGocChup, MSVChup, GocBoSung) VALUES
('DVA1','DD1',N'Hang động','Va1','1'),('DVA2','DD2',N'Phố cổ','Va2','1'),('DVA3','DD3',N'Điện miến','Va3','1'),
('DVA4','DD4',N'Tầng 79','Va4','1'),('DVA5','DD5',N'Sườn núi','Va5','0'),('DVA6','DD6',N'Biển và thác','Va6','1')

/*INSERT CAU 28*/
INSERT INTO DVVayCuoi (MSHD, TongGia) VALUES
('HD1',5000000),('HD2',5400000),('HD3',4200000),('HD4',6300000),('HD5',3100000),('HD6',6500000)

/*INSERT CAU 24*/
INSERT INTO VayNgayCuoi (MSVCuoi, GiaThue, GiaBan, SoLanThue, MSDVVay, NgayBan, Discount) VALUES
('Va1',500000,2000000,3,'DVV1','1/9/2020',10),('Va2',400000,1800000,6,'DVV2','1/10/2020',5),('Va3',300000,1500000,4,'DVV3','1/8/2020',15),
('Va4',600000,2200000,2,'DVV4','1/11/2020',5),('Va5',700000,2400000,1,'DVV5','1/12/2020',5),('Va6',800000,2600000,7,'DVV6','1/7/2020',25)

/*INSERT CAU 26*/
INSERT INTO Bia (Ten, Gia, Mau, ChatLieu) VALUES
(N'Bìa nhựa',50000,N'Xanh',N'Trong suốt'),(N'Bìa nhựa',55000,N'Hồng',N'Dẻo'),(N'Bìa giấy',80000,N'Nâu',N'Nhám'),
(N'Bìa giấy',85000,N'Hồng',N'Chống mục'),(N'Bìa cứng',75000,N'Đen',N'Nhám'),(N'Bìa cứng',85000,N'Hồng',N'Nhám')

/*INSERT CAU 27*/
INSERT INTO GiayIn (ChatLieu, Gia, SoTo) VALUES
(N'Giấy thường','43000',20),(N'Giấy hoa văn','66000',15),(N'Giấy ảnh','78000',30),(N'Giấy cứng','76000',25),(N'Giấy thơm','95000',15),(N'Giấy nhám','82000',20)

/*INSERT CAU 25*/
INSERT INTO Album (SoTo, MSDVAlbum, MSBia, MSGiay) VALUES
(20,'DVA1','Bia1 ','Giay1'),(15,'DVA2','Bia2 ','Giay2'),(30,'DVA3','Bia3 ','Giay3'),
(25,'DVA4','Bia4 ','Giay4'),(15,'DVA5','Bia5 ','Giay5'),(20,'DVA6','Bia6 ','Giay6')

/*INSERT CAU 29*/
SET DATEFORMAT DMY
INSERT INTO DVVayCuoi_Thue (MSDVVay, MSVCuoi, NgayBatDau, NgayKetThuc) VALUES
('DVV1','Va1','9/11/2020','11/11/2020'),('DVV2','Va2','6/12/2020','8/12/2020'),('DVV3','Va3','7/9/2020','9/9/2020'),
('DVV4','Va4','11/12/2020','13/12/2020'),('DVV5','Va5','31/12/2020','2/1/2021'),('DVV6','Va6','9/12/2020','11/12/2020')

/*INSERT CAU 30*/
INSERT INTO DVNgayCuoi (SoLuongNguoiNha, DiaDiem, ThoiDiem, Gia, MSHD, MS_PhotographerKiSu, MS_ThoPhu, TongGia) VALUES
(40,N'Nhà hàng Ái Huê','7:00',2500000,'HD1','PG123','TP789',6000000),
(30,N'Nhà hàng New World','7:30',1500000,'HD2','PG000','TP159',5500000),
(35,N'Nhà hàng Thủy Hử','9:00',1700000,'HD3','PG333','TP555',5700000),
(28,N'Nhà hàng Sinh Đôi','13:00',2200000,'HD4','PG888','TP171',5900000),
(25,N'Nhà hàng Trùng Khánh','8:00',2300000,'HD5','PG801','TP119',6100000),
(36,N'Nhà hàng Valentine','8:30',1600000,'HD6','PG802','TP553',4800000)

/*INSERT CAU 31*/
INSERT INTO NgayCuoi_TrangDiem (MSDVNgay, MS_CVTrangDiem, ThoiDiem, CoDauNguoiNha) VALUES
('DVN1','TD147','7:00','1'),('DVN2','TD753','7:30','0'),('DVN3','TD666','9:00','0'),
('DVN4','TD181','13:00','1'),('DVN5','TD334','8:00','1'),('DVN6','TD334','8:30','1')

/*------*/
/*UPDATE*/
/*------*/

UPDATE Vay
SET TinhTrang = 'K' WHERE TinhTrang = 'T';

/*------*/
/*DELETE*/
/*------*/

/**DELETE FROM HopDong WHERE MSHD='HD6';**/
/* KHÔNG THỂ XÓA TRỰC TIẾP HỢP ĐỒNG NÀY */
/*Giải thích:*/
/*Việc xóa dữ liệu này trong trường hợp sẽ được thực hiện THÀNH CÔNG khi bảng không bị ràng buộc bởi các khóa ngoại tham chiếu
Hoặc sẽ thành công khi xóa theo đúng trình tự các khác ngoại đã tham chiếu đến bảng đó. 
Việc xóa dữ liệu này trong trường hợp sẽ được thực hiện KHÔNG THÀNH CÔNG là khi yêu cầu xóa 1 hợp đồng không tồn tại trong bảng
hoặc yêu cầu xóa hợp đồng ĐÃ BỊ RÀNG BUỘC bởi các khóa ngoại tham chiếu.*/
/*Khi xóa thành công thì có những bảng dữ liệu như DVVayCuoi,HopDong_LanThanhToan sẽ bị ảnh hưởng bởi thao tác xóa này.*/
/*Vì ta chưa cài đặt các Trigger nên việc xóa sẽ dẫn đến dữ liệu của 2 bảng không khớp , bị ràng buộc lẫn nhau , không đồng bộ với nhau.*/

/*------*/
/*SELECT*/
/*------*/

SELECT MSNV,HoTen AS TenChuyenVienTrangDiem,CoDauNguoiNha FROM NhanVien,NgayCuoi_TrangDiem 
WHERE NhanVien.MSNV = NgayCuoi_TrangDiem.MS_CVTrangDiem order by MSNV

SELECT MSNV,HoTen AS TenPhotographerChupAlbum,ThoiDiemChup,Ten AS TenDiaDiem,TongThoiGianChup FROM NhanVien,DVAlbumCuoi,DVAlbum_DiaDiem,DiaDiem
WHERE NhanVien.MSNV = DVAlbumCuoi.MS_PhotographerAlbum AND DVAlbumCuoi.MSDVAlbum = DVAlbum_DiaDiem.MSDVAlbum AND DVAlbum_DiaDiem.MSDD = DiaDiem.MSDD

SELECT * FROM HopDong_LanThanhToan 
WHERE MSHD = 'HD1'

SELECT * FROM HopDong_LanThanhToan
WHERE MSHD = 'HD5'


/*---------------------------*/
/*PHAN 4: PHAN QUYEN TRUY CAP*/
/*---------------------------*/

/* Tao cac tai khoan dang nhap */
GO
sp_addlogin 'NVVanPhong' , '1234' , 'dichvungaycuoi';
GO
sp_addlogin 'KhachHang' , '5678' , 'dichvungaycuoi';
/* Tao cac user */
GO
USE dichvungaycuoi
GO
sp_adduser 'NVVanPhong' , 'NVVanPhong';

GO
USE dichvungaycuoi
GO
sp_adduser 'KhachHang' , 'KhachHang';
/* Phan quyen */
GO
GRANT INSERT,UPDATE,DELETE
ON HopDong
TO NVVanPhong

GO
GRANT INSERT,UPDATE,DELETE
ON HopDong_LanThanhToan
TO NVVanPhong

GO
GRANT INSERT,UPDATE,DELETE
ON DVAlbumCuoi
TO NVVanPhong

GO
GRANT INSERT,UPDATE,DELETE
ON DVVayCuoi
TO NVVanPhong

GO
GRANT INSERT,UPDATE,DELETE
ON DVNgayCuoi
TO NVVanPhong


GO
GRANT SELECT
ON NhanVien
TO KhachHang

GO
GRANT SELECT
ON Bia
TO KhachHang

GO
GRANT SELECT
ON GiayIn
TO KhachHang

GO
GRANT SELECT
ON VayChupHinh
TO KhachHang

GO
GRANT SELECT
ON VayNgayCuoi
TO KhachHang

GO
GRANT SELECT
ON DiaDiem
TO KhachHang

GO
GRANT SELECT
ON DaoCu
TO KhachHang

GO
GRANT SELECT
ON AoVest
TO KhachHang


/*-----*/
/* END */
/*-----*/
