/*
  Create user defined object types that will make it possible to model
    real-world entities as objects in the database. Process of applying an
    object model to relational data.
*/
CREATE OR REPLACE TYPE StripType_typ FORCE AS OBJECT (
    type_id         NUMBER(38,0)
  , type_name       NVARCHAR2(20)
  , type_desc       NVARCHAR2(50)
);

CREATE OR REPLACE TYPE StripMfr_typ FORCE AS OBJECT (
    mfr_id          NUMBER(38,0)
  , mfr_name        NVARCHAR2(50)
  , mfr_desc        NVARCHAR2(40)
);

CREATE OR REPLACE TYPE StripMfrModel_typ FORCE AS OBJECT (
    model_id        NUMBER(38,0)
  , model_name      NVARCHAR2(20)
  , model_desc      NVARCHAR2(40)
  , sheight         FLOAT
  , swidth          FLOAT
  , sdepth          FLOAT
  , rail_size       FLOAT
  , mount           NVARCHAR2(80)
  , mfr_id          NUMBER(38,0)
  , mfr_t           REF StripMfr_typ
);

CREATE OR REPLACE TYPE Strip_typ FORCE AS OBJECT (
    strip_id        NUMBER(38,0)
  , strip_name      NVARCHAR2(30)
  , strip_seq       NUMBER(38,0)
  , mounting        NVARCHAR2(30)
  , dimensions      NVARCHAR2(40)
  , def_flg         NCHAR(1)
  , rail            NCHAR(20)
  , category        NCHAR(1)
  , terminator_flg  NCHAR(1)
  , connect_flg     NCHAR(1)
  , panel_id        NUMBER(38,0)
  , type_t          REF StripType_typ
  , mfr_model_t     REF StripMfrModel_typ
);
/

/*
  Create virtual object tables where each row in the view is an type object.
    You can access the methods & attributes of REF types using dot notation.
    ( Example: SELECT uv.area_t.plant_t.plant_name, uv.area_t.area_name
                    , uv.unit_name FROM Unit_View uv; 
*/
CREATE OR REPLACE VIEW StripType_View OF StripType_typ WITH OBJECT IDENTIFIER (type_id)
AS
  SELECT strip_type_id, strip_type_name, strip_type_desc
  FROM Strip_Type
;

CREATE OR REPLACE VIEW StripMfr_View OF StripMfr_typ WITH OBJECT IDENTIFIER (mfr_id)
AS
  SELECT strip_mfr_id, strip_mfr_name, strip_mfr_desc,
  FROM Strip_Mfr
;

CREATE OR REPLACE VIEW StripMfrModel_View OF StripMfrModel_typ WITH OBJECT IDENTIFIER (mfr_id, model_id)
AS
  SELECT strip_mod_id, strip_mod_name, strip_mod_desc, strip_height, strip_width, strip_depth
        , strip_rail_size, strip_mnt, strip_mfr_id,
        MAKE_REF(StripMfr_View, strip_mfr_id) AS mfr_t
  FROM Strip_Mfr_Mod
;

CREATE OR REPLACE VIEW Strip_View OF Strip_typ WITH OBJECT IDENTIFIER (strip_id) 
AS
	SELECT strip_id, strip_name, panel_strip_seq, mounting, dimensions, def_flg
      , rail, strip_category, terminator_flg, connection_flg, panel_id,
      MAKE_REF(StripType_View, strip_type_id) AS type_t,
      MAKE_REF(StripMfrModel_View, strip_mfr_id, strip_mod_id) AS mfr_model_t
  FROM Panel_Strip
;
/



/* 
    //////////////////////////////////////////////////////////////////////////////////
    // @plsql
    //
    //  Code: ODBA_Strip_ORM.pl
    //  Desc: Create object, view, methods, & attributes necessary to apply object
    //         obj-model for SPI Strips relational table data.
    //
    //  Author: JayLotz
    //  Date: 04-Sep-2015
    ////////////////////////////////////////////////////////////////////////////////////// 
*/