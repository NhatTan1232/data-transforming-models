WITH dim_customer__add_customer_souce AS (
    SELECT * 
    FROM `my-second-project-422312.my_dataset_yayy_stg.stg_dim_customer`
)

,dim_product__add_store_souce AS (
    SELECT
        customer_id
        ,person_id
        ,cus.store_id
        ,store_name
        ,territory_id
    FROM dim_customer__add_customer_souce cus
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_store` sto
    ON cus.store_id = sto.store_id
)

,dim_product__add_territory_souce AS (
    SELECT
        customer_id
        ,person_id
        ,store_id
        ,store_name
        ,sto.territory_id
        ,territory_name
        ,territory_region_id
    FROM dim_product__add_store_souce sto
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_salesterritory` ter
    ON ter.territory_id = sto.territory_id
)

,dim_product__add_region_name AS (
    SELECT
        customer_id
        ,person_id
        ,store_id
        ,store_name
        ,territory_id
        ,territory_name
        ,ter.territory_region_id
        ,region_name
    FROM dim_product__add_territory_souce ter
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_region` reg
    ON ter.territory_region_id = reg.territory_region_id
)

,dim_product__add_person_source AS (
    SELECT
        customer_id
        ,reg.person_id
        ,person_first_name
        ,person_middle_name
        ,person_last_name
        ,person_title
        ,store_id
        ,store_name
        ,territory_id
        ,territory_name
        ,territory_region_id
        ,region_name
    FROM dim_product__add_region_name reg
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_person` per
    ON per.person_id = reg.person_id
)

,dim_customer__set_reseller AS (
    SELECT
        customer_id 
        ,CASE
            WHEN person_id != 0 THEN CONCAT(person_first_name, ' ', person_last_name)
            ELSE 'undefined' 
        END AS customer_name
        ,CASE 
            WHEN 
                store_id != 0 THEN 'true'
            ELSE 'false'
        END AS is_reseller
        ,store_id 
        ,store_name 
        ,territory_id 
        ,territory_name 
        ,territory_region_id 
        ,region_name 
        ,person_title 
        ,person_first_name
        ,person_middle_name 
        ,person_last_name 
    FROM dim_product__add_person_source
)

SELECT
    customer_id as customer_key
    ,customer_name
    ,is_reseller
    ,store_id as reseller_store_id
    ,store_name as reseller_store_name
    ,territory_id as customer_territory_key
    ,territory_name as customer_territory_name
    ,territory_region_id as customer_country_region_key
    ,region_name as customer_country_region_name
    ,person_title as customer_person_title
    ,person_first_name as first_name
    ,person_middle_name as middle_name
    ,person_last_name as last_name
FROM dim_customer__set_reseller
WHERE customer_id != 0
ORDER BY customer_key
