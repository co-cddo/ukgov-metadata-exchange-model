NAME := uk-cross-government-metadata exchange-model
INSTALL_STAMP := .install.stamp
POETRY = $(shell command -v poetry 2> /dev/null)

.DEFAULT_GOAL := help

.PHONY: help clean

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo ""
	@echo "  install     install packages and prepare environment"
	@echo "  update      update packages"
	@echo "  clean       remove all temporary files"
	@echo "  gen-project generate model constraints in different representations"
	@echo "  test        run all the tests"
	@echo "  serve       run the documentation locally; need to use ctrl-c to close the documentation server down"
	@echo "  all         run clean, gen-project, test, and serve"
	@echo ""
	@echo "Check the Makefile to know exactly what each target is doing."

RUN = $(POETRY) run
DEST = project
DOCDIR = docs
EXAMPLEDIR = examples

all: clean gen-project test serve

###########################################################
# Environment configuration
###########################################################

install: $(INSTALL_STAMP)
$(INSTALL_STAMP): pyproject.toml poetry.lock
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi
	$(POETRY) install
	touch $(INSTALL_STAMP)

update: pyproject.toml poetry.lock
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi
	$(POETRY) update
	touch $(INSTALL_STAMP)

###########################################################
# Schema generation
###########################################################

gen-project: 
	$(RUN) gen-project -d $(DEST) src/model/uk_cross_government_metadata_exchange_model.yaml

###########################################################
# Examples and Tests
###########################################################

gen-examples: $(DOCDIR)
	cp src/data/README.md $(DOCDIR)/$(EXAMPLEDIR)
	# TODO: Convert to JSON for the example directory
	cp src/data/*/valid/* $(DOCDIR)/$(EXAMPLEDIR)

# TODO: Extend tests to lint schema to ensure elements are correctly described, see https://linkml.io/linkml/schemas/linter.html

test: gen-project gen-examples test-valid test-invalid

test-valid: src/model/uk_cross_government_metadata_exchange_model.yaml
	for dir in src/data/*; do\
		if [ -d $${dir} ]; then\
			echo `basename $${dir}`;\
  			for file in $${dir}/valid/*.yaml; do\
    			echo $${file};\
    			$(RUN) linkml-validate \
      				$${file} \
      				-s $< \
      				--target-class `basename $${dir}`&&\
				echo "Test passed" || { echo "Test failed!"; exit 1; };\
  			done;\
		fi;\
	done;

test-invalid: src/model/uk_cross_government_metadata_exchange_model.yaml
	for dir in src/data/*; do\
		if [ -d $${dir} ]; then\
  			for file in $${dir}/invalid/*.yaml; do\
    			echo $${file};\
    			$(RUN) linkml-validate \
      				$${file} \
      				-s $< \
      				--target-class `basename $${dir}`&&\
				{ echo "Invalid example passed test!"; exit 1; } || echo "Expected error due to testing invalid example";\
  			done;\
		fi;\
	done;

#TODO: When linkml fixes their linkml-run-examples command we should be able to use the following to run the tests
# linkml-run-examples \
# 	--output-formats json \
# 	--output-formats yaml \
# 	--input-directory src/data/examples-valid \
# 	--counter-example-input-directory src/data/examples-invalid \
# 	--output-directory $@ \
# 	--schema $< \
# 	> $@/README.md

###########################################################
# DOCUMENTATION
###########################################################

# Run documentation locally
# serve will be passed as an argument to mkdocs
serve: mkd-serve

$(DOCDIR):
	mkdir -p $(DOCDIR)/$(EXAMPLEDIR)

gendoc: $(DOCDIR)
	cp src/docs/*.md $(DOCDIR)
	cp LICENSE.md $(DOCDIR)
	$(RUN) gen-doc -d $(DOCDIR) src/model/uk_cross_government_metadata_exchange_model.yaml

MKDOCS = $(RUN) mkdocs

# Run mkdocs with whatever argument was used in the make target
mkd-%: gendoc
	$(MKDOCS) $*

###########################################################
# CLEANUP
###########################################################

clean:
	-rm -r $(DEST)
	-rm -r $(DOCDIR)
	-rm -r $(VENV)
	find . -type d -name "__pycache__" | xargs rm -rf {};
	rm -rf $(INSTALL_STAMP) .coverage .mypy_cache