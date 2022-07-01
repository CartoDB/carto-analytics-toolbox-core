----------------------------
-- Copyright (C) 2022 CARTO
----------------------------
CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_RESULT
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT (
        CAST(FROM_HEX('4000000000000000') AS BIGINT)
        | (1::BIGINT << 59)
        | ($1 << 52)
        | (($2 | ($3 << 1)) >> 12)
        | (CAST(FROM_HEX('00FFFFFFFFFFFFF') AS BIGINT) >> ($1::INT * 2))
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED5
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_RESULT(
        $1,
        ($2 | ($2 << 1)) & CAST(FROM_HEX('5555555555555555') AS BIGINT),
        ($3 | ($3 << 1)) & CAST(FROM_HEX('5555555555555555') AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED4
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED5(
        $1,
        ($2 | ($2 << 2)) & CAST(FROM_HEX('3333333333333333') AS BIGINT),
        ($3 | ($3 << 2)) & CAST(FROM_HEX('3333333333333333') AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED3
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED4(
        $1,
        ($2 | ($2 << 4)) & CAST(FROM_HEX('0f0f0f0f0f0f0f0f') AS BIGINT),
        ($3 | ($3 << 4)) & CAST(FROM_HEX('0f0f0f0f0f0f0f0f') AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED2
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED3(
        $1,
        ($2 | ($2 << 8)) & CAST(FROM_HEX('00ff00ff00ff00ff') AS BIGINT),
        ($3 | ($3 << 8)) & CAST(FROM_HEX('00ff00ff00ff00ff') AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED1
(BIGINT, BIGINT, BIGINT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED2(
        $1,
        ($2 | ($2 << 16)) & CAST(FROM_HEX('0000ffff0000ffff') AS BIGINT),
        ($3 | ($3 << 16)) & CAST(FROM_HEX('0000ffff0000ffff') AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.__QUADBIN_FROMZXY
(INT, INT, INT)
-- (z, x, y)
RETURNS BIGINT
STABLE
AS $$
    SELECT @@RS_PREFIX@@carto.__QUADBIN_FROMZXY_INTERLEAVED1(
        CAST($1 AS BIGINT),
        CAST(($2 << (32 - $1)) AS BIGINT),
        CAST(($3 << (32 - $1)) AS BIGINT)
    )
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION @@RS_PREFIX@@carto.QUADBIN_FROMZXY
(z INT, x INT, y INT)
RETURNS BIGINT
STABLE
AS $$
    from @@RS_PREFIX@@quadbinLib import quadbin_from_zxy
    return quadbin_from_zxy(z, x, y)
$$ LANGUAGE plpythonu;