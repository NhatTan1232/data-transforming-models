

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_store`
  OPTIONS()
  as with stg_store__source as (
    SELECT * 
    FROM `adventureworks2019.Sales.Store`
)

,stg_store__rename as (
    SELECT
        BusinessEntityID as store_id
        ,Name as store_name
        ,SalesPersonID as sales_person_id
    FROM stg_store__source
)

,stg_store__cast_type as (
    SELECT
        cast(store_id as int) as store_id
        ,cast(store_name as string) as store_name
        ,cast(sales_person_id as int) as sales_person_id
    FROM stg_store__rename
)

,stg_store__add_undefined as (
    SELECT
        store_id
        ,store_name
        ,sales_person_id
    FROM stg_store__cast_type
    UNION ALL
    SELECT
        0 as store_id
        ,'undefined' as store_name
        ,0 as sales_person_id
)

SELECT *
FROM stg_store__add_undefined;

