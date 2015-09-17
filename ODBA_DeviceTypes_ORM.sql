/* Instrument Type Type
======================== */
CREATE OR REPLACE TYPE InstrType_typ AS OBJECT(
    inst_type_id    NUMBER(38,0)
);
-- Instrument Type View
CREATE OR REPLACE VIEW InstrType_View OF InstrType_typ WITH OBJECT IDENTIFIER (inst_type_id)
AS
    SELECT 0 FROM DUAL;
-- ===Instrument Type=============


/*  Location Type
======================== */
CREATE OR REPLACE TYPE Location_typ AS OBJECT(
    location_id    NUMBER(38,0)
);
-- Location View
CREATE OR REPLACE VIEW Location_View OF Location_typ WITH OBJECT IDENTIFIER (location_id)
AS
    SELECT 0 FROM DUAL;
-- ===Location Type=============


/*  SignalIo View
======================== */
CREATE OR REPLACE TYPE SignalIo_typ AS OBJECT(
    io_id    NUMBER(38,0)
);
-- SignalIo View
CREATE OR REPLACE VIEW SignalIo_View OF SignalIo_typ WITH OBJECT IDENTIFIER (io_id)
AS
    SELECT 0 FROM DUAL;
-- ===SignalIo Type=============


/*  Device Status Type
======================== */
CREATE OR REPLACE TYPE Status_typ FORCE AS OBJECT (
    stat_id         NUMBER(38,0)
    , name          NVARCHAR2(40)
    , describe      NVARCHAR2(40)
    , proj_id       NUMBER(38,0)
);
--  Device Status View
CREATE OR REPLACE VIEW Status_View OF Status_typ WITH OBJECT IDENTIFIER (stat_id)
AS
    SELECT cmpnt_handle_id, cmpnt_handle_name, cmpnt_handle_desc, proj_id
    FROM component_handle;
-- ===Device Status=============


/*  Equipment Type
======================== */
CREATE OR REPLACE TYPE Equip_typ AS OBJECT(
    equip_id    NUMBER(38,0)
);
-- Equipment View
CREATE OR REPLACE VIEW Equip_View OF Equip_typ WITH OBJECT IDENTIFIER (equip_id)
AS
    SELECT 0 FROM DUAL;
-- ===Equipment Type=============


/*  Loop Type
======================== */
CREATE OR REPLACE TYPE Loop_typ AS OBJECT(
    type_id    NUMBER(38,0)
);
-- Loop View
CREATE OR REPLACE VIEW Loop_View OF Loop_typ WITH OBJECT IDENTIFIER (type_id)
AS
    SELECT 0 FROM DUAL;
-- ===Loop Type=============


/*  Device Mfr Model Type
======================== */
CREATE OR REPLACE TYPE DeviceMfrModel_typ FORCE AS OBJECT (
    mod_id          NUMBER(38,0)
    , mod_name      NVARCHAR2(20)
    , mod_desc      NVARCHAR2(40)
    , proj_id       NUMBER(38,0)
    , mfr_id        NUMBER(38,0)
    , mfr_t         REF DeviceMfr_typ
);
--  Device Mfr Model View
CREATE OR REPLACE VIEW DeviceMfrModel_View OF DeviceMfrModel_typ WITH OBJECT IDENTIFIER (mfr_id, mod_id)
AS
    SELECT cmpnt_mod_id, cmpnt_mod_name, cmpnt_mod_desc, proj_id, cmpnt_mfr_id,
            MAKE_REF(DeviceMfr_View,cmpnt_mfr_id)
    FROM component_mod;
-- ===Device Mfr Model=============


/*  Device Mfr Type
======================== */
CREATE OR REPLACE TYPE DeviceMfr_typ FORCE AS OBJECT (
    mfr_id          NUMBER(38,0)
    , mfr_name      NVARCHAR2(20)
    , mfr_desc      NVARCHAR2(40)
    , company_id    NVARCHAR2(40)
    , proj_id       NUMBER(38,0)
);
--  Device Mfr View
CREATE OR REPLACE VIEW DeviceMfr_View OF DeviceMfr_typ WITH OBJECT IDENTIFIER (mfr_id)
AS
    SELECT cmpnt_mfr_id, cmpnt_mfr_name, cmpnt_mfr_desc, mfr_company_identification, proj_id
    FROM component_mfr;
-- ===Device Mfr=============


/*  Process Type
======================== */
CREATE OR REPLACE TYPE Process_typ FORCE AS OBJECT (
    proc_id     NUMBER(38,0)
    , name      NVARCHAR2(20)
    , form      NVARCHAR2(40)
);
--  Process View
CREATE OR REPLACE VIEW Process_View OF Process_typ WITH OBJECT IDENTIFIER (proc_id)
AS
    SELECT proc_func_id, proc_func_name, proc_func_form
    FROM process_function;
-- ===Process Type=============


/*  PID Type
======================== */
CREATE OR REPLACE TYPE PID_typ AS OBJECT(
    pid_id    NUMBER(38,0)
);
CREATE OR REPLACE VIEW PID_View OF PID_typ WITH OBJECT IDENTIFIER (pid_id)
AS
    SELECT 0 FROM DUAL;
-- ===PID Type=============


/*  Line Type
======================== */
CREATE OR REPLACE TYPE Line_typ AS OBJECT(
    line_id    NUMBER(38,0)
);
-- Line View
CREATE OR REPLACE VIEW Line_View OF Line_typ WITH OBJECT IDENTIFIER (line_id)
AS
    SELECT 0 FROM DUAL;
-- ===Line Type=============


/*  Critical Type
======================== */
CREATE OR REPLACE TYPE Critical_typ AS OBJECT(
    critical_id    NUMBER(38,0)
);
CREATE OR REPLACE VIEW Critical_View OF Critical_typ WITH OBJECT IDENTIFIER (critical_id)
AS
    SELECT 0 FROM DUAL;
-- ===Critical Type=============


/*  EXi Certification Type
======================== */
CREATE OR REPLACE TYPE Certif_Type FORCE AS OBJECT (
    cert_id          NUMBER(38,0)
    , name          NVARCHAR2(20)
    , describe      NVARCHAR2(40)
    , proj_id       NUMBER(38,0)
);
--  EXi Certification View
CREATE OR REPLACE VIEW Certif_View OF Certif_Type WITH OBJECT IDENTIFIER (cert_id)
AS
    SELECT cmpnt_certif_id, cmpnt_certif_name, cmpnt_certif_desc, proj_id
    FROM component_certification;
-- ===EXi Certification=============


/*  UserTable Type
======================== */
CREATE OR REPLACE TYPE UserTable_typ AS OBJECT(
    usertable_id    NUMBER(38,0)
    , name      NVARCHAR2(40)
    , describe  NVARCHAR2(40)
);
CREATE OR REPLACE VIEW UserTable_View OF UserTable_typ WITH OBJECT IDENTIFIER (UDT_SUPPORT1.UDT_SUPPORT_ID)
AS
    SELECT UDT_SUPPORT1.UDT_SUPPORT_ID , UDT_SUPPORT1.DESCRIPTION , UDT_SUPPORT1.NAME
FROM UDT_SUPPORT1;
-- ===UserTable Type=============


/*  Signal Type
======================== */
CREATE OR REPLACE TYPE SignalType_typ AS OBJECT(
    signaltype_id    NUMBER(38,0)
);
-- Signal View
CREATE OR REPLACE VIEW SignalIo_View OF SignalType_typ WITH OBJECT IDENTIFIER (signaltype_id)
AS
    SELECT 0 FROM DUAL;
-- ===Signal Type=============


/*  Linearity View
======================== */
CREATE OR REPLACE TYPE Linearity_typ AS OBJECT(
    linear_id    NUMBER(38,0)
);
-- Linearity View
CREATE OR REPLACE VIEW Linearity_View OF Linearity_typ WITH OBJECT IDENTIFIER (linear_id)
AS
    SELECT 0 FROM DUAL;
-- ===Linearity Type=============


/*  TagTypical View
======================== */
CREATE OR REPLACE TYPE TagTypical_typ AS OBJECT(
    typical_id    NUMBER(38,0)
);
-- TagTypical View
CREATE OR REPLACE VIEW TagTypical_View OF TagTypical_typ WITH OBJECT IDENTIFIER (typical_id)
AS
    SELECT 0 FROM DUAL;
-- ===TagTypical Type=============