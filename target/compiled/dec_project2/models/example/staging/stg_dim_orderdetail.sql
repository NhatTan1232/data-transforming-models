with stg_order_detail__source as (
    SELECT * 
    FROM `adventureworks2019.Sales.SalesOrderDetail`
)

,stg_order_detail__cast_type_rename as (
    SELECT
        cast(SalesOrderID as int) as sales_order_id
        ,cast(SalesOrderDetailID as int) as sales_order_detail_id
        ,cast(OrderQty as int) as order_quantity
        ,cast(ProductID as int) as product_id
        ,cast(UnitPrice as decimal) as unit_price
        ,cast(UnitPriceDiscount as decimal) as unit_price_discount
    FROM stg_order_detail__source
)

,stg_order_detail__add_undefined as (
    SELECT
        0 as sales_order_id
        ,0 as sales_order_detail_id
        ,0 as order_quantity
        ,0 as product_id
        ,0 as unit_price
        ,0 as unit_price_discount
    UNION ALL
    SELECT *
    FROM stg_order_detail__cast_type_rename
)

SELECT *
FROM stg_order_detail__add_undefined