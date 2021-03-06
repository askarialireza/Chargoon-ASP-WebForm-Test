CREATE DATABASE [ChargoonTestDB]
GO

USE [ChargoonTestDB]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[NationalCode] [nvarchar](10) NOT NULL,
	[BirthDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Employees] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Employments]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employments](
	[EmployeeId] [int] NOT NULL,
	[EmploymentTypeId] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Employments] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC,
	[EmploymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[Employments] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[EmploymentTypes]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmploymentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_EmploymentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER AUTHORIZATION ON [dbo].[EmploymentTypes] TO  SCHEMA OWNER 
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employees_NationalCode]    Script Date: 03/27/2020 03:16:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employees_NationalCode] ON [dbo].[Employees]
(
	[NationalCode] ASC
)
WHERE ([NationalCode] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employments_EmployeeId]    Script Date: 03/27/2020 03:16:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employments_EmployeeId] ON [dbo].[Employments]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employments_EmploymentTypeId]    Script Date: 03/27/2020 03:16:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_Employments_EmploymentTypeId] ON [dbo].[Employments]
(
	[EmploymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmploymentTypes_Name]    Script Date: 03/27/2020 03:16:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EmploymentTypes_Name] ON [dbo].[EmploymentTypes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employments]  WITH CHECK ADD  CONSTRAINT [FK_Employments_Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Employments] CHECK CONSTRAINT [FK_Employments_Employees_EmployeeId]
GO
ALTER TABLE [dbo].[Employments]  WITH CHECK ADD  CONSTRAINT [FK_Employments_EmploymentTypes_EmploymentTypeId] FOREIGN KEY([EmploymentTypeId])
REFERENCES [dbo].[EmploymentTypes] ([Id])
GO
ALTER TABLE [dbo].[Employments] CHECK CONSTRAINT [FK_Employments_EmploymentTypes_EmploymentTypeId]
GO
/****** Object:  StoredProcedure [dbo].[CreateEmployee]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateEmployee]
	-- Add the parameters for the stored procedure here
	@EmploymentTypeId int,
	@FirstName nvarchar(max),
	@LastName nvarchar(max),
	@NationalCode nvarchar(10),
	@BirthDate datetime,
	@EmploymentDate datetime,
	@ResultCode int OUTPUT
AS
BEGIN
	-- CODES :
	-- 0 -> SUCCESS
	-- 1 -> NATIONAL CODE EXIST
	-- 2 -> EMPLOYMENT DATE NOT VALID 
	-- 3 -> SQL ERROR

	SET NOCOUNT ON;

	DECLARE @EmployeeId int;

	IF( SELECT COUNT(*) FROM Employees WHERE NationalCode = @NationalCode) != 0 
		BEGIN
			SET @ResultCode = 1;
			PRINT @ResultCode
			RETURN @ResultCode
		END
	
	IF ( CAST(@EmploymentDate AS date) <= CAST(@BirthDate AS date) )
		BEGIN
			SET @ResultCode = 2;
			PRINT @ResultCode
			RETURN @ResultCode
		END		

	INSERT INTO [dbo].[Employees] ( [FirstName], [LastName], [NationalCode], [BirthDate] )
	VALUES ( @FirstName, @LastName, @NationalCode, @BirthDate );

	SET @EmployeeId = SCOPE_IDENTITY();

	INSERT INTO Employments ( [EmployeeId], [EmploymentTypeId], [Date] )
	Values ( @EmployeeId, @EmploymentTypeId, @EmploymentDate );

	IF @@ERROR <> 0   
		BEGIN 
			SET @ResultCode = 3;
			PRINT @ResultCode
			RETURN @ResultCode
		END  
	ELSE  
		BEGIN  
			SET @ResultCode = 0;
			PRINT @ResultCode
			RETURN @ResultCode
		END  
END
GO
ALTER AUTHORIZATION ON [dbo].[CreateEmployee] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[CreateEmploymentType]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateEmploymentType]
	@Name nvarchar(max),
	@IsActive bit,
	@ResultCode int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF( SELECT COUNT(*) FROM EmploymentTypes WHERE Name = @Name) != 0 
		BEGIN
			SET @ResultCode = 1;
			PRINT @ResultCode
			RETURN @ResultCode
		END
	ELSE
		BEGIN
			INSERT INTO [dbo].[EmploymentTypes] ( [Name], [IsActive] )
			VALUES ( @Name, @IsActive );

			SET @ResultCode = 0;
			PRINT @ResultCode
			RETURN @ResultCode
		END

END
GO
ALTER AUTHORIZATION ON [dbo].[CreateEmploymentType] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmployee]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE
	FROM Employees
	WHERE Id = @Id
END
GO
ALTER AUTHORIZATION ON [dbo].[DeleteEmployee] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmploymentType]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmploymentType]
	@Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE
	FROM EmploymentTypes
	WHERE Id = @Id
END
GO
ALTER AUTHORIZATION ON [dbo].[DeleteEmploymentType] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetActiveEmploymentTypes]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetActiveEmploymentTypes]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT *
	FROM EmploymentTypes
	Where IsActive = 1
	ORDER BY Id
END
GO
ALTER AUTHORIZATION ON [dbo].[GetActiveEmploymentTypes] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeById]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeeById]
	-- Add the parameters for the stored procedure here
	@EmployeeId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- 0 -> Employee Not Exist
	-- 1 -> Employee is Exist

    -- Insert statements for procedure here
	IF(	SELECT COUNT(*) FROM Employees WHERE Id = @EmployeeId) = 0
		BEGIN
			RETURN 0
		END
	ELSE
		BEGIN
			RETURN 1
		END
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmployeeById] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeByNationalCode]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeeByNationalCode]
	-- Add the parameters for the stored procedure here
	@NationalCode nvarchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM Employees
	WHERE NationalCode = @NationalCode
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmployeeByNationalCode] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployees]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>

	SELECT * From Employees
	ORDER BY LastName ASC
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmployees] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeesWithFullDetails]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeesWithFullDetails]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Employee.Id, 
	Employee.FirstName,  
	Employee.LastName ,  
	Employee.NationalCode ,  
	Employee.BirthDate,
	EmploymentType.Name AS EmploymentType,
	Employment.Date AS EmploymentDate
	FROM Employees Employee
	INNER JOIN Employments Employment ON Employee.Id = Employment.EmployeeId
	INNER JOIN EmploymentTypes EmploymentType ON Employment.EmploymentTypeId = EmploymentType.Id
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmployeesWithFullDetails] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeWithFullDetails]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeeWithFullDetails]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN

	IF ( SELECT COUNT(*) FROM Employees WHERE Id = @Id ) != 0
		BEGIN
			SELECT Employee.Id, 
			Employee.FirstName,  
			Employee.LastName ,  
			Employee.NationalCode ,  
			Employee.BirthDate,
			EmploymentType.Name AS EmploymentType,
			Employment.Date AS EmploymentDate
			FROM Employees Employee
			INNER JOIN Employments Employment ON Employee.Id = Employment.EmployeeId
			INNER JOIN EmploymentTypes EmploymentType ON Employment.EmploymentTypeId = EmploymentType.Id
			WHERE Employee.Id = @Id
		END
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmployeeWithFullDetails] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmploymentTypeIdByName]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmploymentTypeIdByName] 
	-- Add the parameters for the stored procedure here
	@Name nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Et.Id
	From EmploymentTypes Et
	Where Et.Name = @Name
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmploymentTypeIdByName] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmploymentTypeNameById]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmploymentTypeNameById]
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT Et.Name
	From EmploymentTypes Et
	Where Et.Id = @Id

END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmploymentTypeNameById] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GetEmploymentTypes]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmploymentTypes] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM EmploymentTypes
	ORDER BY Id
END
GO
ALTER AUTHORIZATION ON [dbo].[GetEmploymentTypes] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmployee]
	-- Add the parameters for the stored procedure here
	@Id int,
	@EmploymentTypeId int,
	@FirstName nvarchar(max),
	@LastName nvarchar(max),
	@NationalCode nvarchar(10),
	@BirthDate datetime,
	@EmploymentDate datetime,
	@ResultCode int OUTPUT
AS
BEGIN
	-- CODES :
	-- 0 -> SUCCESS
	-- 1 -> EMPLOYMENT DATE NOT VALID 
	-- 2 -> SQL ERROR

	SET NOCOUNT ON;
	
	IF ( CAST(@EmploymentDate AS date) <= CAST(@BirthDate AS date) )
		BEGIN
			SET @ResultCode = 1;
			PRINT @ResultCode
			RETURN @ResultCode
		END	
		
	UPDATE Employees
	SET FirstName = @FirstName, LastName = @LastName, NationalCode = @NationalCode, BirthDate = @BirthDate
	WHERE Id = @Id
	
	UPDATE Employments
	SET EmploymentTypeId = @EmploymentTypeId, Date = @EmploymentDate
	WHERE EmployeeId = @Id;

	IF @@ERROR <> 0   
		BEGIN 
			SET @ResultCode = 2;
			PRINT @ResultCode
			RETURN @ResultCode
		END  
	ELSE  
		BEGIN  
			SET @ResultCode = 0;
			PRINT @ResultCode
			RETURN @ResultCode
		END  
END
GO
ALTER AUTHORIZATION ON [dbo].[UpdateEmployee] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmploymentType]    Script Date: 03/27/2020 03:16:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmploymentType]
	-- Add the parameters for the stored procedure here
	@Id int,
	@Name nvarchar(max),
	@IsActive bit,
	@ResultCode int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE EmploymentTypes
	SET Name = @Name , IsActive = @IsActive
	WHERE Id = @Id

	IF @@ERROR <> 0   
		BEGIN 
			SET @ResultCode = 2;
			PRINT @ResultCode
			RETURN @ResultCode
		END  
	ELSE  
		BEGIN  
			SET @ResultCode = 0;
			PRINT @ResultCode
			RETURN @ResultCode
		END 

END
GO
ALTER AUTHORIZATION ON [dbo].[UpdateEmploymentType] TO  SCHEMA OWNER 
GO
