---------------------------------
-- Copyright (C) 2021-2024 CARTO
---------------------------------

CREATE OR REPLACE SECURE FUNCTION @@SF_SCHEMA@@.H3_STRING_TOINT
(
    h3_hex STRING
)
RETURNS INT
AS $$
  H3_STRING_TO_INT(h3_hex)
$$;
