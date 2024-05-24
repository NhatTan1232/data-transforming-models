

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_unitmeasure`
  OPTIONS()
  as WITH stg_unit__source AS (
    SELECT * 
    FROM `adventureworks2019.Production.UnitMeasure`
)

,stg_unit__cast_type_rename AS (
    SELECT
        cast(UnitMeasureCode as string) as unit_measure_id
        ,cast(Name as string) as unit_measure_name
    FROM stg_unit__source
)

,stg_unit__add_undefined AS (
    SELECT
        '0'as unit_measure_id
        ,'undefined' as unit_measure_name
    UNION ALL
    SELECT *
    FROM stg_unit__cast_type_rename
)

SELECT *
FROM stg_unit__add_undefined;

