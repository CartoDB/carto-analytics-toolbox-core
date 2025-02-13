## QUADBIN_FROMLONGLAT

```sql:signature
QUADBIN_FROMLONGLAT(longitude, latitude, resolution)
```

**Description**

Returns the Quadbin representation of a point for a requested resolution and geographic coordinates.

* `longitude`: `FLOAT8` longitude (WGS84) of the point.
* `latitude`: `FLOAT8` latitude (WGS84) of the point.
* `resolution`: `INT` level of detail or zoom.

**Return type**

`BIGINT`

**Example**

```sql
SELECT carto.QUADBIN_FROMLONGLAT(-3.7038, 40.4168, 4);
-- 5207251884775047167
```
