CREATE OR REPLACE FUNCTION H3_INT_TOSTRING
(
  h3int INT
)
RETURNS STRING
AS $$
  TO_VARCHAR(h3int, 'xxxxxxxxxxxxxxx')
$$;