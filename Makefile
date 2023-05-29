NAME := uk-cross-government-metadata exchange-model
INSTALL_STAMP := .install.stamp
POETRY = $(shell command -v poetry 2> /dev/null)

.DEFAULT_GOAL := help

.PHONY: help clean

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo ""
	@echo "  install     install packages and prepare environment"
	@echo "  clean       remove all temporary files"
	@echo "  gen-project generate model constraints in different representations"
	@echo "  test        run all the tests"
	@echo "  serve       run the documentation locally"
	@echo "  all         run clean, gen-project, test, and serve"
	@echo ""
	@echo "Check the Makefile to know exactly what each target is doing."

RUN = $(POETRY) run
DEST = project
DOCDIR = docs
EXAMPLEDIR = examples

all: clean gen-project test serve

install: $(INSTALL_STAMP)
$(INSTALL_STAMP): pyproject.toml poetry.lock
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi
	$(POETRY) install
	touch $(INSTALL_STAMP)

gen-project: 
	$(RUN) gen-project -d $(DEST) src/model/uk_cross_government_metadata_exchange_model.yaml

gen-examples: $(DOCDIR)
	sp src/data/README.md $(DOCDIR)/$(EXAMPLEDIR)
	cp src/data/*/valid/* $(DOCDIR)/$(EXAMPLEDIR)

test: gen-project $(DEST)/examples

$(DEST)/examples: src/model/uk_cross_government_metadata_exchange_model.yaml
	# Valid
	$(RUN) linkml-validate \
	    src/data/Distribution/valid/os-postcodes-csv-distribution.yaml \
    	-s $< \
    	--target-class Distribution
	# Valid
	$(RUN) linkml-validate \
    	src/data/Distribution/valid/os-postcodes-csv-distribution-minimal.yaml \
    	-s $< \
    	--target-class Distribution
	# Invalid example: missing `type` attribute
	@$(RUN) linkml-validate \
    	src/data/Distribution/invalid/os-postcodes-csv-distribution.yaml \
    	-s $< \
    	--target-class Distribution && \
		{ echo "Unexpected test pass"; exit 1; } || echo "Expected test failure! Proceed"

#junk:
	# mkdir -p $@
	# linkml-run-examples \
	# 	--output-formats json \
	# 	--output-formats yaml \
	# 	--input-directory src/data/examples-valid \
	# 	--counter-example-input-directory src/data/examples-invalid \
	# 	--output-directory $@ \
	# 	--schema $< \
	# 	> $@/README.md

# Run documentation locally
# serve will be passed as an argument to mkdocs
serve: mkd-serve

$(DOCDIR):
	mkdir -p $@

gendoc: $(DOCDIR)
	cp src/docs/*.md $(DOCDIR)
	gen-doc -d $(DOCDIR) src/model/uk_cross_government_metadata_exchange_model.yaml

MKDOCS = $(RUN) mkdocs

# Run mkdocs with whatever argument was used in the make target
mkd-%: gendoc
	$(MKDOCS) $*

clean:
	-rm -r $(DEST)
	-rm -r $(DOCDIR)
	-rm -r $(VENV)
	find . -type d -name "__pycache__" | xargs rm -rf {};
	rm -rf $(INSTALL_STAMP) .coverage .mypy_cache