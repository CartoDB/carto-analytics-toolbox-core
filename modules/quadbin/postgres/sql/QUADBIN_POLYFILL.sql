----------------------------
-- Copyright (C) 2022 CARTO
----------------------------

CREATE OR REPLACE FUNCTION _SAFE_QUADBIN_POLYFILL(
  geom GEOMETRY,
  resolution INT
)
RETURNS BIGINT[]
 AS
$BODY$
  SELECT CASE
    WHEN resolution IS NULL OR geom IS NULL
    THEN NULL
    ELSE (
      WITH
      __geom4326 AS (
          SELECT CASE ST_SRID(geom)
            WHEN 0 THEN ST_SetSRID(geom, 4326)
            ELSE ST_TRANSFORM(geom, 4326)
          END AS geom4326
      ),
      __bbox AS (
          SELECT geom4326, Box2D(geom4326) AS b FROM __geom4326
      ),
      __params AS (
          SELECT
              geom4326,
              resolution AS z,
              ST_XMIN(b) AS minlon,
              ST_YMIN(b) AS minlat,
              ST_XMAX(b) AS maxlon,
              ST_YMAX(b) AS maxlat
          FROM __bbox
      ),
      __tile_coords_range AS (
          SELECT
              geom4326,
              z,
              FLOOR((1 << z) * ((minlon / 360.0) + 0.5))::INT AS xmin,
              FLOOR((1 << z) * (0.5 - (LN(TAN(PI()/4.0 + maxlat/2.0 * PI()/180.0)) / (2*PI()))))::INT AS ymin,
              FLOOR((1 << z) * ((maxlon / 360.0) + 0.5))::INT AS xmax,
              FLOOR((1 << z) * (0.5 - (LN(TAN(PI()/4.0 + minlat/2.0 * PI()/180.0)) / (2*PI()))))::INT AS ymax
          FROM __params
      ),
      __cells AS (
          SELECT
              geom4326,
              @@PG_PREFIX@@carto.QUADBIN_FROMZXY(z, x, y) AS quadbin
          FROM __tile_coords_range,
              generate_series(xmin, xmax) AS x,
              generate_series(ymin, ymax) AS y
      )
      SELECT ARRAY_AGG(quadbin)
      FROM __cells
      WHERE ST_INTERSECTS(
          @@PG_PREFIX@@carto.QUADBIN_BOUNDARY(quadbin),
          geom4326
      )
    )
    END;
$BODY$
  LANGUAGE SQL;

CREATE OR REPLACE FUNCTION QUADBIN_POLYFILL(
  geom GEOMETRY,
  resolution INT
)
RETURNS BIGINT[]
 AS
$BODY$
BEGIN
    IF resolution < 0 OR resolution > 26 THEN
      RAISE EXCEPTION 'Invalid resolution %; should be between 0 and 26', resolution;
    END IF;

    RETURN @@PG_PREFIX@@carto._SAFE_QUADBIN_POLYFILL(geom, resolution);
END;
$BODY$
  LANGUAGE PLPGSQL;