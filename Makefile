PYTHON_SCRIPTS = ct-honeybee
.PHONY: all
all: check

# Run one or more Python syntax checkers on scripts
# Comment out any that you don't have installed
check:
	flake8 $(PYTHON_SCRIPTS)
	pep8 $(PYTHON_SCRIPTS)
	pyflakes $(PYTHON_SCRIPTS)
	pylint $(PYTHON_SCRIPTS)
	pylint-3 $(PYTHON_SCRIPTS)

