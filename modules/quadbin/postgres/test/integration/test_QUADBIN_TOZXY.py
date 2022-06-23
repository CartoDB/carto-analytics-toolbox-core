import pytest
from test_utils import run_query

quadbins = [
    # z, x, y, quadbin
    ( 0, 0, 0, 5192650370358181887 ),
    ( 1, 0, 0, 5193776270265024511 ),
    ( 1, 0, 1, 5196028070078709759 ),
    ( 1, 1, 0, 5194902170171867135 ),
    ( 1, 1, 1, 5197153969985552383 ),
    ( 2, 0, 0, 5197435444962263039 ),
    ( 2, 1, 3, 5200531669706080255 ),
    ( 4, 9, 8, 5209574053332910079 ),
    ( 7, 11, 23, 5219843491936337919 ),
    ( 7, 127, 23, 5221325633610579967 ),
    ( 7, 11, 127, 5222693426075533311 ),
    ( 7, 127, 127, 5224175567749775359 ),
    ( 23, 111, 721, 5291729562196874751 ),
    ( 23, 111, 721, 5291729562196874751 ),
    ( 23, 8388607, 8388607, 5296233161787703295 ),
    ( 26, 8388607, 8388607, 5305310729786621951 ),
    ( 26, 0, 0, 5305240361042444288 ),
    ( 26, 1, 0, 5305240361042444289 ),
    ( 26, 0, 1, 5305240361042444290 ),
    ( 26, 67108863, 67108863, 5309743960669814783 )
]

@pytest.mark.parametrize('z, x, y, quadbin', quadbins)
def test_quadbin_tozxy(z, x, y, quadbin):
    """Computes z, x, y for quadbin"""
    result = run_query(f"""SELECT QUADBIN_TOZXY({quadbin})""")
    assert result[0][0]['z'] == z
    assert result[0][0]['x'] == x
    assert result[0][0]['y'] == y
