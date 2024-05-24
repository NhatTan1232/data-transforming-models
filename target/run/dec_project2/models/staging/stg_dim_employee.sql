

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_employee`
  OPTIONS()
  as with stg_employee__source as (
    SELECT * 
    FROM `adventureworks2019.HumanResources.Employee`
)

,stg_employee__cast_type_rename as (
    SELECT
        cast(BusinessEntityID as int) as employee_id
        ,cast(JobTitle as string) as employee_title
        ,cast(Gender as string) as employee_gender
    FROM stg_employee__source
)

,stg_employee__add_undefined as (
    SELECT
        0 as employee_id
        ,'undefined' as employee_title
        ,'undefined' as employee_gender
    UNION ALL
    SELECT *
    FROM stg_employee__cast_type_rename
)

SELECT *
FROM stg_employee__add_undefined;

