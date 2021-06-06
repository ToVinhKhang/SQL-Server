/*==============*/
/* Create table */
/*==============*/

/*==============================================================*/
/* Table: BOPHANTHEODOIVATINHCUOC                               */
/*==============================================================*/
create table BOPHANTHEODOIVATINHCUOC 
(
   MABPTDVTC            char(8)                        not null,
   MAKHUYENMAI          char(8)                        null,
   MAHOADONDK           char(8)                        null,
   TIENCUOCHANGTHANG    integer                        not null,
   constraint PK_BOPHANTHEODOIVATINHCUOC primary key (MABPTDVTC)
);

/*==============================================================*/
/* Index: BOPHANTHEODOIVATINHCUOC_PK                            */
/*==============================================================*/
create unique index BOPHANTHEODOIVATINHCUOC_PK on BOPHANTHEODOIVATINHCUOC (
	MABPTDVTC ASC
);

/*==============================================================*/
/* Index: FK_BOPHANTHEODOIVATINHCUOC_MAHOADONDK_HOADONDANGKY_FK */
/*==============================================================*/
create index FK_BOPHANTHEODOIVATINHCUOC_MAHOADONDK_HOADONDANGKY_FK on BOPHANTHEODOIVATINHCUOC (
	MAHOADONDK ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_7_FK on BOPHANTHEODOIVATINHCUOC (
	MAKHUYENMAI ASC
);

/*==============================================================*/
/* Table: CUNGCAPGOICUOCVACTKHUYENMAI                           */
/*==============================================================*/
create table CUNGCAPGOICUOCVACTKHUYENMAI 
(
   MACCGCKM             char(8)                        not null,
   MAKHUYENMAI          char(8)                        null,
   TENGOICUOC           varchar(50)                    not null,
   SOTIENGOICUOC        integer                        not null,
   constraint PK_CUNGCAPGOICUOCVACTKHUYENMAI primary key (MACCGCKM)
);

/*==============================================================*/
/* Index: CUNGCAPGOICUOCVACTKHUYENMAI_PK                        */
/*==============================================================*/
create unique index CUNGCAPGOICUOCVACTKHUYENMAI_PK on CUNGCAPGOICUOCVACTKHUYENMAI (
	MACCGCKM ASC
);

/*================================================================*/
/* Index: FK_CUNGCAPGOICUOCVACTKHUYENMAI_MAKHUYENMAI_KHUYENMAI_FK */
/*================================================================*/
create index FK_CUNGCAPGOICUOCVACTKHUYENMAI_MAKHUYENMAI_KHUYENMAI_FK on CUNGCAPGOICUOCVACTKHUYENMAI (
	MAKHUYENMAI ASC
);

/*==============================================================*/
/* Table: HOADONDANGKY                                          */
/*==============================================================*/
create table HOADONDANGKY 
(
   MAHOADONDK           char(8)                        not null,
   MATHANHTOANDK        char(8)                        null,
   CMND                 varchar(12)                    null,
   DUNGLUONGSUDUNG      integer                        not null,
   DIACHICAIDATDICHVU   varchar(100)                   not null,
   DIACHIGOIHOADONTT    varchar(100)                   not null,
   CHIPHIDK             integer                        not null,
   NGAYBD               date                           not null,
   MATKHAU              varchar(50)                    not null,
   TENTRUYNHAPMANG      varchar(50)                    not null,
   EMAIL                varchar(50)                    not null,
   constraint PK_HOADONDANGKY primary key (MAHOADONDK)
);

/*==============================================================*/
/* Index: HOADONDANGKY_PK                                       */
/*==============================================================*/
create unique index HOADONDANGKY_PK on HOADONDANGKY (
	MAHOADONDK ASC
);

/*==============================================================*/
/* Index: FK_HOADONDANGKY_MATHANHTOANDK_THANHTOANDANGKY_FK      */
/*==============================================================*/
create index FK_HOADONDANGKY_MATHANHTOANDK_THANHTOANDANGKY_FK on HOADONDANGKY (
	MATHANHTOANDK ASC
);

/*==============================================================*/
/* Index: FK_HOADONDANGKY_CMND_HOPDONGDANGKY_FK                 */
/*==============================================================*/
create index FK_HOADONDANGKY_CMND_HOPDONGDANGKY_FK on HOADONDANGKY (
	CMND ASC
);

/*==============================================================*/
/* Table: HOPDONGDANGKY                                         */
/*==============================================================*/
create table HOPDONGDANGKY 
(
   TENKHACHHANG         varchar(50)                    not null,
   CMND                 varchar(12)                    not null,
   NGHENGHIEP           varchar(50)                    null,
   CHUCVU               varchar(50)                    null,
   DIACHI               varchar(100)                   not null,
   DIACHICAIDATDICHVU   varchar(100)                   not null,
   DIACHIGOIHOADONTT    varchar(100)                   not null,
   GOICUOCSUDUNG        varchar(30)                    not null,
   constraint PK_HOPDONGDANGKY primary key (CMND)
);

/*==============================================================*/
/* Index: HOPDONGDANGKY_PK                                      */
/*==============================================================*/
create unique index HOPDONGDANGKY_PK on HOPDONGDANGKY (
	CMND ASC
);

/*==============================================================*/
/* Table: KHUYENMAI                                             */
/*==============================================================*/
create table KHUYENMAI 
(
   MAKHUYENMAI          char(8)                        not null,
   DIEUKIENAPDUNG       varchar(50)                    not null,
   THOIGIAN             date                           not null,
   MOTA                 varchar(80)                    null,
   constraint PK_KHUYENMAI primary key (MAKHUYENMAI)
);

/*==============================================================*/
/* Index: KHUYENMAI_PK                                          */
/*==============================================================*/
create unique index KHUYENMAI_PK on KHUYENMAI (
	MAKHUYENMAI ASC
);

/*==============================================================*/
/* Table: KIEMTRAADSLVAMODEM                                    */
/*==============================================================*/
create table KIEMTRAADSLVAMODEM 
(
   MAKIEMTRA            char(8)                        not null,
   MACCGCKM             char(8)                        null,
   CMND                 varchar(12)                    null,
   ADSL                 char(1)                        not null,
   MODEM                char(1)                        not null,
   constraint PK_KIEMTRAADSLVAMODEM primary key (MAKIEMTRA)
);

/*==============================================================*/
/* Index: KIEMTRAADSLVAMODEM_PK                                 */
/*==============================================================*/
create unique index KIEMTRAADSLVAMODEM_PK on KIEMTRAADSLVAMODEM (
	MAKIEMTRA ASC
);

/*==============================================================*/
/* Index: FK_KIEMTRAADSLVAMODEM_CMND_HOPDONGDANGKY_FK           */
/*==============================================================*/
create index FK_KIEMTRAADSLVAMODEM_CMND_HOPDONGDANGKY_FK on KIEMTRAADSLVAMODEM (
	CMND ASC
);

/*======================================================================*/
/* Index: FK_KIEMTRAADSLVAMODEM_MACCGCKM_CUNGCAPGOICUOCVACTKHUYENMAI_FK */
/*======================================================================*/
create index FK_KIEMTRAADSLVAMODEM_MACCGCKM_CUNGCAPGOICUOCVACTKHUYENMAI_FK on KIEMTRAADSLVAMODEM (
	MACCGCKM ASC
);

/*==============================================================*/
/* Table: THANHTOANDANGKY                                       */
/*==============================================================*/
create table THANHTOANDANGKY 
(
   MATHANHTOANDK        char(8)                        not null,
   MAKIEMTRA            char(8)                        null,
   SOTIENTHANHTOAN      integer                        not null,
   constraint PK_THANHTOANDANGKY primary key (MATHANHTOANDK)
);

/*==============================================================*/
/* Index: THANHTOANDANGKY_PK                                    */
/*==============================================================*/
create unique index THANHTOANDANGKY_PK on THANHTOANDANGKY (
	MATHANHTOANDK ASC
);

/*==============================================================*/
/* Index: FK_THANHTOANDANGKY_MAKIEMTRA_KIEMTRAADSLVAMODEM_FK    */
/*==============================================================*/
create index FK_THANHTOANDANGKY_MAKIEMTRA_KIEMTRAADSLVAMODEM_FK on THANHTOANDANGKY (
	MAKIEMTRA ASC
);

/*=================*/
/* Add Foreign Key */
/*=================*/

alter table BOPHANTHEODOIVATINHCUOC
add constraint FK_BOPHANTH_FK_BOPHAN_HOADONDA foreign key (MAHOADONDK) references HOADONDANGKY (MAHOADONDK)

alter table BOPHANTHEODOIVATINHCUOC
add constraint FK_BOPHANTH_RELATIONS_KHUYENMA foreign key (MAKHUYENMAI) references KHUYENMAI (MAKHUYENMAI)

alter table CUNGCAPGOICUOCVACTKHUYENMAI
add constraint FK_CUNGCAPG_FK_CUNGCA_KHUYENMA foreign key (MAKHUYENMAI) references KHUYENMAI (MAKHUYENMAI)

alter table HOADONDANGKY
add constraint FK_HOADONDA_FK_HOADON_HOPDONGD foreign key (CMND) references HOPDONGDANGKY (CMND)

alter table HOADONDANGKY
add constraint FK_HOADONDA_FK_HOADON_THANHTOA foreign key (MATHANHTOANDK) references THANHTOANDANGKY (MATHANHTOANDK)

alter table KIEMTRAADSLVAMODEM
add constraint FK_KIEMTRAA_FK_KIEMTR_HOPDONGD foreign key (CMND) references HOPDONGDANGKY (CMND)

alter table KIEMTRAADSLVAMODEM
add constraint FK_KIEMTRAA_FK_KIEMTR_CUNGCAPG foreign key (MACCGCKM) references CUNGCAPGOICUOCVACTKHUYENMAI (MACCGCKM)

alter table THANHTOANDANGKY
add constraint FK_THANHTOA_FK_THANHT_KIEMTRAA foreign key (MAKIEMTRA) references KIEMTRAADSLVAMODEM (MAKIEMTRA)

/*========*/
/* Insert */
/*========*/

SET DATEFORMAT DMY
INSERT INTO HOPDONGDANGKY (TENKHACHHANG,CMND,NGHENGHIEP,CHUCVU,DIACHI,DIACHICAIDATDICHVU,DIACHIGOIHOADONTT,GOICUOCSUDUNG) VALUES
('Tran Hong Anh','026053180','Quan Tri Nha Hang','Quan Ly','192 Nguyen Trai Q1','1Bis Nguyen Thi Minh Khai Q1','1Bis Nguyen Thi Minh Khai Q1','InternetFast1'),
('Tran Chi Thuan','098765432120','Bao Ve An Ninh','Nhan Vien','218 Thao Dien Q2','218 Thao Dien Q2','218 Thao Dien Q2','InternetFast1'),
('Nguyen Linh My','042345678982','Tai Chinh Ngan Hang','Kiem Toan','396 Ly Chinh Thang Q3','796 Cach Mang Thang Tam Q3','796 Cach Mang Thang Tam Q3','InternetFast4'),
('Dao Mong Huyen','019945670013','Kien Truc Su','Quan Ly','472 Hau Giang Q6','472 Hau Giang Q6','472 Hau Giang Q6','InternetFast3'),
('Truong Dinh Toan','017535678003','Thiet Ke Thoi Trang','Nhan Vien','523 Cao Lo Q8','821 Pham Hung Q8','821 Pham Hung Q8','InternetFast3'),
('Mai Huu Thien','025053187','Dien Vien Long Tieng','Nhan Vien','680 Han Hai Nguyen Q11','70 Ly Thuong Kiet Q11','70 Ly Thuong Kiet Q11','InternetFast5')

INSERT INTO KHUYENMAI (MAKHUYENMAI,DIEUKIENAPDUNG,THOIGIAN,MOTA) VALUES
('KM000001','Khach Hang Moi Dang Ky','1/3/2020','Goi cuoc 30Mbps (Keo dai 1 thang ke tu ngay 1/3/2020): Giam 5%'),
('KM000002','Khach Hang Moi Dang Ky','1/6/2020','Goi cuoc 30Mbps (Keo dai 3 thang ke tu ngay 1/6/2020): Giam 5%'),
('KM000003','Khach Hang Moi Dang Ky','1/7/2020','Goi cuoc 40Mbps (Keo dai 6 thang ke tu ngay 1/7/2020): Giam 7%'),
('KM000004','Khach Hang Moi Dang Ky','1/8/2020','Goi cuoc 50Mbps (Keo dai 9 thang ke tu ngay 1/8/2020): Giam 9%'),
('KM000005','Khach Hang Moi va Cu','1/5/2019','Goi cuoc 200Mbps (Keo dai 6 thang ke tu ngay 1/5/2019): Giam 15%'),
('KM000006','Khach Hang Moi va Cu','1/9/2020','Goi cuoc 200Mbps (Keo dai 12 thang ke tu ngay 1/9/2020): Giam 25%')

INSERT INTO CUNGCAPGOICUOCVACTKHUYENMAI (MACCGCKM,MAKHUYENMAI,TENGOICUOC,SOTIENGOICUOC) VALUES
('GC000001','KM000001','InternetFast1','179500'),	/*Qui uoc: */
('GC000002','KM000002','InternetFast2','179500'),	/*Gia cuoc 30Mbps:  189.000d/thang (chua bao gom khuyen mai)*/
('GC000003','KM000003','InternetFast3','203600'),	/*Gia cuoc 40Mbps:  219.000d/thang (chua bao gom khuyen mai)*/
('GC000004','KM000004','InternetFast4','235700'),	/*Gia cuoc 50Mbps:  259.000d/thang (chua bao gom khuyen mai)*/
('GC000005','KM000005','InternetFast5','475000'),	/*Gia cuoc 200Mbps: 559.000d/thang (chua bao gom khuyen mai)*/
('GC000006','KM000006','InternetFast6','419000')	/*<Da tham khao cong ty VNPT>*/

INSERT INTO KIEMTRAADSLVAMODEM (MAKIEMTRA,MACCGCKM,CMND,ADSL,MODEM) VALUES
													/*Qui uoc: 0-Khong; 1-Co*/
('KT000001','GC000001','026053180','0','0'),		/*Chua lap dat*/
('KT000002','GC000002','098765432120','1','1'),		/*Da lap dat*/
('KT000003','GC000003','042345678982','1','1'),		/*Da lap dat*/
('KT000004','GC000004','019945670013','1','1'),		/*Da lap dat*/
('KT000005','GC000005','017535678003','0','0'),		/*Chua lap dat*/
('KT000006','GC000006','025053187','1','1')			/*Da lap dat*/

INSERT INTO THANHTOANDANGKY (MATHANHTOANDK,MAKIEMTRA,SOTIENTHANHTOAN) VALUES
/*Phi hoa mang va lap dat la 100.000d danh cho nhung khach hang chua tung lap dat*/
('DK000001','KT000001',279500),	/*Chua lap dat: +100.000d*/
('DK000002','KT000002',179500),	/*Da lap dat*/
('DK000003','KT000003',235700),	/*Da lap dat*/
('DK000004','KT000004',203600),	/*Da lap dat*/
('DK000005','KT000005',303600),	/*Chua lap dat: +100.000d*/
('DK000006','KT000006',475000)	/*Da lap dat*/

INSERT INTO HOADONDANGKY(MAHOADONDK,MATHANHTOANDK,CMND,DUNGLUONGSUDUNG,DIACHICAIDATDICHVU,DIACHIGOIHOADONTT,CHIPHIDK,NGAYBD,MATKHAU,TENTRUYNHAPMANG,EMAIL) VALUES
/*Dung luong su dung (don vi la Mbps)*/
('HD000001','DK000001','026053180',30,'1Bis Nguyen Thi Minh Khai Q1','1Bis Nguyen Thi Minh Khai Q1',279500,'2/3/2020','ha123456','tranhonganh','tranhonganh@client.vn'),
('HD000002','DK000002','098765432120',30,'218 Thao Dien Q2','218 Thao Dien Q2',179500,'2/6/2020','ct123456','tranchithuan','tranchithuan@client.vn'),
('HD000003','DK000003','042345678982',40,'796 Cach Mang Thang Tam Q3','796 Cach Mang Thang Tam Q3',235700,'2/7/2020','lm123456','nguyenlinhmy','nguyenlinhmy@client.vn'),
('HD000004','DK000004','019945670013',50,'472 Hau Giang Q6','472 Hau Giang Q6',203600,'2/8/2020','mh123456','daomonghuyen','daomonghuyen@client.vn'),
('HD000005','DK000005','017535678003',200,'821 Pham Hung Q8','821 Pham Hung Q8',303600,'2/5/2019','dt123456','truongdinhtoan','truongdinhtoan@client.vn'),
('HD000006','DK000006','025053187',200,'70 Ly Thuong Kiet Q11','70 Ly Thuong Kiet Q11',475000,'2/9/2020','ht123456','maihuuthien','maihuuthien@client.vn')

INSERT INTO BOPHANTHEODOIVATINHCUOC (MABPTDVTC,MAKHUYENMAI,MAHOADONDK,TIENCUOCHANGTHANG) VALUES
('TC000001','KM000001','HD000001',179500),
('TC000002','KM000002','HD000002',179500),
('TC000003','KM000003','HD000003',203600),
('TC000004','KM000004','HD000004',235700),
('TC000005','KM000005','HD000005',475000),
('TC000006','KM000006','HD000006',419000)

/*========*/
/* Select */
/*========*/

/*===================================*/
/* Liet ke thong tin tat ca cac bang */
/*===================================*/

SELECT * FROM HOPDONGDANGKY
SELECT * FROM KHUYENMAI
SELECT * FROM CUNGCAPGOICUOCVACTKHUYENMAI
SELECT * FROM KIEMTRAADSLVAMODEM
SELECT * FROM THANHTOANDANGKY
SELECT * FROM HOADONDANGKY
SELECT * FROM BOPHANTHEODOIVATINHCUOC

/*====================================*/
/* Mot so Liet ke thong tin chi tiet  */
/*====================================*/

/*Vidu1: Liet ke khach hang dang ky goi cuoc toc do cao 200Mbps*/
SELECT TENKHACHHANG FROM HOPDONGDANGKY,HOADONDANGKY 
WHERE HOADONDANGKY.DUNGLUONGSUDUNG = 200 AND HOPDONGDANGKY.CMND = HOADONDANGKY.CMND
/*Vidu2: Liet ke ten khach hang va dia chi khach hang nao CO san ADSL va Modem*/
SELECT TENKHACHHANG,DIACHI FROM HOPDONGDANGKY,KIEMTRAADSLVAMODEM
WHERE KIEMTRAADSLVAMODEM.ADSL = '1' AND KIEMTRAADSLVAMODEM.MODEM = '1' AND HOPDONGDANGKY.CMND = KIEMTRAADSLVAMODEM.CMND
/*Vidu3: Liet ke ten khach hang va dia chi khach hang nao CHUA CO san ADSL va Modem*/
SELECT TENKHACHHANG,DIACHI FROM HOPDONGDANGKY,KIEMTRAADSLVAMODEM
WHERE KIEMTRAADSLVAMODEM.ADSL = '0' AND KIEMTRAADSLVAMODEM.MODEM = '0' AND HOPDONGDANGKY.CMND = KIEMTRAADSLVAMODEM.CMND
/*Vidu4: Liet ke nhung khach hang yeu cau Cai dat Dich vu Internet va Gui Hoa Don khac voi Dia chi dang song*/
SELECT TENKHACHHANG,DIACHI,DIACHICAIDATDICHVU,DIACHIGOIHOADONTT FROM HOPDONGDANGKY
WHERE DIACHI!=DIACHICAIDATDICHVU AND DIACHI!=DIACHIGOIHOADONTT
/*Vidu5: Liet ke nhung thong tin khuyen mai truoc nam 2020 va phai sau thang 4*/
SELECT DIEUKIENAPDUNG,THOIGIAN,MOTA FROM KHUYENMAI
WHERE MONTH(THOIGIAN) > 4 AND YEAR(THOIGIAN) < 2020


/*==========*/
/* Function */
/*==========*/
GO
CREATE FUNCTION FUNCT (@CHUCVU VARCHAR(50))
RETURNS TABLE
AS
	RETURN(SELECT * FROM HOPDONGDANGKY WHERE CHUCVU = @CHUCVU)

/*===============*/
/* Test Function */
/*===============*/
/*
	GO
	SELECT * FROM [dbo].[FUNCT]('Nhan Vien')
*/

/*===========*/
/* Procedure */
/*===========*/
GO
CREATE PROCEDURE PROCD (@TENKHACHHANG VARCHAR(50),@CMND VARCHAR(12),@NGHENGHIEP VARCHAR(50),@CHUCVU VARCHAR(50),
@DIACHI VARCHAR(100),@DIACHICAIDATDICHVU VARCHAR(100),@DIACHIGOIHOADONTT VARCHAR(100),@GOICUOCSUDUNG VARCHAR(50))
AS
BEGIN
	DECLARE @CheckCMNDKey INT
	SELECT @CheckCMNDKey = CMND FROM HOPDONGDANGKY WHERE CMND = @CMND
	IF (@CheckCMNDKey > 0)
		print N'Số CMND đã bị trùng! - Không thể thêm hợp đồng đăng ký này!'
	ELSE IF(LEN(@CMND)!=9 AND LEN(@CMND)!=12)
		print N'Số CMND không hợp lệ! - Không thể thêm hợp đồng đăng ký này!'
	ELSE
		INSERT INTO HOPDONGDANGKY VALUES (@TENKHACHHANG,@CMND,@NGHENGHIEP,@CHUCVU,@DIACHI,@DIACHICAIDATDICHVU,@DIACHIGOIHOADONTT,@GOICUOCSUDUNG)
END

/*================*/
/* Test Procedure */
/*================*/

/*	
	EXEC PROCD 
	'Phan Thi Yen','099651742','Quan Tri Du Lich','Quan Ly','12 Nguyen Bieu Q5','97 Han Hai Nguyen Q11','12 Nguyen Bieu Q5','InternetFast6'
*/

/*=========*/
/* Trigger */
/*=========*/
GO
CREATE TRIGGER TRIGG ON KHUYENMAI
FOR INSERT
AS
BEGIN
	DECLARE @COUNT INT
	SET @COUNT = (SELECT COUNT(*) FROM inserted)
	PRINT N'Đã có '+CONVERT(nvarchar(50),@COUNT)+N' hàng dữ liệu được thêm vào bảng KHUYEN MAI'
END

/*==============*/
/* Test Trigger */
/*==============*/

/*
	SET DATEFORMAT DMY
	INSERT INTO KHUYENMAI (MAKHUYENMAI,DIEUKIENAPDUNG,THOIGIAN,MOTA) VALUES
	('KM000007','Khach Hang Moi Dang Ky','1/12/2020','Goi cuoc 30Mbps (Keo dai 1 thang ke tu ngay 1/12/2020): Giam 5%'),
	('KM000008','Khach Hang Moi va Cu','1/1/2021','Goi cuoc 30Mbps (Keo dai 1 thang ke tu ngay 1/1/2021): Giam 5%'),
	('KM000009','Khach Hang Moi Dang Ky','1/2/2021','Goi cuoc 30Mbps (Keo dai 1 thang ke tu ngay 1/2/2021): Giam 5%')
*/

/*=====*/
/* END */
/*=====*/