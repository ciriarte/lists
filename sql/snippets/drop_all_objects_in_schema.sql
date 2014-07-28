DECLARE @schemaName VARCHAR(255)

SELECT 'DROP TABLE ' +
       QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) + '.' +
       QUOTENAME(name) + ';'
  FROM sys.tables
 WHERE OBJECT_SCHEMA_NAME(object_id) = @schemaName;
