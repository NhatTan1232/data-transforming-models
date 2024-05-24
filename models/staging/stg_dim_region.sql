with stg_region__source as (
    SELECT * 
    FROM `adventureworks2019.Person.CountryRegion`
)

,stg_region__cast_type_rename as (
    SELECT
        cast(CountryRegionCode as string) as territory_region_id
        ,cast(Name as string) as region_name
    FROM stg_region__source
)

,stg_region__add_undefined as (
    SELECT
        '0' as territory_region_id
        ,'undefined' as region_name
    UNION ALL
    SELECT *
    FROM stg_region__cast_type_rename
)

SELECT *
FROM stg_region__add_undefined