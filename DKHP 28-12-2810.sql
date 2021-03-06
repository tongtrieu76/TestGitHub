USE [HeThongDangKyHocPhan]
GO
/****** Object:  StoredProcedure [dbo].[proc_gvien01]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----GIÁO VIÊN-------
---------------------
-- Lấy bảng chuyên đề đổ vào datagridview tất cả chuyên đề
create proc [dbo].[proc_gvien01]
as begin
	select * from CHUYENDE
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien02]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Lấy bảng chuyên đề có tình trạng đang mở đổ vào datagridview chuyên đề đang mở
create proc [dbo].[proc_gvien02]
as begin
Select * from CHUYENDE where TinhTrang = 1
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien03]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Lấy bảng chuyên đề có tình trạng đang mở do giao vien dạy đổ vào datagridview chuyên đề đang mở
create proc [dbo].[proc_gvien03] @magv nchar(10) 
as begin
Select * from CHUYENDEDUOCMO where GVPHUTRACH = @magv
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien04]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[proc_gvien04] @mand nchar(10)
as
begin
	Select cd.*  from KHANANG as kn, CHUYENDE as cd where kn.MAND = @mand and kn.MACD = cd.MACD group by cd.MACD, cd.TENCD, cd.TINHTRANG

end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien05]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Câu 8: •	Lấy thông tin điểm sinh viên, chuyên đề từ groupbox show lên datagridview 
create proc [dbo].[proc_gvien05] @mand nchar(10), @macd nchar(10)
as
begin
	select sv.HOTEN,cd.MACD, cd.TENCD ,dk.MALOP, dk.DIEM from SINHVIEN as sv, DANGKI as dk, CHUYENDEDUOCMO as cdmo, CHUYENDE as cd where dk.MAND = @mand and cdmo.MACD = @macd and dk.MALOP = cdmo.MALOP and cd.MACD = cdmo.MACD and sv.MAND = dk.MAND
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien06]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_gvien06] @nam nvarchar(50), @hki int, @macd nchar(10), @mand nchar(10)
as
begin
	select distinct cdmo.MACD,cd.TENCD, cdmo.NAMHOC, cdmo.HOCKY, cdmo.GVPHUTRACH as GiaoVienPhuTrach, cdmo.MODKHP as ThoiGianMoDangKy, cdmo.DONGDKHP as ThoiGianDongDangKy
  from CHUYENDEDUOCMO as cdmo, CHUYENDE as cd where cdmo.NAMHOC = @nam and cdmo.HOCKY = @hki and cdmo.MACD = @macd and cdmo.MACD = cd.MACD and cdmo.GVPHUTRACH = @mand
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien07]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Tìm Kiếm
create proc [dbo].[proc_gvien07] @item nchar(10), @item1 nvarchar(50)
as begin
	begin
		if exists(select * from CHUYENDE where MACD like @item)
		begin
			select * from CHUYENDE where MACD like @item
		end
		if exists(select * from CHUYENDE where TENCD like @item1)
		begin
			select * from CHUYENDE where TENCD like @item1
		end
		if (@item = 'dang mo' or @item = 'Đang Mở' or @item = '1')
		begin
			select * from CHUYENDE where TINHTRANG = 1
		end
		if (@item = 'dang dong' or @item = 'Đang Đóng' or @item = '0' )
		begin
			select * from CHUYENDE where TINHTRANG = 0
		end
	end

end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien08]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[proc_gvien08] @macd varchar(10), @mand varchar(10)
AS BEGIN
	select MALOP
	from CHUYENDEDUOCMO
	where MACD = @macd and GVPHUTRACH  = @mand
END

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien09]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien09] @malop varchar(10), @mand varchar(10)
as begin
	select d.MADEAD from DEADLINEBAITAP as d, CHUYENDEDUOCMO as cd where d.MALOP = @malop and d.MALOP = cd.MALOP and cd.GVPHUTRACH = @mand
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien10]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- •	Lấy năm học gần đây bỏ vào cbxNamHoc
create proc [dbo].[proc_gvien10]
as
begin
	select distinct NAMHOC from HOCKY
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien11]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--	Lấy thông tin những chuyên đề mà giáo viên có khả năng bỏ vào cbMaChuyenDe
create proc [dbo].[proc_gvien11]
as
begin
	select distinct MACD from CHUYENDEDUOCMO
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien12]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- •	Lấy Tên chuyên đề từ MaChuyenDe có sẵn bỏ vào cbxTenChuyenDe
create proc [dbo].[proc_gvien12]
as
begin
	select TENCD from CHUYENDE
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien13]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--•	Lấy Tên chuyên đề từ MaChuyenDe bỏ vào txtTenChuyenDe
create proc [dbo].[proc_gvien13]
	@macd char(10)
as
begin
	select TENCD from CHUYENDE where MACD = @macd
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien14]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Load thông tin ten người dùng vào groupbox(giáo vụ ko có mã ngành, nhưng có chức vụ) 
create proc [dbo].[proc_gvien14] @magv char(10)
as begin
	select TENGV
	from GIAOVIEN
	where MAND = @magv
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien15]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Load mail người dung vào txtMail
create procedure [dbo].[proc_gvien15] @magv char(10)
as begin
	select MAIL
	from GIAOVIEN
	where MAND = @magv
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien16]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--38: Load nganh người dung vào txtMail
create proc [dbo].[proc_gvien16] @magv char(10)
as begin
	select n.TENNGANH
	from GIAOVIEN as gv, NGANH as n
	where gv.MAND = @magv and n.MANGANH = gv.MANGANH
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien17]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--39: Load ngay công tác người dung vào txtMail
create proc [dbo].[proc_gvien17] @magv char(10)
as begin
	select NGAYBDCT
	from GIAOVIEN
	where MAND = @magv
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien18]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Câu 20: Lấy thông tin Ten Sinh Vien từ Ma Sinh Vien vừa nhập bỏ vào txtTenSinhVien 
create proc [dbo].[proc_gvien18] @masv char(10)
as begin
	select HOTEN
	from SinhVien
	where MAND = @masv
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien19]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien19] @macd char(10)

as
begin
	select SOSVTOIDA FROM CHUYENDEDUOCMO where MACD = @macd
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien20]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_gvien20] @macd char(10)
as
begin
	select SONTOIDA from CHUYENDEDUOCMO where MACD = @macd
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien21]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien21] @macd varchar(10), @mand varchar(10)
as
begin
	select COUNT(MALOP) from CHUYENDEDUOCMO where MACD = @macd and GVPHUTRACH = @mand
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien21_1]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_gvien21_1] @macd varchar(10)
as
begin
	select COUNT(MALOP) from CHUYENDEDUOCMO where MACD = @macd
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien22]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Lấy ID dead lớn nhất
CREATE proc [dbo].[proc_gvien22] @malop nchar(10)
as begin
	if not exists(select * from DEADLINEBAITAP where MALOP = @malop)
		select 0
	else
		Select MAX(madead) from DEADLINEBAITAP where MALOP = @malop
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien24]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Check Khả Năng
create proc [dbo].[proc_gvien24] @mand nchar(10), @ten nvarchar(50)
as begin
	declare @macd nchar(10)
	select @macd = MACD from CHUYENDE where TENCD like @ten
	if exists(select * from KHANANG where MACD = @macd and MAND =@mand)
		select 1
	else
		select 0
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien25]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thêm thông tin deadline vào bảng deadline
create proc [dbo].[proc_gvien25] @malop char(10),@madead int,@tendead nvarchar(50),@thoihan datetime
as begin
	insert into DEADLINEBAITAP (MALOP,MADEAD,TENDEADLINE, THOIHAN)
	values(@malop,@madead,@tendead,@thoihan)
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien26]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien26] @macd varchar(10),@malop nvarchar(10), @mand nvarchar(10)
as
begin
	
		declare  @NAMHOC nvarchar(50), @HOCKY  int, @SONTOIDA1LOP int, @SOSVDADK1CD int, @MODKHP datetime,@DONGDKHP datetime,  @TRANGTHAI nvarchar(50)
		select  @NAMHOC = NAMHOC,@HOCKY =HOCKY, @SONTOIDA1LOP  = SONTOIDA,@SOSVDADK1CD = SOSVTOIDA, @MODKHP =  MODKHP,@DONGDKHP =DONGDKHP, @TRANGTHAI = TRANGTHAI from CHUYENDEDUOCMO where MACD = @macd
		
		insert into CHUYENDEDUOCMO (MALOP, MACD, NAMHOC, HOCKY, SONTOIDA,SOSVTOIDA, MODKHP,DONGDKHP, GVPHUTRACH, TRANGTHAI) values (@malop, @macd, @NAMHOC , @HOCKY  , @SONTOIDA1LOP  ,@SOSVDADK1CD, @MODKHP ,@DONGDKHP, @mand, @TRANGTHAI)
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien27]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- xóa lớp khi ngườ dùng giảm số lượng lớp
create proc [dbo].[proc_gvien27] @malop nchar(10)
as
begin

	if exists(select * from DEADLINEBAITAP where MALOP = @malop)
		Delete from DEADLINEBAITAP where MALOP = @malop
	Delete from CHUYENDEDUOCMO where MALOP =@malop
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien28]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Cập nhật thông tin deadline vào bảng deadline
CREATE proc [dbo].[proc_gvien28] @madead int,@tendead nvarchar(50),@thoihan datetime, @malop nchar(250)
as begin
	update DEADLINEBAITAP set THOIHAN = @thoihan, TENDEADLINE = @tendead where MADEAD =@madead and MALOP = @malop
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien29]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien29]
@macd char(10), @slnhom int, @slsinhvien int, @mand varchar(10)
as begin
	update CHUYENDEDUOCMO set SONTOIDA = @slnhom where MACD = @macd and GVPHUTRACH = @mand
	update CHUYENDEDUOCMO set SOSVTOIDA = @slsinhvien where MACD = @macd and GVPHUTRACH = @mand
	update SOLUONGSV set SOSVTOIDA1CD = (select SUM(SOSVTOIDA) from CHUYENDEDUOCMO where MACD = @macd) where MACD = @macd
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien30]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--21:a.	Cập nhật thông tin mới vào thông tin người dùng 
--giáo vụ/giáo viên(chung 1 bảng trong database)
create proc [dbo].[proc_gvien30]
@mand nchar(10), @tengv nvarchar(50), @mail nvarchar(30), @ngaybd datetime
as begin
	update GIAOVIEN set TENGV = @tengv,MAIL = @mail,  NGAYBDCT =@ngaybd
	where MAND =@mand
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien31]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--kiểm tra mật khẩu cũ có khớp không

create proc [dbo].[proc_gvien31] @mand nchar(10),@pass nchar(15), @passcu nchar(15), @kq int out
as begin
	set @kq = 0
	if(@passcu = (select PASSWORD from TAIKHOAN where MAND = @mand))
	begin
		set @kq = 1
	end
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien32]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- 	Thêm thông tin mật khẩu mới vào bảng người dùng
create proc [dbo].[proc_gvien32] @mand nchar(10),@pass nchar(15), @passcu nchar(15)
as begin
	declare @checkkq int
	exec proc_gvien31 @mand, @pass, @passcu, @checkkq out
	if(@checkkq = 1)
	begin
		update TAIKHOAN set PASSWORD = @pass
		where MAND = @mand
	end
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien33]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_gvien33]
@ten nvarchar(50), @magv nvarchar(10)
as begin
	declare @macd nvarchar(10)
	select @macd = MACD from CHUYENDE where TENCD = @ten
	insert into KHANANG (MAND, MACD)
	values(@magv, @macd)
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvien34]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--lấy tên dead theo mã dead
CREATE proc [dbo].[proc_gvien34] @madead int, @malop nchar(250)
as begin
	select TENDEADLINE from DEADLINEBAITAP where MADEAD = @madead and MALOP = @malop
end 



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien35]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--lấy thoi han dead theo mã dead
CREATE proc [dbo].[proc_gvien35] @madead int, @malop nvarchar(250)
as begin
	if not exists (select THOIHAN from DEADLINEBAITAP where MADEAD = @madead and MALOP = @malop)
		select cast('12/1/2018' as datetime)
	select THOIHAN from DEADLINEBAITAP where MADEAD = @madead and MALOP = @malop
end 



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien36]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--xóa khả năng với chuyên đề
create proc [dbo].[proc_gvien36] @tencd nvarchar(50), @magv nchar(10)
as begin
	declare @macd nchar(10)
	select @macd = MACD from CHUYENDE where TENCD = @tencd
	delete from KHANANG where MAND = @magv and MACD = @macd
end 



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien37]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Hiển thị điểm các sinh viên thuộc chuyên đề
create proc [dbo].[proc_gvien37]  @macd nchar(10)
as
begin
	select sv.HOTEN,cd.MACD, cd.TENCD ,dk.MALOP, dk.DIEM 
	from SINHVIEN as sv, DANGKI as dk, CHUYENDEDUOCMO as cdmo, CHUYENDE as cd 
	where cdmo.MACD = @macd and dk.MALOP = cdmo.MALOP and cd.MACD = cdmo.MACD and sv.MAND = dk.MAND
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvien38]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_gvien38]  @mand varchar(10), @ten nvarchar(50)
as
begin
	if exists(select * from CHUYENDEDUOCMO as cdmo, CHUYENDE as cd where cdmo.MACD = cd.MACD and cd.TENCD like @ten and cdmo.GVPHUTRACH = @mand)
		select 1
	else
		select 0
end

GO
/****** Object:  StoredProcedure [dbo].[proc_gvu01]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-------GIÁO VỤ---------
-----------------------
-- Lấy danh sách ngành.
create procedure [dbo].[proc_gvu01]
as begin
	select TENNGANH
	from NGANH
end



GO
/****** Object:  StoredProcedure [dbo].[proc_gvu02]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Lấy học kì gần đây bỏ vào cbxhocki
create procedure [dbo].[proc_gvu02]
as
begin
	select distinct HOCKY from HOCKY
end



GO
/****** Object:  Table [dbo].[BAOGOM]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BAOGOM](
	[MANGANH] [varchar](250) NOT NULL,
	[MACD] [varchar](250) NOT NULL,
 CONSTRAINT [PK_BAOGOM] PRIMARY KEY CLUSTERED 
(
	[MANGANH] ASC,
	[MACD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHUYENDE]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHUYENDE](
	[MACD] [varchar](250) NOT NULL,
	[TENCD] [nvarchar](250) NULL,
	[TINHTRANG] [int] NULL,
 CONSTRAINT [PK_CHUYENDE] PRIMARY KEY CLUSTERED 
(
	[MACD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CHUYENDEDUOCMO]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHUYENDEDUOCMO](
	[MALOP] [nvarchar](250) NOT NULL,
	[MACD] [varchar](250) NULL,
	[NAMHOC] [nvarchar](30) NOT NULL,
	[HOCKY] [int] NOT NULL,
	[SONTOIDA] [int] NULL,
	[SOSVTOIDA] [int] NULL,
	[MODKHP] [datetime] NULL,
	[DONGDKHP] [datetime] NULL,
	[GVPHUTRACH] [varchar](250) NULL,
	[TRANGTHAI] [nvarchar](50) NULL,
 CONSTRAINT [PK_CHUYENDEDUOCMO] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DANGKI]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DANGKI](
	[MAND] [varchar](100) NOT NULL,
	[MALOP] [nvarchar](250) NOT NULL,
	[MANHOM] [varchar](250) NOT NULL,
	[DIEM] [float] NULL,
 CONSTRAINT [PK_DANGKI] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC,
	[MAND] ASC,
	[MANHOM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEADLINEBAITAP]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEADLINEBAITAP](
	[MALOP] [nvarchar](250) NOT NULL,
	[MADEAD] [int] NOT NULL,
	[TENDEADLINE] [nvarchar](250) NULL,
	[THOIHAN] [datetime] NULL,
 CONSTRAINT [PK_DEADLINEBAITAP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC,
	[MADEAD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAND] [varchar](100) NOT NULL,
	[MANGANH] [varchar](250) NOT NULL,
	[TENGV] [nvarchar](250) NULL,
	[CHUCVU] [nvarchar](250) NULL,
	[MAIL] [varchar](250) NULL,
	[NGAYBDCT] [datetime] NULL,
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HOCKY]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOCKY](
	[NAMHOC] [nvarchar](30) NOT NULL,
	[HOCKY] [int] NOT NULL,
 CONSTRAINT [PK_HOCKY] PRIMARY KEY CLUSTERED 
(
	[NAMHOC] ASC,
	[HOCKY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KHANANG]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KHANANG](
	[MAND] [varchar](100) NOT NULL,
	[MACD] [varchar](250) NOT NULL,
 CONSTRAINT [PK_KHANANG] PRIMARY KEY CLUSTERED 
(
	[MAND] ASC,
	[MACD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NGANH]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NGANH](
	[MANGANH] [varchar](250) NOT NULL,
	[TENNGANH] [nvarchar](250) NULL,
	[TONGSV] [int] NULL,
	[SOLUONGCDHT] [int] NULL,
 CONSTRAINT [PK_NGANH] PRIMARY KEY CLUSTERED 
(
	[MANGANH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NGUOIDUNG]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NGUOIDUNG](
	[MAND] [varchar](100) NOT NULL,
 CONSTRAINT [PK_NGUOIDUNG] PRIMARY KEY CLUSTERED 
(
	[MAND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHOM]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NHOM](
	[MALOP] [nvarchar](250) NOT NULL,
	[MANHOM] [varchar](250) NOT NULL,
	[SOSVDADKNHOM] [int] NULL,
	[SOSVTOIDANHOM] [int] NULL,
 CONSTRAINT [PK_NHOM] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC,
	[MANHOM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MAND] [varchar](100) NOT NULL,
	[MANGANH] [varchar](250) NOT NULL,
	[HOTEN] [nvarchar](250) NULL,
	[PHAI] [nvarchar](10) NULL,
	[NGAYSINH] [datetime] NULL,
	[DIACHI] [nvarchar](500) NULL,
	[MAIL] [varchar](250) NULL,
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MAND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SOLUONGSV]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SOLUONGSV](
	[MACD] [varchar](250) NOT NULL,
	[NAMHOC] [nvarchar](30) NOT NULL,
	[HOCKY] [int] NOT NULL,
	[SOSVTOIDA1CD] [int] NULL,
 CONSTRAINT [PK_SOLUONGSV] PRIMARY KEY CLUSTERED 
(
	[MACD] ASC,
	[NAMHOC] ASC,
	[HOCKY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAIKHOAN]    Script Date: 12/28/2018 7:30:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAIKHOAN](
	[MAND] [varchar](100) NOT NULL,
	[PASSWORD] [varchar](500) NULL,
	[LOAITK] [varchar](10) NULL,
	[TINHTRANGTK] [varchar](10) NULL,
 CONSTRAINT [PK_TAIKHOAN] PRIMARY KEY CLUSTERED 
(
	[MAND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'CNMLN')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'CSDL')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'DLCM')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'KTLT')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'NMLT')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'PLDC')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG01', N'TTHCM')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG02', N'NMCNSH')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG02', N'SHPTDC')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG03', N'CNVMT')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG04', N'DCCT')
INSERT [dbo].[BAOGOM] ([MANGANH], [MACD]) VALUES (N'NG05', N'HVC')
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'CNMLN', N'Chủ Nghĩa Mác - Lê Nin', 1)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'CNVMT', N'Con Người Và Môi Trường', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'CSDL', N'Cơ Sở Dữ Liệu', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'DCCT', N'Địa Chất Cấu Tạo', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'DLCM', N'Đường Lối Cách Mạng Của Đảng Cộng Sản Việt Nam', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'HVC', N'Hóa Vô Cơ', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'KTLT', N'Kỹ Thuật Lập Trình', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'NMCNSH', N'Nhập Môn Công Nghệ Sinh Học', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'NMLT', N'Nhập Môn Lập Trình', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'PLDC', N'Pháp Luật Đại Cương', 1)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'SHPTDC', N'Sinh Học Phân Tử Đại Cương', 0)
INSERT [dbo].[CHUYENDE] ([MACD], [TENCD], [TINHTRANG]) VALUES (N'TTHCM', N'Tư Tường Hồ Chí Minh', 0)
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17CNMLN1', N'CNMLN', N'2017 - 2018', 1, 3, 100, CAST(0x0000A95600000000 AS DateTime), CAST(0x0000A97500000000 AS DateTime), N'ND22', N'mở')
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17CNMLN2', N'CNMLN', N'2017 - 2018', 1, 3, 101, CAST(0x0000A95600000000 AS DateTime), CAST(0x0000A97500000000 AS DateTime), N'ND07', N'mở')
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17CNMLN3', N'CNMLN', N'2017 - 2018', 1, 3, 100, CAST(0x0000A95600000000 AS DateTime), CAST(0x0000A97500000000 AS DateTime), N'ND22', N'mở')
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17PLDC1', N'PLDC', N'2017 - 2018', 2, 5, 100, CAST(0x0000A98B00000000 AS DateTime), CAST(0x0000A9BC00000000 AS DateTime), N'ND06', N'mở')
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17PLDC2', N'PLDC', N'2017 - 2018', 2, 5, 100, CAST(0x0000A98B00000000 AS DateTime), CAST(0x0000A9BC00000000 AS DateTime), N'ND06', N'mở')
INSERT [dbo].[CHUYENDEDUOCMO] ([MALOP], [MACD], [NAMHOC], [HOCKY], [SONTOIDA], [SOSVTOIDA], [MODKHP], [DONGDKHP], [GVPHUTRACH], [TRANGTHAI]) VALUES (N'17PLDC3', N'PLDC', N'2017 - 2018', 2, 5, 100, CAST(0x0000A98B00000000 AS DateTime), CAST(0x0000A9BC00000000 AS DateTime), N'ND06', N'mở')
INSERT [dbo].[DANGKI] ([MAND], [MALOP], [MANHOM], [DIEM]) VALUES (N'ND10', N'17PLDC1', N'17PLDC1_1 ', 10)
INSERT [dbo].[DANGKI] ([MAND], [MALOP], [MANHOM], [DIEM]) VALUES (N'ND11', N'17PLDC1', N'17PLDC1_2 ', 9)
INSERT [dbo].[DANGKI] ([MAND], [MALOP], [MANHOM], [DIEM]) VALUES (N'ND12', N'17PLDC1', N'17PLDC1_1 ', 8)
INSERT [dbo].[DEADLINEBAITAP] ([MALOP], [MADEAD], [TENDEADLINE], [THOIHAN]) VALUES (N'17CNMLN1  ', 1, N'bài 3', CAST(0x0000A9C400000000 AS DateTime))
INSERT [dbo].[DEADLINEBAITAP] ([MALOP], [MADEAD], [TENDEADLINE], [THOIHAN]) VALUES (N'17CNMLN2  ', 1, N'bai 1 lớp 2', CAST(0x0000A9B000000000 AS DateTime))
INSERT [dbo].[DEADLINEBAITAP] ([MALOP], [MADEAD], [TENDEADLINE], [THOIHAN]) VALUES (N'17CNMLN3  ', 1, N'bài 1 lớp 3', CAST(0x0000A9CA00000000 AS DateTime))
INSERT [dbo].[DEADLINEBAITAP] ([MALOP], [MADEAD], [TENDEADLINE], [THOIHAN]) VALUES (N'17PLDC1', 1, N'Bài 1', CAST(0x0000A97500000000 AS DateTime))
INSERT [dbo].[DEADLINEBAITAP] ([MALOP], [MADEAD], [TENDEADLINE], [THOIHAN]) VALUES (N'17PLDC1', 2, N'Bài 2', CAST(0x0000A9C800000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND01', N'NG00', N'Nguyễn Thị Ánh', N'Trợ Lý Sinh Viên', N'phongcongtacsinhvien@gmail.com', CAST(0x0000A4BF00000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND02', N'NG00', N'Nguyễn Gia Huy', N'Giáo Vụ', N'phongctsv@hcmus.edu.vn', CAST(0x0000A41300000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND03', N'NG00', N'Ngô Anh Thư', N'Giáo Vụ', N'giaovu@hcmus.edu.vn', CAST(0x0000A71400000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND04', N'NG00', N'Lý Nhĩ Tình', N'Giáo Vụ', N'giaovu@gmail.com', CAST(0x0000A50E00000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND05', N'NG00', N'Ngụy Anh Lạc', N'Giáo Vụ', N'giaovumail2@gmail.com', CAST(0x0000A8D700000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND06', N'NG01', N'Lâm Y Vi', N'Giáo Viên', N'lyv@fit.hcmus.edu.vn', CAST(0x0000A5A000000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND07', N'NG02', N'Nguyễn Minh Ngọc', N'Giáo Viên', N'nmn@hcmus.edu..vn', CAST(0x0000A95400000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND08', N'NG03', N'Ngô Cẩn Ngôn', N'Giáo Viên', N'ncn@hcmus.edu.vn', CAST(0x0000A63C00000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND09', N'NG04', N'Trịnh Nguyên Sướng', N'Giáo Viên', N'tns@hcmus.edu.vn', CAST(0x0000A5E000000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND10', N'NG05', N'Dương Vân Ly', N'Giáo Viên', N'dvl@hcmus.edu.vn', CAST(0x0000A7C900000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND22', N'NG03', N'Phạm Yến Vy', N'Giáo Viên', N'1660754@student.hcmus.edu.vn', CAST(0x0000A9C400000000 AS DateTime))
INSERT [dbo].[GIAOVIEN] ([MAND], [MANGANH], [TENGV], [CHUCVU], [MAIL], [NGAYBDCT]) VALUES (N'ND99', N'NG00', N'test99', N'Giáo Vụ', N'1660646@student.hcmus.edu.vn', CAST(0x0000A9B600000000 AS DateTime))
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2016 - 2017', 1)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2016 - 2017 ', 2)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2017 - 2018', 1)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2017 - 2018', 2)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2018 - 2019 ', 1)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2018 - 2019', 2)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2019 - 2020', 1)
INSERT [dbo].[HOCKY] ([NAMHOC], [HOCKY]) VALUES (N'2019 - 2020 ', 2)
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'CNMLN')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'CNVMT')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'CSDL')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'DCCT')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'DLCM')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'HVC')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND06', N'PLDC')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND07', N'NMCNSH')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND07', N'PLDC')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND08', N'HVC')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND08', N'NMCNSH')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND08', N'SHPTDC')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND09', N'DCCT')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND10', N'CNVMT')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND10', N'DCCT')
INSERT [dbo].[KHANANG] ([MAND], [MACD]) VALUES (N'ND22', N'CNMLN')
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG00', N'Văn Phòng', 0, 0)
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG01', N'Công Nghệ Thông Tin', 250, 5)
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG02', N'Sinh Học', 250, 4)
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG03', N'Khoa Học Môi Trường', 240, 4)
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG04', N'Địa Chất Học', 200, 4)
INSERT [dbo].[NGANH] ([MANGANH], [TENNGANH], [TONGSV], [SOLUONGCDHT]) VALUES (N'NG05', N'Hóa Học', 230, 5)
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND01')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND02')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND03')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND04')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND05')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND06')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND07')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND08')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND09')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND10')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND11')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND12')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND13')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND14')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND15')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND22')
INSERT [dbo].[NGUOIDUNG] ([MAND]) VALUES (N'ND99')
INSERT [dbo].[NHOM] ([MALOP], [MANHOM], [SOSVDADKNHOM], [SOSVTOIDANHOM]) VALUES (N'17CNMLN1', N'17CNMLN1_1', 12, 20)
INSERT [dbo].[NHOM] ([MALOP], [MANHOM], [SOSVDADKNHOM], [SOSVTOIDANHOM]) VALUES (N'17CNMLN1', N'17CNMLN1_2', 8, 20)
INSERT [dbo].[NHOM] ([MALOP], [MANHOM], [SOSVDADKNHOM], [SOSVTOIDANHOM]) VALUES (N'17PLDC1', N'17PLDC1_1', 10, 20)
INSERT [dbo].[NHOM] ([MALOP], [MANHOM], [SOSVDADKNHOM], [SOSVTOIDANHOM]) VALUES (N'17PLDC1', N'17PLDC1_2', 5, 20)
INSERT [dbo].[NHOM] ([MALOP], [MANHOM], [SOSVDADKNHOM], [SOSVTOIDANHOM]) VALUES (N'17PLDC1', N'17PLDC1_3', 5, 20)
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND10', N'NG01', N'Phạm Yến Vy', N'N?', CAST(0x00008D3800000000 AS DateTime), N'Cần Giờ', N'phamyenvy1998@gmail.com       ')
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND11', N'NG01', N'Nguyễn Tống Triều', N'Nam', CAST(0x00008D1900000000 AS DateTime), N'Quãng Ngãi', N'1660646@student.hcmus.edu.vn  ')
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND12', N'NG01', N'Hà Minh Bảo Toàn', N'Nam', CAST(0x00008C2900000000 AS DateTime), N'Dầu Tiếng', N'1660626@student.hcmus.edu.vn  ')
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND13', N'NG02', N'Lý Thị Thu Thảo', N'N?', CAST(0x00008D3F00000000 AS DateTime), N'Bình Tân', N'lythithuthao@gmail.com        ')
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND14', N'NG03', N'Ngô Thị Kim Liên', N'N?', CAST(0x00008D6000000000 AS DateTime), N'Quận 1', N'ngothikimlien@yahoo.com       ')
INSERT [dbo].[SINHVIEN] ([MAND], [MANGANH], [HOTEN], [PHAI], [NGAYSINH], [DIACHI], [MAIL]) VALUES (N'ND15', N'NG05', N'Trần Đặng Lộc', N'Nam', CAST(0x00008C3500000000 AS DateTime), N'Bình Thạnh', N'trandangloc                   ')
INSERT [dbo].[SOLUONGSV] ([MACD], [NAMHOC], [HOCKY], [SOSVTOIDA1CD]) VALUES (N'CNMLN', N'2017 - 2018', 1, 301)
INSERT [dbo].[SOLUONGSV] ([MACD], [NAMHOC], [HOCKY], [SOSVTOIDA1CD]) VALUES (N'PLDC', N'2017 - 2018', 2, 1)
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND01', N'2251022057731868917119086224872421513662', N'0', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND02', N'2251022057731868917119086224872421513662', N'0', N'Dong')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND03', N'2251022057731868917119086224872421513662', N'0', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND04', N'2251022057731868917119086224872421513662', N'0', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND05', N'2251022057731868917119086224872421513662', N'0', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND06', N'2251022057731868917119086224872421513662', N'1', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND07', N'2251022057731868917119086224872421513662', N'1', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND08', N'2251022057731868917119086224872421513662', N'1', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND09', N'2251022057731868917119086224872421513662', N'1', N'Dong')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND10', N'2251022057731868917119086224872421513662', N'1', N'Dong')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND22', N'1592009581592789126195621231402421423866', N'1', N'Mo')
INSERT [dbo].[TAIKHOAN] ([MAND], [PASSWORD], [LOAITK], [TINHTRANGTK]) VALUES (N'ND99', N'2081517201171191312302072317811118422641143', N'0', N'Mo')
ALTER TABLE [dbo].[BAOGOM]  WITH CHECK ADD  CONSTRAINT [FK_BAOGOM_BAOGOM_NGANH] FOREIGN KEY([MANGANH])
REFERENCES [dbo].[NGANH] ([MANGANH])
GO
ALTER TABLE [dbo].[BAOGOM] CHECK CONSTRAINT [FK_BAOGOM_BAOGOM_NGANH]
GO
ALTER TABLE [dbo].[BAOGOM]  WITH CHECK ADD  CONSTRAINT [FK_BAOGOM_BAOGOM2_CHUYENDE] FOREIGN KEY([MACD])
REFERENCES [dbo].[CHUYENDE] ([MACD])
GO
ALTER TABLE [dbo].[BAOGOM] CHECK CONSTRAINT [FK_BAOGOM_BAOGOM2_CHUYENDE]
GO
ALTER TABLE [dbo].[CHUYENDEDUOCMO]  WITH CHECK ADD  CONSTRAINT [FK_CHUYENDE_MORA_CHUYENDE] FOREIGN KEY([MACD])
REFERENCES [dbo].[CHUYENDE] ([MACD])
GO
ALTER TABLE [dbo].[CHUYENDEDUOCMO] CHECK CONSTRAINT [FK_CHUYENDE_MORA_CHUYENDE]
GO
ALTER TABLE [dbo].[CHUYENDEDUOCMO]  WITH CHECK ADD  CONSTRAINT [FK_CHUYENDE_MOVAO_HOCKY] FOREIGN KEY([NAMHOC], [HOCKY])
REFERENCES [dbo].[HOCKY] ([NAMHOC], [HOCKY])
GO
ALTER TABLE [dbo].[CHUYENDEDUOCMO] CHECK CONSTRAINT [FK_CHUYENDE_MOVAO_HOCKY]
GO
ALTER TABLE [dbo].[DANGKI]  WITH CHECK ADD  CONSTRAINT [FK_DANGKI_DANGKI_SINHVIEN] FOREIGN KEY([MAND])
REFERENCES [dbo].[SINHVIEN] ([MAND])
GO
ALTER TABLE [dbo].[DANGKI] CHECK CONSTRAINT [FK_DANGKI_DANGKI_SINHVIEN]
GO
ALTER TABLE [dbo].[DANGKI]  WITH CHECK ADD  CONSTRAINT [FK_DANGKI_DANGKI2_NHOM] FOREIGN KEY([MALOP], [MANHOM])
REFERENCES [dbo].[NHOM] ([MALOP], [MANHOM])
GO
ALTER TABLE [dbo].[DANGKI] CHECK CONSTRAINT [FK_DANGKI_DANGKI2_NHOM]
GO
ALTER TABLE [dbo].[DEADLINEBAITAP]  WITH CHECK ADD  CONSTRAINT [FK_DEADLINE_CO_BAI_TA_CHUYENDE] FOREIGN KEY([MALOP])
REFERENCES [dbo].[CHUYENDEDUOCMO] ([MALOP])
GO
ALTER TABLE [dbo].[DEADLINEBAITAP] CHECK CONSTRAINT [FK_DEADLINE_CO_BAI_TA_CHUYENDE]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_THUOC2_NGUOIDUN] FOREIGN KEY([MAND])
REFERENCES [dbo].[NGUOIDUNG] ([MAND])
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_THUOC2_NGUOIDUN]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_TRUCTHUOC_NGANH] FOREIGN KEY([MANGANH])
REFERENCES [dbo].[NGANH] ([MANGANH])
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_TRUCTHUOC_NGANH]
GO
ALTER TABLE [dbo].[KHANANG]  WITH CHECK ADD  CONSTRAINT [FK_KHANANG_KHANANG_GIAOVIEN] FOREIGN KEY([MAND])
REFERENCES [dbo].[GIAOVIEN] ([MAND])
GO
ALTER TABLE [dbo].[KHANANG] CHECK CONSTRAINT [FK_KHANANG_KHANANG_GIAOVIEN]
GO
ALTER TABLE [dbo].[KHANANG]  WITH CHECK ADD  CONSTRAINT [FK_KHANANG_KHANANG2_CHUYENDE] FOREIGN KEY([MACD])
REFERENCES [dbo].[CHUYENDE] ([MACD])
GO
ALTER TABLE [dbo].[KHANANG] CHECK CONSTRAINT [FK_KHANANG_KHANANG2_CHUYENDE]
GO
ALTER TABLE [dbo].[NHOM]  WITH CHECK ADD  CONSTRAINT [FK_NHOM_CO_NHOM_CHUYENDE] FOREIGN KEY([MALOP])
REFERENCES [dbo].[CHUYENDEDUOCMO] ([MALOP])
GO
ALTER TABLE [dbo].[NHOM] CHECK CONSTRAINT [FK_NHOM_CO_NHOM_CHUYENDE]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_THUOC_NGUOIDUN] FOREIGN KEY([MAND])
REFERENCES [dbo].[NGUOIDUNG] ([MAND])
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_THUOC_NGUOIDUN]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_THUOCNGAN_NGANH] FOREIGN KEY([MANGANH])
REFERENCES [dbo].[NGANH] ([MANGANH])
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_THUOCNGAN_NGANH]
GO
ALTER TABLE [dbo].[SOLUONGSV]  WITH CHECK ADD  CONSTRAINT [FK_SOLUONGS_CO_CHUYENDE] FOREIGN KEY([MACD])
REFERENCES [dbo].[CHUYENDE] ([MACD])
GO
ALTER TABLE [dbo].[SOLUONGSV] CHECK CONSTRAINT [FK_SOLUONGS_CO_CHUYENDE]
GO
ALTER TABLE [dbo].[SOLUONGSV]  WITH CHECK ADD  CONSTRAINT [FK_SOLUONGS_TRONG_HOCKY] FOREIGN KEY([NAMHOC], [HOCKY])
REFERENCES [dbo].[HOCKY] ([NAMHOC], [HOCKY])
GO
ALTER TABLE [dbo].[SOLUONGSV] CHECK CONSTRAINT [FK_SOLUONGS_TRONG_HOCKY]
GO
ALTER TABLE [dbo].[TAIKHOAN]  WITH CHECK ADD  CONSTRAINT [FK_TAIKHOAN_CO_TAI_KH_NGUOIDUN] FOREIGN KEY([MAND])
REFERENCES [dbo].[NGUOIDUNG] ([MAND])
GO
ALTER TABLE [dbo].[TAIKHOAN] CHECK CONSTRAINT [FK_TAIKHOAN_CO_TAI_KH_NGUOIDUN]
GO
