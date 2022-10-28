CREATE DATABASE SCOPED CREDENTIAL ASCredencial
WITH
    IDENTITY = 'user',
    SECRET = 'access_key'
;

CREATE EXTERNAL DATA SOURCE ASStorage_Name
WITH (
    TYPE = HADOOP,
    LOCATION = 'abfs://container_name@storage_account.dfs.core.windows.net',
    CREDENTIAL = ASCredencial
);

CREATE EXTERNAL FILE FORMAT CSV_HEADER_REJECTROWS
 WITH (FORMAT_TYPE = DELIMITEDTEXT,
 FORMAT_OPTIONS(
 FIELD_TERMINATOR = '\t',
 STRING_DELIMITER = '"' ,
 FIRST_ROW = 2,
 USE_TYPE_DEFAULT = True,
 Encoding = 'UTF8'
 )
 )

CREATE EXTERNAL TABLE dbo.table_name
(
column_name1 varchar(400),
column_name2 varchar(400),
column_name3 varchar(400),
column_name4 varchar(400),
column_name5 varchar(400)
)
WITH
(
    LOCATION='/data/file_name.csv'
,   DATA_SOURCE = ASStorage_Name
,   FILE_FORMAT = CSV_HEADER_REJECTROWS
,   REJECT_TYPE = value
,   REJECT_VALUE = 10000
,   REJECTED_ROW_LOCATION = '/data/rejected/table_name'
)
;

select * from dbo.table_name