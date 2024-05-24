WITH dim_date__get_dim AS (
    {{ dbt_date.get_date_dimension("2010-01-01", "2030-12-31") }}
)

,dim_date__set_weekend_full_date AS (
    SELECT
        date_day AS date_key
        ,CASE
            WHEN day_of_month = 1 THEN CONCAT(month_name, ' 1st ', year_number)
            WHEN day_of_month = 2 THEN CONCAT(month_name, ' 2nd ', year_number)
            WHEN day_of_month = 1 THEN CONCAT(month_name, ' 3rd ', year_number)
            ELSE CONCAT(month_name, ' ', day_of_month, 'th ', year_number)
        END AS full_date
        ,day_of_week_name AS day_of_week
        ,day_of_week_name_short AS day_of_week_short
        ,CASE 
            WHEN day_of_week_name_short = 'Sun' OR day_of_week_name_short = 'Sat' THEN 'weekend'
            ELSE 'weekday'
        END AS is_weekday_or_weekend
        ,day_of_month
        ,month_start_date AS year_month
        ,month_of_year AS month
        ,day_of_year AS day_of_the_year
        ,week_of_year
        ,quarter_of_year AS quarter_number
        ,year_start_date AS year
        ,year_number
    FROM dim_date__get_dim
)

SELECT
    date_key
    ,full_date
    ,day_of_week
    ,day_of_week_short
    ,is_weekday_or_weekend
    ,CAST(day_of_month AS string) AS day_of_month
    ,year_month
    ,month
    ,day_of_the_year
    ,CAST(week_of_year AS string) AS week_of_year
    ,quarter_number
    ,year
    ,year_number
FROM dim_date__set_weekend_full_date