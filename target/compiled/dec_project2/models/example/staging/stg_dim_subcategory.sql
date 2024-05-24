with stg_subcategory__source as (
    SELECT * 
    FROM `adventureworks2019.Production.ProductSubcategory`
)

,stg_subcategory__cast_type_rename as (
    SELECT
        cast(ProductSubcategoryID as int) as product_subcategory_id
        ,cast(ProductCategoryID as int) as product_category_id
        ,cast(Name as string) as product_subcategory_name
    FROM stg_subcategory__source
)

,stg_subcategory__add_undefined as (
    SELECT
        0 as product_subcategory_id
        ,0 as product_category_id
        ,'undefined' as product_subcategory_name
    UNION ALL
    SELECT *
    FROM stg_subcategory__cast_type_rename
)

SELECT *
FROM stg_subcategory__add_undefined