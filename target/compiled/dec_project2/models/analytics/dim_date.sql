WITH dim_date__get_dim AS (
    
    
with base_dates as (
    
    with date_spine as
(

    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
     + 
    
    p12.generated_number * power(2, 12)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
     cross join 
    
    p as p12
    
    

    )

    select *
    from unioned
    where generated_number <= 7669
    order by generated_number



),

all_periods as (

    select (
        

        datetime_add(
            cast( cast('2010-01-01' as datetime ) as datetime),
        interval (row_number() over (order by 1) - 1) day
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2030-12-31' as datetime )

)

select * from filtered



)
select
    cast(d.date_day as timestamp) as date_day
from
    date_spine d


),
dates_with_prior_year_dates as (

    select
        cast(d.date_day as date) as date_day,
        cast(

        datetime_add(
            cast( d.date_day as datetime),
        interval -1 year
        )

 as date) as prior_year_date_day,
        cast(

        datetime_add(
            cast( d.date_day as datetime),
        interval -364 day
        )

 as date) as prior_year_over_year_date_day
    from
    	base_dates d

)
select
    d.date_day,
    cast(

        datetime_add(
            cast( d.date_day as datetime),
        interval -1 day
        )

 as date) as prior_date_day,
    cast(

        datetime_add(
            cast( d.date_day as datetime),
        interval 1 day
        )

 as date) as next_date_day,
    d.prior_year_date_day as prior_year_date_day,
    d.prior_year_over_year_date_day,
    extract(dayofweek from d.date_day) as day_of_week,
    case
        -- Shift start of week from Sunday (1) to Monday (2)
        when extract(dayofweek from d.date_day) = 1 then 7
        else extract(dayofweek from d.date_day) - 1
    end as day_of_week_iso,
    format_date('%A', cast(d.date_day as date)) as day_of_week_name,
    format_date('%a', cast(d.date_day as date)) as day_of_week_name_short,
    extract(day from d.date_day) as day_of_month,
    extract(dayofyear from d.date_day) as day_of_year,

    cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        week
    ) as date) as week_start_date,
    cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.date_day as timestamp),
        week
    ) as datetime),
        interval 1 week
        )

 as datetime),
        interval -1 day
        )


        as date) as week_end_date,
    cast(timestamp_trunc(
        cast(d.prior_year_over_year_date_day as timestamp),
        week
    ) as date) as prior_year_week_start_date,
    cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.prior_year_over_year_date_day as timestamp),
        week
    ) as datetime),
        interval 1 week
        )

 as datetime),
        interval -1 day
        )


        as date) as prior_year_week_end_date,
    cast(extract(week from d.date_day) as INT64) as week_of_year,

    cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        isoweek
    ) as date) as iso_week_start_date,
    cast(

        datetime_add(
            cast( cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        isoweek
    ) as date) as datetime),
        interval 6 day
        )

 as date) as iso_week_end_date,
    cast(timestamp_trunc(
        cast(d.prior_year_over_year_date_day as timestamp),
        isoweek
    ) as date) as prior_year_iso_week_start_date,
    cast(

        datetime_add(
            cast( cast(timestamp_trunc(
        cast(d.prior_year_over_year_date_day as timestamp),
        isoweek
    ) as date) as datetime),
        interval 6 day
        )

 as date) as prior_year_iso_week_end_date,
    cast(extract(isoweek from d.date_day) as INT64) as iso_week_of_year,

    cast(extract(week from d.prior_year_over_year_date_day) as INT64) as prior_year_week_of_year,
    cast(extract(isoweek from d.prior_year_over_year_date_day) as INT64) as prior_year_iso_week_of_year,

    cast(extract(month from d.date_day) as INT64) as month_of_year,
    format_date('%B', cast(d.date_day as date))  as month_name,
    format_date('%b', cast(d.date_day as date))  as month_name_short,

    cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        month
    ) as date) as month_start_date,
    cast(cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.date_day as timestamp),
        month
    ) as datetime),
        interval 1 month
        )

 as datetime),
        interval -1 day
        )


        as date) as date) as month_end_date,

    cast(timestamp_trunc(
        cast(d.prior_year_date_day as timestamp),
        month
    ) as date) as prior_year_month_start_date,
    cast(cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.prior_year_date_day as timestamp),
        month
    ) as datetime),
        interval 1 month
        )

 as datetime),
        interval -1 day
        )


        as date) as date) as prior_year_month_end_date,

    cast(extract(quarter from d.date_day) as INT64) as quarter_of_year,
    cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        quarter
    ) as date) as quarter_start_date,
    cast(cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.date_day as timestamp),
        quarter
    ) as datetime),
        interval 1 quarter
        )

 as datetime),
        interval -1 day
        )


        as date) as date) as quarter_end_date,

    cast(extract(year from d.date_day) as INT64) as year_number,
    cast(timestamp_trunc(
        cast(d.date_day as timestamp),
        year
    ) as date) as year_start_date,
    cast(cast(
        

        datetime_add(
            cast( 

        datetime_add(
            cast( timestamp_trunc(
        cast(d.date_day as timestamp),
        year
    ) as datetime),
        interval 1 year
        )

 as datetime),
        interval -1 day
        )


        as date) as date) as year_end_date
from
    dates_with_prior_year_dates d
order by 1


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