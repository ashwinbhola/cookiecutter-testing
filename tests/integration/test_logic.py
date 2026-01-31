from cookiecutter_testing.logic import add_numbers

def test_add_numbers() -> None:
    assert add_numbers(2, 3) == 5

def test_add_numbers_fail() -> None:
    assert add_numbers(1, 1) != 3