USE [master]
GO
/****** Object:  Database [SikaAX_KLKPOS]    Script Date: 18/07/2025 16:36:21 ******/
CREATE DATABASE [SikaAX_KLKPOS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SikaDB', FILENAME = N'C:\DATA\Data\SikaDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SikaDB_log', FILENAME = N'C:\DATA\Data\SikaDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SikaAX_KLKPOS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET RECOVERY FULL 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET  MULTI_USER 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SikaAX_KLKPOS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SikaAX_KLKPOS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SikaAX_KLKPOS', N'ON'
GO
ALTER DATABASE [SikaAX_KLKPOS] SET QUERY_STORE = ON
GO
ALTER DATABASE [SikaAX_KLKPOS] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SikaAX_KLKPOS]
GO
/****** Object:  UserDefinedTableType [dbo].[CustomersType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[CustomersType] AS TABLE(
	[CustAccount] [nvarchar](20) NULL,
	[RIF] [nvarchar](12) NULL,
	[FullName] [nvarchar](60) NULL,
	[Phone] [nvarchar](15) NULL,
	[Address] [nvarchar](250) NULL,
	[WithholdingAgent] [bit] NULL,
	[WithholdingCode] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ItemsType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[ItemsType] AS TABLE(
	[ItemId] [nvarchar](60) NULL,
	[ItemName] [nvarchar](60) NULL,
	[GroupId] [nvarchar](15) NULL,
	[TaxCode] [nvarchar](10) NULL,
	[PriceUSD] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OrdersLinesType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[OrdersLinesType] AS TABLE(
	[OrderNumber] [nvarchar](20) NULL,
	[LineNum] [int] NULL,
	[ItemId] [nvarchar](20) NULL,
	[ItemName] [nvarchar](60) NULL,
	[Unit] [nvarchar](10) NULL,
	[Quantity] [int] NULL,
	[Kgs] [decimal](18, 2) NULL,
	[TotalKgs] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[TaxCode] [nvarchar](10) NULL,
	[TaxValue] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[DiscAmount] [decimal](18, 2) NULL,
	[DiscPercent] [decimal](18, 2) NULL,
	[Status] [nvarchar](20) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OrdersTotalsType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[OrdersTotalsType] AS TABLE(
	[OrderNumber] [nvarchar](20) NULL,
	[TotalKgs] [decimal](18, 2) NULL,
	[Subtotal] [decimal](18, 2) NULL,
	[DiscPrice] [decimal](18, 2) NULL,
	[BaseTaxable] [decimal](18, 2) NULL,
	[TotalTax] [decimal](18, 2) NULL,
	[TotalToPay] [decimal](18, 2) NULL,
	[Observs] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TaxTableType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[TaxTableType] AS TABLE(
	[Code] [nvarchar](10) NULL,
	[Value] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[WithholdingsType]    Script Date: 18/07/2025 16:36:22 ******/
CREATE TYPE [dbo].[WithholdingsType] AS TABLE(
	[Code] [nvarchar](10) NULL,
	[Name] [nvarchar](30) NULL,
	[Type] [nvarchar](10) NULL,
	[ContributorType] [nvarchar](15) NULL,
	[Percent] [decimal](18, 2) NULL,
	[BaseMin] [decimal](18, 2) NULL,
	[Subtrahend] [decimal](18, 2) NULL,
	[TaxBasePercent] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[AuditLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[SchemaName] [nvarchar](128) NULL,
	[TableName] [nvarchar](128) NOT NULL,
	[RecordId] [nvarchar](100) NOT NULL,
	[ActionType] [char](1) NOT NULL,
	[FieldName] [nvarchar](128) NULL,
	[OldValue] [nvarchar](max) NULL,
	[NewValue] [nvarchar](max) NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[ApplicationName] [nvarchar](128) NULL,
	[HostName] [nvarchar](128) NULL,
	[ChangeDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__AuditLog__EB5F6CBDA3F0FD74] PRIMARY KEY CLUSTERED 
(
	[AuditLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[CustAccount] [nvarchar](20) NOT NULL,
	[RIF] [nvarchar](12) NOT NULL,
	[FullName] [nvarchar](60) NOT NULL,
	[Phone] [nvarchar](15) NULL,
	[Address] [nvarchar](250) NULL,
	[WithholdingAgent] [bit] NOT NULL,
	[WithholdingCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[ItemId] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](60) NOT NULL,
	[GroupId] [nvarchar](15) NOT NULL,
	[TaxCode] [nvarchar](10) NOT NULL,
	[PriceUSD] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersLines]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersLines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[OrderNumber] [nvarchar](20) NOT NULL,
	[LineNum] [int] NOT NULL,
	[ItemId] [nvarchar](20) NOT NULL,
	[ItemName] [nvarchar](60) NOT NULL,
	[Unit] [nvarchar](10) NULL,
	[Quantity] [int] NOT NULL,
	[Kgs] [decimal](18, 2) NOT NULL,
	[TotalKgs] [decimal](18, 2) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[TaxCode] [nvarchar](10) NULL,
	[TaxValue] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[DiscAmount] [decimal](18, 2) NULL,
	[DiscPercent] [decimal](18, 2) NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK__OrdersLi__3214EC07E758EC75] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC,
	[LineNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersTable]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[OrderNumber] [nvarchar](20) NOT NULL,
	[CustAccount] [nvarchar](20) NOT NULL,
	[CustRIF] [nvarchar](10) NOT NULL,
	[CustIdentification] [nvarchar](15) NOT NULL,
	[CustName] [nvarchar](60) NOT NULL,
	[CustAddress] [nvarchar](250) NOT NULL,
	[IssueDate] [date] NOT NULL,
	[DueDate] [date] NOT NULL,
	[SalesPersonId] [nvarchar](10) NOT NULL,
	[SalesPersonName] [nvarchar](60) NOT NULL,
	[RegionId] [nvarchar](6) NOT NULL,
	[RegionName] [nvarchar](60) NOT NULL,
	[CreditDays] [nvarchar](60) NOT NULL,
	[BaseTaxable] [decimal](18, 2) NOT NULL,
	[Base0] [decimal](18, 2) NOT NULL,
	[TaxRate] [decimal](18, 2) NOT NULL,
	[TotalTaxes] [decimal](18, 2) NOT NULL,
	[CurrencyCode] [nvarchar](3) NULL,
	[ControlNumber] [nvarchar](15) NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_OrdersTable] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__OrdersTa__CAC5E7430EE73D59] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersTotals]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersTotals](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[OrderNumber] [nvarchar](20) NOT NULL,
	[TotalKgs] [decimal](18, 2) NOT NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
	[DiscPrice] [decimal](18, 2) NOT NULL,
	[BaseTaxable] [decimal](18, 2) NOT NULL,
	[TotalTax] [decimal](18, 2) NOT NULL,
	[TotalToPay] [decimal](18, 2) NOT NULL,
	[Observs] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrdersTotals] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaxTable]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
	[Value] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_TaxTable] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Role] [nvarchar](10) NOT NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK__Users__3214EC07207D2E56] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ__Users__C9F2845637A5C14B] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Withholdings]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Withholdings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Type] [nvarchar](10) NULL,
	[ContributorType] [nvarchar](15) NULL,
	[Percent] [decimal](18, 2) NOT NULL,
	[BaseMin] [decimal](18, 2) NOT NULL,
	[Subtrahend] [decimal](18, 2) NOT NULL,
	[TaxBasePercent] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Withholdings] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OrdersTotals]    Script Date: 18/07/2025 16:36:22 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrdersTotals] ON [dbo].[OrdersTotals]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF__AuditLog__Change__0A9D95DB]  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Items] ADD  CONSTRAINT [DF_Items_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[OrdersLines] ADD  CONSTRAINT [DF__OrdersLin__Creat__6D0D32F4]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrdersLines] ADD  CONSTRAINT [DF__OrdersLin__Updat__6E01572D]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[OrdersLines] ADD  CONSTRAINT [DF_OrdersLines_Status]  DEFAULT (N'Creado') FOR [Status]
GO
ALTER TABLE [dbo].[OrdersTable] ADD  CONSTRAINT [DF__OrdersTab__Creat__68487DD7]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrdersTable] ADD  CONSTRAINT [DF__OrdersTab__Updat__693CA210]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[OrdersTable] ADD  CONSTRAINT [DF_OrdersTable_Status]  DEFAULT (N'Creado') FOR [Status]
GO
ALTER TABLE [dbo].[OrdersTotals] ADD  CONSTRAINT [DF_OrdersTotals_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[OrdersTotals] ADD  CONSTRAINT [DF_OrdersTotals_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[TaxTable] ADD  CONSTRAINT [DF_TaxTable_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TaxTable] ADD  CONSTRAINT [DF_TaxTable_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__CreatedAt__38996AB5]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__UpdatedAt__398D8EEE]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__Role__3A81B327]  DEFAULT ('admin') FOR [Role]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__Enabled__3B75D760]  DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Withholdings] ADD  CONSTRAINT [DF_Withholdings_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Withholdings] ADD  CONSTRAINT [DF_Withholdings_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Withholdings] FOREIGN KEY([WithholdingCode])
REFERENCES [dbo].[Withholdings] ([Code])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Withholdings]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_TaxTable_TaxCode] FOREIGN KEY([TaxCode])
REFERENCES [dbo].[TaxTable] ([Code])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_TaxTable_TaxCode]
GO
ALTER TABLE [dbo].[OrdersLines]  WITH CHECK ADD  CONSTRAINT [FK_OrdersLines_ItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([ItemId])
GO
ALTER TABLE [dbo].[OrdersLines] CHECK CONSTRAINT [FK_OrdersLines_ItemId]
GO
ALTER TABLE [dbo].[OrdersLines]  WITH CHECK ADD  CONSTRAINT [FK_OrdersLines_OrdersTable] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[OrdersTable] ([OrderNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrdersLines] CHECK CONSTRAINT [FK_OrdersLines_OrdersTable]
GO
ALTER TABLE [dbo].[OrdersLines]  WITH CHECK ADD  CONSTRAINT [FK_OrdersLines_TaxCode] FOREIGN KEY([TaxCode])
REFERENCES [dbo].[TaxTable] ([Code])
GO
ALTER TABLE [dbo].[OrdersLines] CHECK CONSTRAINT [FK_OrdersLines_TaxCode]
GO
ALTER TABLE [dbo].[OrdersTable]  WITH CHECK ADD  CONSTRAINT [FK_OrdersTable_CustAccount] FOREIGN KEY([CustAccount])
REFERENCES [dbo].[Customers] ([CustAccount])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrdersTable] CHECK CONSTRAINT [FK_OrdersTable_CustAccount]
GO
ALTER TABLE [dbo].[OrdersTotals]  WITH CHECK ADD  CONSTRAINT [FK_OrdersTotals_OrdersTable] FOREIGN KEY([OrderNumber])
REFERENCES [dbo].[OrdersTable] ([OrderNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrdersTotals] CHECK CONSTRAINT [FK_OrdersTotals_OrdersTable]
GO
ALTER TABLE [dbo].[AuditLog]  WITH CHECK ADD  CONSTRAINT [CK_ActionType] CHECK  (([ActionType]='D' OR [ActionType]='U' OR [ActionType]='I'))
GO
ALTER TABLE [dbo].[AuditLog] CHECK CONSTRAINT [CK_ActionType]
GO
/****** Object:  StoredProcedure [dbo].[sp_ChangeUserRole]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ChangeUserRole]
	@UserName NVARCHAR(20),
	@Role NVARCHAR(10),
	@ReturnValue INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Users WHERE UserName = @UserName)
	BEGIN
		UPDATE Users
		SET [Role] = @Role
		WHERE UserName = @UserName

		SET @ReturnValue = 1
	END
	ELSE
	BEGIN
		SET @ReturnValue = 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckIfOrderExists]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_DeleteCustomers]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteCustomers]
	@CustAccount NVARCHAR(20)
AS
BEGIN
	DELETE FROM Customers WHERE CustAccount = @CustAccount;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteItems]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteItems]
	@ItemId NVARCHAR(20)
AS
BEGIN
	DELETE FROM Items WHERE ItemId = @ItemId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteTaxTable]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteTaxTable]
	@Code NVARCHAR(10)
AS
BEGIN
	DELETE FROM TaxTable WHERE Code = @Code;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteWithholdings]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteWithholdings]
	@Code NVARCHAR(10)
AS
BEGIN
	DELETE FROM Withholdings WHERE Code = @Code;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EnableUser]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EnableUser]
	@UserName NVARCHAR(20),
	@ReturnValue INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Users WHERE UserName = @UserName)
	BEGIN
		UPDATE Users
		SET [Enabled] = 1
		WHERE UserName = @UserName

		SET @ReturnValue = 1
	END
	ELSE
	BEGIN
		SET @ReturnValue = 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerByIdentification]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCustomerByIdentification]
	@Identification NVARCHAR(20)
AS
	SELECT CustAccount, RIF, FullName, Phone, [Address], WithholdingAgent, WithholdingCode
	FROM Customers
	WHERE CustAccount = @Identification
	OR RIF = @Identification
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomers]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCustomers]
AS
	SELECT CustAccount, RIF, FullName, Phone, [Address], WithholdingAgent, WithholdingCode
	FROM Customers
	ORDER BY RIF
GO
/****** Object:  StoredProcedure [dbo].[sp_GetItemByItemId]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetItemByItemId]
	@ItemId NVARCHAR(20)
AS
	SELECT ItemId, ItemName, GroupId, TaxCode, PriceUSD
	FROM Items
	WHERE ItemId = @ItemId
GO
/****** Object:  StoredProcedure [dbo].[sp_GetItems]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetItems]
	
AS
	SELECT ItemId, ItemName, GroupId, TaxCode, PriceUSD
	FROM Items
	ORDER BY  ItemId
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrders]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetOrders]
    @PageNumber INT = 1,
    @PageSize INT = 10 
AS
BEGIN
    IF @PageNumber < 1 SET @PageNumber = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    -- 1. Obtener los encabezados de las órdenes paginadas
    SELECT
        ot.Id,
        ot.CreatedAt,
        ot.UpdatedAt,
        ot.OrderNumber,
        ot.CustAccount,
        ot.CustRIF,
        ot.CustIdentification,
        ot.CustName,
        ot.CustAddress,
        ot.IssueDate,
        ot.DueDate,
        ot.SalesPersonId,
        ot.SalesPersonName,
        ot.RegionId,
        ot.RegionName,
        ot.CreditDays,
        ot.BaseTaxable,
        ot.Base0,
        ot.TaxRate,
        ot.TotalTaxes,
        ot.CurrencyCode,
        ot.ControlNumber,
        ot.Status
    INTO #SelectedOrderHeaders
    FROM OrdersTable ot
    ORDER BY ot.OrderNumber
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;


	SELECT * FROM #SelectedOrderHeaders

    -- 2. Seleccionar las líneas de las órdenes para los encabezados paginados
    SELECT
        ol.Id,
        ol.CreatedAt,
        ol.UpdatedAt,
        ol.OrderNumber,
        ol.LineNum,
        ol.ItemId,
        ol.ItemName,
        ol.Unit,
        ol.Quantity,
        ol.Kgs,
        ol.TotalKgs,
        ol.UnitPrice,
        ol.TotalAmount,
        ol.TaxCode,
        ol.TaxValue,
        ol.TaxAmount,
        ol.DiscAmount,
        ol.DiscPercent,
        ol.Status
    FROM OrdersLines ol
    INNER JOIN #SelectedOrderHeaders soh ON ol.OrderNumber = soh.OrderNumber
    ORDER BY ol.OrderNumber, ol.LineNum;

    -- 3. Seleccionar los totales de las órdenes para los encabezados paginados
    SELECT
        otl.Id,
        otl.CreatedAt,
        otl.UpdatedAt,
        otl.OrderNumber,
        otl.TotalKgs,
        otl.Subtotal,
        otl.DiscPrice,
        otl.BaseTaxable,
        otl.TotalTax,
        otl.TotalToPay,
        otl.Observs
    FROM OrdersTotals otl
    INNER JOIN #SelectedOrderHeaders soh ON otl.OrderNumber = soh.OrderNumber
    ORDER BY otl.OrderNumber;

    -- Opcional: Contar el total de registros para paginación (útil para el cliente)
    SELECT COUNT(1) AS TotalCount FROM OrdersTable;

    -- Limpiar la tabla temporal
    DROP TABLE #SelectedOrderHeaders;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrdersTableByOrderNumber]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetOrdersTableByOrderNumber]
    @OrderNumber NVARCHAR(20)
AS
BEGIN
    SELECT * FROM OrdersTable WHERE OrderNumber = @OrderNumber;
    SELECT * FROM OrdersLines WHERE OrderNumber = @OrderNumber;
	SELECT * FROM OrdersTotals WHERE OrderNumber = @OrderNumber;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTaxTable]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTaxTable]
AS
SELECT Code, [Value] FROM TaxTable ORDER BY Code
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTaxTableByCode]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTaxTableByCode]
	@Code NVARCHAR(10)
AS
	SELECT Code, [Value] FROM TaxTable WHERE Code = @Code
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWithholdingByCode]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetWithholdingByCode]
	@Code NVARCHAR(10)
AS
	SELECT Code, [Name], [Type], ContributorType, [Percent], BaseMin, Subtrahend, TaxBasePercent
	FROM Withholdings
	WHERE Code = @Code
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWithholdings]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetWithholdings]
AS
	SELECT Code, [Name], [Type], ContributorType, [Percent], BaseMin, Subtrahend, TaxBasePercent
	FROM Withholdings
	ORDER BY Code
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertOrders]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertOrders]
    @OrderNumber NVARCHAR(20),
    @CustAccount NVARCHAR(20),
    @CustRIF NVARCHAR(10),
    @CustIdentification NVARCHAR(15),
    @CustName NVARCHAR(60),
	@CustAddress NVARCHAR(250),
	@IssueDate DATE,
	@DueDate DATE,
	@SalesPersonId NVARCHAR(10),
	@SalesPersonName NVARCHAR(60),
	@RegionId NVARCHAR(6),
	@RegionName NVARCHAR(60),
	@CreditDays NVARCHAR(60),
    @BaseTaxable DECIMAL(18, 2),
	@Base0 DECIMAL(18, 2),
	@TaxRate DECIMAL(18, 2),
	@TotalTaxes DECIMAL(18, 2),
	@CurrencyCode NVARCHAR(3),
    @OrdersLines [dbo].[OrdersLinesType] READONLY,
	@OrdersTotals [dbo].[OrdersTotalsType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM OrdersTable WHERE OrderNumber = @OrderNumber)
        BEGIN
            SET @ReturnValue = 0;
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO OrdersTable 
        (
            OrderNumber, CustAccount, CustRIF, CustIdentification, CustName, 
            CustAddress, IssueDate, DueDate, SalesPersonId, SalesPersonName, 
            RegionId, RegionName, CreditDays, BaseTaxable, Base0, 
            TaxRate, TotalTaxes, CurrencyCode
        )
        VALUES (
            @OrderNumber, @CustAccount, @CustRIF, @CustIdentification, @CustName, 
            @CustAddress, @IssueDate, @DueDate, @SalesPersonId, @SalesPersonName,
            @RegionId, @RegionName, @CreditDays, @BaseTaxable, @Base0,
            @TaxRate, @TotalTaxes, @CurrencyCode
        );

		-- Líneas (detalle)
		INSERT INTO OrdersLines (OrderNumber, LineNum, ItemId, ItemName, Unit, Quantity, Kgs, TotalKgs, UnitPrice, TotalAmount, TaxCode, TaxValue, TaxAmount, DiscAmount, DiscPercent)
        SELECT @OrderNumber, LineNum, ItemId, ItemName, Unit, Quantity, Kgs, TotalKgs, UnitPrice, TotalAmount, TaxCode, TaxValue, TaxAmount, DiscAmount, DiscPercent FROM @OrdersLines

		-- Totales
		INSERT INTO OrdersTotals (OrderNumber, TotalKgs, Subtotal, DiscPrice, BaseTaxable, TotalTax, TotalToPay, Observs)
		SELECT OrderNumber, TotalKgs, Subtotal, DiscPrice, BaseTaxable, TotalTax, TotalToPay, Observs FROM @OrdersTotals;

        COMMIT TRANSACTION;
        SET @ReturnValue = 1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_InsertOrders: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Login]
    @UserName NVARCHAR(20)
AS
BEGIN
    SELECT * FROM Users WHERE UserName = @UserName AND [Enabled] = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegisterUser]
	@UserName NVARCHAR(20),
	@Password NVARCHAR(100),
	@ReturnValue INT OUTPUT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Users WHERE UserName = @UserName)
	BEGIN
		SET @ReturnValue = 0
	END
	ELSE
	BEGIN
		INSERT INTO Users
		(
			UserName, [Password], [Role], [Enabled]
		)
		VALUES
		(
			@UserName, @Password, 'user', 0
		)
		SET @ReturnValue = 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateOrders]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateOrders]
    @OrderNumber NVARCHAR(20),
    @CustAccount NVARCHAR(20),
    @CustRIF NVARCHAR(10),
    @CustIdentification NVARCHAR(15),
    @CustName NVARCHAR(60),
	@CustAddress NVARCHAR(250),
	@IssueDate DATE,
	@DueDate DATE,
	@SalesPersonId NVARCHAR(10),
	@SalesPersonName NVARCHAR(60),
	@RegionId NVARCHAR(6),
	@RegionName NVARCHAR(60),
	@CreditDays NVARCHAR(60),
    @BaseTaxable DECIMAL(18, 2),
	@Base0 DECIMAL(18, 2),
	@TaxRate DECIMAL(18, 2),
	@TotalTaxes DECIMAL(18, 2),
	@CurrencyCode NVARCHAR(3),
    @OrdersLines [dbo].[OrdersLinesType] READONLY,
	@OrdersTotals [dbo].[OrdersTotalsType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY
		BEGIN TRANSACTION;

		UPDATE OrdersTable
		SET CustAccount = @CustAccount,
			CustRIF = @CustRIF,
			CustIdentification = @CustIdentification,   
			CustName = @CustName,
			CustAddress = @CustAddress,
			IssueDate = @IssueDate,
			DueDate = @DueDate,
			SalesPersonId = @SalesPersonId,
			SalesPersonName = @SalesPersonName,
			RegionId = @RegionId,
			RegionName = @RegionName,
			CreditDays = @CreditDays,
			BaseTaxable = @BaseTaxable,
			Base0 = @Base0,
			TaxRate = @TaxRate,
			TotalTaxes = @TotalTaxes,
			CurrencyCode = @CurrencyCode,
			[Status] = 'Actualizado'
		WHERE OrderNumber = @OrderNumber;
    
		DECLARE @LineNum INT;
        DECLARE @ItemId NVARCHAR(20);
        DECLARE @ItemName NVARCHAR(60);
        DECLARE @UnitPrice DECIMAL(18, 2);
        DECLARE @Quantity INT;
		DECLARE @Kgs DECIMAL(18, 2);
		DECLARE @TotalKgs DECIMAL(18, 2);
        DECLARE @TotalAmount DECIMAL(18, 2);
		DECLARE @Unit NVARCHAR(10);
		DECLARE @TaxCode NVARCHAR(10);
		DECLARE @TaxValue DECIMAL(18, 2);
		DECLARE @TaxAmount DECIMAL(18, 2);
		DECLARE @DiscAmount DECIMAL(18, 2);
		DECLARE @DiscPercent DECIMAL(18, 2);

		-- Líneas (detalle)
		DECLARE CUR_OrderLines CURSOR FOR
		SELECT LineNum, ItemId, ItemName, Unit, Quantity, Kgs, TotalKgs, UnitPrice, TotalAmount, TaxCode, TaxValue, TaxAmount, DiscAmount, DiscPercent
		FROM @OrdersLines;

		OPEN CUR_OrderLines;
		FETCH NEXT FROM CUR_OrderLines INTO @LineNum, @ItemId, @ItemName, @Unit, @Quantity, @Kgs, @TotalKgs, @UnitPrice, @TotalAmount, @TaxCode, @TaxValue, @TaxAmount, @DiscAmount, @DiscPercent;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF EXISTS (SELECT 1 FROM OrdersLines WHERE OrderNumber = @OrderNumber AND LineNum = @LineNum)
			BEGIN
				UPDATE OrdersLines
				SET ItemId = @ItemId,
					ItemName = @ItemName,
					UnitPrice = @UnitPrice,
					Quantity = @Quantity,
					Kgs = @Kgs,
					TotalAmount = @TotalAmount,
					Unit = @Unit,
					TaxCode = @TaxCode,
					TaxValue = @TaxValue,
					TaxAmount = @TaxAmount,
					DiscAmount = @DiscAmount,
					DiscPercent = @DiscPercent,
					[Status] = 'Actualizado'
				WHERE OrderNumber = @OrderNumber AND LineNum = @LineNum;
			END
			ELSE
			BEGIN
				INSERT INTO OrdersLines (OrderNumber, LineNum, ItemId, ItemName, UnitPrice, Quantity, Kgs, TotalKgs, TotalAmount, Unit, TaxCode, TaxValue, TaxAmount, DiscAmount, DiscPercent)
				VALUES (@OrderNumber, @LineNum, @ItemId, @ItemName, @UnitPrice, @Quantity, @Kgs, @TotalKgs, @TotalAmount, @Unit, @TaxCode, @TaxValue, @TaxAmount, @DiscAmount, @DiscPercent);
			END
			FETCH NEXT FROM CUR_OrderLines INTO @LineNum, @ItemId, @ItemName, @Unit, @Quantity, @Kgs, @TotalKgs, @UnitPrice, @TotalAmount, @TaxCode, @TaxValue, @TaxAmount, @DiscAmount, @DiscPercent;
		END
    
		CLOSE CUR_OrderLines;
		DEALLOCATE CUR_OrderLines;

		DELETE FROM OrdersLines WHERE OrderNumber = @OrderNumber AND LineNum NOT IN (SELECT LineNum FROM @OrdersLines);

		-- Totales
		IF EXISTS (SELECT 1 FROM OrdersTotals WHERE OrderNumber = @OrderNumber)
		BEGIN
			DECLARE @TotalKgs2 DECIMAL(18, 2);
			DECLARE @Subtotal2 DECIMAL(18, 2);
			DECLARE @DiscPrice2 DECIMAL(18, 2);
			DECLARE @BaseTaxable2 DECIMAL(18, 2);
			DECLARE @TotalTax2 DECIMAL(18, 2);
			DECLARE @TotalToPay2 DECIMAL(18, 2);
			DECLARE @Observs2 NVARCHAR(50);
			
			DECLARE CUR_OrdersTotals CURSOR FOR
			SELECT TotalKgs, Subtotal, DiscPrice, BaseTaxable, TotalTax, TotalToPay, Observs FROM @OrdersTotals

			OPEN CUR_OrdersTotals;
			FETCH NEXT FROM CUR_OrdersTotals INTO @TotalKgs2, @Subtotal2, @DiscPrice2, @BaseTaxable2, @TotalTax2, @TotalToPay2, @Observs2

			WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE OrdersTotals
				SET TotalKgs = @TotalKgs2,
					Subtotal = @Subtotal2,
					DiscPrice = @DiscPrice2,
					BaseTaxable = @BaseTaxable2,
					TotalTax = @TotalTax2,
					TotalToPay = @TotalToPay2,
					Observs = @Observs2
				WHERE OrderNumber = @OrderNumber

				FETCH NEXT FROM CUR_OrdersTotals INTO @TotalKgs2, @Subtotal2, @DiscPrice2, @BaseTaxable2, @TotalTax2, @TotalToPay2, @Observs2
			END
			CLOSE CUR_OrdersTotals;
			DEALLOCATE CUR_OrdersTotals;
		END
		ELSE
		BEGIN
			INSERT INTO OrdersTotals (OrderNumber, TotalKgs, Subtotal, DiscPrice, BaseTaxable, TotalTax, TotalToPay, Observs)
			SELECT OrderNumber, TotalKgs, Subtotal, DiscPrice, BaseTaxable, TotalTax, TotalToPay, Observs FROM @OrdersTotals;
		END

		COMMIT TRANSACTION;
        SET @ReturnValue = 1;
	END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_UpdateOrders: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateOrdersTable_ControlNumber]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
    SET ControlNumber = @ControlNumber,
	[Status] = 'N. control agregado'
    WHERE OrderNumber = @OrderNumber;

    SET @ReturnValue = 1;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpsertCustomers]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpsertCustomers]
    @CustomersData [dbo].[CustomersType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustAccount NVARCHAR(20);
    DECLARE @RIF NVARCHAR(12);
    DECLARE @FullName NVARCHAR(60);
    DECLARE @Phone NVARCHAR(15);
    DECLARE @Address NVARCHAR(250);
    DECLARE @WithholdingAgent BIT;
    DECLARE @WithholdingCode NVARCHAR(50);

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE CUR_CustomerData CURSOR FOR
        SELECT
            CustAccount,
            RIF,
            FullName,
            Phone,
            [Address],
            WithholdingAgent,
            WithholdingCode
        FROM @CustomersData;

        OPEN CUR_CustomerData;
        FETCH NEXT FROM CUR_CustomerData INTO
            @CustAccount,
            @RIF,
            @FullName,
            @Phone,
            @Address,
            @WithholdingAgent,
            @WithholdingCode;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS (SELECT 1 FROM dbo.Customers WHERE CustAccount = @CustAccount)
            BEGIN
                -- Update existing record
                UPDATE dbo.Customers
                SET
                    RIF = @RIF,
                    FullName = @FullName,
                    Phone = @Phone,
                    [Address] = @Address,
                    WithholdingAgent = @WithholdingAgent,
                    WithholdingCode = @WithholdingCode
                WHERE CustAccount = @CustAccount;
            END
            ELSE
            BEGIN
                INSERT INTO dbo.Customers (
                    CustAccount,
                    RIF,
                    FullName,
                    Phone,
                    [Address],
                    WithholdingAgent,
                    WithholdingCode
                )
                VALUES (
                    @CustAccount,
                    @RIF,
                    @FullName,
                    @Phone,
                    @Address,
                    @WithholdingAgent,
                    @WithholdingCode
                );
            END

            FETCH NEXT FROM CUR_CustomerData INTO
                @CustAccount,
                @RIF,
                @FullName,
                @Phone,
                @Address,
                @WithholdingAgent,
                @WithholdingCode;
        END

        CLOSE CUR_CustomerData;
        DEALLOCATE CUR_CustomerData;

        COMMIT TRANSACTION;
        SET @ReturnValue = 1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_UpsertCustomers: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpsertItems]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpsertItems]
    @ItemsData [dbo].[ItemsType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ItemId NVARCHAR(60);
    DECLARE @ItemName NVARCHAR(60);
    DECLARE @GroupId NVARCHAR(15);
    DECLARE @TaxCode NVARCHAR(10);
    DECLARE @PriceUSD DECIMAL(18,2);

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE CUR_ItemData CURSOR FOR
        SELECT
            ItemId,
            ItemName,
            GroupId,
            TaxCode,
            PriceUSD
        FROM @ItemsData;

        OPEN CUR_ItemData;
        FETCH NEXT FROM CUR_ItemData INTO
            @ItemId,
            @ItemName,
            @GroupId,
            @TaxCode,
            @PriceUSD;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS (SELECT 1 FROM dbo.Items WHERE ItemId = @ItemId)
            BEGIN
                UPDATE dbo.Items
                SET
                    ItemName = @ItemName,
                    GroupId = @GroupId,
                    TaxCode = @TaxCode,
                    PriceUSD = @PriceUSD
                WHERE ItemId = @ItemId;
            END
            ELSE
            BEGIN
                INSERT INTO dbo.Items (
                    ItemId,
                    ItemName,
                    GroupId,
                    TaxCode,
                    PriceUSD
                )
                VALUES (
                    @ItemId,
                    @ItemName,
                    @GroupId,
                    @TaxCode,
                    @PriceUSD
                );
            END

            FETCH NEXT FROM CUR_ItemData INTO
                @ItemId,
                @ItemName,
                @GroupId,
                @TaxCode,
                @PriceUSD;
        END

        CLOSE CUR_ItemData;
        DEALLOCATE CUR_ItemData;

        COMMIT TRANSACTION;
        SET @ReturnValue = 1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_UpsertItems: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpsertTaxTable]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpsertTaxTable]
	@TaxTable [dbo].[TaxTableType] READONLY,
	@ReturnValue INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Code NVARCHAR(10);
	DECLARE @Value DECIMAL(18,2);

	BEGIN TRY
		BEGIN TRANSACTION;

		DECLARE CUR_TaxTable CURSOR FOR
		SELECT Code, [Value] FROM @TaxTable;

		OPEN CUR_TaxTable;
		FETCH NEXT FROM CUR_TaxTable INTO @Code, @Value;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF EXISTS (SELECT 1 FROM TaxTable WHERE Code = @Code)
			BEGIN
				UPDATE TaxTable
				SET [Value] = @Value
				WHERE Code = @Code
			END
			ELSE
			BEGIN
				INSERT INTO TaxTable (Code, [Value])
				VALUES (@Code, @Value)
			END

			FETCH NEXT FROM CUR_TaxTable INTO @Code, @Value;
		END

		CLOSE CUR_TaxTable
		DEALLOCATE CUR_TaxTable

		COMMIT TRANSACTION;
        SET @ReturnValue = 1;
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_UpsertTaxTable: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpsertWithholdings]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpsertWithholdings]
    @WithholdingsData [dbo].[WithholdingsType] READONLY,
    @ReturnValue INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Code NVARCHAR(10);
    DECLARE @Name NVARCHAR(30);
    DECLARE @Type NVARCHAR(10);
    DECLARE @ContributorType NVARCHAR(15);
    DECLARE @Percent DECIMAL(18,2);
    DECLARE @BaseMin DECIMAL(18,2);
    DECLARE @Subtrahend DECIMAL(18,2);
    DECLARE @TaxBasePercent DECIMAL(18,2);

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE CUR_WithholdingData CURSOR FOR
        SELECT
            Code,
            [Name],
            [Type],
            ContributorType,
            [Percent],
            BaseMin,
            Subtrahend,
            TaxBasePercent
        FROM @WithholdingsData;

        OPEN CUR_WithholdingData;
        FETCH NEXT FROM CUR_WithholdingData INTO
            @Code,
            @Name,
            @Type,
            @ContributorType,
            @Percent,
            @BaseMin,
            @Subtrahend,
            @TaxBasePercent;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS (SELECT 1 FROM dbo.Withholdings WHERE Code = @Code)
            BEGIN
                UPDATE dbo.Withholdings
                SET
                    [Name] = @Name,
                    [Type] = @Type,
                    ContributorType = @ContributorType,
                    [Percent] = @Percent,
                    BaseMin = @BaseMin,
                    Subtrahend = @Subtrahend,
                    TaxBasePercent = @TaxBasePercent
                WHERE Code = @Code;
            END
            ELSE
            BEGIN
                INSERT INTO dbo.Withholdings (
                    Code,
                    [Name],
                    [Type],
                    ContributorType,
                    [Percent],
                    BaseMin,
                    Subtrahend,
                    TaxBasePercent
                )
                VALUES (
                    @Code,
                    @Name,
                    @Type,
                    @ContributorType,
                    @Percent,
                    @BaseMin,
                    @Subtrahend,
                    @TaxBasePercent
                );
            END

            FETCH NEXT FROM CUR_WithholdingData INTO
                @Code,
                @Name,
                @Type,
                @ContributorType,
                @Percent,
                @BaseMin,
                @Subtrahend,
                @TaxBasePercent;
        END

        CLOSE CUR_WithholdingData;
        DEALLOCATE CUR_WithholdingData;

        COMMIT TRANSACTION;
        SET @ReturnValue = 1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error en sp_UpsertWithholdings: %s', 16, 1, @ErrorMessage);

        SET @ReturnValue = 0;
    END CATCH
END;
GO
/****** Object:  Trigger [dbo].[trg_Customers_AuditLog_Delete]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Customers_AuditLog_Delete]
ON [dbo].[Customers]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

    -- Try to get the username from SESSION_CONTEXT first
    SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

    -- If SESSION_CONTEXT is empty or null, default to 'SQL SERVER'
    IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
        SET @UserName = 'SQL SERVER';

    -- Insert into AuditLog for each deleted row
    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT
        'dbo',
        'Customers',
        CONVERT(NVARCHAR, d.Id, 100),
        'D',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM deleted d;
END;
GO
ALTER TABLE [dbo].[Customers] ENABLE TRIGGER [trg_Customers_AuditLog_Delete]
GO
/****** Object:  Trigger [dbo].[trg_Customers_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Customers_AuditLog_Insert]
ON [dbo].[Customers]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'Customers',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[Customers] ENABLE TRIGGER [trg_Customers_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_Customers_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Customers_AuditLog_Update]
ON [dbo].[Customers]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustAccount', CONVERT(NVARCHAR(MAX), d.CustAccount), CONVERT(NVARCHAR(MAX), i.CustAccount)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustAccount, '') <> ISNULL(i.CustAccount, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'RIF', CONVERT(NVARCHAR(MAX), d.RIF), CONVERT(NVARCHAR(MAX), i.RIF)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.RIF, '') <> ISNULL(i.RIF, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'FullName', CONVERT(NVARCHAR(MAX), d.FullName), CONVERT(NVARCHAR(MAX), i.FullName)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.FullName, '') <> ISNULL(i.FullName, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Phone', CONVERT(NVARCHAR(MAX), d.Phone), CONVERT(NVARCHAR(MAX), i.Phone)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Phone, '') <> ISNULL(i.Phone, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Address', CONVERT(NVARCHAR(MAX), d.Address), CONVERT(NVARCHAR(MAX), i.Address)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Address, '') <> ISNULL(i.Address, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'WithholdingAgent', CONVERT(NVARCHAR(MAX), d.WithholdingAgent), CONVERT(NVARCHAR(MAX), i.WithholdingAgent)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.WithholdingAgent, '') <> ISNULL(i.WithholdingAgent, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'WithholdingCode', CONVERT(NVARCHAR(MAX), d.WithholdingCode), CONVERT(NVARCHAR(MAX), i.WithholdingCode)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.WithholdingCode, '') <> ISNULL(i.WithholdingCode, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'Customers',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  
END
GO
ALTER TABLE [dbo].[Customers] ENABLE TRIGGER [trg_Customers_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_Customers_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Customers_UpdateTimestamp]
ON [dbo].[Customers]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Customers
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO
ALTER TABLE [dbo].[Customers] ENABLE TRIGGER [trg_Customers_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_Items_AuditLog_Delete]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Items_AuditLog_Delete]
ON [dbo].[Items]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

    -- Try to get the username from SESSION_CONTEXT first
    SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

    -- If SESSION_CONTEXT is empty or null, default to 'SQL SERVER'
    IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
        SET @UserName = 'SQL SERVER';

    -- Insert into AuditLog for each deleted row
    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT
        'dbo',
        'Items',
        CONVERT(NVARCHAR, d.Id, 100),
        'D',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM deleted d;
END;
GO
ALTER TABLE [dbo].[Items] ENABLE TRIGGER [trg_Items_AuditLog_Delete]
GO
/****** Object:  Trigger [dbo].[trg_Items_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Items_AuditLog_Insert]
ON [dbo].[Items]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'Items',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[Items] ENABLE TRIGGER [trg_Items_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_Items_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Items_AuditLog_Update]
ON [dbo].[Items]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'ItemId', CONVERT(NVARCHAR(MAX), d.ItemId), CONVERT(NVARCHAR(MAX), i.ItemId)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.ItemId, '') <> ISNULL(i.ItemId, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'ItemName', CONVERT(NVARCHAR(MAX), d.ItemName), CONVERT(NVARCHAR(MAX), i.ItemName)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.ItemName, '') <> ISNULL(i.ItemName, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'GroupId', CONVERT(NVARCHAR(MAX), d.GroupId), CONVERT(NVARCHAR(MAX), i.GroupId)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.GroupId, '') <> ISNULL(i.GroupId, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TaxCode', CONVERT(NVARCHAR(MAX), d.TaxCode), CONVERT(NVARCHAR(MAX), i.TaxCode)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TaxCode, '') <> ISNULL(i.TaxCode, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'PriceUSD', CONVERT(NVARCHAR(MAX), d.PriceUSD), CONVERT(NVARCHAR(MAX), i.PriceUSD)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.PriceUSD, '') <> ISNULL(i.PriceUSD, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'Items',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  -- Asumimos una sola fila modificada
END
GO
ALTER TABLE [dbo].[Items] ENABLE TRIGGER [trg_Items_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_Items_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Items_UpdateTimestamp]
ON [dbo].[Items]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Items
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO
ALTER TABLE [dbo].[Items] ENABLE TRIGGER [trg_Items_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_OrdersLines_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersLines_AuditLog_Insert]
ON [dbo].[OrdersLines]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	INSERT INTO [dbo].[AuditLog] (
		SchemaName,
		TableName,
		RecordId,
		ActionType,
		FieldName,
		OldValue,
		NewValue,
		UserName,
		ApplicationName,
		HostName
	)
	SELECT
		'dbo',
		'OrdersLines',
		CONCAT(i.Id, ', ', i.LineNum), -- Concatenate OrderNumber and LineNum for RecordId
		'I',
		NULL, -- No specific field change for an INSERT
		NULL, -- No old value for an INSERT
		NULL, -- No specific new value for an INSERT (the whole record is new)
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM inserted i;
END
GO
ALTER TABLE [dbo].[OrdersLines] ENABLE TRIGGER [trg_OrdersLines_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_OrdersLines_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersLines_AuditLog_Update]
ON [dbo].[OrdersLines]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		OrderNumber NVARCHAR(50), -- Assuming OrderNumber is NVARCHAR, adjust if needed
		LineNum INT,             -- Assuming LineNum is INT, adjust if needed
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas para cada campo de OrdersLines
	-- Se asume que la clave primaria es una combinación de OrderNumber y LineNum.

	-- ItemId
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'ItemId', CONVERT(NVARCHAR(MAX), d.ItemId), CONVERT(NVARCHAR(MAX), i.ItemId)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.ItemId, '') <> ISNULL(i.ItemId, '');

	-- ItemName
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'ItemName', CONVERT(NVARCHAR(MAX), d.ItemName), CONVERT(NVARCHAR(MAX), i.ItemName)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.ItemName, '') <> ISNULL(i.ItemName, '');

	-- Quantity
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'Quantity', CONVERT(NVARCHAR(MAX), d.Quantity), CONVERT(NVARCHAR(MAX), i.Quantity)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.Quantity, '') <> ISNULL(i.Quantity, '');

	-- Kgs
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'Kgs', CONVERT(NVARCHAR(MAX), d.Kgs), CONVERT(NVARCHAR(MAX), i.Kgs)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.Kgs, '') <> ISNULL(i.Kgs, '');

	-- TotalKgs
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'TotalKgs', CONVERT(NVARCHAR(MAX), d.TotalKgs), CONVERT(NVARCHAR(MAX), i.TotalKgs)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.TotalKgs, '') <> ISNULL(i.TotalKgs, '');

	-- UnitPrice
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'UnitPrice', CONVERT(NVARCHAR(MAX), d.UnitPrice), CONVERT(NVARCHAR(MAX), i.UnitPrice)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.UnitPrice, '') <> ISNULL(i.UnitPrice, '');

	-- TotalAmount
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'TotalAmount', CONVERT(NVARCHAR(MAX), d.TotalAmount), CONVERT(NVARCHAR(MAX), i.TotalAmount)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.TotalAmount, '') <> ISNULL(i.TotalAmount, '');

	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'TaxCode', CONVERT(NVARCHAR(MAX), d.TaxCode), CONVERT(NVARCHAR(MAX), i.TaxCode)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.TaxCode, '') <> ISNULL(i.TaxCode, '');

	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'TaxValue', CONVERT(NVARCHAR(MAX), d.TaxValue), CONVERT(NVARCHAR(MAX), i.TaxValue)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.TaxValue, '') <> ISNULL(i.TaxValue, '');

	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'TaxAmount', CONVERT(NVARCHAR(MAX), d.TaxAmount), CONVERT(NVARCHAR(MAX), i.TaxAmount)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.TaxAmount, '') <> ISNULL(i.TaxAmount, '');

	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'DiscAmount', CONVERT(NVARCHAR(MAX), d.DiscAmount), CONVERT(NVARCHAR(MAX), i.DiscAmount)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.DiscAmount, '') <> ISNULL(i.DiscAmount, '');

	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'DiscPercent', CONVERT(NVARCHAR(MAX), d.DiscPercent), CONVERT(NVARCHAR(MAX), i.DiscPercent)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.DiscPercent, '') <> ISNULL(i.DiscPercent, '');

	-- Status
	INSERT INTO @AuditChanges (OrderNumber, LineNum, FieldName, OldValue, NewValue)
	SELECT i.OrderNumber, i.LineNum, 'Status', CONVERT(NVARCHAR(MAX), d.Status), CONVERT(NVARCHAR(MAX), i.Status)
	FROM inserted i
	INNER JOIN deleted d ON i.OrderNumber = d.OrderNumber AND i.LineNum = d.LineNum
	WHERE ISNULL(d.Status, '') <> ISNULL(i.Status, '');


	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT
		'dbo',
		'OrdersLines',
		CONCAT(i.Id, ', ', ac.LineNum), -- Concatenar OrderNumber y LineNum para RecordId
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  -- Asumimos una sola fila modificada
END
GO
ALTER TABLE [dbo].[OrdersLines] ENABLE TRIGGER [trg_OrdersLines_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_OrdersLines_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[OrdersLines] ENABLE TRIGGER [trg_OrdersLines_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTable_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersTable_AuditLog_Insert]
ON [dbo].[OrdersTable]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'OrdersTable',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[OrdersTable] ENABLE TRIGGER [trg_OrdersTable_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTable_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersTable_AuditLog_Update]
ON [dbo].[OrdersTable]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Solo considera una fila modificada por ejecución
	-- Para múltiples filas, se requeriría un enfoque más complejo (MERGE o cursor)

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustAccount', CONVERT(NVARCHAR(MAX), d.CustAccount), CONVERT(NVARCHAR(MAX), i.CustAccount)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustAccount, '') <> ISNULL(i.CustAccount, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustRIF', CONVERT(NVARCHAR(MAX), d.CustRIF), CONVERT(NVARCHAR(MAX), i.CustRIF)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustRIF, '') <> ISNULL(i.CustRIF, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustIdentification', CONVERT(NVARCHAR(MAX), d.CustIdentification), CONVERT(NVARCHAR(MAX), i.CustIdentification)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustIdentification, '') <> ISNULL(i.CustIdentification, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustName', CONVERT(NVARCHAR(MAX), d.CustName), CONVERT(NVARCHAR(MAX), i.CustName)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustName, '') <> ISNULL(i.CustName, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CustAddress', CONVERT(NVARCHAR(MAX), d.CustAddress), CONVERT(NVARCHAR(MAX), i.CustAddress)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CustAddress, '') <> ISNULL(i.CustAddress, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'IssueDate', CONVERT(NVARCHAR(MAX), d.IssueDate), CONVERT(NVARCHAR(MAX), i.IssueDate)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.IssueDate, '') <> ISNULL(i.IssueDate, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'DueDate', CONVERT(NVARCHAR(MAX), d.DueDate), CONVERT(NVARCHAR(MAX), i.DueDate)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.DueDate, '') <> ISNULL(i.DueDate, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'SalesPersonId', CONVERT(NVARCHAR(MAX), d.SalesPersonId), CONVERT(NVARCHAR(MAX), i.SalesPersonId)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.SalesPersonId, '') <> ISNULL(i.SalesPersonId, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'SalesPersonName', CONVERT(NVARCHAR(MAX), d.SalesPersonName), CONVERT(NVARCHAR(MAX), i.SalesPersonName)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.SalesPersonName, '') <> ISNULL(i.SalesPersonName, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'RegionId', CONVERT(NVARCHAR(MAX), d.RegionId), CONVERT(NVARCHAR(MAX), i.RegionId)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.RegionId, '') <> ISNULL(i.RegionId, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'RegionName', CONVERT(NVARCHAR(MAX), d.RegionName), CONVERT(NVARCHAR(MAX), i.RegionName)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.RegionName, '') <> ISNULL(i.RegionName, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CreditDays', CONVERT(NVARCHAR(MAX), d.CreditDays), CONVERT(NVARCHAR(MAX), i.CreditDays)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CreditDays, '') <> ISNULL(i.CreditDays, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'BaseTaxable', CONVERT(NVARCHAR(MAX), d.BaseTaxable), CONVERT(NVARCHAR(MAX), i.BaseTaxable)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.BaseTaxable, '') <> ISNULL(i.BaseTaxable, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Base0', CONVERT(NVARCHAR(MAX), d.Base0), CONVERT(NVARCHAR(MAX), i.Base0)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Base0, '') <> ISNULL(i.Base0, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TaxRate', CONVERT(NVARCHAR(MAX), d.TaxRate), CONVERT(NVARCHAR(MAX), i.TaxRate)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TaxRate, '') <> ISNULL(i.TaxRate, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TotalTaxes', CONVERT(NVARCHAR(MAX), d.TotalTaxes), CONVERT(NVARCHAR(MAX), i.TotalTaxes)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TotalTaxes, '') <> ISNULL(i.TotalTaxes, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'CurrencyCode', CONVERT(NVARCHAR(MAX), d.CurrencyCode), CONVERT(NVARCHAR(MAX), i.CurrencyCode)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.CurrencyCode, '') <> ISNULL(i.CurrencyCode, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'ControlNumber', CONVERT(NVARCHAR(MAX), d.ControlNumber), CONVERT(NVARCHAR(MAX), i.ControlNumber)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.ControlNumber, '') <> ISNULL(i.ControlNumber, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'OrdersTable',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  -- Asumimos una sola fila modificada
END
GO
ALTER TABLE [dbo].[OrdersTable] ENABLE TRIGGER [trg_OrdersTable_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTable_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[OrdersTable] ENABLE TRIGGER [trg_OrdersTable_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTotals_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersTotals_AuditLog_Insert]
ON [dbo].[OrdersTotals]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'OrdersTotals',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[OrdersTotals] ENABLE TRIGGER [trg_OrdersTotals_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTotals_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersTotals_AuditLog_Update]
ON [dbo].[OrdersTotals]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'OrderNumber', CONVERT(NVARCHAR(MAX), d.OrderNumber), CONVERT(NVARCHAR(MAX), i.OrderNumber)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.OrderNumber, '') <> ISNULL(i.OrderNumber, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TotalKgs', CONVERT(NVARCHAR(MAX), d.TotalKgs), CONVERT(NVARCHAR(MAX), i.TotalKgs)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TotalKgs, '') <> ISNULL(i.TotalKgs, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Subtotal', CONVERT(NVARCHAR(MAX), d.Subtotal), CONVERT(NVARCHAR(MAX), i.Subtotal)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Subtotal, '') <> ISNULL(i.Subtotal, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'DiscPrice', CONVERT(NVARCHAR(MAX), d.DiscPrice), CONVERT(NVARCHAR(MAX), i.DiscPrice)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.DiscPrice, '') <> ISNULL(i.DiscPrice, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'BaseTaxable', CONVERT(NVARCHAR(MAX), d.BaseTaxable), CONVERT(NVARCHAR(MAX), i.BaseTaxable)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.BaseTaxable, '') <> ISNULL(i.BaseTaxable, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TotalTax', CONVERT(NVARCHAR(MAX), d.TotalTax), CONVERT(NVARCHAR(MAX), i.TotalTax)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TotalTax, '') <> ISNULL(i.TotalTax, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TotalToPay', CONVERT(NVARCHAR(MAX), d.TotalToPay), CONVERT(NVARCHAR(MAX), i.TotalToPay)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TotalToPay, '') <> ISNULL(i.TotalToPay, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Observs', CONVERT(NVARCHAR(MAX), d.Observs), CONVERT(NVARCHAR(MAX), i.Observs)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Observs, '') <> ISNULL(i.Observs, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'OrdersTotals',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  -- Asumimos una sola fila modificada
END
GO
ALTER TABLE [dbo].[OrdersTotals] ENABLE TRIGGER [trg_OrdersTotals_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_OrdersTotals_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_OrdersTotals_UpdateTimestamp]
ON [dbo].[OrdersTotals]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE OrdersTotals
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO
ALTER TABLE [dbo].[OrdersTotals] ENABLE TRIGGER [trg_OrdersTotals_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_TaxTable_AuditLog_Delete]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_TaxTable_AuditLog_Delete]
ON [dbo].[TaxTable]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

    -- Try to get the username from SESSION_CONTEXT first
    SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

    -- If SESSION_CONTEXT is empty or null, default to 'SQL SERVER'
    IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
        SET @UserName = 'SQL SERVER';

    -- Insert into AuditLog for each deleted row
    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT
        'dbo',
        'TaxTable',
        CONVERT(NVARCHAR, d.Id, 100),
        'D',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM deleted d;
END;
GO
ALTER TABLE [dbo].[TaxTable] ENABLE TRIGGER [trg_TaxTable_AuditLog_Delete]
GO
/****** Object:  Trigger [dbo].[trg_TaxTable_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_TaxTable_AuditLog_Insert]
ON [dbo].[TaxTable]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'TaxTable',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[TaxTable] ENABLE TRIGGER [trg_TaxTable_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_TaxTable_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_TaxTable_AuditLog_Update]
ON [dbo].[TaxTable]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Code', CONVERT(NVARCHAR(MAX), d.Code), CONVERT(NVARCHAR(MAX), i.Code)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Code, '') <> ISNULL(i.Code, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Value', CONVERT(NVARCHAR(MAX), d.Value), CONVERT(NVARCHAR(MAX), i.Value)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Value, '') <> ISNULL(i.Value, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'TaxTable',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  -- Asumimos una sola fila modificada
END
GO
ALTER TABLE [dbo].[TaxTable] ENABLE TRIGGER [trg_TaxTable_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_TaxTable_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_TaxTable_UpdateTimestamp]
ON [dbo].[TaxTable]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE TaxTable
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO
ALTER TABLE [dbo].[TaxTable] ENABLE TRIGGER [trg_TaxTable_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_Users_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [trg_Users_UpdateTimestamp]
GO
/****** Object:  Trigger [dbo].[trg_Withholdings_AuditLog_Delete]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Withholdings_AuditLog_Delete]
ON [dbo].[Withholdings]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

    -- Try to get the username from SESSION_CONTEXT first
    SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

    -- If SESSION_CONTEXT is empty or null, default to 'SQL SERVER'
    IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
        SET @UserName = 'SQL SERVER';

    -- Insert into AuditLog for each deleted row
    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT
        'dbo',
        'Withholdings',
        CONVERT(NVARCHAR, d.Id, 100),
        'D',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM deleted d;
END;
GO
ALTER TABLE [dbo].[Withholdings] ENABLE TRIGGER [trg_Withholdings_AuditLog_Delete]
GO
/****** Object:  Trigger [dbo].[trg_Withholdings_AuditLog_Insert]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Withholdings_AuditLog_Insert]
ON [dbo].[Withholdings]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

    INSERT INTO [dbo].[AuditLog] (
        SchemaName,
        TableName,
        RecordId,
        ActionType,
        FieldName,
        OldValue,
        NewValue,
        UserName,
        ApplicationName,
        HostName
    )
    SELECT 
        'dbo',
        'Withholdings',
        CONVERT(NVARCHAR, i.Id, 100),
        'I',
        NULL,
        NULL,
        NULL,
        @UserName,
        APP_NAME(),
        HOST_NAME()
    FROM inserted i;
END
GO
ALTER TABLE [dbo].[Withholdings] ENABLE TRIGGER [trg_Withholdings_AuditLog_Insert]
GO
/****** Object:  Trigger [dbo].[trg_Withholdings_AuditLog_Update]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Withholdings_AuditLog_Update]
ON [dbo].[Withholdings]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserName NVARCHAR(20);

	SET @UserName = CONVERT(NVARCHAR, SESSION_CONTEXT(N'UserName'), 20);

	IF (@UserName IS NULL OR LTRIM(RTRIM(@UserName)) = '')
		SET @UserName = 'SQL SERVER';

	-- Tabla para almacenar diferencias
	DECLARE @AuditChanges TABLE (
		FieldName NVARCHAR(100),
		OldValue NVARCHAR(MAX),
		NewValue NVARCHAR(MAX)
	);

	-- Insertar diferencias detectadas
	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Code', CONVERT(NVARCHAR(MAX), d.Code), CONVERT(NVARCHAR(MAX), i.Code)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Code, '') <> ISNULL(i.Code, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Name', CONVERT(NVARCHAR(MAX), d.[Name]), CONVERT(NVARCHAR(MAX), i.[Name])
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.[Name], '') <> ISNULL(i.[Name], '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Type', CONVERT(NVARCHAR(MAX), d.[Type]), CONVERT(NVARCHAR(MAX), i.[Type])
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.[Type], '') <> ISNULL(i.[Type], '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'ContributorType', CONVERT(NVARCHAR(MAX), d.ContributorType), CONVERT(NVARCHAR(MAX), i.ContributorType)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.ContributorType, '') <> ISNULL(i.ContributorType, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT '[Percent]', CONVERT(NVARCHAR(MAX), d.[Percent]), CONVERT(NVARCHAR(MAX), i.[Percent])
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.[Percent], '') <> ISNULL(i.[Percent], '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'BaseMin', CONVERT(NVARCHAR(MAX), d.BaseMin), CONVERT(NVARCHAR(MAX), i.BaseMin)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.BaseMin, '') <> ISNULL(i.BaseMin, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'Subtrahend', CONVERT(NVARCHAR(MAX), d.Subtrahend), CONVERT(NVARCHAR(MAX), i.Subtrahend)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.Subtrahend, '') <> ISNULL(i.Subtrahend, '');

	INSERT INTO @AuditChanges (FieldName, OldValue, NewValue)
	SELECT 'TaxBasePercent', CONVERT(NVARCHAR(MAX), d.TaxBasePercent), CONVERT(NVARCHAR(MAX), i.TaxBasePercent)
	FROM inserted i
	INNER JOIN deleted d ON i.Id = d.Id
	WHERE ISNULL(d.TaxBasePercent, '') <> ISNULL(i.TaxBasePercent, '');

	-- Insertar en AuditLog
	INSERT INTO [dbo].[AuditLog] (
		SchemaName, TableName, RecordId, ActionType, FieldName, OldValue, NewValue, UserName, ApplicationName, HostName
	)
	SELECT 
		'dbo',
		'Withholdings',
		CONVERT(NVARCHAR, i.Id, 100),
		'U',
		ac.FieldName,
		ac.OldValue,
		ac.NewValue,
		@UserName,
		APP_NAME(),
		HOST_NAME()
	FROM @AuditChanges ac
	CROSS JOIN inserted i;  
END
GO
ALTER TABLE [dbo].[Withholdings] ENABLE TRIGGER [trg_Withholdings_AuditLog_Update]
GO
/****** Object:  Trigger [dbo].[trg_Withholdings_UpdateTimestamp]    Script Date: 18/07/2025 16:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_Withholdings_UpdateTimestamp]
ON [dbo].[Withholdings]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Withholdings
    SET UpdatedAt = GETDATE()
    WHERE Id = (SELECT Id FROM inserted);
END
GO
ALTER TABLE [dbo].[Withholdings] ENABLE TRIGGER [trg_Withholdings_UpdateTimestamp]
GO
USE [master]
GO
ALTER DATABASE [SikaAX_KLKPOS] SET  READ_WRITE 
GO
