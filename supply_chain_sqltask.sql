CREATE TABLE business_operations (
    Warehouse_ID VARCHAR(50),
    Location VARCHAR(100),
    Current_Stock NUMERIC,
    Demand_Forecast NUMERIC,
    Lead_Time_Days NUMERIC,
    Shipping_Time_Days NUMERIC,
    Stockout_Risk NUMERIC,
    Operational_Cost NUMERIC,
    Supplier_ID VARCHAR(50),
    Product_Category VARCHAR(100),
    Monthly_Sales NUMERIC,
    Order_Processing_Time NUMERIC,
    Return_Rate NUMERIC,
    Customer_Rating NUMERIC,
    Warehouse_Capacity NUMERIC,
    Storage_Cost NUMERIC,
    Transportation_Cost NUMERIC,
    Backorder_Quantity NUMERIC,
    Damaged_Goods NUMERIC,
    Employee_Count NUMERIC,
    Inventory_Turnover NUMERIC,
    Stock_Utilization NUMERIC,
    Delivery_Efficiency NUMERIC,
    Total_Cost NUMERIC,
    Estimated_Profit NUMERIC,
    Demand_Gap NUMERIC,
    Risk_Score NUMERIC,
    Sales_Efficiency NUMERIC
); 

SELECT *
FROM business_operations
LIMIT 10;

/*01 Top delayed warehouses */

SELECT
    Warehouse_ID,
    AVG(Shipping_Time_Days) AS Avg_Shipping_Time,
    COUNT(*) AS Total_Records
FROM business_operations
GROUP BY Warehouse_ID
ORDER BY Avg_Shipping_Time DESC
LIMIT 10;

/*Insight
Warehouses with higher average shipping times are contributing more to delivery delays.
Recommendation
Investigate transportation routes and operational bottlenecks in these warehouses.
can try keeping more focus on these warehouses by providing high performace delivery persons to decrease delivery time of orders
these warehouses and increase the performance of warehouse */

/*02 High Stockout Risk Locations */

SELECT
    Location,
    AVG(Current_Stock) AS Avg_Stock,
    AVG(Demand_Forecast) AS Avg_Demand,
    AVG(Stockout_Risk) AS Avg_Risk
FROM business_operations
GROUP BY Location
ORDER BY Avg_Risk DESC;

/*Insight: 
Houston has the highest stockout risk (16.27) with demand significantly exceeding available stock, indicating a strong likelihood of inventory shortages.
Recommendation:
Increase inventory replenishment and maintain higher safety stock levels in high-risk locations, especially Houston and New York*/

/*03 Product-wise Sales Performance */

SELECT
    Product_Category,
    SUM(Monthly_Sales) AS Total_Sales,
    AVG(Customer_Rating) AS Avg_Rating,
    AVG(Sales_Efficiency) AS Avg_Sales_Efficiency
FROM business_operations
GROUP BY Product_Category
ORDER BY Total_Sales DESC;

/*Insight: 
Apparel generated the highest total sales (564,991), while Electronics achieved the highest average customer rating (3.21), indicating strong customer satisfaction.
Recommendation:
Continue investing in Apparel due to its strong sales performance and analyze Electronics strategies to improve customer satisfaction and sales across other product categories.*/

/*04 Cost vs Profit Analysis */

SELECT
    Warehouse_ID,
    SUM(Total_Cost) AS Total_Cost,
    SUM(Estimated_Profit) AS Total_Profit
FROM business_operations
GROUP BY Warehouse_ID
ORDER BY Total_Profit DESC;

/*Insight: 
Warehouse WH156 recorded the lowest loss (-28,877), while WH033 recorded the highest loss (-434,236), showing large variations in warehouse profitability.
Recommendation:
Focus on reducing operational costs and improving efficiency in warehouses with high losses while adopting best practices from better-performing warehouses. */

/*05 Demand vs Stock Comparison */

SELECT
    Product_Category,
    SUM(Demand_Forecast) AS Total_Demand,
    SUM(Current_Stock) AS Total_Stock
FROM business_operations
GROUP BY Product_Category;

/*
Insight:
All product categories have demand higher than available stock, with Apparel showing the highest demand (320,878) and Groceries showing the largest demand-stock gap (17,409 units).
Recommendation:
Increase inventory levels for high-demand categories, especially Groceries and Apparel, to reduce the risk of stock shortages and improve order fulfillment. */