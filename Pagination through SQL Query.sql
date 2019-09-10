USE [DevSkillExample]
GO
/****** Object:  StoredProcedure [dbo].[usp_paging]    Script Date: 9/11/2019 12:23:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_paging]
	@PageNumber INT= 5, 
	@PageSize   INT= 6,
	@id			int = 0
AS 
BEGIN
	WITH Product_Page_IndexSize 
		 AS (SELECT *,
					Row_number() OVER(ORDER BY Id) AS  IndexRow
			 FROM Product)
			 
			 SELECT	*
			FROM	Product_Page_IndexSize WHERE   IndexRow BETWEEN (@PageNumber - 1 ) * @PageSize + 1 AND
	@PageNumber * @PageSize and 1=1  or Id = @id
End
