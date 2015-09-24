/*
    DDL for DEVICE Type Object
  ======================================================== */
--  
CREATE OR REPLACE TYPE Device_obj AS OBJECT (
/* ##  Core Properties  ## */
    id_Device             NUMBER(38,0)
  , Device_Tag            NVARCHAR2(50)
  , Service               NVARCHAR2(52)
  , TagNumber             NVARCHAR2(8)
  , TagPrefix             NVARCHAR2(10)
  , TagSuffix             NVARCHAR2(3)
  , ItemPrice             NUMBER(15,2)
  , Note                  NVARCHAR2(2000)
  , Remark1               NVARCHAR2(200)
  , Remark2               NVARCHAR2(200)
  , Remark3               NVARCHAR2(200)
  , Remark4               NVARCHAR2(200)
  , Remark5               NVARCHAR2(100)
  , CmpntSeq              NUMBER(38,0)
  , LoopParam             NVARCHAR2(6)
  , QualityFlg            NCHAR(1)
  , Cmpnt_Find_Rem        NUMBER(38,0)
  , Requisition           NVARCHAR2(60)
  , PipeClass             NVARCHAR2(25)
  , Requires_PwrSupply    NCHAR(1)
  , PwrSupply_TypeFlg     NCHAR(1)     
  , Analyzer_Flg          NCHAR(1)
  , id_Circuite_Type      NUMBER(38,0)
  , Use_Symbol_Flg        NCHAR(1)
  , Associated_DevID      NUMBER(38,0)
  , MergeRel_Flg          NCHAR(1)
  , id_Tag_Typical        NUMBER(38,0)
  
/* ## Support Tables  ## */
  , PlantSect_ref         REF PlantSect_obj
  , Location_ref          REF Location_ob                --//TODO..
  , Status_ref            REF Status_ob                  --//TODO..
  , Equipment_ref         REF Equipment_obj              --//TODO..
--  , CmpntType_ref          REF CmpntType_obj              --//TODO..
--   , Process_ref           REF Process_obj                --//TODO..
  , PID_ref               REF PID_obj                    --//TODO..
--   , Pipeline_ref          REF Pipeline_ob                --//TODO..
--   , Critical_ref          REF Critical_ob                --//TODO..
  , Certificate_ref       REF Certificate_obj            --//TODO..
--   , Category_ref          REF Category_ob                --//TODO..
--   , SignalType_ref        REF SignalType_ob              --//TODO..

/* ## Polymorph Object related types  ## */
--   , Config_ref            REF InstrConfigure_obj         --//TODO..
--   , Specification_ref     REF DevSpec_obj                --//TODO..
--   , ProcessData_ref       REF DevProcessData_obj         --//TODO..
--   , Document_ref          Document_tab                   --//TODO..
--   , Wiring_ref            REF DevElectric_Connect_obj    --//TODO..
--   , Loop_ref              REF SignalLoop_obj             --//TODO..
);


/*
    DDL for View DEVICE_VIEW
  ======================================================== */
CREATE OR REPLACE VIEW Device_View OF Device_obj 
    WITH OBJECT IDENTIFIER (id_Device) AS 
SELECT cmpnt_id,cmpnt_name,cmpnt_serv,cmpnt_num,prefix,cmpnt_suff,item_price
      ,cmpnt_note,Remark1,Remark2,Remark3,Remark4,remark5,cmpnt_seq,loop_param
      ,cmpnt_quality_flg,cmpnt_find_rem,req_no,pipe_class,requires_power_supply
      ,power_supply_type_flag,analyzer_flg,cmpnt_is_circuite_type_id,use_symbol_flg
      ,cmpnt_associated_id,merge_release_flg,typical_tag_class_id
      ,MAKE_REF( PlantSect_View, unit_id,area_id,plant_id ) AS PlantSection
FROM component ;
