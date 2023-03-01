CREATE DATABASE QuanLyQuanTraSua
GO

USE QuanLyQuanTraSua
GO

-- Food
-- Table
-- Category
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id	INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa đặt tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống' -- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'NiMiDo',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 -- 1: admin || 0: nhân viên
)
GO

CREATE TABLE Category
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.Category(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán || 0: chưa thanh toán

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
		(
			UserName ,
			DisplayName ,
			PassWord ,
			Type 
		)

VALUES	(
			N'K9' , -- UserName - nvarchar(100)
			N'RongK9' , -- DisplayName - nvarchar(100)
			N'1' , -- PassWord - nvarchar(100)
			1 -- Type - int
		)

INSERT INTO dbo.Account
		(
			UserName ,
			DisplayName ,
			PassWord ,
			Type 
		)

VALUES	(
			N'staff' , -- UserName - nvarchar(100)
			N'staff' , -- DisplayName - nvarchar(100)
			N'1' , -- PassWord - nvarchar(100)
			0 -- Type - int
		)
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'K9' -- nvarchar(100)

GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

--thêm bàn
DECLARE @i INT = 0

WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood (name) VALUES ( N'Bàn ' + CAST(@i AS nvarchar(100)))
	SET @i = @i +1
END
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET STATUS = N'Có người' WHERE id = 9

EXEC dbo.USP_GetTableList
GO

--thêm category
INSERT dbo.Category
		( name )
VALUES ( N'Trà sữa' ) -- name - nvarchar(100) 

INSERT dbo.Category
		( name )
VALUES ( N'Nước' ) -- name - nvarchar(100) 

INSERT dbo.Category
		( name )
VALUES ( N'Đồ ăn' ) -- name - nvarchar(100) 

-- thêm món ăn
INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Trân châu đường đen', -- name - nvarchar(100)
		1, -- idCategory - int
		25000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Trà sữa Thái', -- name - nvarchar(100)
		1, -- idCategory - int
		15000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Socola bạc hà', -- name - nvarchar(100)
		1, -- idCategory - int
		12000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Coca Cola', -- name - nvarchar(100)
		2, -- idCategory - int
		10000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Trà xanh C2', -- name - nvarchar(100)
		2, -- idCategory - int
		10000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Mirinda', -- name - nvarchar(100)
		2, -- idCategory - int
		10000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Bim Bim', -- name - nvarchar(100)
		3, -- idCategory - int
		5000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Gói quẩy ngọt', -- name - nvarchar(100)
		3, -- idCategory - int
		2000)

INSERT dbo.Food
		( name, idCategory, price )
VALUES (N'Nem chua rán', -- name - nvarchar(100)
		3, -- idCategory - int
		2000)

-- thêm bill
INSERT dbo.Bill
		( 
			DateCheckIn,
			DateCheckOut,
			idTable,
			status
		)
VALUES	( 
			GETDATE(), --DateCheckIn - date
			NULL , -- DateCheckOut - date
			1, -- idTable - int
			0 -- status - int
		)

INSERT dbo.Bill
		( 
			DateCheckIn,
			DateCheckOut,
			idTable,
			status
		)
VALUES	( 
			GETDATE(), --DateCheckIn - date
			NULL , -- DateCheckOut - date
			2, -- idTable - int
			0 -- status - int
		)

INSERT dbo.Bill
		( 
			DateCheckIn,
			DateCheckOut,
			idTable,
			status
		)
VALUES	( 
			GETDATE(), --DateCheckIn - date
			GETDATE(), -- DateCheckOut - date
			2, -- idTable - int
			1 -- status - int
		)

-- thêm Bill Info
INSERT dbo.BillInfo
		(idBill, idFood, count)
VALUES	(	1, -- idBill - int
			3, -- idFood - int
			2  -- count - int
		)

INSERT dbo.BillInfo
		(idBill, idFood, count)
VALUES	(	2, -- idBill - int
			2, -- idFood - int
			3  -- count - int
		)

INSERT dbo.BillInfo
		(idBill, idFood, count)
VALUES	(	2, -- idBill - int
			1, -- idFood - int
			3  -- count - int
		)

INSERT dbo.BillInfo
		(idBill, idFood, count)
VALUES	(	3, -- idBill - int
			2, -- idFood - int
			2  -- count - int
		)

INSERT dbo.BillInfo
		(idBill, idFood, count)
VALUES	(	3, -- idBill - int
			1, -- idFood - int
			3  -- count - int
		)
GO

CREATE PROC USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT dbo.Bill
			( 
				DateCheckIn,
				DateCheckOut,
				idTable,
				status,
				discount
			)
	VALUES	( 
				GETDATE(), --DateCheckIn - date
				NULL , -- DateCheckOut - date
				@idTable, -- idTable - int
				0, -- status - int
				0
			)
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN
		
		DECLARE @isExitBillInfo INT
		DECLARE @foodCount INT = 1

		SELECT @isExitBillInfo = id, @foodCount = b.count FROM dbo.BillInfo AS b WHERE idBill = @idBill AND idFood = @idFood

		IF (@isExitBillInfo > 0)
		BEGIN
			DECLARE @newCount INT = @foodCount + @Count
			IF (@newCount > 0)
				UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idFood = @idFood 
			ELSE 
				DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
		END

		ELSE 
		BEGIN
				INSERT dbo.BillInfo
						( idBill, idFood, count )
				VALUES	(	@idBill, -- idBill - int
						@idFood, -- idFood - int
						@count  -- count - int
						)
		END

END
GO

DELETE dbo.BillInfo

DELETE dbo.Bill
GO

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = idBill FROM inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0

	DECLARE @count INT
	SELECT @count = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idBill

	IF (@count > 0)
	BEGIN

		PRINT @idTable
		PRINT @idBill
		PRINT @count

		UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable	
	END
	ELSE
	BEGIN

		PRINT @idTable
		PRINT @idBill
		PRINT @count

		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
	END
END
GO

CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = id FROM inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill

	DECLARE @count int = 0

	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0

	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

ALTER TABLE dbo.Bill
ADD discount INT

UPDATE dbo.Bill SET discount = 0;
GO

CREATE PROC USP_SwitchTable
@idTable1 INT, @idTable2 INT
AS 
BEGIN
	
	DECLARE @idFirstBill INT
	DECLARE @idSecondBill INT

	DECLARE @isFirstTableEmpty INT = 1
	DECLARE @isSecondTableEmpty INT = 1

	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '------------'

	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
				( 
				DateCheckIn,
				DateCheckOut,
				idTable,
				status
				)
		VALUES	( 
				GETDATE(), --DateCheckIn - date
				NULL , -- DateCheckOut - date
				@idTable1, -- idTable - int
				0 -- status - int
				)

		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END

	SELECT @isFirstTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '------------'

	IF (@idSecondBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
				( 
				DateCheckIn,
				DateCheckOut,
				idTable,
				status
				)
		VALUES	( 
				GETDATE(), --DateCheckIn - date
				NULL , -- DateCheckOut - date
				@idTable2, -- idTable - int
				0 -- status - int
				)

		SELECT @idSecondBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0

	END

	SELECT @isSecondTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill
	
	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '------------'

	SELECT id INTO  IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill

	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)

	DROP TABLE IDBillInfoTable

	IF (@isFirstTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2

	IF (@isSecondTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO

EXEC dbo.USP_SwitchTable @idTable1 = 1, -- int
	@idTable2 = 2 -- int

ALTER TABLE dbo.Bill ADD totalPrice FLOAT

DELETE dbo.BillInfo
DELETE dbo.Bill

GO

CREATE PROC USP_GetListBillByDate
@checkIn date, @checkOut date
AS
BEGIN

	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b, dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable

END
GO

CREATE PROC USP_UpdateAccount
@userName NVARCHAR(100), @displayName NVARCHAR(100), @passWord NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @passWord

	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	END
END
GO

CREATE TRIGGER UTG_DeleteBillInfo
ON dbo.BillInfo FOR DELETE
AS
BEGIN
	DECLARE @idBillInfo INT
	DECLARE @idBill INT
	SELECT @idBillInfo = id, @idBill = Deleted.idBill FROM Deleted

	DECLARE @idTable INT
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill

	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.BillInfo AS bi, dbo.Bill AS b WHERE b.id = bi.id AND b.id = @idBill AND b.status = 0 

	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

CREATE PROC USP_GetListBillByDateAndPage
@checkIn date, @checkOut date, @page int
AS
BEGIN
	
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows * @page
	DECLARE @exceptRows INT = (@page - 1) * @pageRows

	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)

END
GO

CREATE PROC USP_GetNumBillByDate
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO