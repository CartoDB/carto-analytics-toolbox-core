---------------------------------
-- Copyright (C) 2021-2023 CARTO
---------------------------------

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_POLYFILL_GEOJSON(
    geojson TEXT,
    resolution INTEGER
)
RETURNS VARCHAR(16)[]
AS
$BODY$
    if (!geojson || resolution == null) {
        return [];
    }
    if (resolution < 0 || resolution > 15) {
        return [];
    }

    @@PG_LIBRARY_H3@@

    const bboxA = [-180, -90, 0, 90]
    const bboxB = [0, -90, 180, 90]
    const featureGeometry = JSON.parse(geojson)
    let polygonCoordinatesA = [];
    let polygonCoordinatesB = [];
    switch(featureGeometry.type) {
        case 'GeometryCollection':
            featureGeometry.geometries.forEach(function (geom) {
                if (geom.type === 'MultiPolygon') {
                    var clippedGeometryA = h3Lib.bboxClip(geom, bboxA).geometry;
                    polygonCoordinatesA = polygonCoordinatesA.concat(clippedGeometryA.coordinates);
                    var clippedGeometryB = h3Lib.bboxClip(geom, bboxB).geometry;
                    polygonCoordinatesB = polygonCoordinatesB.concat(clippedGeometryB.coordinates);
                } else if (geom.type === 'Polygon') {
                    var clippedGeometryA = h3Lib.bboxClip(geom, bboxA).geometry;
                    polygonCoordinatesA = polygonCoordinatesA.concat([clippedGeometryA.coordinates]);
                    var clippedGeometryB = h3Lib.bboxClip(geom, bboxB).geometry;
                    polygonCoordinatesB = polygonCoordinatesB.concat([clippedGeometryB.coordinates]);
                }
            });
        break;
        case 'MultiPolygon':
            var clippedGeometryA = h3Lib.bboxClip(featureGeometry, bboxA).geometry;
            polygonCoordinatesA = clippedGeometryA.coordinates;
            var clippedGeometryB = h3Lib.bboxClip(featureGeometry, bboxB).geometry;
            polygonCoordinatesB = clippedGeometryB.coordinates;
        break;
        case 'Polygon':
            var clippedGeometryA = h3Lib.bboxClip(featureGeometry, bboxA).geometry;
            polygonCoordinatesA = [clippedGeometryA.coordinates];
            var clippedGeometryB = h3Lib.bboxClip(featureGeometry, bboxB).geometry;
            polygonCoordinatesB = [clippedGeometryB.coordinates];
        break;
        default:
            return [];
    }

    if (polygonCoordinatesA.length + polygonCoordinatesB.length === 0) {
        return [];
    }

    let hexesA = polygonCoordinatesA.reduce(
        (acc, coordinates) => acc.concat(h3Lib.polyfill(coordinates, resolution, true)),
        []
    ).filter(h => h != null);
    let hexesB = polygonCoordinatesB.reduce(
        (acc, coordinates) => acc.concat(h3Lib.polyfill(coordinates, resolution, true)),
        []
    ).filter(h => h != null);
    hexes = [...hexesA, ...hexesB];
    hexes = [...new Set(hexes)];

    return hexes;
$BODY$
LANGUAGE plv8 IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_AVG_EDGE_LENGTH
(resolution INTEGER)
RETURNS FLOAT8
AS
$BODY$
    SELECT CASE resolution
    WHEN 0 THEN 1281256.011
    WHEN 1 THEN 483056.8391
    WHEN 2 THEN 182512.9565
    WHEN 3 THEN 68979.22179
    WHEN 4 THEN 26071.75968
    WHEN 5 THEN 9854.090990
    WHEN 6 THEN 3724.532667
    WHEN 7 THEN 1406.475763
    WHEN 8 THEN 531.414010
    WHEN 9 THEN 200.786148
    WHEN 10 THEN 75.863783
    WHEN 11 THEN 28.663897
    WHEN 12 THEN 10.830188
    WHEN 13 THEN 4.092010
    WHEN 14 THEN 1.546100
    WHEN 15 THEN 0.584169
    ELSE
        @@PG_SCHEMA@@.__CARTO_ERROR(FORMAT('Invalid resolution "%s"; should be between 0 and 26', resolution))::FLOAT8
    END
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_POLYFILL_INIT
(geom GEOMETRY, resolution INTEGER)
RETURNS VARCHAR(16)[]
AS
$BODY$
    SELECT CASE
        WHEN resolution < 0 OR resolution > 26 THEN @@PG_SCHEMA@@.__CARTO_ERROR(FORMAT('Invalid resolution "%s"; should be between 0 and 26', resolution))::VARCHAR(16)[]
        WHEN resolution IS NULL OR geom IS NULL THEN NULL::VARCHAR(16)[]
        ELSE
            @@PG_SCHEMA@@.__H3_POLYFILL_GEOJSON(
                ST_ASGEOJSON(ST_BUFFER(geom, @@PG_SCHEMA@@.__H3_AVG_EDGE_LENGTH(resolution))),
                resolution
            )
    END;
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_INTERSECTS
(geom GEOMETRY, resolution INTEGER)
RETURNS VARCHAR(16)[]
AS
$BODY$
    WITH cells AS (
        SELECT h3
        FROM
            UNNEST(@@PG_SCHEMA@@.__H3_POLYFILL_INIT(geom, (resolution - 2))) AS parent,
            UNNEST(@@PG_SCHEMA@@.H3_TOCHILDREN(parent, resolution)) AS h3
    )
    SELECT ARRAY_AGG(h3)
    FROM cells
    WHERE ST_INTERSECTS(geom, @@PG_SCHEMA@@.H3_BOUNDARY(h3))
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_CONTAINS
(geom GEOMETRY, resolution INTEGER)
RETURNS VARCHAR(16)[]
AS
$BODY$
    WITH cells AS (
        SELECT h3
        FROM
            UNNEST(@@PG_SCHEMA@@.__H3_POLYFILL_INIT(geom, (resolution - 2))) AS parent,
            UNNEST(@@PG_SCHEMA@@.H3_TOCHILDREN(parent, resolution)) AS h3
    )
    SELECT ARRAY_AGG(h3)
    FROM cells
    WHERE ST_CONTAINS(geom, @@PG_SCHEMA@@.H3_BOUNDARY(h3))
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_CENTER
(geom GEOMETRY, resolution INTEGER)
RETURNS VARCHAR(16)[]
AS
$BODY$
    WITH cells AS (
        SELECT h3
        FROM
            UNNEST(@@PG_SCHEMA@@.__H3_POLYFILL_INIT(geom, (resolution - 2))) AS parent,
            UNNEST(@@PG_SCHEMA@@.H3_TOCHILDREN(parent, resolution)) AS h3
    )
    SELECT ARRAY_AGG(h3)
    FROM cells
    WHERE ST_INTERSECTS(geom, @@PG_SCHEMA@@.H3_CENTER(h3))
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.H3_POLYFILL_MODE
(geom GEOMETRY, resolution INTEGER, mode TEXT)
RETURNS VARCHAR(16)[]
AS
$BODY$
    SELECT CASE mode
        WHEN 'intersects' THEN @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_INTERSECTS(geom, resolution)
        WHEN 'contains' THEN @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_CONTAINS(geom, resolution)
        WHEN 'center' THEN @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_CENTER(geom, resolution)
    END
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE FUNCTION @@PG_SCHEMA@@.H3_POLYFILL
(geom GEOMETRY, resolution INTEGER)
RETURNS VARCHAR(16)[]
AS
$BODY$
    SELECT CASE ST_DIMENSION(geom)
        WHEN 0 THEN
            ARRAY[@@PG_SCHEMA@@.H3_FROMGEOGPOINT(geom, resolution)]
        ELSE
            @@PG_SCHEMA@@.__H3_POLYFILL_CHILDREN_INTERSECTS(geom, resolution)
    END
$BODY$
LANGUAGE sql IMMUTABLE PARALLEL SAFE;
