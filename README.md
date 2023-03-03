# Data Catalogue Model Implementation

This directory captures the implementation of the [Government Data Catalogue model](https://docs.google.com/document/d/13KqG1Zom0YqCehPHagCnV6ADOwj8k6qcv7Us4UDWnNg/).

The implementation is as [JSON Schema](https://json-schema.org/) files (conforming to the `2020-12` draft) to capture the expected form of the JSON files. There is the option to convert into linked data by linking in the [context file](cddo-context.json).

## Schemas

The JSON Schemas are split into separate interlinked files with data service and dataset schemas extending the base data service schema. The schema files are:
- Core Schemas:
  - [cddo-data-resources-schema.json](cddo-data-resources-schema.json): Schema for an array of data resources.  
    __Reuses:__ 
    - [cddo-data-service-schema.json](cddo-data-service-schema.json) and 
    - [cddo-dataset-schema.json](cddo-dataset-schema.json)
  - [cddo-data-resource-schema.json](cddo-data-resource-schema.json): Schema capturing common properties for all data resources. Resource must be typed as either a dataset or a data service and should be validated against the schema specific to that resource.  
  _This schema is not intended to be used independently of one of the more specific schemas._
  - [cddo-data-service-schema.json](cddo-data-service-schema.json): Schema for data service properties that extends [cddo-data-resource-schema.json](cddo-data-resource-schema.json)
  - [cddo-dataset-schema.json](cddo-dataset-schema.json): Schema for dataset properties that extends [cddo-data-resource-schema.json](cddo-data-resource-schema.json)
  - [cddo-organisation-schema.json](cddo-organisation-schema.json): Schema for a single organisation
  - [cddo-organisations-schema.json](cddo-organisations-schema.json): Schema for an array of organisations.  
    __Reuses:__ [cddo-organisation-schema.json](cddo-organisation-schema.json)
- Auxiliary Schemas:
  - [available-organisations.json](available-organisations.json): Enumerated list of valid organisation slugs
  - [status.json](status.json): Enumerated list of service status

## Organisation

We maintain a collection of the organisations that have supplied data in [`organisations.json`](examples/organisations.json). The organisations are identified using a `slug` which is also used in the [Collections API](https://docs.publishing.service.gov.uk/repos/collections/api.html). A JSON record for an organisation can be retrieved by prepending the `slug` with `https://www.gov.uk/api/organisations/`, while a human readable page can be accessed with `https://www.gov.uk/government/organisations/`.

> __Note:__ In the future it may be desirable to develop a script of harvest the data associated with an organisation from the Collections API. Such a script could use the titles of `superseded_organisations` to populate the `alternativeTitle` field.

For the JSON Schema validation, a list of valid `slugs` is enumerated in [`available-organisations.json`](available-organisations.json). This list needs to be manually maintained with organisations added manually.

> __Note:__ In the future, a script could be used to populate the enumeration with the values from the organisations file.

## Examples

The [`examples`](exmaples) directory contains sample data. 

The files can be validated against the schemas by using a JSON Schema validator, e.g. [check-jsonschema](https://github.com/python-jsonschema/check-jsonschema) is a python based CLI that we have used for testing; other validators are available (see [here](https://json-schema.org/implementations.html)).

The [`organisations.json`](examples/organisations.json) contains the data about the organisations that supply or publish data resources.

```shell
check-jsonschema -v --schemafile cddo-organisations-schema.json examples/organisations.json
```

The [`services.json`](examples/services.json) file contains sample data about data services drawn from DWP, FSA, and NHS.

```shell
check-jsonschema -v --schemafile cddo-data-resources-schema.json examples/services.json
```

> __Note:__ There are validation errors in three out of the four sample service descriptions. This is due to the lack of available sample data from these sources.

The [`dwp-address-lookup.json`](examples/dwp-address-lookup.json) file contains the description of a single data service based on information available from DWP.

```shell
check-jsonschema -v --schemafile cddo-data-service-schema.json examples/dwp-address-lookup.json
```

> __Note:__ An error is reported for the `creator` field.
