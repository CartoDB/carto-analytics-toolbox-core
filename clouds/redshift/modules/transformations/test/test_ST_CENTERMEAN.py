from test_utils import run_query, get_cursor
import os


def test_center_mean_success():
    fixture_file = open('./test/integration/center_fixtures/in/wkts.txt', 'r')
    points = fixture_file.readlines()
    fixture_file.close()

    results = run_query(
        f"""SELECT ST_ASTEXT(@@RS_SCHEMA@@.ST_CENTERMEAN(
            ST_GeomFromText('{points[0].rstrip()}'))),
        ST_ASTEXT(@@RS_SCHEMA@@.ST_CENTERMEAN(
            ST_GeomFromText('{points[1].rstrip()}'))),
        ST_ASTEXT(@@RS_SCHEMA@@.ST_CENTERMEAN(
            ST_GeomFromText('{points[2].rstrip()}'))),
        ST_ASTEXT(@@RS_SCHEMA@@.ST_CENTERMEAN(
            ST_GeomFromText('{points[3].rstrip()}')))"""
    )

    assert str(results[0][0]) == 'POINT(4.84119415283 45.7580714303)'
    assert str(results[0][1]) == 'POINT(25 27.5)'
    assert str(results[0][2]) == 'POINT(-58.75 22.5)'
    assert str(results[0][3]) == 'POINT(-3.79091167202 37.7810735685)'


def test_center_mean_none():
    results = run_query(
        """SELECT @@RS_SCHEMA@@.ST_CENTERMEAN(
            ST_GeomFromText(NULL))"""
    )

    assert results[0][0] is None


def test_read_from_table_success():
    fixture_file = open('./test/integration/center_fixtures/in/wkts.txt', 'r')
    points = fixture_file.readlines()
    fixture_file.close()

    cursor = get_cursor()

    cursor.execute(
        f"""
        CREATE TEMP TABLE test_data AS
        SELECT ST_GEOMFROMTEXT('{points[0].rstrip()}') AS geom, 1 AS idx UNION ALL
        SELECT ST_GEOMFROMTEXT('{points[1].rstrip()}') AS geom, 2 AS idx UNION ALL
        SELECT ST_GEOMFROMTEXT('{points[2].rstrip()}') AS geom, 3 AS idx
        """
    )

    cursor.execute(
        """
        SELECT ST_ASTEXT(@@RS_SCHEMA@@.ST_CENTERMEAN(geom))
        FROM test_data ORDER BY idx
        """.replace(
            '@@RS_PREFIX@@', os.environ['RS_SCHEMA_PREFIX']
        )
    )

    results = cursor.fetchall()

    assert str(results[0][0]) == 'POINT(4.84119415283 45.7580714303)'
    assert str(results[1][0]) == 'POINT(25 27.5)'
    assert str(results[2][0]) == 'POINT(-58.75 22.5)'
