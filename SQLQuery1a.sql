USE [SmartLogisticsDB]
GO

/****** Object:  View [dbo].[vw_HighPerformingAssets]    Script Date: 06-03-2026 12:45:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vw_HighPerformingAssets] AS
SELECT Asset_ID, AVG(Asset_Utilization) AS Avg_Utilization
FROM vw_StandardizedData
GROUP BY Asset_ID
HAVING AVG(Asset_Utilization) > 
		(SELECT AVG(Asset_Utilization) 
		FROM vw_StandardizedData);
GO


