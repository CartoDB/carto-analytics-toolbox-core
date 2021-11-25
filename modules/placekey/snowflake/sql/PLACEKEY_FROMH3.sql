----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

CREATE OR REPLACE FUNCTION __PLACEKEY_FROMH3
(h3Index STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
IMMUTABLE
AS $$
    @@SF_LIBRARY_CONTENT@@

    return placekeyLib.h3ToPlacekey(H3INDEX);
$$;

CREATE OR REPLACE SECURE FUNCTION PLACEKEY_FROMH3
(h3Index STRING)
RETURNS STRING
IMMUTABLE
AS $$
    IFF(H3_ISVALID(H3INDEX),
      __PLACEKEY_FROMH3(H3INDEX),
      null)
$$;