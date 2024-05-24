

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_category`
  OPTIONS()
  as with stg_category__source as (
    SELECT * 
    FROM `adventureworks2019.Production.ProductCategory`
)

,stg_category__cast_type_rename as (
    SELECT
        cast(ProductCategoryID as int) as product_category_id
        ,cast(Name as string) as product_category_name
    FROM stg_category__source
)

,stg_category__add_undefined as (
    SELECT
        0 as product_category_id
        ,'undefined' as product_category_name
    UNION ALL
    SELECT *
    FROM stg_category__cast_type_rename
)

SELECT *
FROM stg_category__add_undefined;

