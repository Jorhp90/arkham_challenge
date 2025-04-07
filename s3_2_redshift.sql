COPY fact_sensor_readings
FROM 's3://00-arkham-challenge/transform-zone-jagc/sensor_readings/year=2025/month=4/day=3/'
IAM_ROLE 'arn:aws:iam::227646377839:role/service-role/AmazonRedshift-CommandsAccessRole-20250404T152935'
FORMAT AS PARQUET;