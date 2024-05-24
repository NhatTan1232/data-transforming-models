

  create or replace view `my-second-project-422312`.`my_dataset_yayy_stg`.`stg_dim_person`
  OPTIONS()
  as with stg_person__source as (
    SELECT * 
    FROM `adventureworks2019.Person.Person`
)

,stg_person__cast_type_rename as (
    SELECT
        cast(BusinessEntityID as int) as person_id
        ,cast(PersonType as string) as job_title
        ,cast(Title as string) as person_title
        ,cast(FirstName as string) as person_first_name
        ,cast(MiddleName as string) as person_middle_name
        ,cast(LastName as string) as person_last_name
    FROM stg_person__source
)

,stg_person__add_undefined as (
    SELECT
        person_id
        ,job_title
        ,person_title
        ,person_first_name
        ,person_middle_name
        ,person_last_name
    FROM stg_person__cast_type_rename
    UNION ALL
    SELECT
        0 as person_id
        ,'undefined' as job_title
        ,'undefined' as person_title
        ,'undefined' as person_first_name
        ,'undefined' as person_middle_name
        ,'undefined' as person_last_name
)

,stg_person__null_job_title as ( 
    SELECT 
        person_id
        ,job_title
        ,CASE 
            WHEN stg_person__add_undefined.person_title = 'NULL' THEN 'undefined'
            ELSE stg_person__add_undefined.person_title
        END AS person_title
        ,person_first_name
        ,person_middle_name
        ,person_last_name
    FROM stg_person__add_undefined
)

,stg_person__null_middle_name as ( 
    SELECT 
        person_id
        ,job_title
        ,person_title
        ,person_first_name
        ,CASE 
            WHEN stg_person__null_job_title.person_middle_name = 'NULL' THEN 'undefined'
            ELSE stg_person__null_job_title.person_middle_name
        END AS person_middle_name
        ,person_last_name
    FROM stg_person__null_job_title
)

SELECT *
FROM stg_person__null_middle_name;

