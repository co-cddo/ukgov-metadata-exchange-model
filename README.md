# UK Cross-Government Metadata Exchange Model

A metadata model for describing data assets for exchanging between UK government organisations.

This repository uses:
- [LinkML](https://linkml.io/linkml/): YAML  specification of the metadata model which can be translated into JSON-Schema and SHACL, as well as having documentation generated
- [MkDocs Tech Docs Template](https://ministryofjustice.github.io/mkdocs-tech-docs-template/): GOV.UK styling for the [MkDocs Material theme](https://squidfunk.github.io/mkdocs-material/) for service [MkDocs](https://www.mkdocs.org/) technical documentation

## Website

The website is automatically deployed when a new commit is made to the `main` branch using the `.github/workflows/deploy-docs.yaml` action. The website is available from:

[https://co-cddo.github.io/uk-cross-government-metadata-exchange-model](https://co-cddo.github.io/uk-cross-government-metadata-exchange-model)

> :warning: repository still needs to be configured to deploy GitHub pages

## Repository Structure

Key directories and files are highlighted here:

* [project/](project/) - project files (do not edit these)
* [src/](src/) - source files (edit these)
  * [data/](src/data/) - example data by class with subfolders for valid and invalid examples
  * [docs/](src/docs/) - static documentation files and assets to be included in the generated documentation site
  * [model](src/model/) - [LinkML](https://linkml.io) specification of the metadata model – edit these files
* [mkdocs.yml] - MkDocs configuration file


## Developer Documentation

To initialise your environment run
```shell
make install
```

To update the dependencies in your environment run
```shell
make update
```

To generate the schemas in different constraint languages and run the tests run
```shell
make test
```

To generate and serve the documentation locally run
```shell
make serve
```

> :warning: **Note:** Documentation will not be generated correctly on macOS due to the use of entity names only differing by case, e.g. the class `Distribution` and the property `distribution`. In this case, you can use Docker to build and serve the documentation
> ```shell
> make docker-serve
> ```

To discover what other targets are available run
```shell
make help
```