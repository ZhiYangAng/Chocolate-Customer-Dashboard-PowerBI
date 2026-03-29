# **Chocolate Customer Dashboard**
Data Pipeline: Excel Power Query (csv) ➜ MySQL Workbench ➜ Power BI Desktop

***Disclaimer: The data is synthetic and designed to simulate real life data analysis for business problem solving***

## **Project Overview**
<p align="justify">
The project analysed customer demographics and products preferences for a global chocolate retailer. The final interactive dashboard provide actionable insights to support data-driven decision-making for marketing stategies and regional growth.
</p>

## **Business Objectives**

* Identify customers' purchase behaviour and demographic trends.
* Analyze top-performing chococolate by using DAX ranking measure.
* Track the potential growth opportunities across global cities based on revenue.

## **Methodology**
Before we straight into the process of creating dashboard, here is the final dashboard preview......

### **Preview of Interactive Dashboard**
<p align="center">
  <img src="media/Dashboard%20Demo.gif" width="900" title="Interactive Power BI Demo">
  <br>
</p>

### **Excel**
The raw data were downloaded from Kaggle and loaded in Power Query via Excel to examine the data quality followed by conducting data preprocessing.
<p align="center">
  <img src="media/excel/1.png" width="900" title="Successful Loaded">
  <br>
</p>

Here is the found data error:
1. The country and city under stores table are not tally. (Assuming that the value in the city correct while country incorrect)
<p align="center">
  <img src="media/excel/2.png" width="900" title="Country_Error">
  <br>
</p>

The process of **preprocessing** applied in the power query are:

#### **Stores**
1. Removed the **country** column. Recreated the **country** column by using custom columns.
    
   ```powerquery
   = Table.AddColumn(#"Filtered Rows", "country_name", each if [city] = "New York" then "USA"
      else if [city]="Melbourne" then "Australia"
      else if [city]="Berlin" then "Germany"
      else if [city]="London" then "UK"
      else if [city]="Paris" then "France"
      else if [city]="Sydney" then "Australia"
      else if [city]="Toronto" then "Canada"
      else "Other")
##### **Calendar**
1. Added **Month Name**, **Day Name** and **Week of Year**
2. Modify the **date** format from _"yyyy-mm-dd"_ into _"mm/dd/yyyy"_ (SQL date format)

#### **Customers**
1. Create the **loyalty_members?** by using custom columns to convert binary into "Yes" or "No". Then removed **loyalty_member**.
    
   ```powerquery
    = Table.AddColumn(#"Changed Type", "loyalty_member?",
       each if [loyalty_member]=1 then "Yes"
       else "No")
2. Create **age_category** column by using custom columns for categorized **age** into four different categories.

   ```powerquery
    = Table.AddColumn(#"Removed Columns", "age_category", each if [age] <= 25 then "1. Young Adult (18-25)"
      else if [age] <= 40 then "2. Adult (26-40)"
      else if [age] <= 60 then "3. Middle-Aged (41-60)"
      else "4. Senior Citizen (61+)")
3. Modify the **join_date** format from _"yyyy-mm-dd_" into _"mm/dd/yyyy"_ (SQL date format)

#### **Products**
1. Create full_product_name column to combine product_name, brand, category and weight_g into the format:

    <p align="center">
      "brand" "product_name" ("category") - "weighted_g"g
    </p>

    ```powerquery
    = Table.AddColumn(#"Filtered Rows", "full_product_name", each [brand]&" "& [product_name]&" ("&[category]&") - "& Text.From([weight_g]) & "g")"
    
#### **Sales**
1. Modify the **order_date** format from _"yyyy-mm-dd_" into _"mm/dd/yyyy"_ (SQL date format)

After preprocessing were done, every table or sheet was then converted to .csv file. These csv file will be imported into MySQL 8.0 Workbence CE for further data analysis.

### **MySQL**

### **Power BI**

## **Buisness Insights**


## **Directories**
* [***/Dashboard***](./Dashboard/): Contains the final dashboard .pbix file.
* [***/SQL Query***](./SQL%20Query/): Includes .sql scripts for table creation and data analysis.
* [***/media***](./media/): Contains screenshots and the interactive GIF demo.
* [***/data***](./data/): Contains [***cleaned data***](./data/cleaneddata/) and [***Excel Power Query***](./data/Chocolate%20Power%20Query.xlsx) that merge from [***raw data***](./data/rawdata/). 
* **LICENSE**: MIT License for open-source transparency.
