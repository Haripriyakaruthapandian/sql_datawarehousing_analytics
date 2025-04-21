
	TRUNCATE TABLE gold.dim_customers;
	GO
	BULK INSERT gold.dim_customers
	FROM 'C:\Users\HP\Desktop\sql\datasets\gold.dim_customers.csv'
	with(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	

	TRUNCATE TABLE gold.dim_products;
	GO
	BULK INSERT gold.dim_products
	FROM 'C:\Users\HP\Desktop\sql\datasets\gold.dim_products.csv'
	with(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
	);

	
	TRUNCATE TABLE gold.fact_sales;
	GO

	BULK INSERT gold.fact_sales
			FROM 'C:\Users\HP\Desktop\sql\datasets\gold.fact_sales.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

