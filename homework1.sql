-- Question 3
select 
 count(1) 
from green_tripdata
where 
 cast(lpep_pickup_datetime as DATE) ='2019-01-15' 
 and cast(lpep_dropoff_datetime as DATE) ='2019-01-15';

-- Question 4
select 
 cast(lpep_pickup_datetime as DATE) as "Date", 
 max(trip_distance) as trip_distance 
from green_tripdata
group by cast(lpep_pickup_datetime as DATE)
order by trip_distance desc
limit 1;

-- Question 5
select 
 passenger_count,
 count(*)
from 
 green_tripdata t
where
 cast(lpep_pickup_datetime as DATE) ='2019-01-01'
group by 1

-- Question 6
select 
 zdo."Zone" as "drop_off_loc",
 max(t."tip_amount") as "tip_amount"
from 
 green_tripdata t,
 zones zpu,
 zones zdo
where
 t."PULocationID" = zpu."LocationID" and
 t."DOLocationID" = zdo."LocationID" and
 zpu."Zone" = 'Astoria'
group by 1
order by "tip_amount" desc
