# UK Cross-Government Metadata Exchange Model

A metadata model for describing data assets for exchanging between UK government organisations. A primary use case for this model is populating the Cross-Government Data Marketplace with details of data assets provided by UK Government organisations.

## Purpose

This metadata model is focused on the essential attributes needed to describe a critical data asset in the context of a cross-government data share and to facilitate data discoverability in the Government Data Marketplace.

The metadata model is based in [DCAT Working Draft v3](https://www.w3.org/TR/vocab-dcat-3/) itself an extension of [Dublin Core](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) which is a metadata standard already approved by the [Open Standards Board](https://www.gov.uk/government/groups/open-standards-board) to [describe data shared in government](https://www.gov.uk/government/publications/recommended-open-standards-for-government/using-metadata-to-describe-data-shared-within-government). It extends the attributes under the [existing guidance](https://www.gov.uk/guidance/record-information-about-data-sets-you-share-with-others) and once it is baselined will subsequently update the latter.

It is designed to add clarification and context to Pillar 1 of the Cross-Government Metadata Approach and endorsed for implementation by the Data Standards Authority Steering Board. Its objective is to present and describe all of the metadata elements that are to be included in a critical data set to be onboarded into the Government Data Catalogue.

Subsequent iterations will provide more comprehensive descriptions and cover areas which may have additional specific requirements (such as the Health and Geospatial domains) with accompanying guidance to be developed in the form of a playbook for use by relevant DDaT professionals across government and wider public sector, where applicable.

While this set of attributes is specific to the Government Data Marketplace, it is envisaged that other Data Catalogues, Marketplaces and/or Data Portals will be able to apply this specification within their individual context with little or no modifications, to ensure better interoperability between government information systems.

### Data Catalogue Vocabulary (DCAT)

DCAT is an RDF vocabulary designed to facilitate interoperability between data catalogues published on the Web and [already in use in data.gov.uk](https://guidance.data.gov.uk/publish_and_manage_data/harvest_or_add_data/harvest_data/dcat/#accepted-dcat-and-data-json-fields). 

DCAT enables a publisher to describe datasets and data services in a catalogue using a standard model and vocabulary that facilitates the consumption and aggregation of metadata from multiple catalogues. This can increase the discoverability of datasets and data services. It also makes it possible to have a decentralised approach to publishing data catalogues and makes federated search for datasets across catalogues in multiple sites possible using the same query mechanism and structure.

The namespace for DCAT is [`http://www.w3.org/ns/dcat#`](http://www.w3.org/ns/dcat#). However, it should be noted that DCAT makes extensive use of terms from other vocabularies, in particular Dublin Core. DCAT itself defines a minimal set of classes and properties of its own.

A __Dataset__ in DCAT is defined as a _"collection of data, published or curated by a single agent, and available for access or download in one or more representations.”_ A dataset is a conceptual entity which can be represented by one or more distributions that serialise the dataset for transfer. Distributions of a dataset can be provided via data services.

A __Data Service__ in DCAT is defined as a _"collection of operations that provides access to one or more datasets or data processing functions."_

A __Distribution__ in DCAT is defined as a _"specific representation of a dataset. A dataset might be available in multiple serializations that may differ in various ways, including natural language, media-type or format, schematic organization, temporal and spatial resolution, level of detail or profiles (which might specify any or all of the above)."_
