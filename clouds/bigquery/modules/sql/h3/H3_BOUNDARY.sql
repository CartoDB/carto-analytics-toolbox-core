----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_DATASET@@.__H3_BOUNDARY`
(index STRING)
RETURNS STRING
DETERMINISTIC
LANGUAGE js
OPTIONS (library=["@@BQ_LIBRARY_BUCKET@@"])
AS """
    if (!index) {
        return null;
    }

    if (!coreLib.h3.h3IsValid(index)) {
        return null;
    }

    const coords = coreLib.h3.h3ToGeoBoundary(index, true);
    let output = `POLYGON((`;
    for (let i = 0; i < coords.length - 1; i++) {
        output += coords[i][0] + ` ` + coords[i][1] + `,`;
    }
    output += coords[coords.length - 1][0] + ` ` + coords[coords.length - 1][1] + `))`;
    return output;
""";

CREATE OR REPLACE FUNCTION `@@BQ_DATASET@@.H3_BOUNDARY`
(index STRING)
RETURNS GEOGRAPHY
AS (
    SAFE.ST_GEOGFROMTEXT(`@@BQ_DATASET@@.__H3_BOUNDARY`(index), make_valid => TRUE)
);