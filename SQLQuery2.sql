ALTER VIEW vw_HighPerformingAssets AS
SELECT 
    Asset_ID,
    AVG(Asset_Utilization) AS Avg_Utilization
FROM vw_StandardizedData
GROUP BY Asset_ID
HAVING AVG(Asset_Utilization) >
(
    SELECT AVG(Asset_Utilization) 
    FROM vw_StandardizedData
);
