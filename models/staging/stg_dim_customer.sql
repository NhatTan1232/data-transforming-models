with stg_customer__source as (
    SELECT *
    FROM `adventureworks2019.Sales.Customer`
)

,stg_customer__rename as (
    SELECT
        CustomerID as customer_id
        ,PersonID as person_id
        ,StoreID  as store_id
        ,TerritoryID as territory_id
    FROM stg_customer__source
)

,stg_customer__null_personid as ( 
    SELECT 
        customer_id
        ,CASE 
            WHEN stg_customer__rename.person_id = 'NULL' THEN '0'
            ELSE stg_customer__rename.person_id
        END AS person_id
        ,store_id
        ,territory_id
    FROM stg_customer__rename
)

,stg_customer__null_storeid as ( 
    SELECT 
        customer_id
        ,person_id
        ,CASE 
            WHEN stg_customer__null_personid.store_id = 'NULL' THEN '0'
            ELSE stg_customer__null_personid.store_id
        END AS store_id
        ,territory_id
    FROM stg_customer__null_personid
)

,stg_customer__cast_type as (
    SELECT
        cast(customer_id as int) as customer_id
        ,cast(person_id as int) as person_id
        ,cast(store_id as int) as store_id
        ,cast(territory_id as int) as territory_id
    FROM stg_customer__null_storeid
)

,stg_customer__add_undefined as (
    SELECT
        0 as customer_id
        ,0 as person_id
        ,0 as store_id
        ,0 as territory_id
    UNION ALL
    SELECT *
    FROM stg_customer__cast_type
)

SELECT *
FROM stg_customer__add_undefined


