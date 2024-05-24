# A DATA TRANSFORMATION PROJECT
> Hi, this is my second project for my DE course, where I'll be convert raw data into a more accessible format with dbt and Google BigQuery for SQL queries!

## Table of Contents
* [Project Goal](#project-goal)
* [Task](#task)
* [Technologies Used](#technologies-used)
* [How I Did It](#how-i-did-it)
* [Improvements](#improvements)

## Project Goal
- "Our goal is to convert raw data into a more accessible format for extracting insights. dbt, an open-source tool, will help us effectively transform data in our warehouses."
- "We'll use SQL for data management and Google BigQuery, a fully-managed, serverless data warehouse, for super-fast SQL queries."

## Technologies Used
- DBT
- Google BigQuery
- Visual Studio Code for query statements

## Task
- Use SQL, data source from AdventureWorks2019 and dbt to build this Sales model in Bigquery datamart
> ![adventureWorks_Sales](https://github.com/NhatTan1232/data-transforming-models/assets/126853176/349add67-b196-457d-b59c-2153c21dc036)
> ![Uploading adventureWorks_Sales.png…]()

## How I Did It
- Research the AdventureWorks2019 dataset.
- In the staging layer, I built all the nescessary models where I transform, handle Null value, handle data type, etc.
- Then using the views I built in the staging layer, I built the dim tables and the fact table.

## Improvements
> My code is still not fully optimal yet, so I'll try to regularly update!
> Thank you!
