WITH dim_salesperson__add_salesperson_source AS (
    SELECT * 
    FROM `my-second-project-422312.my_dataset_yayy_stg.stg_dim_salesperson`
)

,dim_salesperson__add_person_source AS (
    SELECT
        sper.sales_person_id
        ,person_title
        ,person_first_name
        ,person_middle_name
        ,person_last_name
        ,job_title
        ,sales_person_bonus
        ,sales_person_commission
    FROM dim_salesperson__add_salesperson_source sper
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_person` per
    ON sper.sales_person_id = per.person_id
)

,dim_salesperson__add_employee_source AS (
    SELECT
        per.sales_person_id
        ,person_title
        ,person_first_name
        ,person_middle_name
        ,person_last_name
        ,job_title
        ,employee_gender
        ,sales_person_bonus
        ,sales_person_commission
    FROM dim_salesperson__add_person_source per
    INNER JOIN `my-second-project-422312.my_dataset_yayy_stg.stg_dim_employee` emp
    ON per.sales_person_id = emp.employee_id
)

SELECT 
    sales_person_id AS sales_person_key
    ,person_title AS sales_person_title
    ,person_first_name AS first_name
    ,person_middle_name AS middle_name
    ,person_last_name AS last_name
    ,job_title
    ,employee_gender AS gender
    ,sales_person_bonus AS bonus
    ,sales_person_commission AS commission
FROM dim_salesperson__add_employee_source
WHERE sales_person_id != 0
ORDER BY sales_person_key