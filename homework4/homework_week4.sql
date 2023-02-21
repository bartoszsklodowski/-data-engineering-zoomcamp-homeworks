
-- Question 1
SELECT count(*) FROM `hidden-casing-375920.week4_de_zoomcamp.fact_trips` 
where
 cast(pickup_datetime as DATE) >='2019-01-01' and cast(pickup_datetime as DATE) <='2020-12-31'

-- Question 3
 SELECT count(*) FROM `hidden-casing-375920.week4_de_zoomcamp.stg_fhv_trips` 

 -- Question 4
 SELECT count(*) FROM `hidden-casing-375920.week4_de_zoomcamp.fact_fhv_trips` 

 -- Question 5
 WITH trips_by_month AS (
  SELECT
    EXTRACT(YEAR FROM pickup_datetime) AS year,
    EXTRACT(MONTH FROM pickup_datetime) AS month,
    COUNT(tripid) AS num_trips
  FROM
    `hidden-casing-375920.week4_de_zoomcamp.fact_fhv_trips` 
  GROUP BY
    year,
    month
), 
tiles AS (
  SELECT 
    year,
    month, 
    NTILE(12) OVER (ORDER BY num_trips DESC) AS tile
  FROM 
    trips_by_month
)
SELECT 
  CONCAT(year, '-', LPAD(CAST(month AS string), 2, '0'), '-01') AS month_with_most_rides
FROM 
  tiles
WHERE 
  tile = 1;