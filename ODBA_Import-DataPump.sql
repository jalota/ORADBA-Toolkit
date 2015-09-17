/* Set SQL shell environment parameters */
SET SCAN OFF
SET SERVEROUTPUT ON
SET ESCAPE OFF
WHENEVER SQLERROR EXIT 
DECLARE
    h1            NUMBER;
    errorvarchar  VARCHAR2(100) := 'ERROR';
    tryGetStatus  NUMBER        := 0;
BEGIN
    /* Open a job to get the handle id */
    h1 := dbms_datapump.open   ( operation => 'IMPORT', job_mode => 'SCHEMA', job_name => 'IMPORT_JOB_SQLDEV_101', version => 'COMPATIBLE' ); 
    tryGetStatus := 1;

    /* 
        Set datapump files, directory, and optional parameters.
         Remove comments to include features. Be sure to chang the 
         option values before including. 
    ==================================================================  */
#    dbms_datapump.set_parallel    ( handle => h1, degree   => 2 ); 
    dbms_datapump.add_file        ( handle => h1, filename => 'IMPORT.LOG' , directory => 'DMP_DIR', filetype => 3 ); 
    dbms_datapump.set_parameter   ( handle => h1, name  => 'KEEP_MASTER'   , value     => 1 ); 
    dbms_datapump.metadata_filter ( handle => h1, name  => 'SCHEMA_EXPR'   , value     => 'IN(''IN_DBAMN'',''INTOOLS_ENGINEER'',''INTOOLS_LOGIN'',''KNPC'',''KNPC_VIEW'')' ); 
    dbms_datapump.add_file        ( handle => h1, filename => 'EXPDP.DMP'  , directory => 'DMP_DIR', filetype => 1 ); 
    dbms_datapump.set_parameter   ( handle => h1, name  => 'INCLUDE_METADATA' , value  => 1 ); 
    dbms_datapump.metadata_transform ( handle => h1, name  => 'OID'        , value     => 0 , object_type => null  );
#    dbms_datapump.metadata_filter ( handle => h1, name  => 'NAME_EXPR'     , value     => 'IN(KNPC.CHANGES_LOG, KNPC.SPEC_REVISION_DOCUMENT_MAIN )', object_type => 'TABLE' ); 
    dbms_datapump.set_parameter   ( handle => h1, name  => 'DATA_ACCESS_METHOD'    , value => 'AUTOMATIC' ); 
    dbms_datapump.set_parameter   ( handle => h1, name  => 'TABLE_EXISTS_ACTION'   , value => 'REPLACE'   ); 
    dbms_datapump.set_parameter   ( handle => h1, name  => 'SKIP_UNUSABLE_INDEXES' , value => 1 );
    dbms_datapump.start_job       ( handle => h1, skip_current => 0, abort_step => 0 ); 

    /* Stop and close the import job */
    dbms_datapump.detach          ( handle => h1 ); 
    errorvarchar := 'NO_ERROR'; 

EXCEPTION           -- Include exceptions
    WHEN OTHERS THEN
    BEGIN 
        IF (( errorvarchar = 'ERROR' ) AND ( tryGetStatus=1 )) THEN 
            dbms_datapump.detach(h1);
        END IF;
    EXCEPTION 
    WHEN OTHERS THEN 
        NULL;
    END;
    RAISE;          -- Raise program error
END;
/

