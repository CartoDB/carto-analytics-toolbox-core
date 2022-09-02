from python_utils.test_utils import run_query


def test_st_issimple_success():
    query = "SELECT @@DB_SCHEMA@@.ST_ISSIMPLE(@@DB_SCHEMA@@.ST_GEOMFROMWKT('LINESTRING(1 1, 2 3, 4 3, 2 3)'));"
    result = run_query(query)
    assert result[0][0] is False
