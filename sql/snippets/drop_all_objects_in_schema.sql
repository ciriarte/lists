DECLARE @schemaName VARCHAR(255);
SET @schemaName = 'schema_to_delete';

SELECT 'DROP TABLE ' +
       QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) + '.' +
       QUOTENAME(name) + ';'
  FROM sys.tables
 WHERE OBJECT_SCHEMA_NAME(object_id) = @schemaName;
