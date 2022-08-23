
/*
  
  load data
  
*/

CREATE TABLE index_table AS SELECT * FROM '/Users/jamieclery/code/sql-questions/index.csv';
CREATE TABLE kpi_table AS SELECT * FROM '/Users/jamieclery/code/sql-questions/kpi.csv';

 /*
 
    Q) 
    
    1) use the below code and join in the KPI table
    2) with the combined spread calculate the average spread between the sales column and kpi column for each ticker

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
	
) select * from index_grid;