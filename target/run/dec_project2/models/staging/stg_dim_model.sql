

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_model`
  OPTIONS()
  as with stg_model__source as (
    SELECT * 
    FROM `adventureworks2019.Production.ProductModel`
)

,stg_model__cast_type_rename as (
    SELECT
        cast(ProductModelID as int) as product_model_id
        ,cast(Name as string) as product_model_name
    FROM stg_model__source
)

,stg_model__add_undefined as (
    SELECT
        0 as product_model_id
        ,'undefined' as product_model_name
    UNION ALL
    SELECT *
    FROM stg_model__cast_type_rename
)

SELECT *
FROM stg_model__add_undefined;

