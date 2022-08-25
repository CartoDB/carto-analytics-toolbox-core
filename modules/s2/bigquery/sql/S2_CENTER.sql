----------------------------
-- Copyright (C) 2022 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@carto.__S2_CENTER`(id INT64)
RETURNS STRUCT<lng FLOAT64,lat FLOAT64> DETERMINISTIC LANGUAGE js
OPTIONS (library=["@@BQ_LIBRARY_BUCKET@@"])
AS R"""
if (id == null) {
        throw new Error('NULL argument passed to UDF');
    }
    return s2Lib.idToLatLng(String(id));
""";

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@carto.S2_CENTER`
(id INT64)
RETURNS GEOGRAPHY
AS (
    ST_GEOGPOINT(`@@BQ_PREFIX@@carto.__S2_CENTER`(id).lng,`@@BQ_PREFIX@@carto.__S2_CENTER`(id).lat)
);