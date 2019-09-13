```USE [DevSkillExample]
GO
/****** Object:  StoredProcedure [dbo].[DynamicSearch_assignmant1]    Script Date: 9/13/2019 11:03:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[DynamicSearch_assignmant1]
	@PageIndex					int,
	@PageSize					int, 
	@OrderBy					nvarchar(50),
	@Id							int = NULL,
	@Name						nvarchar(100) = NULL,
	@Price						decimal(18,2) = NULL,
	@MaxPrice					decimal(18,2) = NULL,
	@MinPrice					decimal(18,2) = NULL,
	@Description				nvarchar(MAX) = NULL,
	@ImageURL					nvarchar(100) = NULL,
	@Category					nvarchar(100) = NULL,
	@Rating						decimal(18,2) = NULL,
	@Weight						decimal(18,2) = NULL,
	@IsActive					bit			  = NULL,
	@Width						int			  = NULL,
	@Height						int			  = NULL AS

BEGIN
 
DECLARE @sql nvarchar(MAX),
@paramlist nvarchar(MAX),
@NameSearch nvarchar(4000)	
 

	SET @sql =' select * from Product WHERE 1=1 '

	IF @Id IS NOT NULL 
		SET @sql += ' AND Id = @Id'

	IF @Name IS NOT NULL 
		SET @sql += ' AND Name LIKE ''%'+@Name+'%'' '

	IF @price IS NOT NULL
		SET @sql += ' AND Price = @Price'

	IF @Description IS NOT NULL
		SET @sql += ' AND Description LIKE ''%'+@Description+'%'' '

	IF @ImageURL IS NOT NULL
		SET @sql += ' AND ImageURL = @ImageURL'
	IF @Category IS NOT NULL
		SET @sql += ' AND Category = @Category'
 
	SET @sql += ' ORDER by '+@OrderBy+' ASC OFFSET @PageSize * (@PageIndex - 1) 
				  ROWS FETCH NEXT @PageSize ROWS ONLY'
 print @sql

	SELECT @paramlist = 
					'@Id			int,				                   
                     @Name			nvarchar(200),	                   
                     @Price			money,	
					 @MaxPrice		money,			                   
                     @MinPrice		money,			                                      
                     @Description	nvarchar(200),	                   
                     @ImageUrl		nvarchar(200),	                   
                     @Category		nvarchar(200),	                   
                     @Rating		decimal,			                   
                     @Weight		decimal,			                   
                     @IsActive		bit,				                   
                     @Width			nvarchar(200),	                   
                     @Height		nvarchar(200),
					 @PageIndex		int,
					 @PageSize		int'	

 
	exec sp_executesql @sql , @paramlist , @Id ,
		@Name , 
		@Price ,
		@MaxPrice ,
		@MinPrice ,
		@Description , 
		@ImageURL , 
		@Category,
		@Rating ,
		@Weight,
		@IsActive,
		@Width,
		@Height,
		@PageIndex,
		@PageSize
 
END
// ASIGNMENT-2
USE [DevSkillExample]
GO
/****** Object:  StoredProcedure [dbo].[DynamicSearch_assignmant2]    Script Date: 9/13/2019 11:03:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
ALTER PROCEDURE [dbo].[DynamicSearch_assignmant2]
	@PageIndex					int,
	@PageSize					int , 
	@OrderBy					nvarchar(50),
	@SearchText					nvarchar(250)
 
AS
BEGIN
	Declare @SQL nvarchar(4000)
	Declare @ParamList nvarchar(MAX) 
 
	SET @SQL = 'SELECT * FROM Product 
		WHERE Name LIKE ''%'+@SearchText+'%''
		OR Description LIKE ''%'+@SearchText+'%''
		OR ImageURL LIKE ''%'+@SearchText+'%''
		OR Category LIKE ''%'+@SearchText+'%''
		ORDER BY '+@OrderBy+' ASC OFFSET @PageSize * (@PageIndex - 1) 
		ROWS FETCH NEXT @PageSize ROWS ONLY' 
 
	SELECT @ParamList = 
						'@SearchText	nvarchar(250),
						 @PageIndex		int,
						 @PageSize		int' 
 
	exec sp_executesql  @SQL , @ParamList ,
						@SearchText , 
						@PageIndex,
						@PageSize
 
END
