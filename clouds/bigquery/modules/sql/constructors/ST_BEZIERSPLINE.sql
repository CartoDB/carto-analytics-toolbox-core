----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_DATASET@@.__BEZIERSPLINE`
(geojson STRING, resolution INT64, sharpness FLOAT64)
RETURNS STRING
DETERMINISTIC
LANGUAGE js
OPTIONS (
    library = ["@@BQ_LIBRARY_CONSTRUCTORS_BUCKET@@"]
)
AS """
    if (!geojson) {
        return null;
    }
    const options = {};
    if (resolution != null) {
        options.resolution = Number(resolution);
    }
    if (sharpness != null) {
        options.sharpness = Number(sharpness);
    }
    const curved = constructorsLib.bezierSpline(JSON.parse(geojson), options);
    return JSON.stringify(curved.geometry);
""";

CREATE OR REPLACE FUNCTION `@@BQ_DATASET@@.ST_BEZIERSPLINE`
(geog GEOGRAPHY, resolution INT64, sharpness FLOAT64)
RETURNS GEOGRAPHY
AS (
    ST_GEOGFROMGEOJSON(
        `@@BQ_DATASET@@.__BEZIERSPLINE`(
            ST_ASGEOJSON(geog), resolution, sharpness
        )
    )
);
