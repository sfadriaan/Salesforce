VENVDIR = venv
VENV = $(VENVDIR)/bin/activate
VALE_CONFIG = .vale.ini
TARGET = README.md

.PHONY: install spelling vale-install run-behave 


# If requirements are updated, venv should be rebuilt and timestamped.
$(VENVDIR):
	@echo "... setting up virtualenv"
	python3 -m venv $(VENVDIR) || { echo "You must install python3-venv before you can build the documentation."; exit 1; }
	. $(VENV); pip install $(PIPOPTS) --require-virtualenv \
	    --upgrade -r requirements.txt \
            --log $(VENVDIR)/pip_install.log
	@test ! -f $(VENVDIR)/pip_list.txt || \
            mv $(VENVDIR)/pip_list.txt $(VENVDIR)/pip_list.txt.bak
	@. $(VENV); pip list --local --format=freeze > $(VENVDIR)/pip_list.txt
	@touch $(VENVDIR)

install: $(VENVDIR)

lint-md: pymarkdownlnt-install
	@. $(VENV); pymarkdownlnt --config .pymarkdown.json scan fixtures --recurse

pymarkdownlnt-install:
	@. $(VENV); test -d $(VENVDIR)/lib/python*/site-packages/pymarkdown || pip install pymarkdownlnt

run-behave: vale-install
	@. $(VENV); behave

spelling: vale-install
	@echo "Running Vale against $(TARGET). To change target set TARGET= with make command"
	@. $(VENV); vale --config="$(VALE_CONFIG)" --glob='*.{md,rst}' $(TARGET)

vale-install: install
	@. $(VENV);
	@. $(VENV); find $(VENVDIR)/lib/python*/site-packages/vale/vale_bin -size 195c -exec vale --version \;

vale-verbose: vale-install
	@. $(VENV); vale --output=line --sort --normalize --relative --no-global .

