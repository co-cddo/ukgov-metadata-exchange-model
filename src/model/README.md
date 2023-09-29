## Government Organisations Enumeration

The information about government organisations was extracted from https://www.gov.uk/api/organisations ([docs](https://docs.publishing.service.gov.uk/repos/collections/api.html)) on 3 May 2023.

For each organisation, the following values were extracted:
- slug: used as the id for the enumeration item
- web_url: used for the meaning property
- title: used for the description property
- abbreviation: used for abbreviation property
- format: used for the organisationType property
- govuk_status: used for status property
- content_id: used for contentID property

The extraction was performed using [OpenRefine](https://openrefine.org/), a data wrangling tool. The following operations were applied
```json
[
  {
    "op": "core/column-removal",
    "columnName": "_ - updated_at",
    "description": "Remove column _ - updated_at"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - analytics_identifier",
    "description": "Remove column _ - analytics_identifier"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - abbreviation",
    "description": "Remove column _ - details - abbreviation"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - slug",
    "description": "Remove column _ - details - slug"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - logo_formatted_name",
    "description": "Remove column _ - details - logo_formatted_name"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - organisation_brand_colour_class_name",
    "description": "Remove column _ - details - organisation_brand_colour_class_name"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - organisation_logo_type_class_name",
    "description": "Remove column _ - details - organisation_logo_type_class_name"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - closed_at",
    "description": "Remove column _ - details - closed_at"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - govuk_closed_status",
    "description": "Remove column _ - details - govuk_closed_status"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - details - content_id",
    "description": "Remove column _ - details - content_id"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - child_organisations - _ - id",
    "description": "Remove column _ - child_organisations - _ - id"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - child_organisations - _ - web_url",
    "description": "Remove column _ - child_organisations - _ - web_url"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - superseding_organisations - _ - id",
    "description": "Remove column _ - superseding_organisations - _ - id"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - superseding_organisations - _ - web_url",
    "description": "Remove column _ - superseding_organisations - _ - web_url"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - superseded_organisations - _ - id",
    "description": "Remove column _ - superseded_organisations - _ - id"
  },
  {
    "op": "core/column-removal",
    "columnName": "_ - superseded_organisations - _ - web_url",
    "description": "Remove column _ - superseded_organisations - _ - web_url"
  }
]
```

The data was then ready to be exported using the template [export-gov-uk-orgs.grel](export-gov-uk-orgs.grel). The resulting file ([uk-gov-orgs.yaml](uk-gov-orgs.yaml)) was then manually edited to provide the required heading information for linkml.
