from test_utils import run_query


def test_quadbin_fromgeogpoint():
    result = run_query(
        'SELECT @@RS_SCHEMA@@.QUADBIN_FROMGEOGPOINT(ST_POINT(40.4168, -3.7038),4)'
    )

    assert len(result[0]) == 1
    assert result[0][0] == 5209574053332910079


def test_quadbin_fromgeopoint():
    result = run_query(
        'SELECT @@RS_SCHEMA@@.QUADBIN_FROMGEOPOINT(ST_POINT(40.4168, -3.7038),4)'
    )

    assert len(result[0]) == 1
    assert result[0][0] == 5209574053332910079