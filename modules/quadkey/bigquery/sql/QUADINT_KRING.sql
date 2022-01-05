----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@carto.__ZXY_KRING`
  (origin STRUCT<z INT64, x INT64, y INT64>, size INT64)
AS ((
    SELECT
      ARRAY_AGG((`@@BQ_PREFIX@@carto.QUADINT_FROMZXY`(origin.z,
              IF(origin.x+dx<0,origin.x+dx+(1 << origin.z),origin.x+dx),
              origin.y+dy)))
    FROM
      UNNEST(GENERATE_ARRAY(-size,size)) dx,
      UNNEST(GENERATE_ARRAY(-size,size)) dy
    WHERE origin.y+dy >= 0 and origin.y+dy < (1 << origin.z)
));

CREATE OR REPLACE FUNCTION `@@BQ_PREFIX@@carto.QUADINT_KRING`
(origin INT64, size INT64)
AS (
    `@@BQ_PREFIX@@carto.__ZXY_KRING`(`@@BQ_PREFIX@@carto.QUADINT_TOZXY`(origin),size)
);