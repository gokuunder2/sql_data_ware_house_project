/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
Alter or create procedure Bronze.load_data as 
Begin 
declare @start_time datetime , @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	begin try
	set @batch_start_time=getdate()
	    set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		--refresh condition
		truncate table Bronze.crm_cust_info
		print'>>loading value in CRM table: Bronze.crm_cust_info'
		bulk insert Bronze.crm_cust_info
		from 'C:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast (datediff(second, @start_time, @end_time) as nvarchar) +'second'
		print'==================================================================='

		set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		truncate table Bronze.crm_prd_info
		print'>>loading value in CRM table: Bronze.crm_prd_info'
		bulk insert Bronze.crm_prd_info
		from 'C:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast (datediff(second, @start_time, @end_time) as nvarchar) +'second'
		print'==================================================================='

		set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		truncate table Bronze.crm_sales_details 
		print'>>loading value in CRM table: Bronze.crm_sales_details'
		bulk insert Bronze.crm_sales_details
		from 'C:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast (datediff(second, @start_time, @end_time) as nvarchar) +'second'
		print'==================================================================='

		set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		truncate table Bronze.erp_cust_az12
		print'>>loading value in ERP table: Bronze.erp_cust_az12'
		bulk insert Bronze.erp_cust_az12
		from 'C:\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast (datediff(second, @start_time, @end_time) as nvarchar) +'second'
		print'==================================================================='


		set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		truncate table Bronze.erp_loc_a101
		print'>>loading value in ERP table: Bronze.erp_loc_a101'
		bulk insert Bronze.erp_loc_a101
		from 'C:\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast (datediff(second, @start_time, @end_time) as nvarchar) +'second'
		print'==================================================================='

		set @start_time=getdate()
		print'==================================================================='
		print 'truncating entier table'
		truncate table Bronze.erp_px_cat_g1v2
		print'>>loading value in ERP table: Bronze.erp_px_cat_g1v2'
		bulk insert Bronze.erp_px_cat_g1v2
		from 'C:\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with
		(
		 firstrow=2,
		 fieldterminator=',',
		 tablock
		)
		set @end_time=getdate()
		print'load time' + cast(datediff(second, @start_time, @end_time) AS nvarchar) +'second';
		print'==================================================================='
     
	set @batch_end_time=getdate()
	print'>>Bronze Layer load time:' + cast(datediff(second, @batch_start_time, @batch_end_time) AS nvarchar) +'second';
	end try 
	begin catch 
	    print'===================================================================='
		print'Errors occurs during broze layer'
		print 'Error Message:' + Error_message() 
		print 'Error Message:' + Error_number()
		print'===================================================================='
	end catch
End 

exec Bronze.load_data
