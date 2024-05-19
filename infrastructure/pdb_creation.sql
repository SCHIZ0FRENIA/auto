
-- cdb sys
CREATE PLUGGABLE DATABASE auto 
  ADMIN USER programmer IDENTIFIED BY 12341234
  STORAGE (MAXSIZE 2G)
  DEFAULT TABLESPACE auto_ts
    DATAFILE 'C:\APP\ORADATA\ORCL\autoauto01.dbf' SIZE 250M 
    AUTOEXTEND ON
  FILE_NAME_CONVERT = ('C:\APP\ORADATA\ORCL', 'C:\APP\ORADATA\ORCL\AUTO');

alter pluggable database auto open;

alter pluggable database auto close immediate;

select name from v$datafile;

alter pluggable database auto unplug into 'C:/APP/ORADATA/ORCL/shit1.xml';

drop pluggable database auto;