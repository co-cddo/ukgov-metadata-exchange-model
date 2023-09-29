NAME := uk-cross-government-metadata exchange-model
INSTALL_STAMP := .install.stamp
POETRY = $(shell command -v poetry 2> /dev/null)

.DEFAULT_GOAL := help

.PHONY: help clean

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo ""
	@echo "  install      install packages and prepare environment"
	@echo "  update       update packages"
	@echo "  clean        remove all temporary files"
	@echo "  gen-project  generate model constraints in different representations"
	@echo "  test         run all the tests"
	@echo "  doc-setup    create folders required for documentation site and copy across content"
	@echo "  serve        run the documentation locally; need to use ctrl-c to close the documentation server down"
	@echo "  docker-serve build and run the documentation in a Docker container"
	@echo "  all          run clean, gen-project, test, and serve"
	@echo ""
	@echo "Check the Makefile to know exactly what each target is doing."

RUN = $(POETRY) run
DEST = project
DOCDIR = docs
EXAMPLEDIR = src/docs/extras/assets/examples

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

ContactPoint*.yaml:
	echo "Processing ContactPoint examples"
	for file in $(wildcard $(EXAMPLEDIR)/ContactPoint*.yaml) ; do \
		$(RUN) linkml-convert \
			-s src/model/uk_cross_government_metadata_exchange_model.yaml \
			-o $${file}.json \
			-t json \
			-C ContactPoint \
			$${file} ; \
	done

DataService*.yaml:
	echo "Processing DataService examples"
	for file in $(wildcard $(EXAMPLEDIR)/DataService*.yaml) ; do \
		$(RUN) linkml-convert \
			-s src/model/uk_cross_government_metadata_exchange_model.yaml \
			-o $${file}.json \
			-t json \
			-C DataService \
			$${file} ; \
	done

Dataset*.yaml:
	echo "Processing Dataset examples"
	for file in $(wildcard $(EXAMPLEDIR)/Dataset*.yaml) ; do \
		$(RUN) linkml-convert \
			-s src/model/uk_cross_government_metadata_exchange_model.yaml \
			-o $${file}.json \
			-t json \
			-C Dataset \
			$${file} ; \
	done

Distribution*.yaml:
	echo "Processing Dataset examples"
	for file in $(wildcard $(EXAMPLEDIR)/Distribution*.yaml) ; do \
		$(RUN) linkml-convert \
			-s src/model/uk_cross_government_metadata_exchange_model.yaml \
			-o $${file}.json \
			-t json \
			-C Distribution \
			$${file} ; \
	done

gen-examples: doc-setup ContactPoint*.yaml DataService*.yaml Dataset*.yaml Distribution*.yaml

# TODO: Extend tests to lint schema to ensure elements are correctly described, see https://linkml.io/linkml/schemas/linter.html

test: gen-project gen-examples test-valid test-invalid

test-valid: src/model/uk_cross_government_metadata_exchange_model.yaml
	@for dir in src/data/*; do\
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
	@echo "Successfully passed all positive tests!\n"

test-invalid: src/model/uk_cross_government_metadata_exchange_model.yaml
	@for dir in src/data/*; do\
		if [ -d $${dir} ]; then\
  			for file in $${dir}/invalid/*.yaml; do\
    			echo $${file};\
    			$(RUN) linkml-validate \
      				$${file} \
      				-s $< \
      				--target-class `basename $${dir}` &> $${dir}/invalid/$${file}-test-output.txt &&\
				{ echo "Test failed"; exit 1; } || echo "Test passed";\
  			done;\
		fi;\
	done;
	@echo "Successfully passed all negative tests!\n"

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
#
# Any changes to the documentation process need to be 
# reflected in the Dockerfile as well
###########################################################

# Run documentation locally
# serve will be passed as an argument to mkdocs
serve: mkd-serve

doc-setup:
	mkdir -p $(DOCDIR)
	mkdir -p $(EXAMPLEDIR)
	cp src/data/*/valid/* $(EXAMPLEDIR)

gendoc: gen-examples
	cp src/docs/*.md $(DOCDIR)
	cp LICENSE.md $(DOCDIR)
	$(RUN) gen-doc -d $(DOCDIR) \
		--example-directory $(EXAMPLEDIR) \
		--template-directory src/docs/templates \
		src/model/uk_cross_government_metadata_exchange_model.yaml

MKDOCS = $(RUN) mkdocs

# Run mkdocs with whatever argument was used in the make target
mkd-%: gendoc
	$(MKDOCS) $*

# Allows the testing of documentation locally on macOS machines
# Needed as macOS does not support multiple entities with the same name but different cases
docker-serve:
	docker build -t model-docs .   
	docker run -p 8080:8080 model-docs
###########################################################
# CLEANUP
###########################################################

clean:
	-rm -r $(DEST)
	-rm -r $(DOCDIR)
	-rm -r $(EXAMPLEDIR)
	-rm -r $(VENV)
	find . -type d -name "__pycache__" | xargs rm -rf {};
	rm -rf $(INSTALL_STAMP) .coverage .mypy_cache
