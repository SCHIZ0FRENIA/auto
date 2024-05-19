
-- auto sys

grant all privileges to programmer;
alter user programmer quota unlimited on auto_ts;

commit;

GRANT READ, WRITE ON DIRECTORY serialization TO programmer;
grant execute on utl_file to programmer;
grant create any directory to programmer;
commit;

select name from v$datafile;

select * from ALL_DIRECTORIES;

create or replace directory serialization as 'C:\app\oradata\ORCL\AUTO\PDBSEED\ser';