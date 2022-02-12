-- 1. What is count for fhv vehicles data for year 2019
SELECT COUNT(*) FROM `divine-apogee-338801.trips_data_all.fhv_tripdata_external_table`;

-- 2. How many distinct dispatching_base_num we have in fhv for 2019
SELECT COUNT (DISTINCT dispatching_base_num) FROM `divine-apogee-338801.trips_data_all.fhv_tripdata_external_table`;

-- 4. What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279
CREATE OR REPLACE TABLE divine-apogee-338801.trips_data_all.fhv_tripdata_partitoned_clustered
PARTITION BY DATE(pickup_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM divine-apogee-338801.trips_data_all.fhv_tripdata_external_table;

SELECT COUNT(*) FROM `divine-apogee-338801.trips_data_all.fhv_tripdata_partitoned_clustered`
WHERE pickup_datetime BETWEEN '2019-01-01' AND '2019-03-31'
AND dispatching_base_num IN ('B00987', 'B02060', 'B02279');
