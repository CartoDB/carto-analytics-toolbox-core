----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@constructors.__MAKEELLIPSE`
(geojson STRING, xSemiAxis FLOAT64, ySemiAxis FLOAT64, angle FLOAT64, units STRING, steps INT64)
RETURNS STRING
DETERMINISTIC
LANGUAGE js
OPTIONS (library=["@@BQ_LIBRARY_BUCKET@@"])
AS """
    if (!geojson || xSemiAxis == null || ySemiAxis == null) {
        return null;
    }
    let options = {};
    if(angle != null)
    {
        options.angle = Number(angle);
    }
    if(units)
    {
        options.units = units;
    }
    if(steps != null)
    {
        options.steps = Number(steps);
    }
    const ellipse = lib.ellipse(JSON.parse(geojson), Number(xSemiAxis), Number(ySemiAxis), options);
    return JSON.stringify(ellipse.geometry);
""";

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@constructors.ST_MAKEELLIPSE`
(geog GEOGRAPHY, xSemiAxis FLOAT64, ySemiAxis FLOAT64, angle FLOAT64, units STRING, steps INT64)
AS (
    ST_GEOGFROMGEOJSON(`@@BQ_PREFIX@@constructors.__MAKEELLIPSE`(ST_ASGEOJSON(geog), xSemiAxis, ySemiAxis, angle, units, steps))
);