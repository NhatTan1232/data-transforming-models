WITH fact_sales__add_detail_source AS (
    SELECT * 
    FROM `my-second-project-422312.my_dataset_yayy_stg.stg_dim_orderdetail`
)

,fact_sales__add_header_rename AS (
    SELECT 
        det.sales_order_id AS sales_order_key
        ,product_id AS product_key
        ,customer_id AS customer_key
        ,sales_territory_id AS sales_territory_key
        ,sales_person_id AS sales_person_key
        ,order_date AS order_date_key
        ,order_status AS sales_order_status
        ,bill_to_address_id AS bill_to_address_key
        ,ship_to_address_id AS ship_to_address_key
        ,ship_method_id AS ship_method_key
        ,order_quantity
        ,unit_price
        ,unit_price_discount
        ,tax_amount
        ,unit_price * (1 - unit_price_discount) * order_quantity AS gross_amount
        ,sub_total
        ,total_due
    FROM fact_sales__add_detail_source det
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_orderheader` hea
    ON det.sales_order_id = hea.sales_order_id
)

SELECT *
FROM fact_sales__add_header_rename