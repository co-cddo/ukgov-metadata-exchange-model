VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip

all: gen-project test 

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

gen-project: $(VENV)/bin/activate
	gen-project -d project src/model/uk_cross_government_metadata_exchange_model.yaml

test: gen-project project/examples

project/examples: src/model/uk_cross_government_metadata_exchange_model.yaml
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
	-linkml-validate \
    	src/data/Distribution/invalid/os-postcodes-csv-distribution.yaml \
    	-s $< \
    	--target-class Distribution

junk:
	# mkdir -p $@
	# linkml-run-examples \
	# 	--output-formats json \
	# 	--output-formats yaml \
	# 	--input-directory src/data/examples-valid \
	# 	--counter-example-input-directory src/data/examples-invalid \
	# 	--output-directory $@ \
	# 	--schema $< \
	# 	> $@/README.md

clean:
	rm -r project
	rm -r $(VENV)