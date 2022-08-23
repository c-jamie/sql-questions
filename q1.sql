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
