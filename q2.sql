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


/*
  
  Q) with the above query do you expect to get more or less data with a left vs inner join?
  
  Q) what join would you choose and why?
 
  Q) what happens if the m1y.sales is zero? Is there anything we can do to fix a potential issue here?
*/
