CREATE TABLE Orders (
	OrderId int,
	ProductId int,
	Comments varchar(255)
)

INSERT INTO Orders
VALUES (1, 233, 'Fragile')

INSERT INTO Orders
VALUES (2, 284, 'Expedite')

INSERT INTO Orders
VALUES (4, 212, 'Rush')

INSERT INTO Orders
VALUES (3, 200, 'Recurring')


SELECT * FROM Orders

exec sp_addextendedproperty  
     @name = N'test' 
    ,@value = N'First test.' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'Orders' 
    ,@level2type = N'Column', @level2name = 'OrderId'
go

select * 
from sys.tables

select * 
from sys.extended_properties 
where NAME = 'test'

SELECT
   SCHEMA_NAME(tbl.schema_id) AS SchemaName,	
   tbl.name AS TableName, 
   clmns.name AS ColumnName,
   p.name AS ExtendedPropertyName,
   CAST(p.value AS sql_variant) AS ExtendedPropertyValue
FROM
   sys.tables AS tbl
   INNER JOIN sys.all_columns AS clmns ON clmns.object_id=tbl.object_id
   INNER JOIN sys.extended_properties AS p ON p.major_id=tbl.object_id AND p.minor_id=clmns.column_id AND p.class=1
WHERE
   SCHEMA_NAME(tbl.schema_id)='dbo'
   and tbl.name='Orders'


CREATE VIEW OrdersProperties AS
   SELECT
      SCHEMA_NAME(tbl.schema_id) AS SchemaName,	
      tbl.name AS TableName, 
      clmns.name AS ColumnName,
      p.name AS ExtendedPropertyName,
      CAST(p.value AS sql_variant) AS ExtendedPropertyValue
   FROM
      sys.tables AS tbl
      INNER JOIN sys.all_columns AS clmns ON clmns.object_id=tbl.object_id
      INNER JOIN sys.extended_properties AS p ON p.major_id=tbl.object_id AND p.minor_id=clmns.column_id AND p.class=1
   WHERE
      SCHEMA_NAME(tbl.schema_id)='dbo'
      and tbl.name='Orders';
         

exec sp_addextendedproperty  
     @name = N'Description' 
    ,@value = N'String based text collected from order form.' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'Orders' 
    ,@level2type = N'Column', @level2name = 'Comments'
go

exec sp_addextendedproperty  
     @name = N'Description' 
    ,@value = N'Primary key for orders. stflower 2/5/2024' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'Orders' 
    ,@level2type = N'Column', @level2name = 'OrderId'
go



exec sp_addextendedproperty  
     @name = N'Owner' 
    ,@value = N'Steve Flowers' 
    ,@level0type = N'Schema', @level0name = 'dbo' 
    ,@level1type = N'Table',  @level1name = 'Orders' 
    ,@level2type = N'Column', @level2name = 'Comments'
go
