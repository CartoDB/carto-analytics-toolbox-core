
CREATE OR REPLACE FUNCTION @@SF_SCHEMA@@.@@VERSION_FUNCTION@@
()
RETURNS VARCHAR
IMMUTABLE
AS $$
    SELECT '@@PACKAGE_VERSION@@'
$$ LANGUAGE sql;
