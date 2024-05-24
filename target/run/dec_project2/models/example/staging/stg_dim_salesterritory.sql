

  create or replace view `my-second-project-422312`.`my_dataset_yay`.`stg_dim_salesterritory`
  OPTIONS()
  as with stg_sales_territory__source as (
    SELECT * 
    FROM `adventureworks2019.Sales.SalesTerritory`
)

,stg_sales_territory__cast_type_rename as (
    SELECT
        cast(TerritoryID as int) as territory_id
        ,cast(Name as string) as territory_name
        ,cast(CountryRegionCode as string) as territory_region_id
        ,cast(stg_sales_territory__source.Group as string) as territory_group_name
    FROM stg_sales_territory__source
)

,stg_sales_territory__add_undefined as (
    SELECT
        0 as territory_id
        ,'undefined' as territory_name
        ,'0' as territory_region_id
        ,'undefined' as territory_group_name
    UNION ALL
    SELECT *
    FROM stg_sales_territory__cast_type_rename
)

SELECT *
FROM stg_sales_territory__add_undefined;

