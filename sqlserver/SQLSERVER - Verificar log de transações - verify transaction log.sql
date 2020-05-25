/* 
https://blog.sqlauthority.com/2015/03/25/sql-server-knowing-nested-transactions-behavior-with-sql-server/
By: Pinal Dave
*/

SELECT Operation, [Transaction ID], Description FROM fn_dblog(NULL, NULL)