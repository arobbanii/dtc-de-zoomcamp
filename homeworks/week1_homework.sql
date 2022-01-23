-- Question 3: How many taxi trips were there on January 15? 
SELECT
	CAST(tpep_pickup_datetime AS DATE) as "day",
	COUNT(1)
FROM yellow_taxi_trips 
WHERE 
	CAST(tpep_pickup_datetime AS DATE) = '2021-01-15'
GROUP BY
	CAST(tpep_pickup_datetime AS DATE);
-- answer: 53024

-- Question 4: On which day it was the largest tip in January? (note: it's not a typo, it's "tip", not "trip")
SELECT
	CAST(tpep_pickup_datetime AS DATE) as "day",
	tip_amount
FROM yellow_taxi_trips
WHERE 
	EXTRACT(MONTH FROM tpep_pickup_datetime) = 1
	AND EXTRACT(YEAR FROM tpep_pickup_datetime) = 2021
ORDER BY tip_amount DESC
LIMIT 1;
-- answer: 2021-01-20


-- Question 5:What was the most popular destination for passengers picked up in central park on January 14? Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"
SELECT 
	(SELECT z."Zone" FROM zones z WHERE y."DOLocationID" = z."LocationID"),
	COUNT(y."DOLocationID")
FROM
	yellow_taxi_trips y,
	zones z
WHERE
	CAST(y."tpep_pickup_datetime" AS DATE) = '2021-01-14'
		AND
	y."PULocationID" = (
		SELECT zones."LocationID"
		FROM zones
		WHERE zones."Zone" = 'Central Park')
GROUP BY y."DOLocationID"
ORDER BY COUNT(y."DOLocationID") DESC;
--answer: Upper East Side South

--Question 6: What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)? Enter two zone names separated by a slashFor example:"Jamaica Bay / Clinton East"If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".
SELECT
	CONCAT(COALESCE(zpu."Zone", 'Unknown'), ' / ', COALESCE(zdo."Zone", 'Unknown')) as "pu_do",
	AVG(y."total_amount")
FROM
	yellow_taxi_trips y,
	zones zpu,
	zones zdo
WHERE
	y."PULocationID" = zpu."LocationID" AND
	y."DOLocationID" = zdo."LocationID"
GROUP BY CONCAT(COALESCE(zpu."Zone", 'Unknown'), ' / ', COALESCE(zdo."Zone", 'Unknown'))
ORDER BY AVG(y."total_amount") DESC;
--answer: Alphabet City/Unknown