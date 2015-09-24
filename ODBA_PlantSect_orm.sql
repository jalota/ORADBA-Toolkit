/* =============================================
     Ceate Type Objects
   ============================================= */
--
-- #  Plant_obj         <<type-object>>
CREATE OR REPLACE TYPE Plant_obj FORCE AS OBJECT ( 
  id_Plant      NUMBER(38,0),
  name          NVARCHAR2(50),
  note          NVARCHAR2(200),
  plant_flg     NCHAR(1)
);
-- # Plant_View         <<table-view>>
CREATE OR REPLACE VIEW Plant_View OF Plant_obj 
    WITH OBJECT IDENTIFIER (id_Plant) AS
SELECT plant_id, plant_name, plant_note, plant_flg 
FROM plant ;
/
--
-- #  Area_obj          <<type-object>>
CREATE OR REPLACE TYPE Area_obj AS OBJECT ( 
  id_Plant      NUMBER(38,0),                                              
  id_Area       NUMBER(38,0),
  name          NVARCHAR2(50),
  note          NVARCHAR2(200),
  path          NVARCHAR2(255)
) ;
-- #  Area_View          <<table-view>>
-- # AREA_VIEW
CREATE OR REPLACE VIEW Area_View OF Area_obj 
    WITH OBJECT IDENTIFIER (id_Area,id_Plant) AS
SELECT plant_id, area_id, area_name, area_note, pau_path 
FROM plant_area;
/
--
-- #  Unit_obj          <<type-object>> 
CREATE OR REPLACE TYPE Unit_obj AS OBJECT ( 
  id_Plant      NUMBER(38,0),
  id_Area       NUMBER(38,0),                                           
  id_Unit       NUMBER(38,0),
  name          NVARCHAR2(50),
  code          NVARCHAR2(40),
  note          NVARCHAR2(200)
) ;
-- #  Unit_View         <<table-view>> 
CREATE OR REPLACE VIEW Unit_View OF Unit_obj 
    WITH OBJECT IDENTIFIER (id_Unit,id_Area,id_Plant) AS  
SELECT plant_id, area_id, unit_id, unit_name, unit_num, unit_note 
FROM plant_area_unit;
/
--
-- #  Project_obj       <<type-object>>
CREATE OR REPLACE TYPE Project_obj FORCE AS OBJECT ( 
  id_Project    NUMBER(38,0),
  name          NVARCHAR2(30),
  describe      NVARCHAR2(30),
  note          NVARCHAR2(255),
  activ_track_flg NCHAR(1),
  logo_name     NVARCHAR2(80),
  proj_del      NCHAR(1),
  code          NVARCHAR2(20),
  tag_conv_flg  NCHAR(1)
);
-- #  Project_View       <<table-view>>
CREATE OR REPLACE VIEW Project_View OF Project_obj 
    WITH OBJECT IDENTIFIER (id_Project) AS
SELECT proj_id, proj_name, proj_desc, proj_note, activ_track_flg, logo_name, proj_del
     , proj_num, tag_conv_flg 
FROM project_info;
/
--
-- #  PlantSect_obj     <<type-object>>
CREATE OR REPLACE TYPE PlantSect_obj AS OBJECT (
    id_Plant      NUMBER(38,0),
    id_Area       NUMBER(38,0),
    id_Unit       NUMBER(38,0),
    id_Project    NUMBER(38,0),
    Unit_ref      REF Unit_obj,
    Area_ref      REF Area_obj,
    Plant_ref     REF Plant_obj,
--    Project_ref   REF Project_obj,
--    MEMBER FUNCTION unit_name (id_Plant IN id_Plant, id_Area IN id_Area, id_Unit IN id_Unit) RETURN VARCHAR2,
--    MEMBER FUNCTION area_name (id_Plant IN id_Plant, id_Area IN id_Area) RETURN VARCHAR2,
--    MEMBER FUNCTION plant_name (id_Plant IN id_Plant) RETURN VARCHAR2,
--    MEMBER FUNCTION project_name (id_Project IN id_Project) RETURN VARCHAR2
);
-- #  PlantSect_obj       <<type-body>>
-- CREATE TYPE BODY PlantSect_obj AS OBJECT (           
--   FUNCTION unit_name (id_Plant, id_Area, id_Unit) IS    --Unit_Name
--     v_UnitName    VARCHAR2(50);
--   BEGIN
--     SELECT u.name
--     INTO v_UnitName
--     FROM REF(Unit_View, id_Plant, id_Area, id_Unit) u;

--     RETURN v_UnitName
--   END;

--   FUNCTION area_name (id_Plant, id_Area) IS             --Area_Name
--     v_AreaName    VARCHAR2(50);
--   BEGIN
--     SELECT a.name
--     INTO v_AreaName
--     FROM REF(Area_View, id_Plant, id_Area) u;

--     RETURN v_AreaName
--   END;

--   FUNCTION plant_name (id_Plant) IS                       --Plant_Name
--     v_PlantName    VARCHAR2(50);
--   BEGIN
--     SELECT p.name
--     INTO v_PlantName
--     FROM REF(Plant_View, id_Plant) p;

--     RETURN v_PlantName
--   END;

--   FUNCTION plant_name (id_Project) IS                     --Project_Name
--     v_ProjectName    VARCHAR2(50);
--   BEGIN
--     SELECT p.name
--     INTO v_ProjectName
--     FROM REF(Project_View, id_Project) p;

--     RETURN v_ProjectName
--   END;

-- );
-- #  PlantSect_View          <<table-view>>
CREATE OR REPLACE VIEW PlantSect_View OF PlantSect_obj 
    WITH OBJECT IDENTIFIER (id_Plant, id_Area, id_Unit, id_Project) AS 
SELECT plant_id, area_id, unit_id, proj_id
    , MAKE_REF ( Unit_View , plant_id, area_id, unit_id  )                                                                                                                        
    , MAKE_REF( Area_View , area_id  )
    , MAKE_REF ( Area_View, plant_id, area_id )
    , MAKE_REF ( Plant_View, plant_id )
    -- , MAKE_REF ( Project_View, proj_id )
FROM plant_area_unit 
JOIN plant_area     USING ( plant_id, area_id )
JOIN plant          USING ( plant_id ) ;
/
