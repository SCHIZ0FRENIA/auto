
-- cdb sys
CREATE PLUGGABLE DATABASE auto 
  ADMIN USER programmer IDENTIFIED BY 12341234
  STORAGE (MAXSIZE 2G)
  default tablespace auto_ts
    DATAFILE 'C:\APP\ORADATA\ORCL\auto\auto01.dbf' SIZE 250M 
    AUTOEXTEND ON
    PATH_PREFIX = 'C:\APP\ORADATA\ORCL\auto\'
    FILE_NAME_CONVERT = ('C:\APP\ORADATA\ORCL\PDBSEED\', 
                         'C:\APP\ORADATA\ORCL\auto\');

alter pluggable database auto open;

-- auto sys

grant all privileges to programmer;
alter user programmer quota unlimited on auto_ts;

commit;
