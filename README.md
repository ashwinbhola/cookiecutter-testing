# cookiecutter-testing

A python library for cookiecutter testing

The `Makefile` handles everything. Just run:

```bash
make install-requirements  # Sets up a python env with all the installed dependencies
make fix-lint  # Format code and fix lint errors
make lint  # Run linting checks
make test  # Run tests
make bump PART=minor  # Increment version
make help  # View all make commands
```