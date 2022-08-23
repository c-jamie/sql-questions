/*
  	1) Add a month to a date: `[date] + interval 1 month`
  	2) Subtract a month to a date: `[date] - interval 1 month`
  	3) Using a with statement which you want to be recursive = `with recursive ...`
*/

/*
  
  load data
  
*/

CREATE TABLE index_table AS SELECT * FROM '/Users/jamieclery/code/sql-questions/index.csv';


/*
   
  	Q) Calculate the YoY growth rates for this index
  	
  	HINT: to get the previous year, - 365 days
*/


with selection as (
	
	select 
			month
			, sales
			, ticker
	from 	index_table 
	

), growth as (

	select
				cy.ticker
				, cy.month
				, (cy.sales / m1y.sales)-1 as yoy
	from 		selection as cy
	left join 	selection as m1y 
	on			cy.ticker = m1y.ticker
	and 		cy.month - interval 12 month = m1y.month
				
) select * from growth;
