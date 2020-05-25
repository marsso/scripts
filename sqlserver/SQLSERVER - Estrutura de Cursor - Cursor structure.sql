/*
https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/declare-cursor-transact-sql?view=sql-server-ver15

Exemplo de estrutura de um cursor em sqlserver para implementação.

Como trabalho com vários tipos de banco, tinha uma certa dificuldade para lembrar. rs
*/

DECLARE @v_campo DO SELECT  VARCHAR(30); -- Campo que recebe a projeção do select
DECLARE <<nome do cursor >> CURSOR FOR 
SELECT campo FROM <<nome da tabela>>;

OPEN <<nome do cursor >>;

FETCH NEXT FROM <<nome do cursor>> INTO @v_campo;  

WHILE @@FETCH_STATUS = 0
BEGIN
	/* Trabalhar com a variável */
	FETCH NEXT FROM <<nome do cursor>> INTO @v_campo;  
END;
CLOSE <<nome do cursor>> ;
DEALLOCATE <<nome do cursor>> ;

