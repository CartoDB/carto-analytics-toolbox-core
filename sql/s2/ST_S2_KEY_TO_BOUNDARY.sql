CREATE OR REPLACE FUNCTION jslibs.s2.ST_S2_BOUNDARY(key STRING) AS (
	ST_GEOGFROMGEOJSON(jslibs.s2.keyToCornerLatLngs(key))
);