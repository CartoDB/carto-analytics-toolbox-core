-- Accessors 
CREATE OR REPLACE FUNCTION ST_COORDDIM as 'com.carto.analyticstoolbox.modules.accessors.ST_CoordDim';
CREATE OR REPLACE FUNCTION ST_DIMENSION as 'com.carto.analyticstoolbox.modules.accessors.ST_Dimension';
CREATE OR REPLACE FUNCTION ST_ENVELOPE as 'com.carto.analyticstoolbox.modules.accessors.ST_Envelope';
CREATE OR REPLACE FUNCTION ST_GEOMETRYN as 'com.carto.analyticstoolbox.modules.accessors.ST_GeometryN';
CREATE OR REPLACE FUNCTION ST_ISCLOSED as 'com.carto.analyticstoolbox.modules.accessors.ST_IsClosed';
CREATE OR REPLACE FUNCTION ST_ISCOLLECTION as 'com.carto.analyticstoolbox.modules.accessors.ST_IsCollection';
CREATE OR REPLACE FUNCTION ST_ISEMPTY as 'com.carto.analyticstoolbox.modules.accessors.ST_IsEmpty';
CREATE OR REPLACE FUNCTION ST_ISGEOMFIELD as 'com.carto.analyticstoolbox.modules.accessors.ST_IsGeomField';
CREATE OR REPLACE FUNCTION ST_ISRING as 'com.carto.analyticstoolbox.modules.accessors.ST_IsRing';
CREATE OR REPLACE FUNCTION ST_ISSIMPLE as 'com.carto.analyticstoolbox.modules.accessors.ST_IsSimple';
CREATE OR REPLACE FUNCTION ST_ISVALID as 'com.carto.analyticstoolbox.modules.accessors.ST_IsValid';
CREATE OR REPLACE FUNCTION ST_NUMGEOMETRIES as 'com.carto.analyticstoolbox.modules.accessors.ST_NumGeometries';
CREATE OR REPLACE FUNCTION ST_NUMPOINTS as 'com.carto.analyticstoolbox.modules.accessors.ST_NumPoints';
CREATE OR REPLACE FUNCTION ST_POINTN as 'com.carto.analyticstoolbox.modules.accessors.ST_PointN';
CREATE OR REPLACE FUNCTION ST_X as 'com.carto.analyticstoolbox.modules.accessors.ST_X';
CREATE OR REPLACE FUNCTION ST_Y as 'com.carto.analyticstoolbox.modules.accessors.ST_Y';
-- Formatters
CREATE OR REPLACE FUNCTION ST_ASBINARY as 'com.carto.analyticstoolbox.modules.formatters.ST_AsBinary';
CREATE OR REPLACE FUNCTION ST_ASGEOJSON as 'com.carto.analyticstoolbox.modules.formatters.ST_AsGeoJson';
CREATE OR REPLACE FUNCTION ST_ASLATLONTEXT as 'com.carto.analyticstoolbox.modules.formatters.ST_AsLatLonText';
CREATE OR REPLACE FUNCTION ST_ASTEXT as 'com.carto.analyticstoolbox.modules.formatters.ST_AsText';
CREATE OR REPLACE FUNCTION ST_ASTWKB as 'com.carto.analyticstoolbox.modules.formatters.ST_AsTWKB';
CREATE OR REPLACE FUNCTION ST_BYTEARRAY as 'com.carto.analyticstoolbox.modules.formatters.ST_ByteArray';
CREATE OR REPLACE FUNCTION ST_CASTTOGEOMETRY as 'com.carto.analyticstoolbox.modules.formatters.ST_CastToGeometry';
CREATE OR REPLACE FUNCTION ST_CASTTOLINESTRING as 'com.carto.analyticstoolbox.modules.formatters.ST_CastToLineString';
CREATE OR REPLACE FUNCTION ST_CASTTOPOINT as 'com.carto.analyticstoolbox.modules.formatters.ST_CastToPoint';
CREATE OR REPLACE FUNCTION ST_CASTTOPOLYGON as 'com.carto.analyticstoolbox.modules.formatters.ST_CastToPolygon';
CREATE OR REPLACE FUNCTION ST_GEOHASH as 'com.carto.analyticstoolbox.modules.formatters.ST_AsGeoHash';
-- Parsers
CREATE OR REPLACE FUNCTION ST_BOX2DFROMGEOHASH as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromGeoHash';
CREATE OR REPLACE FUNCTION ST_GEOMFROMGEOHASH as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromGeoHash';
CREATE OR REPLACE FUNCTION ST_GEOMFROMGEOJSON as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromGeoJson';
CREATE OR REPLACE FUNCTION ST_GEOMFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromWKT';
CREATE OR REPLACE FUNCTION ST_GEOMFROMTWKB as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromTWKB';
CREATE OR REPLACE FUNCTION ST_GEOMFROMWKB as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromWKB';
CREATE OR REPLACE FUNCTION ST_GEOMFROMWKT as 'com.carto.analyticstoolbox.modules.parsers.ST_GeomFromWKT';
CREATE OR REPLACE FUNCTION ST_LINEFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_LineFromText';
CREATE OR REPLACE FUNCTION ST_MLINEFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_MLineFromText';
CREATE OR REPLACE FUNCTION ST_MPOINTFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_MPointFromText';
CREATE OR REPLACE FUNCTION ST_MPOLYFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_MPolyFromText';
CREATE OR REPLACE FUNCTION ST_POINTFROMGEOHASH as 'com.carto.analyticstoolbox.modules.parsers.ST_PointFromGeoHash';
CREATE OR REPLACE FUNCTION ST_POINTFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_PointFromText';
CREATE OR REPLACE FUNCTION ST_POINTFROMWKB as 'com.carto.analyticstoolbox.modules.parsers.ST_PointFromWKB';
CREATE OR REPLACE FUNCTION ST_POLYGONFROMTEXT as 'com.carto.analyticstoolbox.modules.parsers.ST_PolygonFromText';
-- Constructors
CREATE OR REPLACE FUNCTION ST_MAKEBBOX as 'com.carto.analyticstoolbox.modules.constructors.ST_MakeBBOX';
CREATE OR REPLACE FUNCTION ST_MAKEBOX2D as 'com.carto.analyticstoolbox.modules.constructors.ST_MakeBox2D';
CREATE OR REPLACE FUNCTION ST_MAKELINE as 'com.carto.analyticstoolbox.modules.constructors.ST_MakeLine';
CREATE OR REPLACE FUNCTION ST_MAKEPOINT as 'com.carto.analyticstoolbox.modules.constructors.ST_MakePoint';
CREATE OR REPLACE FUNCTION ST_MAKEPOINTM as 'com.carto.analyticstoolbox.modules.constructors.ST_MakePointM';
CREATE OR REPLACE FUNCTION ST_MAKEPOLYGON as 'com.carto.analyticstoolbox.modules.constructors.ST_MakePolygon';
CREATE OR REPLACE FUNCTION ST_POINT as 'com.carto.analyticstoolbox.modules.constructors.ST_MakePoint';
-- Measurements
CREATE OR REPLACE FUNCTION ST_AREA as 'com.carto.analyticstoolbox.modules.measurements.ST_Area';
CREATE OR REPLACE FUNCTION ST_DISTANCE as 'com.carto.analyticstoolbox.modules.measurements.ST_Distance';
CREATE OR REPLACE FUNCTION ST_DISTANCESPHERE as 'com.carto.analyticstoolbox.modules.measurements.ST_DistanceSphere';
CREATE OR REPLACE FUNCTION ST_LENGTH as 'com.carto.analyticstoolbox.modules.measurements.ST_Length';
CREATE OR REPLACE FUNCTION ST_LENGTHSPHERE as 'com.carto.analyticstoolbox.modules.measurements.ST_LengthSphere';
-- Predicates
CREATE OR REPLACE FUNCTION ST_CONTAINS as 'com.carto.analyticstoolbox.modules.predicates.ST_Contains';
CREATE OR REPLACE FUNCTION ST_COVERS as 'com.carto.analyticstoolbox.modules.predicates.ST_Covers';
CREATE OR REPLACE FUNCTION ST_CROSSES as 'com.carto.analyticstoolbox.modules.predicates.ST_Crosses';
CREATE OR REPLACE FUNCTION ST_DISJOINT as 'com.carto.analyticstoolbox.modules.predicates.ST_Disjoint';
CREATE OR REPLACE FUNCTION ST_EQUALS as 'com.carto.analyticstoolbox.modules.predicates.ST_Equals';
CREATE OR REPLACE FUNCTION ST_INTERSECTS as 'com.carto.analyticstoolbox.modules.predicates.ST_Intersects';
CREATE OR REPLACE FUNCTION ST_OVERLAPS as 'com.carto.analyticstoolbox.modules.predicates.ST_Overlaps';
CREATE OR REPLACE FUNCTION ST_RELATE as 'com.carto.analyticstoolbox.modules.predicates.ST_Relate';
CREATE OR REPLACE FUNCTION ST_RELATEBOOL as 'com.carto.analyticstoolbox.modules.predicates.ST_RelateBool';
CREATE OR REPLACE FUNCTION ST_TOUCHES as 'com.carto.analyticstoolbox.modules.predicates.ST_Touches';
CREATE OR REPLACE FUNCTION ST_WITHIN as 'com.carto.analyticstoolbox.modules.predicates.ST_Within';
-- Transformations
CREATE OR REPLACE FUNCTION ST_ANTIMERIDIANSAFEGEOM as 'com.carto.analyticstoolbox.modules.transformations.ST_AntimeridianSafeGeom';
CREATE OR REPLACE FUNCTION ST_BOUNDARY as 'com.carto.analyticstoolbox.modules.transformations.ST_Boundary';
CREATE OR REPLACE FUNCTION ST_BUFFERPOINT as 'com.carto.analyticstoolbox.modules.transformations.ST_BufferPoint';
CREATE OR REPLACE FUNCTION ST_CENTROID as 'com.carto.analyticstoolbox.modules.transformations.ST_Centroid';
CREATE OR REPLACE FUNCTION ST_CLOSESTPOINT as 'com.carto.analyticstoolbox.modules.transformations.ST_ClosestPoint';
CREATE OR REPLACE FUNCTION ST_CONVEXHULL as 'com.carto.analyticstoolbox.modules.transformations.ST_ConvexHull';
CREATE OR REPLACE FUNCTION ST_DIFFERENCE as 'com.carto.analyticstoolbox.modules.transformations.ST_Difference';
CREATE OR REPLACE FUNCTION ST_EXTERIORRING as 'com.carto.analyticstoolbox.modules.transformations.ST_ExteriorRing';
CREATE OR REPLACE FUNCTION ST_IDLSAFEGEOM as 'com.carto.analyticstoolbox.modules.transformations.ST_AntimeridianSafeGeom';
CREATE OR REPLACE FUNCTION ST_INTERIORRINGN as 'com.carto.analyticstoolbox.modules.transformations.ST_InteriorRingN';
CREATE OR REPLACE FUNCTION ST_INTERSECTION as 'com.carto.analyticstoolbox.modules.transformations.ST_Intersection';
CREATE OR REPLACE FUNCTION ST_SIMPLIFY as 'com.carto.analyticstoolbox.modules.transformations.ST_Simplify';
CREATE OR REPLACE FUNCTION ST_SIMPLIFYPRESERVETOPOLOGY as 'com.carto.analyticstoolbox.modules.transformations.ST_SimplifyPreserveTopology';
CREATE OR REPLACE FUNCTION ST_TRANSLATE as 'com.carto.analyticstoolbox.modules.transformations.ST_Translate';
-- Index
CREATE OR REPLACE FUNCTION ST_CRSFROMTEXT as 'com.carto.analyticstoolbox.modules.index.ST_CrsFromText';
CREATE OR REPLACE FUNCTION ST_EXTENTFROMGEOM as 'com.carto.analyticstoolbox.modules.index.ST_ExtentFromGeom';
CREATE OR REPLACE FUNCTION ST_EXTENTTOGEOM as 'com.carto.analyticstoolbox.modules.index.ST_ExtentToGeom';
CREATE OR REPLACE FUNCTION ST_GEOMREPROJECT as 'com.carto.analyticstoolbox.modules.index.ST_GeomReproject';
CREATE OR REPLACE FUNCTION ST_MAKEEXTENT as 'com.carto.analyticstoolbox.modules.index.ST_MakeExtent';
CREATE OR REPLACE FUNCTION ST_PARTITIONCENTROID as 'com.carto.analyticstoolbox.modules.index.ST_PartitionCentroid';
CREATE OR REPLACE FUNCTION ST_Z2LATLON as 'com.carto.analyticstoolbox.modules.index.ST_Z2LatLon';
-- Product
CREATE OR REPLACE FUNCTION VERSION_CORE()
    RETURNS STRING
    RETURN '2022.09.21';