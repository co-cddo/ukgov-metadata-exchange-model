# Cross-Government Data Marketplace Data Exchange Model Implementation

This repository captures the implementation of the [Government Data Marketplace Data Exchange model](https://docs.google.com/document/d/13KqG1Zom0YqCehPHagCnV6ADOwj8k6qcv7Us4UDWnNg/). It is an implementation of the Cross-Government Data Sharing Metadata Requirements Specification that has been defined by the [Cross-Government Metadata Implementation Working Group](https://khub.net/group/cross-government-metadata-implementation-working-group/group-home).

This repository contains [JSON Schema](https://json-schema.org/) files (conforming to the `2020-12` draft) to capture the expected form of the JSON files. There is the option to convert into linked data by linking in the [context file](cddo-context.json).

## Schemas

The JSON Schemas are split into separate interlinked files with data service and dataset schemas extending the base data service schema. 

**Status:** 

- DataService has been approved by the Metadata Working Group
- Dataset and Distribution are in draft and still to be approved by the Metadata Working Group

The schema files are:

- Core Schemas:
  - [cddo-data-resources-schema.json](cddo-data-resources-schema.json): Schema for an array of data resources.  
    __Reuses:__ 
    - [cddo-data-service-schema.json](cddo-data-service-schema.json) and 
    - [cddo-dataset-schema.json](cddo-dataset-schema.json)
  - [cddo-data-resource-schema.json](cddo-data-resource-schema.json): Schema capturing common properties for all data resources. Resource must be typed as either a dataset or a data service and should be validated against the schema specific to that resource.  
  _This schema is not intended to be used independently of one of the more specific schemas._
  - [cddo-data-service-schema.json](cddo-data-service-schema.json): Schema for data service properties that extends [cddo-data-resource-schema.json](cddo-data-resource-schema.json)
  - [cddo-dataset-schema.json](cddo-dataset-schema.json) (draft): Schema for dataset properties that extends [cddo-data-resource-schema.json](cddo-data-resource-schema.json) 
  - [cddo-distribution-schema.json](cddo-distribution-schema.json) (draft)
  - [cddo-organisation-schema.json](cddo-organisation-schema.json): Schema for a single organisation
  - [cddo-organisations-schema.json](cddo-organisations-schema.json): Schema for an array of organisations.  
    __Reuses:__ [cddo-organisation-schema.json](cddo-organisation-schema.json)
- Auxiliary Schemas:
  - [available-organisations.json](available-organisations.json): Enumerated list of valid organisation slugs
  - [security-classification.json](security-classification.json): Enumerated list of security classifications
  - [service-status.json](service-status.json): Enumerated list of service status
  - [service-types.json](service-types.json): Enumerated list of service types

## Organisation

We maintain a collection of the organisations that have supplied data in [`organisations.json`](examples/organisations.json). The organisations are identified using a `slug` which is also used in the [Collections API](https://docs.publishing.service.gov.uk/repos/collections/api.html). A JSON record for an organisation can be retrieved by prepending the `slug` with `https://www.gov.uk/api/organisations/`, while a human readable page can be accessed with `https://www.gov.uk/government/organisations/`.

> __Note:__ In the future it may be desirable to develop a script of harvest the data associated with an organisation from the Collections API. Such a script could use the titles of `superseded_organisations` to populate the `alternativeTitle` field.

For the JSON Schema validation, a list of valid `slugs` is enumerated in [`available-organisations.json`](available-organisations.json). This list needs to be manually maintained with organisations added manually.

> __Note:__ In the future, a script could be used to populate the enumeration with the values from the organisations file.

## Examples

The [`examples`](exmaples) directory contains sample data. 

The files can be validated against the schemas by using a JSON Schema validator, e.g. [check-jsonschema](https://github.com/python-jsonschema/check-jsonschema) is a python based CLI that we have used for testing; other validators are available (see [here](https://json-schema.org/implementations.html)).

### Data Services

The [`services.json`](examples/services.json) file contains sample data about data services drawn from DWP, FSA, and NHS.

```shell
check-jsonschema -v --schemafile cddo-data-resources-schema.json examples/services.json
```

> __Note:__ There are validation errors in all four sample service descriptions. The first resource uses an invalid creator value, the other resources are missing a security classification, and the fourth resource is also missing a version value.

The [`dwp-address-lookup.json`](examples/dwp-address-lookup.json) file contains the description of a single data service based on information available from DWP.

```shell
check-jsonschema -v --schemafile cddo-data-service-schema.json examples/dwp-address-lookup.json
```

> __Note:__ An error is reported for the `creator` field.

### Datasets

The [`os-postcodes-data.json`](examples/os-postcodes-data.json) file contains the description of a single dataset based on information available from DWP and OS ([data.gov.uk record](https://www.data.gov.uk/dataset/2dfb82b4-741a-4b93-807e-11abb4bb0875/os-postcodes-data#licence-info) and [OS Data Record](https://osdatahub.os.uk/downloads/open/CodePointOpen). The OS postcodes dataset is one of the datasets referenced in the [DWP Address Lookup Service description](examples/dwp-address-lookup.json).

```shell
check-jsonschema -v --schemafile cddo-dataset-schema.json examples/os-postcodes-data.json
```

### Distributions

The [`os-postcodes-csv-distribution.json`](examples/os-postcodes-csv-distribution.json) and [`os-postcodes-geopackage-distribution.json`](examples/os-postcodes-geopackage-distribution.json) files contain the descriptions of distributions of OS postcodes dataset.

```shell
check-jsonschema -v --schemafile cddo-distribution-schema.json examples/os-postcodes-csv-distribution.json examples/os-postcodes-geopackage-distribution.json
```

### Organisations

The [`organisations.json`](examples/organisations.json) file contains the data about the organisations that supply or publish data resources.

```shell
check-jsonschema -v --schemafile cddo-organisations-schema.json examples/organisations.json
```

