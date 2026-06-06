/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
if object_id ('Bronze.crm_cust_info','u') is not null
  drop table Bronze.crm_cust_info;

create table Bronze.crm_cust_info
(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
)


if object_id ('Bronze.crm_prd_info','u') is not null
  drop table Bronze.crm_prd_info;
create table Bronze.crm_prd_info
(
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt date,
prd__dt_end date
)

if object_id ('Bronze.crm_sales_details','u') is not null
  drop table Bronze.crm_sales_details;

create table Bronze.crm_sales_details
(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_ordr_id int,
sls_ship_dt date,
sls_due_dt date,
sls_sales int,
sls_quantity int,
sls_price int
)

-- create table for Erp 

if object_id ('Bronze.erp_cust_az12','u') is not null
  drop table Bronze.erp_cust_az12;
drop table Bronze.erp_cust_az12
create table Bronze.erp_cust_az12
(
cid nvarchar(20),
bdate date,
gen nvarchar(20)
)

if object_id ('Bronze.erp_loc_a101','u') is not null
  drop table Bronze.erp_loc_a101;
create table Bronze.erp_loc_a101
(
cid nvarchar(50),
cntry nvarchar(50)
)

if object_id ('Bronze.erp_px_cat_g1v2','u') is not null
  drop table Bronze.erp_px_cat_g1v2;
create table Bronze.erp_px_cat_g1v2
(
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar(50),
maintenance nvarchar(50)
)

