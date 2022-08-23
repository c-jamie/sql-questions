/*
  
  load data
  
*/

CREATE TABLE index_table AS SELECT * FROM '/Users/jamieclery/code/sql-questions/index.csv';

/*
  
  The data for these indexes is sparse
  This means that there are a number 
  of missing months in the series
 
  Q) Why might this impact the growth rate calculations in the index?
 
*/

 /*
 
  The below code is used to desparse the dataset, and force any missing months to be 0
  
  Q) Explain what each step is doing (add a comment inside each CTE)
  
 */

with recursive min_max_dates as (

	select 
				ticker
				, min(month) as min_month
				, max(month) as max_month
	from 		index_table 
	group by 	ticker
	
), date_grid as (

	select 		ticker
				, max(max_month) as mm
	from 		min_max_dates
	group by 	ticker
	
	union 
	
	select 		ticker
				, mm - interval 1 month as mm from date_grid
	where		mm - interval 1 month >= (select min(min_month) from min_max_dates)

), index_grid as (

	select	
				dg.ticker
				, dg.mm as month
				, case when it.sales is null then 0 else it.sales end as sales
	
	from 		date_grid as dg
	left join 	index_table as it
	on 			dg.mm = it.month
	and 		dg.ticker = it.ticker
	
) select * from date_grid;