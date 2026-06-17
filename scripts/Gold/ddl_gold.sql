/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- create gold dimensions :- gold.dim_customers
create  view gold.dim_customer as 
select
row_number() over (order by ci.cst_id ) as rownumber,
ci.cst_id customer_id,
ci.cst_key customer_key,
ci.cst_firstname first_name,
ci.cst_lastname last_name,
lc.cntry country,
ec.bdate DOB,
ci.cst_marital_status marital_status,
case when ci.cst_gndr !='n/a' then ci.cst_gndr
	 else coalesce(ec.gen,'n/a')
end as Gender,
ci.cst_create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ec
on ec.cid=ci.cst_key 

---- create gold dimensions:- gold.dim-products
create view gold.dim_products as
select 
row_number() over (order by pf.prd_start_dt,pf.prd_key) as product_keys,
pf.prd_id product_id,
pf.prd_key product_key,
pf.prd_nm product_name ,
pf.cat_id category_id,
px.cat category,
px.subcat sub_category,
prd_cost cost,
prd_line product_line,
prd_start_dt start_dt
from silver.crm_prd_info pf
left join silver.erp_px_cat_g1v2 px
on px.id=pf.cat_id
where pf.prd_end_dt is null

-- create gold dimensions:- gold.fact_sales
Create view gold.fact_sales as
SELECT 
sd.sls_ord_num order_Number,
dc.rownumber customer_keys,
dm.product_keys,
sd.sls_order_dt order_date,
sd.sls_ship_dt ship_date,
sd.sls_due_dt Due_date,
sd.sls_sales Sales,
sd.sls_quantity quantity,
sd.sls_price Price  
FROM silver.crm_sales_details sd
left join gold.dim_customer dc
on dc.customer_id=sd.sls_cust_id
left join gold.dim_products dm
on sd.sls_prd_key=dm.product_key
