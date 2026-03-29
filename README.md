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
---

## **Methodology**
Before we straight into the process of creating dashboard, here is the final dashboard preview......

### **Preview of Interactive Dashboard**
<p align="center">
  <img src="media/Dashboard%20Demo.gif" width="900" title="Interactive Power BI Demo">
  <br>
</p>

### **Excel**
The raw dataset was sourced from [Kaggle](https://www.kaggle.com/datasets/ssssws/chocolate-sales-dataset-2023-2024/data) and imported into Power Query to perform data quality assessments and initial preprocessing.
<p align="center">
  <img src="media/excel/1.png" width="400" title="Successful Loaded">
  <br>
</p>

Here is the found data error:
1. The country and city values under stores table did not align. (Assuming that the cities mapped to the incorrect country)
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
```
#### **Calendar**
1. Added **Month Name**, **Day Name** and **Week of Year**
2. Modified the **date** format from _"yyyy-mm-dd"_ into _"mm/dd/yyyy"_ (SQL date format)

#### **Customers**
1. Created the **loyalty_members?** by using custom columns to convert binary into "Yes" or "No". Then removed **loyalty_member**.
```powerquery
    = Table.AddColumn(#"Changed Type", "loyalty_member?",
       each if [loyalty_member]=1 then "Yes"
       else "No")
```
2. Created **age_category** column by using custom column for categorized **age** into four different categories.

   ```powerquery
    = Table.AddColumn(#"Removed Columns", "age_category", each if [age] <= 25 then "1. Young Adult (18-25)"
      else if [age] <= 40 then "2. Adult (26-40)"
      else if [age] <= 60 then "3. Middle-Aged (41-60)"
      else "4. Senior Citizen (61+)")
   ```
3. Modified the **join_date** format from _"yyyy-mm-dd_" into _"mm/dd/yyyy"_ (SQL date format)

#### **Products**
1. Created full_product_name column to combine product_name, brand, category and weight_g
      **Format**: > *"brand" "product_name" ("category") - "weighted_g"g*
    ```powerquery
    = Table.AddColumn(#"Filtered Rows", "full_product_name", each [brand]&" "& [product_name]&"
    ("&[category]&") - "& Text.From([weight_g]) & "g")
    ```
#### **Sales**
1. Modified the **order_date** format from _"yyyy-mm-dd_" into _"mm/dd/yyyy"_ (SQL date format)

After preprocessing were done, every table or sheet was then converted to .csv file. These csv file will be imported into MySQL 8.0 Workbench CE for further data analysis.

---

### **MySQL**

<p align="justify">
I created a schema named retail_chocolate_syn in MySQL database. Then, I created tables for importing data from csv files into MySQL under <i>retail_chocolate_syn</i> schema. There is an additional table named country_metadata which functioned as dynamic flag feature which will covered in PowerBI section later. 
</p>

#### Example of creating table using SQL:
```sql
    CREATE TABLE sales (
        order_id VARCHAR(50),
        order_date DATE,
        product_id VARCHAR(50),
        store_id VARCHAR(50),
        customer_id VARCHAR(50),
        quantity INT,
        unit_price DECIMAL(10,2),
        discount DECIMAL(10,2),
        revenue DECIMAL(10,2),
        cost DECIMAL(10,2),
        profit DECIMAL(10,2)
    );
```
The outcome of successful creating table under schema:
<p align="center">
  <img src="media/mysql/1.png" width=400"" title="Done Creating Table">
  <br>
</p>

#### Data Format used in SQL
These are the data format used while creating the table.
| Data Type | Description |
| :--- | :--- |
| DATE | Date format of _"mm/dd/yyyy"_|
| DECIMAL(_P,S_) | Decimal value where _P_ is total number of digits and _S_ is decimal point |
| INT | Whole number |
| VARCHAR(_L_) | Variable Character where _L_ is maximum length of string|

After tables were created, the csv files are required to copy into `C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads` directory for importing data into mySQL database.

#### Example of importing data into the schema using SQL:
```sql
    LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sales.csv"
    INTO TABLE sales
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 ROWS;
```
We can check whether the data were sucessfully imported into mySQL by using
**SQL Query**: > *SELECT * WHEN retail_chocolate_syn.table_name*

The example of success data imported in mySQL:
<p align="center">
  <img src="media/mysql/2.png" width="900" title="Done importing data">
  <br>
</p>

The rest sql code for creating table and importing data were available in [**SQL Query**](./SQL%20Query/) directory.

### **Power BI**

## **Buisness Insights**


## **Directories**
* [***/Dashboard***](./Dashboard/): Contains the final dashboard .pbix file.
* [***/SQL Query***](./SQL%20Query/): Includes .sql scripts for table creation and data analysis.
* [***/media***](./media/): Contains screenshots and the interactive GIF demo.
* [***/data***](./data/): Contains [***cleaned data***](./data/cleaneddata/) and [***Excel Power Query***](./data/Chocolate%20Power%20Query.xlsx) that merge from [***raw data***](./data/rawdata/). 
* **LICENSE**: MIT License for open-source transparency.
