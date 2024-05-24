
  
    

    create or replace table `my-second-project-422312`.`my_dataset_yayy`.`dim_sales_territory`
      
    
    

    OPTIONS()
    as (
      WITH dim_territory__add_territory_source AS (
    SELECT * 
    FROM `my-second-project-422312.my_dataset_yayy_stg.stg_dim_salesterritory`
)

,dim_territory__add_region_source AS (
    SELECT
        territory_id
        ,territory_name
        ,ter.territory_region_id
        ,region_name
        ,territory_group_name
    FROM dim_territory__add_territory_source ter
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_region` reg
    ON ter.territory_region_id = reg.territory_region_id
)

SELECT
    territory_id AS territory_key
    ,territory_name
    ,territory_region_id AS country_region_key
    ,region_name AS country_region_name
    ,territory_group_name AS group_name
FROM dim_territory__add_region_source
WHERE territory_id != 0
ORDER BY territory_key
    );
  