CREATE TABLE Users (
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UserName] NVARCHAR(20) NOT NULL UNIQUE,
    [Password] NVARCHAR(100) NOT NULL,
    [Role] NVARCHAR(10) NOT NULL DEFAULT 'admin',
    [Enabled] BIT NOT NULL DEFAULT 1
);
GO

CREATE TRIGGER [dbo].[trg_Users_UpdateTimestamp]
ON [dbo].[Users]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Users
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO

CREATE PROCEDURE [dbo].[sp_Login]
    @UserName NVARCHAR(20)
AS
BEGIN
    SELECT * FROM Users WHERE UserName = @UserName;
END
GO

--INSERT INTO Users (UserName, Password, Enabled) VALUES ('adminsika', '$2b$10$8Y5nwO66BQEwB.33P5qdo.fHicgCCwguil8.wdOd8fjnsoZb8FFBy', 1);
--GO

CREATE TABLE [dbo].[OrdersTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedAt] [datetime] NOT NULL DEFAULT (getdate()),
	[OrderNumber] [nvarchar](20) NOT NULL,
	[CustAccount] [nvarchar](20) NOT NULL,
	[CustRIF] [nvarchar](10) NOT NULL,
	[CustIdentification] [nvarchar](15) NOT NULL,
	[CustName] [nvarchar](60) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
    [ControlNumber] [nvarchar](15) NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TRIGGER [dbo].[trg_OrdersTable_UpdateTimestamp]
ON [dbo].[OrdersTable]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE OrdersTable
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO

CREATE TABLE [dbo].[OrdersLines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL DEFAULT GETDATE(),
	[UpdatedAt] [datetime] NOT NULL DEFAULT GETDATE(),
	[OrderNumber] [nvarchar](20) NOT NULL,
	[LineNum] [int] NOT NULL,
	[ItemId] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](60) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_OrdersLines_OrderNumber_LineNum] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC,
	[LineNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrdersLines]  WITH CHECK ADD  CONSTRAINT [FK_OrdersLines_OrdersTable] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[OrdersTable] ([OrderNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[OrdersLines] CHECK CONSTRAINT [FK_OrdersLines_OrdersTable]
GO

CREATE TRIGGER [dbo].[trg_OrdersLines_UpdateTimestamp]
ON [dbo].[OrdersLines]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE OrdersLines
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO

ALTER TABLE [dbo].[OrdersTable] WITH NOCHECK
ADD CONSTRAINT [FK_OrdersTable_OrdersLines] FOREIGN KEY ([OrderNumber]) 
REFERENCES [dbo].[OrdersLines] ([OrderNumber]) 
ON DELETE CASCADE;
GO

CREATE TYPE [dbo].[OrdersLinesType] AS TABLE 
(
	[OrderNumber] NVARCHAR(20),
	[LineNum] INT,
	[ItemId] NVARCHAR(20),
	[ItemName] NVARCHAR(60),
	[Unit] NVARCHAR(10),
	[Quantity] INT,
    [Kgs] DECIMAL(18, 2),
    [TotalKgs] DECIMAL(18, 2),
	[UnitPrice] DECIMAL(18, 2),	
	[TotalAmount] DECIMAL(18, 2),
	[TaxCode] NVARCHAR(10),
	[TaxValue] DECIMAL(18, 2),
	[TaxAmount] DECIMAL(18, 2),
	[DiscAmount] DECIMAL(18, 2),
	[DiscPercent] DECIMAL(18, 2),
	[Status] NVARCHAR(20)
)
GO

CREATE PROCEDURE [dbo].[sp_CheckIfOrderExists]
    @OrderNumber NVARCHAR(20),
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Exists INT;
    SELECT @Exists = COUNT(*) FROM OrdersTable WHERE OrderNumber = @OrderNumber;
    IF @Exists = 0
    BEGIN
        SET @ReturnValue = 0;
    END
    ELSE
    BEGIN
        SET @ReturnValue = 1;
    END
END
GO

CREATE PROCEDURE [dbo].[sp_InsertOrders]
    @OrderNumber NVARCHAR(20),
    @CustAccount NVARCHAR(20),
    @CustRIF NVARCHAR(10),
    @CustIdentification NVARCHAR(15),
    @CustName NVARCHAR(60),
    @TotalAmount DECIMAL(18, 2),
    @Status NVARCHAR(20),
    @OrdersLines [dbo].[OrdersLinesType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM OrdersTable WHERE OrderNumber = @OrderNumber)
    BEGIN
        SET @ReturnValue = 0;
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO OrdersTable (OrderNumber, CustAccount, CustRIF, CustIdentification, CustName, TotalAmount, [Status])
        VALUES (@OrderNumber, @CustAccount, @CustRIF, @CustIdentification, @CustName, @TotalAmount, @Status);  
    END

    DECLARE @OrderNumber1 NVARCHAR(20);
    DECLARE @LineNum INT;
    DECLARE @ItemId NVARCHAR(20);
    DECLARE @ItemName NVARCHAR(60);
    DECLARE @UnitPrice DECIMAL(18, 2);
    DECLARE @Quantity INT;
    DECLARE @TotalAmount1 DECIMAL(18, 2);
    DECLARE @Status1 NVARCHAR(20);
    DECLARE CUR_OrderLines CURSOR FOR
    SELECT OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status]
    FROM @OrdersLines;

    OPEN CUR_OrderLines;

    FETCH NEXT FROM CUR_OrderLines INTO @OrderNumber1, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @TotalAmount1, @Status1;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO OrdersLines (OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status])
        VALUES (@OrderNumber1, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @TotalAmount1, @Status1);

        FETCH NEXT FROM CUR_OrderLines INTO @OrderNumber1, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @TotalAmount1, @Status1;
    END
    
    CLOSE CUR_OrderLines;
    DEALLOCATE CUR_OrderLines;

    SET @ReturnValue = 1;
END
GO

CREATE PROCEDURE [dbo].[sp_UpdateOrdersTable_ControlNumber]
    @OrderNumber NVARCHAR(20),
    @ControlNumber NVARCHAR(15),
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM OrdersTable WHERE OrderNumber = @OrderNumber)
    BEGIN
        SET @ReturnValue = 0;
        RETURN;
    END

    UPDATE OrdersTable
    SET ControlNumber = @ControlNumber
    WHERE OrderNumber = @OrderNumber;

    SET @ReturnValue = 1;
END
GO

CREATE PROCEDURE sp_UpdateOrders
    @OrderNumber NVARCHAR(20),
    @CustAccount NVARCHAR(20),
    @CustRIF NVARCHAR(10),
    @CustIdentification NVARCHAR(15),
    @CustName NVARCHAR(60),
    @TotalAmount DECIMAL(18, 2),
    @Status NVARCHAR(20),
    @OrdersLines [dbo].[OrdersLinesType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM OrdersTable WHERE OrderNumber = @OrderNumber)
    BEGIN
        SET @ReturnValue = 0;
        RETURN;
    END

    UPDATE OrdersTable
    SET CustAccount = @CustAccount,
        CustRIF = @CustRIF,
        CustIdentification = @CustIdentification,
        CustName = @CustName,
        TotalAmount = @TotalAmount,
        Status = @Status
    WHERE OrderNumber = @OrderNumber;

    DECLARE @OrderNumber1 NVARCHAR(20);
    DECLARE @LineNum INT;
    DECLARE @ItemId NVARCHAR(20);
    DECLARE @ItemName NVARCHAR(60);
    DECLARE @UnitPrice DECIMAL(18, 2);
    DECLARE @Quantity INT;
    DECLARE @TotalAmount1 DECIMAL(18, 2);
    DECLARE @Status1 NVARCHAR(20);

    DECLARE CUR_OrderLines CURSOR FOR
    SELECT OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status]
    FROM @OrdersLines;

    OPEN CUR_OrderLines;

    FETCH NEXT FROM CUR_OrderLines INTO @OrderNumber1, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @TotalAmount1, @Status1;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE OrdersLines
        SET ItemId = @ItemId,
            ItemName = @ItemName,
            UnitPrice = @UnitPrice,
            Quantity = @Quantity,
            TotalAmount = @TotalAmount1,
            [Status] = @Status1
        WHERE OrderNumber = @OrderNumber1 AND LineNum = @LineNum;

        FETCH NEXT FROM CUR_OrderLines INTO @OrderNumber1, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @TotalAmount1, @Status1;
    END

    CLOSE CUR_OrderLines;
    DEALLOCATE CUR_OrderLines;

    DELETE FROM OrdersLines WHERE OrderNumber = @OrderNumber AND LineNum NOT IN (SELECT LineNum FROM @OrdersLines);
    
    SET @ReturnValue = 1;
END
GO

CREATE PROCEDURE [dbo].[sp_GetOrdersTableByOrderNumber]
    @OrderNumber NVARCHAR(20)
AS
BEGIN
    SELECT * FROM OrdersTable WHERE OrderNumber = @OrderNumber;
    SELECT * FROM OrdersLines WHERE OrderNumber = @OrderNumber;
END
GO
