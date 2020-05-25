/*
https://blog.devart.com/find-invalid-objects-in-your-databases.html
By: Sergey Syrovatchenko

*/

SELECT
      obj_name = QUOTENAME(SCHEMA_NAME(o.[schema_id])) + '.' + QUOTENAME(o.name)
    , obj_type = o.type_desc
    , d.referenced_database_name
    , d.referenced_schema_name
    , d.referenced_entity_name
FROM sys.sql_expression_dependencies d
JOIN sys.objects o ON d.referencing_id = o.[object_id]
WHERE d.is_ambiguous = 0
    AND d.referenced_id IS NULL
    AND d.referenced_server_name IS NULL -- ignore objects from Linked server
    AND CASE d.referenced_class -- if does not exist
        WHEN 1 -- object
            THEN OBJECT_ID(
                ISNULL(QUOTENAME(d.referenced_database_name), DB_NAME()) + '.' + 
                ISNULL(QUOTENAME(d.referenced_schema_name), SCHEMA_NAME()) + '.' + 
                QUOTENAME(d.referenced_entity_name))
        WHEN 6 – or user datatype
            THEN TYPE_ID(
                ISNULL(d.referenced_schema_name, SCHEMA_NAME()) + '.' + d.referenced_entity_name) 
        WHEN 10 -- or XML schema
            THEN (
                SELECT 1 FROM sys.xml_schema_collections x 
                WHERE x.name = d.referenced_entity_name
                    AND x.[schema_id] = ISNULL(SCHEMA_ID(d.referenced_schema_name), SCHEMA_ID())
                )
        END IS NULL