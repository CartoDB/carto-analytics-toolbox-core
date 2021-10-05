----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@transformations.__CENTERMEDIAN
(geom VARCHAR(MAX), n_iter INT)
RETURNS VARCHAR(MAX)
IMMUTABLE
AS $$
    from @@RS_PREFIX@@transformationsLib import center_median
    import geojson
    
    if geom is None or n_iter is None:
        return None

    return str(center_median(geojson.loads(geom), n_iter))
$$ LANGUAGE plpythonu;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@transformations.ST_CENTERMEDIAN
(GEOMETRY)
-- (geom)
RETURNS GEOMETRY
IMMUTABLE
AS $$
    SELECT @@RS_PREFIX@@transformations.__ST_GEOMFROMGEOJSON(@@RS_PREFIX@@transformations.__CENTERMEDIAN(ST_ASGEOJSON($1)::VARCHAR(MAX), 100))
$$ LANGUAGE sql;