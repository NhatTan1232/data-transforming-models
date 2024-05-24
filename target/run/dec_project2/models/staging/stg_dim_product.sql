

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_product`
  OPTIONS()
  as with stg_product_source as (
    SELECT * 
    FROM `adventureworks2019.Production.Product`
)

,stg_product_rename as (
    SELECT 
        ProductID as product_id
        ,Name as product_name
        ,ProductNumber as product_number
        ,MakeFlag as make_flag
        ,FinishedGoodsFlag as finish_goods_flag
        ,Color as product_color
        ,SafetyStockLevel as safety_stock_level
        ,StandardCost as standard_cost
        ,ListPrice as list_price
        ,Size as product_size
        ,SizeUnitMeasureCode as size_unit_measure_id
        ,Weight as product_weight
        ,WeightUnitMeasureCode as weight_unit_measure_id
        ,ProductSubcategoryID as product_subcategory_id
        ,ProductModelID as product_model_id
    FROM stg_product_source
)

,stg_product_null_color as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,CASE
            WHEN product_color = 'NULL' THEN 'undefined'
            ELSE product_color
        END AS product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_rename
)

,stg_product_null_size as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,CASE
            WHEN product_size = 'NULL' THEN 'undefined'
            ELSE product_size
        END AS product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_null_color
)

,stg_product_null_weight as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,CASE
            WHEN product_weight = 'NULL' THEN '0'
            ELSE product_weight
        END AS product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_null_size
)

,stg_product_null_size_unit_id as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,CASE
            WHEN size_unit_measure_id = 'NULL' THEN '0'
            ELSE size_unit_measure_id
        END AS size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_null_weight
)

,stg_product_null_weight_unit_id as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,CASE
            WHEN weight_unit_measure_id = 'NULL' THEN '0'
            ELSE weight_unit_measure_id
        END AS weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_null_size_unit_id
)

,stg_product_null_subcategory_id as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,CASE
            WHEN product_subcategory_id = 'NULL' THEN '0'
            ELSE product_subcategory_id
        END AS product_subcategory_id
        ,product_model_id
    FROM stg_product_null_weight_unit_id
)

,stg_product_null_model_id as (
    SELECT 
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,CASE
            WHEN product_model_id = 'NULL' THEN '0'
            ELSE product_model_id
        END AS product_model_id
    FROM stg_product_null_subcategory_id
)

,stg_product_cast_type as (
    SELECT
        cast(product_id as int) as product_id
        ,cast(product_name as string) as product_name
        ,cast(product_number as string) as product_number
        ,cast(make_flag as string) as make_flag
        ,cast(finish_goods_flag as string) as finish_goods_flag
        ,cast(product_color as string) as product_color
        ,cast(safety_stock_level as bigint) as safety_stock_level
        ,cast(standard_cost as decimal) as standard_cost
        ,cast(list_price as decimal) as list_price
        ,cast(product_size as string) as product_size
        ,cast(size_unit_measure_id as string) as size_unit_measure_id
        ,cast(product_weight as decimal) as product_weight
        ,cast(weight_unit_measure_id as string) as weight_unit_measure_id
        ,cast(product_subcategory_id as int) as product_subcategory_id
        ,cast(product_model_id as int) as product_model_id
    FROM stg_product_null_model_id
)

,stg_product_set_make_flag as (
    SELECT
        product_id
        ,product_name
        ,product_number
        ,CASE
            WHEN make_flag = '0' THEN 'purchased'
            ELSE 'manufactured in-house'
        END AS make_flag
        ,finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_cast_type
)

,stg_product_set_finished_flag as (
    SELECT
        product_id
        ,product_name
        ,product_number
        ,make_flag
        ,CASE
            WHEN finish_goods_flag = '0' THEN 'unsalable'
            ELSE 'salable'
        END AS finish_goods_flag
        ,product_color
        ,safety_stock_level
        ,standard_cost
        ,list_price
        ,product_size
        ,size_unit_measure_id
        ,product_weight
        ,weight_unit_measure_id
        ,product_subcategory_id
        ,product_model_id
    FROM stg_product_set_make_flag
)

SELECT *
FROM stg_product_set_finished_flag;

