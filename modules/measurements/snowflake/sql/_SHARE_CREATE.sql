----------------------------
-- Copyright (C) 2021 CARTO
----------------------------

USE @@SF_DATABASE@@;

CREATE SHARE IF NOT EXISTS @@SF_SHARE@@;
grant usage on database @@SF_DATABASE@@ to share @@SF_SHARE@@;
grant usage on schema @@SF_DATABASE@@.@@SF_SCHEMA@@ to share @@SF_SHARE@@;

grant usage on function @@SF_PREFIX@@measurements.ST_ANGLE(GEOGRAPHY, GEOGRAPHY, GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function @@SF_PREFIX@@measurements.ST_AZIMUTH(GEOGRAPHY, GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function @@SF_PREFIX@@measurements.ST_MINKOWSKIDISTANCE(GEOGRAPHY) to share @@SF_SHARE@@;
grant usage on function @@SF_PREFIX@@measurements.ST_MINKOWSKIDISTANCE(GEOGRAPHY, DOUBLE) to share @@SF_SHARE@@;
grant usage on function @@SF_PREFIX@@measurements.VERSION() to share @@SF_SHARE@@;