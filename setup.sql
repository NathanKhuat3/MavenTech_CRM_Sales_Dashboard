CREATE DATABASE crm_project;

USE crm_project;

-- To update the database
SET sql_safe_updates = 0;

UPDATE crm_project.sales_pipeline
SET engage_date = NULL
WHERE engage_date = '';

UPDATE crm_project.sales_pipeline
SET close_date = NULL
WHERE close_date = '';

UPDATE crm_project.sales_pipeline
SET close_value = NULL
WHERE close_value = '';

ALTER TABLE crm_project.sales_pipeline
MODIFY COLUMN account TEXT NULL,
MODIFY COLUMN engage_date DATE NULL,
MODIFY COLUMN close_date DATE NULL,
MODIFY COLUMN close_value INT NULL;

ALTER TABLE crm_project.sales_pipeline
ADD COLUMN quarter INT;

UPDATE crm_project.sales_pipeline
SET quarter = QUARTER(close_date);

ALTER TABLE crm_project.accounts
MODIFY COLUMN year_established INT,
MODIFY COLUMN revenue FLOAT,
MODIFY COLUMN employees INT;

ALTER TABLE crm_project.products
MODIFY COLUMN sales_price INT;

