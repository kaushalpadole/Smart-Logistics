-- Handling Nulls

CREATE VIEW vw_CleanedLogistics AS
SELECT * 
FROM smart_logistics_dataset
WHERE Asset_ID IS NOT NULL 
AND Logistics_Delay_Reason IS NOT NULL;
GO

-- Standardizing Status and Date Formatting

CREATE VIEW vw_StandardizedData AS
SELECT * , 
		CAST(Timestamp AS DATE) AS Trip_Date,
		UPPER(Shipment_Status) AS Cleaned_Status
FROM vw_CleanedLogistics;
GO

-- Summary Of Delays

CREATE VIEW vw_DelaySummary AS
SELECT Logistics_Delay_Reason,
		COUNT(*) AS Total_Incidents,
		AVG(Waiting_Time) AS Avg_Wait
FROM vw_StandardizedData
GROUP BY Logistics_Delay_Reason;
GO

-- Key Assets

CREATE VIEW vw_AssetKPIs AS
SELECT Asset_ID, 
       AVG(Asset_Utilization) as Avg_Utilization,
       COUNT(Logistics_Delay) as Total_Delays,
       AVG(Inventory_Level) as Avg_Inventory_Level
FROM vw_StandardizedData
GROUP BY Asset_ID;
GO

-- Ranking Efficiency

CREATE VIEW vw_RankedEfficiencies AS
SELECT Asset_ID, Avg_Utilization,
	   RANK() OVER(ORDER BY Avg_Utilization DESC) AS Rank
FROM vw_AssetKPIs;
GO

-- Running Total of Revenue

CREATE VIEW 
vw_CumulativeRevenue AS
SELECT Trip_Date, Asset_ID, User_Transaction_Amount,
       SUM(User_Transaction_Amount) OVER(PARTITION BY Asset_ID ORDER BY Trip_Date) AS Running_Total
FROM vw_StandardizedData;
GO

-- Moving Average of Temperature

CREATE VIEW vw_TempTrends AS
SELECT Trip_Date, Asset_ID, Temperature,
	   AVG(Temperature) OVER(PARTITION BY Asset_ID ORDER BY Trip_Date
	   ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS Rolling_Temp_Avg
FROM vw_StandardizedData;
GO

-- Percentile waiting rank

CREATE VIEW vw_WaitingPercentile AS
SELECT Asset_ID, Waiting_Time, 
	   (PERCENT_RANK() OVER(ORDER BY Waiting_Time) * 100) AS Wait_Percentile
FROM vw_StandardizedData;
GO

-- Critical delays 

CREATE VIEW vw_CriticalDelays AS
WITH Delay_CTE AS
( SELECT Asset_ID, Waiting_Time, Traffic_Status
FROM vw_StandardizedData
WHERE Waiting_Time >= 45
) 

SELECT Asset_ID, Waiting_Time, Traffic_Status
FROM Delay_CTE 
WHERE Traffic_Status = 'Heavy';
GO

-- Assets with Utilization Above Average

CREATE VIEW vw_HighPerformingAssets AS
SELECT Asset_ID, Asset_Utilization
FROM vw_StandardizedData
WHERE Asset_Utilization > (SELECT AVG(Asset_Utilization) FROM vw_StandardizedData);
GO

-- Analysing Shifts

CREATE VIEW vw_ShiftType AS
SELECT *,
       CASE 
          WHEN DATEPART(HOUR, Timestamp) BETWEEN 6 AND 17 THEN 'Day Shift'
          ELSE 'Night Shift' 
       END as Shift_Type
FROM vw_StandardizedData;
GO

-- Risk Alerts

CREATE VIEW vw_InventoryRisks AS
SELECT Asset_ID, Demand_Forecast, Inventory_Level,
	   CASE WHEN 
			Demand_Forecast > Inventory_Level THEN 'Restock Needed'
			ELSE 'Sufficient Stock'
			END AS Inventory_Risk
FROM vw_StandardizedData;
GO

-- Weather Impact

CREATE VIEW vw_WeatherRisk AS
SELECT Asset_ID, Temperature, Humidity, 
		CASE 
			WHEN Temperature > 28 AND Humidity > 65 THEN 'Extreme Heat'
			WHEN Humidity >  80 THEN 'High Moisture'
			ELSE 'Normal'
		END AS 'Environmental_Condition'
FROM vw_StandardizedData;
GO

-- Customer Loyalty

CREATE VIEW vw_CustomerLoyalty AS
SELECT User_Transaction_Amount,User_Purchase_Frequency, Logistics_Delay
FROM vw_StandardizedData
WHERE User_Purchase_Frequency > 5;
GO

-- Monthly Trend

CREATE VIEW vw_MonthlyTrends AS
SELECT MONTH(Trip_Date) AS Trip_Month,
       COUNT(*) AS Total_Trips,
       SUM(CAST(Logistics_Delay AS INT)) AS Total_Delays
FROM vw_StandardizedData
GROUP BY MONTH(Trip_Date);
GO
