----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.QUADBIN_TOPARENT
(BIGINT, INT)
-- (quadbin, resolution)
RETURNS BIGINT
STABLE
AS $$
  SELECT ($1 & ~(CAST(31 AS BIGINT) << 52)) | (CAST($2 AS BIGINT) << 52) | (4503599627370495 >> ($2 << 1))
$$ LANGUAGE sql;