with stg_salesperson__source as (
    SELECT * 
    FROM `adventureworks2019.Sales.SalesPerson`
)

,stg_salesperson__cast_type_rename as (
    SELECT
        cast(BusinessEntityID as int) as sales_person_id
        ,cast(Bonus as decimal) as sales_person_bonus
        ,cast(CommissionPct as decimal) as sales_person_commission
    FROM stg_salesperson__source
)

,stg_salesperson__add_undefined as (
    SELECT
        0 as sales_person_id
        ,0 as sales_person_bonus
        ,0 as sales_person_commission
    UNION ALL
    SELECT *
    FROM stg_salesperson__cast_type_rename
)

SELECT *
FROM stg_salesperson__add_undefined