/*  Device attribute
================================================ */
CREATE OR REPLACE TYPE Device_Attr AS OBJECT (
  id            NUMBER(38,0),
  name          NVARCHAR2(50),
  descript      NVARCHAR2(200)
);

/*  Device Supporting Tables
================================================ */
--
-- #  Location_View           <<table-view>>
CREATE OR REPLACE VIEW Location_View OF Device_Attr WITH OBJECT IDENTIFIER (id)
AS SELECT cmpnt_loc_id AS id_Location, cmpnt_loc_name AS name, cmpnt_loc_desc AS descript
   FROM component_location ;
--
-- #  Status_View             <<table-view>>
CREATE OR REPLACE VIEW Status_View OF Device_Attr WITH OBJECT IDENTIFIER (id)
AS SELECT cmpnt_handle_id AS id_Status, cmpnt_handle_name AS name, cmpnt_handle_desc AS descript
   FROM component_handle ;
--
-- #  Certification_View      <<table-view>>
CREATE OR REPLACE VIEW Certification_View OF Device_Attr WITH OBJECT IDENTIFIER (id)
AS SELECT cmpnt_certif_id AS id_Certif, cmpnt_certif_name AS name, cmpnt_certif_desc AS descript
   FROM component_certification ;
--
-- #  Type_View               <<table-view>>
--? CREATE OR REPLACE VIEW Type_View OF Device_Attr WITH OBJECT IDENTIFIER (id)
--? AS SELECT cmpnt_func_type_id AS id_Type, cmpnt_func_type_name AS name, cmpnt_func_type_desc AS descript
--?    FROM component_function_type ;
--
-- #  PID_Obj                 <<type-object>>
CREATE OR REPLACE TYPE PID_Obj AS OBJECT (
    id_Pid        NUMBER(38,0)
  , Pid_Code       NVARCHAR2(20)
  , 
);
--
-- #  PID_View                <<table-view>>
CREATE OR REPLACE VIEW Pid_View OF PID_Obj WITH OBJECT IDENTIFIER (id_Pid)
AS SELECT dwg_id AS id_Pid, dwg_name AS Pid_Code
   FROM drawing
   WHERE dwg_type_id = 1
   ORDER BY dwg_name ;
--
-- #  Process_View             <<table-view>>
CREATE OR REPLACE VIEW Process_View OF Device_Attr 
        WITH OBJECT IDENTIFIER (id)
    AS SELECT proc_func_id, proc_func_name, proc_func_desc
       FROM process_function;
    ;

-- ////////////////////////////////////////////////////////////


/*   Manufacturer and Model table and objects
================================================ */
--
-- #  Model_obj               <<type-object>>
CREATE OR REPLACE TYPE Model_obj AS OBJECT (
  id_Make         NUMBER(38,0),
  id_Model        NUMBER(38,0),
  name            NVARCHAR2(100),
  descript        NVARCHAR2(40),
  company_id      NVARCHAR2(40)
);
-- #  Model_View              <<table-view>>
CREATE OR REPLACE VIEW Model_View OF Model_obj WITH OBJECT IDENTIFIER (id_Make,id_Model)
AS SELECT cmpnt_mfr_id, cmpnt_mod_id, cmpnt_mod_name, cmpnt_mod_desc, mod_company_identification
   FROM component_mod;
/
-- #
-- #  Make_obj                <<type-object>> 
CREATE OR REPLACE TYPE Make_obj AS OBJECT (
  id_Make       NUMBER(38,0),
  name          NVARCHAR2(20),
  descript      NVARCHAR2(40),
  url           NVARCHAR2(255)
);
-- #  Device_Mfr_View         <<table-view>>
CREATE OR REPLACE VIEW Make_View OF Make_obj WITH OBJECT IDENTIFIER (id_Make)
AS SELECT cmpnt_mfr_id, cmpnt_mfr_name, cmpnt_mfr_desc, ip_adress
   FROM component_mfr ;
/
-- #
-- #  MakeModel_obj           <<type-object>> 
CREATE OR REPLACE TYPE MakeModel_obj AUTHID CURRENT_USER AS OBJECT (
  id_Make       NUMBER(38,0),
  id_Model      NUMBER(38,0),
  Make_ref      REF Make_obj,
  Model_ref     REF Model_obj
);
-- #  MakeModel_View          <<table-view>>
CREATE OR REPLACE VIEW MakeModel_View OF MakeModel_obj WITH OBJECT IDENTIFIER (id_Make,id_Model)
  SELECT  cmf.cmpnt_mfr_id AS id_Make
        , cmd.cmpnt_mod_id AS id_Model
        , MAKE_REF( Make_View, cmf.cmpnt_mfr_id ) AS Make_ref
        , MAKE_REF( Model_View, cmd.cmpnt_mfr_id,cmd.cmpnt_mod_id ) AS Model_ref
  FROM component_mfr cmf
  LEFT OUTER JOIN component_mod cmd ON (cmf.cmpnt_mfr_id = cmd.cmpnt_mfr_id );
/


/*   Equipment table
================================================ */
-- #
-- #  EquipType_obj           <<type-object>>
CREATE OR REPLACE TYPE EquipType_obj AS OBJECT (
  id_EquipType    NUMBER(38,0),
  name            NVARCHAR2(30),
  descript        NVARCHAR2(60)
);
-- #
-- #  EquipType_View          <<table-view>>
CREATE OR REPLACE VIEW EquipType_View OF EquipType_obj WITH OBJECT IDENTIFIER (id_EquipType)
AS  SELECT equip_type_id, equip_type_name, equip_type_desc
    FROM equipment_type;
/
-- #
-- #  Equip_Attr              <<type-object>>
CREATE OR REPLACE TYPE EquipAttr_obj AS OBJECT (
  pd_eq_material                NVARCHAR2(20),
  pd_source_bank                NVARCHAR2(20),
  pd_up_fluid_name              NVARCHAR2(20),
  pd_up_dens_at_flow            FLOAT,
  pd_up_dens_at_flow_uid        NVARCHAR2(10),
  pd_up_visc_at_flow            FLOAT,
  pd_up_visc_at_flow_uid        NVARCHAR2(10),
  pd_boil_pnt_up                FLOAT,
  pd_boil_pnt_up_uid            NVARCHAR2(10),
  pd_boil_pnt_low               FLOAT,
  pd_boil_pnt_low_uid           NVARCHAR2(10),
  pd_pour_pnt_up                FLOAT,
  pd_pour_pnt_up_uid            NVARCHAR2(10),
  pd_pour_pnt_low               FLOAT,
  pd_pour_pnt_low_uid           NVARCHAR2(10),
  pd_level_nor                  FLOAT,
  pd_level_nor_uid              NVARCHAR2(10),
  pd_preference                 NVARCHAR2(20),
  pd_above_ref                  NVARCHAR2(20),
  pd_e_corrosive_up             NCHAR(1),
  pd_e_erosive_up               NCHAR(1),
  pd_e_toxic_up                 NCHAR(1),
  pd_up_fld_grp                 NVARCHAR2(20),
  pd_low_fld_grp                NVARCHAR2(20),
  pd_up_dens_base               FLOAT,
  pd_up_dens_base_uid           NVARCHAR2(10),
  pd_chemic_abs_up              NVARCHAR2(20),
  pd_chemic_abs_low             NVARCHAR2(20),
  pd_pid_num                    NVARCHAR2(10),
  kks_totalplant                NVARCHAR2(1),
  kks_function_key_prefix       NVARCHAR2(2),
  kks_function_key              NVARCHAR2(3),
  kks_function_key_sequence     NVARCHAR2(2),
  kks_equipment_unit_code       NVARCHAR2(2),
  kks_equipment_unit_sequence   NVARCHAR2(3),
  kks_equipment_unit_add_code   NVARCHAR2(1),
  kks_component_key             NVARCHAR2(2),
  kks_component_key_sequence    NVARCHAR2(2),
  merge_release_flg             NCHAR(1)
);

-- #  Equipment_obj           <<type-object>>
CREATE OR REPLACE TYPE Equipment_obj AS OBJECT (
  id_Equip              NUMBER(38,0)
  , name                NVARCHAR2(50)
  , descript            NVARCHAR2(40)
  , EquipType_ref       REF EquipType_obj
  , add_attr            EquipAttr_obj
);
-- #
-- #  Equipment View           <<table-view>>
CREATE OR REPLACE VIEW Equipment_View OF Equipment_obj WITH OBJECT IDENTIFIER (id_Equip)
AS  SELECT equip_id AS id_Equip, equip_name AS name, equip_desc AS descript
         , MAKE_REF( EquipType_View, equip_type_id ) AS EquipType_ref 
         , EquipAttr_obj(   

                            pd_eq_material,pd_source_bank,pd_up_fluid_name,pd_up_dens_at_flow,pd_up_dens_at_flow_uid
                          , pd_up_visc_at_flow,pd_up_visc_at_flow_uid,pd_boil_pnt_up,pd_boil_pnt_up_uid,pd_boil_pnt_low
                          , pd_boil_pnt_low_uid,pd_pour_pnt_up,pd_pour_pnt_up_uid,pd_pour_pnt_low,pd_pour_pnt_low_uid
                          , pd_level_nor,pd_level_nor_uid,pd_preference,pd_above_ref,pd_e_corrosive_up,pd_e_erosive_up
                          , pd_e_toxic_up,pd_up_fld_grp,pd_low_fld_grp,pd_up_dens_base,pd_up_dens_base_uid,pd_chemic_abs_up
                          , pd_chemic_abs_low,pd_pid_num,kks_totalplant,kks_function_key_prefix,kks_function_key
                          , kks_function_key_sequence,kks_equipment_unit_code,kks_equipment_unit_sequence,kks_equipment_unit_add_code
                          , kks_component_key,kks_component_key_sequence,merge_release_flg
                        ) AS add_attr
    FROM  equipment ;


