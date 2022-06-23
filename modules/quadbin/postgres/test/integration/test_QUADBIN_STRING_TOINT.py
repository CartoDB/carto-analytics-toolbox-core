import pytest
from test_utils import run_query

def test_quadbin_string_toint():
    """Computes int quadbin"""
    result = run_query(f"""SELECT QUADBIN_STRING_TOINT('484c1fffffffffff')""")
    assert result[0][0] == 5209574053332910079
