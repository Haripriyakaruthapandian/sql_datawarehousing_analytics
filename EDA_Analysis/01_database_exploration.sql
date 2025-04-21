
/*
================================================================================================================
----------------------------------------------------------------------------------------------------------------
                01:DATABASE EXPLORATION
----------------------------------------------------------------------------------------------------------------
Purpose:
		To explore the structure of the databases, including the list of tables and their schemas.
		To inspect the columns and metadata for specific tables.


Table Used:
		1. Information_Schema.Tables
		2. Information_Schema.Columns

=================================================================================================================

*/
--------RETRIEVE THE LIST OF ALL TABLES-------
SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME,
TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;


--------RETRIEVE ALL COLUMNS FOR A SPECIFIC TABLE-------
SELECT COLUMN_NAME,
IS_NULLABLE,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dim_customers' ;

SELECT COLUMN_NAME,
IS_NULLABLE,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='dim_products' ;

SELECT COLUMN_NAME,
IS_NULLABLE,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='fact_sales' ;
