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

The process of preprocessing applied in the power query are:
1. Remove the country column. Recreate the country column by using custom columns.
    The custom column:
   <pre>
   ``` m
   = Table.AddColumn(#"Filtered Rows", "country_name", each if [city] = "New York" then "USA"
      else if [city]="Melbourne" then "Australia"
      else if [city]="Berlin" then "Germany"
      else if [city]="London" then "UK"
      else if [city]="Paris" then "France"
      else if [city]="Sydney" then "Australia"
      else if [city]="Toronto" then "Canada"
      else "Other")
   </pre>
   
3. 
4. 

### **MySQL**

### **Power BI**

## **Buisness Insights**


## **Directories**
* [***/Dashboard***](./Dashboard/): Contains the final dashboard .pbix file.
* [***/SQL Query***](./SQL%20Query/): Includes .sql scripts for table creation and data analysis.
* [***/media***](./media/): Contains screenshots and the interactive GIF demo.
* [***/data***](./data/): Contains [***cleaned data***](./data/cleaneddata/) and [***Excel Power Query***](./data/Chocolate%20Power%20Query.xlsx) that merge from [***raw data***](./data/rawdata/). 
* **LICENSE**: MIT License for open-source transparency.
