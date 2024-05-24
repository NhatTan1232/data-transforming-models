

  create or replace view `my-second-project-422312`.`my_dataset_yay`.`dim_product`
  OPTIONS()
  as WITH dim_product__add_product_souce AS (
    SELECT * 
    FROM `my-second-project-422312.my_dataset_yayy.stg_dim_product`
)

,dim_product__add_subcategory_souce AS (
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
        ,pro.product_subcategory_id
        ,product_category_id
        ,product_subcategory_name
        ,product_model_id
    FROM dim_product__add_product_souce pro
    INNER JOIN `my-second-project-422312.my_dataset_yayy.stg_dim_subcategory` sub
    ON sub.product_subcategory_id = pro.product_subcategory_id
)

,dim_product__add_category_souce AS (
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
        ,sub.product_category_id
        ,product_category_name
        ,product_subcategory_name
        ,product_model_id
    FROM dim_product__add_subcategory_souce sub
    INNER JOIN `my-second-project-422312.my_dataset_yayy.stg_dim_category` cat
    ON sub.product_category_id = cat.product_category_id
)

,dim_product__add_model_souce AS (
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
        ,product_category_id
        ,product_category_name
        ,product_subcategory_name
        ,cat.product_model_id
        ,product_model_name
    FROM dim_product__add_category_souce cat
    INNER JOIN `my-second-project-422312.my_dataset_yayy.stg_dim_model` mol
    ON mol.product_model_id = cat.product_model_id
)

,dim_product__add_weight_name_souce AS (
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
        ,uni.unit_measure_name as weight_unit_measure_name
        ,product_subcategory_id
        ,product_category_id
        ,product_category_name
        ,product_subcategory_name
        ,product_model_id
        ,product_model_name
    FROM dim_product__add_model_souce mol
    INNER JOIN `my-second-project-422312.my_dataset_yayy.stg_dim_unitmeasure` uni
    ON mol.weight_unit_measure_id = uni.unit_measure_id
)

,dim_product__add_size_name_souce AS (
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
        ,uni.unit_measure_name as size_unit_measure_name
        ,product_weight
        ,weight_unit_measure_id
        ,weight_unit_measure_name
        ,product_subcategory_id
        ,product_category_id
        ,product_category_name
        ,product_subcategory_name
        ,product_model_id
        ,product_model_name
    FROM dim_product__add_weight_name_souce wei
    INNER JOIN `my-second-project-422312.my_dataset_yayy.stg_dim_unitmeasure` uni
    ON wei.size_unit_measure_id = uni.unit_measure_id
)

SELECT
    product_id as product_key
    ,product_name 
    ,product_number
    ,make_flag
    ,finish_goods_flag as finished_goods_flag
    ,product_subcategory_id as product_subcategory_key
    ,product_subcategory_name
    ,product_category_id as product_category_key
    ,product_category_name
    ,product_model_id as product_model_key
    ,product_model_name
    ,size_unit_measure_id as size_unit_measure_key
    ,size_unit_measure_name
    ,weight_unit_measure_id as weight_unit_measure_key
    ,weight_unit_measure_name
    ,product_color as color
    ,product_weight as weight
    ,product_size as size
    ,safety_stock_level
    ,standard_cost
    ,list_price
FROM dim_product__add_size_name_souce
ORDER BY product_key;

