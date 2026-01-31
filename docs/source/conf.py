import os
import sys
from datetime import datetime

# -- Path setup --------------------------------------------------------------
# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here.
sys.path.insert(0, os.path.abspath("../../src"))

# -- Project information -----------------------------------------------------
project = "cookiecutter-testing"
author = "Ashwin"

# This automatically grabs the version from your package
try:
    from cookiecutter_testing import __version__ as release
except ImportError:
    release = "0.1.0"

# -- General configuration ---------------------------------------------------
extensions = [
    "myst_parser",          # Enable Markdown support
    "sphinx.ext.autodoc",   # Pull docs from docstrings
    "sphinx.ext.napoleon",  # Support for Google/NumPy style docstrings
    "sphinx.ext.viewcode",  # Add links to highlighted source code
    "sphinx.ext.githubpages", # Create .nojekyll file for GitHub Pages
]

# Configure MyST-Parser
myst_enable_extensions = [
    "colon_fence",
    "deflist",
]

source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}

templates_path = ["_templates"]
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]

# -- Options for HTML output -------------------------------------------------
html_theme = "furo"  # A modern, clean theme
html_static_path = ["_static"]
html_title = f"{project} v{release}"

# If you have a logo, uncomment this:
# html_logo = "_static/logo.png"
