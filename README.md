# UK Cross-Government Metadata Exchange Model

A metadata model for describing data assets for exchanging between UK government organisations.

## Website

[https://co-cddo.github.io/uk-cross-government-metadata-exchange-model](https://co-cddo.github.io/uk-cross-government-metadata-exchange-model)

## Repository Structure

* [project/](project/) - project files (do not edit these)
* [src/](src/) - source files (edit these)
  * [data/](src/data/) - example data by class with subfolders for valid and invalid examples
  * [docs/](src/docs/) - static documentation files to be included in the generated documentation site
  * [model](src/model/) - [LinkML](https://linkml.io) specification of the metadata model – edit these files

## Developer Documentation

To initialise your environment run
```shell
make install
```

To update the dependencies in your environment run
```shell
make update
```

To discover what other targets are available run
```shell
make help
```