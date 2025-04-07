CREATE TABLE dim_plants (
    plant_id BIGINT PRIMARY KEY,
    name VARCHAR(255),
    region VARCHAR(100),
    latitude FLOAT,
    longitude FLOAT,
);

CREATE TABLE dim_equipments (
  equipment_id BIGINT PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  plant_id BIGINT, 
  FOREIGN KEY (plant_id) REFERENCES dim_plants(plant_id)
);

CREATE TABLE dim_sensors (
  sensor_id BIGINT PRIMARY KEY,
  name VARCHAR(255),
  unit VARCHAR(50),
  equipment_id BIGINT,
  FOREIGN KEY (equipment_id) REFERENCES dim_equipments(equipment_id)
);
 
CREATE TABLE dim_time (
  date_value DATE NOT NULL,
  time_id BIGINT PRIMARY KEY,
  year INT,
  month INT,
  day INT,
  hour BIGINT
);


CREATE TABLE fact_sensor_readings (
  reading_id BIGINT IDENTITY(1,1) PRIMARY KEY,
  sensor_id INT NOT NULL,
  time_id BIGINT NOT NULL,
  value FLOAT,
  equipment_id INT NOT NULL,
  plant_id INT NOT NULL,
  processed_at BIGINT,
  FOREIGN KEY (sensor_id) REFERENCES dim_sensors(sensor_id),
  FOREIGN KEY (time_id) REFERENCES dim_time(time_id),
  FOREIGN KEY (equipment_id) REFERENCES dim_equipments(equipment_id),
  FOREIGN KEY (plant_id) REFERENCES dim_plants(plant_id)
);


COPY dim_plants
FROM 's3://00-arkham-challenge/transform-zone-jagc/plants/'
IAM_ROLE 'arn:aws:iam::227646377839:role/service-role/AmazonRedshift-CommandsAccessRole-20250404T152935'
FORMAT AS PARQUET;

COPY dim_equipments
FROM 's3://00-arkham-challenge/transform-zone-jagc/equipments/'
IAM_ROLE 'arn:aws:iam::227646377839:role/service-role/AmazonRedshift-CommandsAccessRole-20250404T152935'
FORMAT AS PARQUET;

COPY dim_sensors
FROM 's3://00-arkham-challenge/transform-zone-jagc/sensors/'
IAM_ROLE 'arn:aws:iam::227646377839:role/service-role/AmazonRedshift-CommandsAccessRole-20250404T152935'
FORMAT AS PARQUET;

COPY dim_time
FROM 's3://00-arkham-challenge/transform-zone-jagc/time/'
IAM_ROLE 'arn:aws:iam::227646377839:role/service-role/AmazonRedshift-CommandsAccessRole-20250404T152935'
FORMAT AS PARQUET;