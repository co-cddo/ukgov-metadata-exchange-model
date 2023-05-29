VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip
DEST = project
DOCDIR = docs
EXAMPLEDIR = examples

all: gen-project test gendoc

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

gen-project: $(VENV)/bin/activate
	gen-project -d $(DEST) src/model/uk_cross_government_metadata_exchange_model.yaml

gen-examples: $(DOCDIR)
	sp src/data/README.md $(DOCDIR)/$(EXAMPLEDIR)
	cp src/data/*/valid/* $(DOCDIR)/$(EXAMPLEDIR)

test: gen-project $(DEST)/examples

$(DEST)/examples: src/model/uk_cross_government_metadata_exchange_model.yaml
	# Valid
	linkml-validate \
	    src/data/Distribution/valid/os-postcodes-csv-distribution.yaml \
    	-s $< \
    	--target-class Distribution
	# Valid
	linkml-validate \
    	src/data/Distribution/valid/os-postcodes-csv-distribution-minimal.yaml \
    	-s $< \
    	--target-class Distribution
	# Invalid example: missing `type` attribute
	@linkml-validate \
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
serve: $(VENV)/bin/activate gendoc
	mkdocs -v serve

$(DOCDIR):
	mkdir -p $@

gendoc: $(DOCDIR)
	cp src/docs/*.md $(DOCDIR)
	gen-doc -d $(DOCDIR) src/model/uk_cross_government_metadata_exchange_model.yaml

MKDOCS = mkdocs

# Run mkdocs with whatever argument was used in the make target
mkd-%: gendoc
	$(MKDOCS) $%

clean:
	-rm -r $(DEST)
	-rm -r $(DOCDIR)
	-rm -r $(VENV)