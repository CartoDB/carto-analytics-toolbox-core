
CREATE OR REPLACE FUNCTION `@@BQ_DATASET@@.@@BQ_VERSION_FUNCTION@@`
()
RETURNS STRING
AS (
    '@@BQ_PACKAGE_VERSION@@'
);