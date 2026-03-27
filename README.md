This project provides a comprehensive end-to-end analytics solution for a global logistics provider. By integrating sensor data, traffic reports, and financial metrics, the dashboard enables stakeholders to identify bottlenecks, mitigate environmental risks, and protect high-value revenue.

# 1. Business Problem
The logistics operation was struggling with 350 recorded delays across 1,000 total trips, leading to an average critical wait time of 52.10 minutes—significantly exceeding the target threshold of 45 minutes. Without a unified reporting system, the management could not identify whether delays were caused by mechanical failures, traffic, or environmental factors. This lack of visibility directly threatened $299K in annual revenue and led to a "Restock Needed" status for 26.1% of inventory segments.

# 2. Methodology
I implemented a robust data lifecycle to move from raw data to actionable insights:

1. Data Engineering (SQL): Developed a suite of SQL Views in SSMS (e.g., vw_StandardizedData, vw_AssetKPIs) to clean, standardize timestamps, and aggregate performance metrics before ingestion.

2. Star Schema Modeling: Architected a high-performance data model in Power BI, connecting a central Fact table (vw_StandardizedData) to multiple dimension tables for Assets, Delays, and a custom Calendar table to support time-intelligence.

3. Diagnostic Analytics: Integrated a Decomposition Tree for root cause analysis, allowing users to drill down from total delays into specific shifts, traffic conditions, and asset IDs.

4. UX-Driven Design: Developed a multi-page dashboard with custom tooltip pages and conditional formatting to highlight critical KPIs like Inventory Coverage (1.5) and Asset Utilization (80.49%).

# 2. Skills Used

- SQL Server: View creation, data standardization, and complex aggregations.

- Power BI Desktop: Advanced data visualization, Report Page Tooltips, and Decomposition Trees.

- DAX (Data Analysis Expressions): Calculated measures for running totals, Target vs. Actual variances, and conditional alerts.

- Data Modeling: Star Schema architecture, relationship management, and cross-filter optimization.

- Business Intelligence: KPI development, trend analysis, and root cause diagnostics.

# 4. Results

- Root Cause Identification: Identified that Weather (267 incidents) is the leading driver of delays, followed closely by Traffic (236) and Mechanical Failures (234).

- High-Value Customer Protection: Uncovered that customers with a purchase frequency of 9 generate the highest revenue ($34K), yet face significant delivery friction.

- Operational Benchmarking: Established that "Truck_3" and "Truck_7" are the most critical liabilities, together accounting for nearly 10% of all critical delays.

- Inventory Optimization: Successfully mapped the "Sufficient Stock" (73.9%) vs. "Restock Needed" (26.1%) segments to prevent future supply chain gaps.

# 5. Business Recommendations

1. Asset Retirement/Overhaul: Immediately pull Truck_3 and Truck_7 from the fleet for mechanical inspection, as they lead the "Assets Causing Most Critical Delays" list.

2. Weather-Resilient Planning: Since Weather is the #1 delay factor, implement a predictive "Weather Delay" buffer for routes scheduled during high-humidity windows (currently averaging 65%).

3. Revenue Safeguarding: Prioritize shipments for the "Frequency 9" group. These customers provide peak revenue but are currently suffering from inconsistent delivery performance.

4. Shift Realignment: While Day Shifts generate higher total utilization, Night Shifts show a higher revenue-per-trip efficiency. Optimizing Night Shift staffing could close the $14.89 gap in average customer spend targets.
