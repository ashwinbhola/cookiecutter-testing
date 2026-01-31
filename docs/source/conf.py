import os
import sys

# This tells Sphinx to look in the ../src directory for your docstrings
sys.path.insert(0, os.path.abspath("../../src"))

extensions = [
    "sphinx.ext.autodoc",  # Pulls documentation from docstrings
    "sphinx.ext.napoleon",  # Supports Google/NumPy style docstrings
    "sphinx.ext.viewcode",  # Adds links to highlighted source code
]

html_theme = "furo"  # A clean, modern production-grade theme
