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

INSERT INTO Users (UserName, Password, Enabled) VALUES ('adminsika', '$2b$10$8Y5nwO66BQEwB.33P5qdo.fHicgCCwguil8.wdOd8fjnsoZb8FFBy', 1);
GO

CREATE TABLE OrdersTable (
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [OrderNumber] NVARCHAR(20) UNIQUE NOT NULL,
    [CustAccount] NVARCHAR(20) NOT NULL,
    [CustRIF] NVARCHAR(10) NOT NULL,
    [CustIdentification] NVARCHAR(15) NOT NULL,
    [CustName] NVARCHAR(60) NOT NULL,
    [TotalAmount] DECIMAL(18, 2) NOT NULL,
    [Status] NVARCHAR(20) NOT NULL
);
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

CREATE TABLE OrdersLines (
    [Id] INT IDENTITY(1,1) PRIMARY KEY,
    [CreatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [UpdatedAt] DATETIME NOT NULL DEFAULT GETDATE(),
    [OrderNumber] NVARCHAR(20) NOT NULL,
    [LineNum] INT NOT NULL,
    [ItemId] NVARCHAR(20) NOT NULL,
    [ItemName] NVARCHAR(60) NOT NULL,
    [Quantity] INT NOT NULL,
    [UnitPrice] DECIMAL(18, 2) NOT NULL,
    [TotalAmount] DECIMAL(18, 2) NOT NULL,
    [Status] NVARCHAR(20) NOT NULL
);
GO

ALTER TABLE OrdersLines
ADD CONSTRAINT UQ_OrdersLines_OrderNumber_LineNum UNIQUE (OrderNumber, LineNum);
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

CREATE TYPE [dbo].[OrdersLinesType] AS TABLE 
(
	[OrderNumber] NVARCHAR(20),
	[LineNum] INT,
	[ItemId] NVARCHAR(20),
	[ItemName] NVARCHAR(60),
	[UnitPrice] DECIMAL(18, 2),
	[Quantity] INT,
	[TotalAmount] DECIMAL(18, 2),
	[Status] NVARCHAR(20)
)
GO

CREATE PROCEDURE [dbo].[sp_UpsertOrders]
    @OrderNumber NVARCHAR(20),
    @CustAccount NVARCHAR(20),
    @CustRIF NVARCHAR(10),
    @CustIdentification NVARCHAR(15),
    @CustName NVARCHAR(60),
    @TotalAmount DECIMAL(18, 2),
    @Status NVARCHAR(20),
    @OrdersLines [dbo].[OrdersLinesType] READONLY
AS
BEGIN
    IF EXISTS (SELECT 1 FROM OrdersTable WHERE OrderNumber = @OrderNumber)
    BEGIN
        UPDATE OrdersTable
        SET CustAccount = @CustAccount,
            CustRIF = @CustRIF,
            CustIdentification = @CustIdentification,   
            CustName = @CustName,
            TotalAmount = @TotalAmount,
            Status = @Status
        WHERE OrderNumber = @OrderNumber;
    END
    ELSE
    BEGIN
        INSERT INTO OrdersTable (OrderNumber, CustAccount, CustRIF, CustIdentification, CustName, TotalAmount, [Status])
        VALUES (@OrderNumber, @CustAccount, @CustRIF, @CustIdentification, @CustName, @TotalAmount, @Status);  
    END

    DELETE FROM OrdersLines WHERE OrderNumber = @OrderNumber;

    INSERT INTO OrdersLines (OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status])
    SELECT @OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status]
    FROM @OrdersLines;
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

--declare @OrdersLines [dbo].[OrdersLinesType];
--insert into @OrdersLines (OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, TotalAmount, [Status])
--values ('ON123', 1, 'I001', 'Artículo I001', 100, 1, 100, 'Pendiente');

--exec sp_UpsertOrders 'ON123', 'CA123', 'V140070340', '14007034', 'ELVIS VIZCAINO', 100, 'Pendiente', @OrdersLines;