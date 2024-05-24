with stg_order_header__source as (
    SELECT * 
    FROM `adventureworks2019.Sales.SalesOrderHeader`
)

,stg_order_header__rename as (
    SELECT
        SalesOrderID as sales_order_id
        ,OrderDate as order_date
        ,Status as order_status
        ,CustomerID as customer_id
        ,SalesPersonID as sales_person_id
        ,TerritoryID as sales_territory_id
        ,BillToAddressID as bill_to_address_id
        ,ShipToAddressID as ship_to_address_id
        ,ShipMethodID as ship_method_id
        ,SubTotal as sub_total
        ,TaxAmt as tax_amount
        ,TotalDue as total_due
    FROM stg_order_header__source
)

,stg_order_header__null_sales_person as (
    SELECT
        sales_order_id
        ,order_date
        ,order_status
        ,customer_id
        ,CASE
            WHEN sales_person_id = 'NULL' THEN '0'
            ELSE sales_person_id
        END AS sales_person_id
        ,sales_territory_id
        ,bill_to_address_id
        ,ship_to_address_id
        ,ship_method_id
        ,sub_total
        ,tax_amount
        ,total_due
    FROM stg_order_header__rename
)

,stg_order_header__cast_type as (
    SELECT
        cast(sales_order_id as int) as sales_order_id
        ,cast(order_date as date) as order_date
        ,cast(order_status as string) as order_status
        ,cast(customer_id as int) as customer_id
        ,cast(sales_person_id as int) as sales_person_id
        ,cast(sales_territory_id as int) as sales_territory_id
        ,cast(bill_to_address_id as int) as bill_to_address_id
        ,cast(ship_to_address_id as int) as ship_to_address_id
        ,cast(ship_method_id as int) as ship_method_id
        ,cast(sub_total as decimal) as sub_total
        ,cast(tax_amount as decimal) as tax_amount
        ,cast(total_due as bigint) as total_due
    FROM stg_order_header__null_sales_person
)

,stg_order_header__set_status as (
    SELECT 
        sales_order_id
        ,order_date
        ,CASE
            WHEN order_status = '1' THEN 'In progress'
            WHEN order_status = '2' THEN 'Approved'
            WHEN order_status = '3' THEN 'Backordered'
            WHEN order_status = '4' THEN 'Rejected'
            WHEN order_status = '5' THEN 'Shipped'
            ELSE 'Cancelled'
        END AS order_status
        ,customer_id
        ,sales_person_id
        ,sales_territory_id
        ,bill_to_address_id
        ,ship_to_address_id
        ,ship_method_id
        ,sub_total
        ,tax_amount
        ,total_due
    FROM stg_order_header__cast_type
)

SELECT *
FROM stg_order_header__set_status