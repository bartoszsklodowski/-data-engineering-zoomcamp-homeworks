-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `eu_taxi_data1.external_fhv_2019`
OPTIONS (
  format = 'CSV',
  uris = ['gs://dtc_data_lake_hidden-casing-375920/data/fhv/fhv_tripdata_2019-*.csv.gz']
);

-- What is the count for fhv vehicle records for year 2019?
SELECT count(*) FROM hidden-casing-375920.eu_taxi_data1.external_fhv_2019;

-- Write a query to count the distinct number of affiliated_base_number for the entire dataset on both the tables.
SELECT count(distinct(affiliated_base_number)) FROM hidden-casing-375920.eu_taxi_data1.external_fhv_2019;
SELECT count(distinct(affiliated_base_number)) FROM hidden-casing-375920.eu_taxi_data1.fhv_2019;

-- How many records have both a blank (null) PUlocationID and DOlocationID in the entire dataset?
SELECT 
  count(*) 
FROM hidden-casing-375920.eu_taxi_data1.fhv_2019
WHERE PUlocationID is null and DOlocationID is null;

-- Write a query to retrieve the distinct affiliated_base_number between pickup_datetime 03/01/2019 and 03/31/2019 (inclusive)

  -- Creating a partition and cluster table
  CREATE OR REPLACE TABLE eu_taxi_data1.fhv_2019_partitoned_clustered1
  PARTITION BY DATE(pickup_datetime)
  CLUSTER BY affiliated_base_number AS
  SELECT * FROM eu_taxi_data1.fhv_2019;

  SELECT DISTINCT(affiliated_base_number)
  FROM eu_taxi_data1.fhv_2019
  WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';

  SELECT DISTINCT(affiliated_base_number)
  FROM eu_taxi_data1.fhv_2019_partitoned_clustered1
  WHERE DATE(pickup_datetime) BETWEEN '2019-03-01' AND '2019-03-31';