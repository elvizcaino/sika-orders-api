USE [SikaAX_KLKPOS]
GO

INSERT [dbo].[Withholdings] ([Code], [Name], [Type], [ContributorType], [Percent], [BaseMin], [Subtrahend], [TaxBasePercent]) VALUES (N'ISLR01', N'Retención de Impuesto Sobre la', N'ISLR', N'Persona Natural', CAST(3.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Withholdings] ([Code], [Name], [Type], [ContributorType], [Percent], [BaseMin], [Subtrahend], [TaxBasePercent]) VALUES (N'ISLR02', N'Retención de Impuesto al Valor', N'ISLR', N'Persona Jurídic', CAST(75.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Withholdings] ([Code], [Name], [Type], [ContributorType], [Percent], [BaseMin], [Subtrahend], [TaxBasePercent]) VALUES (N'ISLR03', N'Retención de Impuesto Sobre la', N'ISLR', N'Ambos', CAST(5.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)))
GO

INSERT [dbo].[Customers] ([CustAccount], [RIF], [FullName], [Phone], [Address], [WithholdingAgent], [WithholdingCode]) VALUES (N'CUST001', N'J-12345678-9', N'Empresa Ejemplo C.A.', N'0212-1234567', N'Av. Principal, Edif. Centro, Piso 5, Ofic. 5A, Caracas', 1, N'ISLR02')
GO
INSERT [dbo].[Customers] ([CustAccount], [RIF], [FullName], [Phone], [Address], [WithholdingAgent], [WithholdingCode]) VALUES (N'CUST002', N'V-98765432-1', N'María Bolívar', N'0414-7654321', N'Calle Las Flores, Casa #10, Baruta, Miranda', 0, N'ISLR01')
GO
INSERT [dbo].[Customers] ([CustAccount], [RIF], [FullName], [Phone], [Address], [WithholdingAgent], [WithholdingCode]) VALUES (N'CUST003', N'G-11223344-5', N'Comercializadora del Sol S.A.', N'0241-8765432', N'Zona Industrial, Galpón 3, Valencia, Carabobo', 1, N'ISLR02')
GO
INSERT [dbo].[Customers] ([CustAccount], [RIF], [FullName], [Phone], [Address], [WithholdingAgent], [WithholdingCode]) VALUES (N'CUST004', N'E-55667788-0', N'Pedro Pérez', N'0426-1122334', N'Urb. El Bosque, Calle 7, Lechería, Anzoátegui', 0, N'ISLR01')
GO
INSERT [dbo].[Customers] ([CustAccount], [RIF], [FullName], [Phone], [Address], [WithholdingAgent], [WithholdingCode]) VALUES (N'CUST005', N'J-33445566-7', N'Servicios Integrales 2000 C.A.', N'0251-9988776', N'Calle Miranda, Centro Comercial, Local 15, Barquisimeto, Lara', 1, N'ISLR03')
GO

INSERT [dbo].[TaxTable] ([Code], [Value]) VALUES (N'iva00ext', CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[TaxTable] ([Code], [Value]) VALUES (N'iva16', CAST(16.00 AS Decimal(18, 2)))
GO

INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00001', N'CUST001', N'J-12345678', N'J-12345678-9', N'Empresa Ejemplo C.A.', N'Av. Principal, Edif. Centro, Piso 5, Ofic. 5A, Caracas', CAST(N'2025-07-15' AS Date), CAST(N'2025-07-29' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'15', CAST(750.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00002', N'CUST002', N'V-98765432', N'V-98765432-1', N'María Bolívar', N'Calle Las Flores, Casa #10, Baruta, Miranda', CAST(N'2025-07-15' AS Date), CAST(N'2025-07-15' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'0', CAST(0.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00003', N'CUST003', N'G-11223344', N'G-11223344-5', N'Comercializadora del Sol S.A.', N'Zona Industrial, Galpón 3, Valencia, Carabobo', CAST(N'2025-07-16' AS Date), CAST(N'2025-07-30' AS Date), N'SP001', N'Juan Pérez', N'REG02', N'Central', N'15', CAST(263.75 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(42.20 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00004', N'CUST004', N'E-55667788', N'E-55667788-0', N'Pedro Pérez', N'Urb. El Bosque, Calle 7, Lechería, Anzoátegui', CAST(N'2025-07-16' AS Date), CAST(N'2025-07-16' AS Date), N'SP001', N'Juan Pérez', N'REG03', N'Oriental', N'0', CAST(0.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00005', N'CUST005', N'J-33445566', N'J-33445566-7', N'Servicios Integrales 2000 C.A.', N'Calle Miranda, Centro Comercial, Local 15, Barquisimeto, Lara', CAST(N'2025-07-17' AS Date), CAST(N'2025-07-31' AS Date), N'SP001', N'Juan Pérez', N'REG04', N'Centro Occidental', N'15', CAST(139.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(22.32 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00006', N'CUST001', N'J-12345678', N'J-12345678-9', N'Empresa Ejemplo C.A.', N'Av. Principal, Edif. Centro, Piso 5, Ofic. 5A, Caracas', CAST(N'2025-07-18' AS Date), CAST(N'2025-08-01' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'15', CAST(361.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(57.76 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00007', N'CUST003', N'G-11223344', N'G-11223344-5', N'Comercializadora del Sol S.A.', N'Zona Industrial, Galpón 3, Valencia, Carabobo', CAST(N'2025-07-18' AS Date), CAST(N'2025-08-01' AS Date), N'SP001', N'Juan Pérez', N'REG02', N'Central', N'15', CAST(180.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(28.80 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00008', N'CUST002', N'V-98765432', N'V-98765432-1', N'María Bolívar', N'Calle Las Flores, Casa #10, Baruta, Miranda', CAST(N'2025-07-18' AS Date), CAST(N'2025-07-18' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'0', CAST(0.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00009', N'CUST004', N'E-55667788', N'E-55667788-0', N'Pedro Pérez', N'Urb. El Bosque, Calle 7, Lechería, Anzoátegui', CAST(N'2025-07-19' AS Date), CAST(N'2025-07-19' AS Date), N'SP001', N'Juan Pérez', N'REG03', N'Oriental', N'0', CAST(0.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00010', N'CUST005', N'J-33445566', N'J-33445566-7', N'Servicios Integrales 2000 C.A.', N'Calle Miranda, Centro Comercial, Local 15, Barquisimeto, Lara', CAST(N'2025-07-19' AS Date), CAST(N'2025-08-02' AS Date), N'SP001', N'Juan Pérez', N'REG04', N'Centro Occidental', N'15', CAST(75.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(12.15 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00011', N'CUST001', N'J-12345678', N'J-12345678-9', N'Empresa Ejemplo C.A.', N'Av. Principal, Edif. Centro, Piso 5, Ofic. 5A, Caracas', CAST(N'2025-07-20' AS Date), CAST(N'2025-08-03' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'15', CAST(137.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(22.08 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00012', N'CUST003', N'G-11223344', N'G-11223344-5', N'Comercializadora del Sol S.A.', N'Zona Industrial, Galpón 3, Valencia, Carabobo', CAST(N'2025-07-20' AS Date), CAST(N'2025-08-03' AS Date), N'SP001', N'Juan Pérez', N'REG02', N'Central', N'15', CAST(75.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00013', N'CUST001', N'J-12345678', N'J-12345678-9', N'Empresa Ejemplo C.A.', N'Av. Principal, Edif. Centro, Piso 5, Ofic. 5A, Caracas', CAST(N'2025-07-21' AS Date), CAST(N'2025-08-04' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'15', CAST(237.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(38.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00014', N'CUST002', N'V-98765432', N'V-98765432-1', N'María Bolívar', N'Calle Las Flores, Casa #10, Baruta, Miranda', CAST(N'2025-07-21' AS Date), CAST(N'2025-07-21' AS Date), N'SP001', N'Juan Pérez', N'REG01', N'Capital', N'0', CAST(0.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO
INSERT [dbo].[OrdersTable] ([OrderNumber], [CustAccount], [CustRIF], [CustIdentification], [CustName], [CustAddress], [IssueDate], [DueDate], [SalesPersonId], [SalesPersonName], [RegionId], [RegionName], [CreditDays], [BaseTaxable], [Base0], [TaxRate], [TotalTaxes], [CurrencyCode], [ControlNumber], [Status]) VALUES (N'ORD00015', N'CUST003', N'G-11223344', N'G-11223344-5', N'Comercializadora del Sol S.A.', N'Zona Industrial, Galpón 3, Valencia, Carabobo', CAST(N'2025-07-22' AS Date), CAST(N'2025-08-05' AS Date), N'SP001', N'Juan Pérez', N'REG02', N'Central', N'15', CAST(100.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.16 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), N'USD', NULL, N'Creado')
GO

INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM001', N'Laptop Dell Inspiron 15', N'ELECT', N'iva16', CAST(750.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM002', N'Monitor Samsung 24 pulgadas', N'ELECT', N'iva16', CAST(180.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM003', N'Teclado Inalámbrico Logitech', N'ELECT', N'iva16', CAST(45.99 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM004', N'Mouse Óptico USB', N'ELECT', N'iva16', CAST(15.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM005', N'Impresora Multifuncional HP', N'ELECT', N'iva16', CAST(220.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM006', N'Resma de Papel Carta Bond', N'OFICINA', N'iva16', CAST(8.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM007', N'Bolígrafos Azules (Caja x12)', N'OFICINA', N'iva16', CAST(6.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM008', N'Cuaderno Espiral Grande', N'OFICINA', N'iva16', CAST(3.20 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM009', N'Archivador Plástico', N'OFICINA', N'iva16', CAST(12.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM010', N'Pintura Acrílica Roja', N'ARTE', N'iva16', CAST(7.99 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM011', N'Set de Pinceles para Acuarela', N'ARTE', N'iva16', CAST(18.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM012', N'Lienzo en Blanco 50x70cm', N'ARTE', N'iva16', CAST(25.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM013', N'Juego de Destornilladores', N'HERRAMIENTAS', N'iva16', CAST(30.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM014', N'Taladro Percutor Bosch', N'HERRAMIENTAS', N'iva16', CAST(150.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM015', N'Caja de Herramientas Plástica', N'HERRAMIENTAS', N'iva16', CAST(40.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM016', N'Libro: Cien Años de Soledad', N'LIBROS', N'iva00ext', CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM017', N'Agua Mineral 1 Litro', N'BEBIDAS', N'iva00ext', CAST(1.50 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM018', N'Pan Integral 500g', N'ALIMENTOS', N'iva00ext', CAST(3.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM019', N'Leche Pasteurizada 1 Litro', N'ALIMENTOS', N'iva00ext', CAST(2.25 AS Decimal(18, 2)))
GO
INSERT [dbo].[Items] ([ItemId], [ItemName], [GroupId], [TaxCode], [PriceUSD]) VALUES (N'ITM020', N'Medicamento Analgésico (sin receta)', N'SALUD', N'iva00ext', CAST(10.00 AS Decimal(18, 2)))
GO

INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00001', 1, N'ITM001', N'Laptop Dell Inspiron 15', N'UND', 1, CAST(2.50 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), CAST(750.00 AS Decimal(18, 2)), CAST(750.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00002', 1, N'ITM016', N'Libro: Cien Años de Soledad', N'UND', 1, CAST(0.50 AS Decimal(18, 2)), CAST(0.50 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00003', 1, N'ITM005', N'Impresora Multifuncional HP', N'UND', 1, CAST(5.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(220.00 AS Decimal(18, 2)), CAST(220.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(35.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00003', 2, N'ITM006', N'Resma de Papel Carta Bond', N'UND', 5, CAST(0.50 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), CAST(8.75 AS Decimal(18, 2)), CAST(43.75 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00004', 1, N'ITM017', N'Agua Mineral 1 Litro', N'UND', 6, CAST(1.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00004', 2, N'ITM018', N'Pan Integral 500g', N'UND', 2, CAST(0.50 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00005', 1, N'ITM009', N'Archivador Plástico', N'UND', 10, CAST(0.80 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(19.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00005', 2, N'ITM007', N'Bolígrafos Azules (Caja x12)', N'UND', 3, CAST(0.20 AS Decimal(18, 2)), CAST(0.60 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), CAST(19.50 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(3.12 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00006', 1, N'ITM002', N'Monitor Samsung 24 pulgadas', N'UND', 2, CAST(3.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), CAST(180.50 AS Decimal(18, 2)), CAST(361.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(57.76 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00007', 1, N'ITM013', N'Juego de Destornilladores', N'UND', 1, CAST(0.70 AS Decimal(18, 2)), CAST(0.70 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(4.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00007', 2, N'ITM014', N'Taladro Percutor Bosch', N'UND', 1, CAST(2.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), CAST(150.00 AS Decimal(18, 2)), CAST(150.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00008', 1, N'ITM019', N'Leche Pasteurizada 1 Litro', N'UND', 4, CAST(1.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)), CAST(2.25 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00009', 1, N'ITM020', N'Medicamento Analgésico (sin receta)', N'UND', 1, CAST(0.10 AS Decimal(18, 2)), CAST(0.10 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00010', 1, N'ITM010', N'Pintura Acrílica Roja', N'UND', 5, CAST(0.30 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), CAST(7.99 AS Decimal(18, 2)), CAST(39.95 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(6.39 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00010', 2, N'ITM011', N'Set de Pinceles para Acuarela', N'UND', 2, CAST(0.10 AS Decimal(18, 2)), CAST(0.20 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)), CAST(36.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(5.76 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00011', 1, N'ITM003', N'Teclado Inalámbrico Logitech', N'UND', 3, CAST(0.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), CAST(45.99 AS Decimal(18, 2)), CAST(137.97 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(22.08 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00012', 1, N'ITM004', N'Mouse Óptico USB', N'UND', 5, CAST(0.20 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00013', 1, N'ITM005', N'Impresora Multifuncional HP', N'UND', 1, CAST(5.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), CAST(220.00 AS Decimal(18, 2)), CAST(220.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(35.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00013', 2, N'ITM006', N'Resma de Papel Carta Bond', N'UND', 2, CAST(0.50 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(8.75 AS Decimal(18, 2)), CAST(17.50 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(2.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00014', 1, N'ITM016', N'Libro: Cien Años de Soledad', N'UND', 2, CAST(0.50 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), N'iva00ext', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00015', 1, N'ITM015', N'Caja de Herramientas Plástica', N'UND', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(6.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO
INSERT [dbo].[OrdersLines] ([OrderNumber], [LineNum], [ItemId], [ItemName], [Unit], [Quantity], [Kgs], [TotalKgs], [UnitPrice], [TotalAmount], [TaxCode], [TaxValue], [TaxAmount], [DiscAmount], [DiscPercent], [Status]) VALUES (N'ORD00015', 2, N'ITM013', N'Juego de Destornilladores', N'UND', 2, CAST(0.70 AS Decimal(18, 2)), CAST(1.40 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), N'iva16', CAST(0.16 AS Decimal(18, 2)), CAST(9.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), N'Creado')
GO

INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00001', CAST(2.50 AS Decimal(18, 2)), CAST(750.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(750.00 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), CAST(870.00 AS Decimal(18, 2)), N'Pago por transferencia')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00002', CAST(0.50 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00003', CAST(7.50 AS Decimal(18, 2)), CAST(263.75 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(263.75 AS Decimal(18, 2)), CAST(42.20 AS Decimal(18, 2)), CAST(305.95 AS Decimal(18, 2)), N'Factura por correo')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00004', CAST(7.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), N'Retiro en tienda')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00005', CAST(8.60 AS Decimal(18, 2)), CAST(139.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(139.50 AS Decimal(18, 2)), CAST(22.32 AS Decimal(18, 2)), CAST(161.82 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00006', CAST(6.00 AS Decimal(18, 2)), CAST(361.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(361.00 AS Decimal(18, 2)), CAST(57.76 AS Decimal(18, 2)), CAST(418.76 AS Decimal(18, 2)), N'Urgente')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00007', CAST(2.70 AS Decimal(18, 2)), CAST(180.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(180.00 AS Decimal(18, 2)), CAST(28.80 AS Decimal(18, 2)), CAST(208.80 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00008', CAST(4.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)), N'Entrega a domicilio')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00009', CAST(0.10 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00010', CAST(1.70 AS Decimal(18, 2)), CAST(75.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(75.95 AS Decimal(18, 2)), CAST(12.15 AS Decimal(18, 2)), CAST(88.10 AS Decimal(18, 2)), N'Pedido especial')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00011', CAST(1.50 AS Decimal(18, 2)), CAST(137.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(137.97 AS Decimal(18, 2)), CAST(22.08 AS Decimal(18, 2)), CAST(160.05 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00012', CAST(1.00 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(87.00 AS Decimal(18, 2)), N'Para nueva oficina')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00013', CAST(6.00 AS Decimal(18, 2)), CAST(237.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(237.50 AS Decimal(18, 2)), CAST(38.00 AS Decimal(18, 2)), CAST(275.50 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00014', CAST(1.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), N'')
GO
INSERT [dbo].[OrdersTotals] ([OrderNumber], [TotalKgs], [Subtotal], [DiscPrice], [BaseTaxable], [TotalTax], [TotalToPay], [Observs]) VALUES (N'ORD00015', CAST(2.90 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(16.00 AS Decimal(18, 2)), CAST(116.00 AS Decimal(18, 2)), N'')
GO

SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [CreatedAt], [UpdatedAt], [UserName], [Password], [Role], [Enabled]) VALUES (1, GETDATE(), GETDATE(), N'adminsika', N'$2b$10$8Y5nwO66BQEwB.33P5qdo.fHicgCCwguil8.wdOd8fjnsoZb8FFBy', N'admin', 1)
GO
INSERT [dbo].[Users] ([Id], [CreatedAt], [UpdatedAt], [UserName], [Password], [Role], [Enabled]) VALUES (2, GETDATE(), GETDATE(), N'elvizcaino', N'$2b$10$26wVCHxbHOQipTq4/g6kGezUHMAQMt9PZrifWMy5CEZScNj2lPTwm', N'admin', 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
