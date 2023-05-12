# Auto generated from uk_cross_government_metadata_exchange_model.yaml by pythongen.py version: 0.9.0
# Generation date: 2023-05-12T16:04:32
# Schema: uk-cross-government-metadata-exchange-model
#
# id: https://w3id.org/co-cddo/uk-cross-government-metadata-exchange-model
# description: A metadata model for describing data assets for exchanging between UK government organisations.
# license: https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/

import dataclasses
import re
from jsonasobj2 import JsonObj, as_dict
from typing import Optional, List, Union, Dict, ClassVar, Any
from dataclasses import dataclass
from linkml_runtime.linkml_model.meta import EnumDefinition, PermissibleValue, PvFormulaOptions

from linkml_runtime.utils.slot import Slot
from linkml_runtime.utils.metamodelcore import empty_list, empty_dict, bnode
from linkml_runtime.utils.yamlutils import YAMLRoot, extended_str, extended_float, extended_int
from linkml_runtime.utils.dataclass_extensions_376 import dataclasses_init_fn_with_kwargs
from linkml_runtime.utils.formatutils import camelcase, underscore, sfx
from linkml_runtime.utils.enumerations import EnumDefinitionImpl
from rdflib import Namespace, URIRef
from linkml_runtime.utils.curienamespace import CurieNamespace
from linkml_runtime.linkml_model.types import Date, Integer, String, Uri, Uriorcurie
from linkml_runtime.utils.metamodelcore import URI, URIorCURIE, XSDDate

metamodel_version = "1.7.0"
version = None

# Overwrite dataclasses _init_fn to add **kwargs in __init__
dataclasses._init_fn = dataclasses_init_fn_with_kwargs

# Namespaces
DCAT = CurieNamespace('dcat', 'http://www.w3.org/ns/dcat#')
DCT = CurieNamespace('dct', 'http://purl.org/dc/terms/')
LINKML = CurieNamespace('linkml', 'https://w3id.org/linkml/')
RDF = CurieNamespace('rdf', 'http://example.org/UNKNOWN/rdf/')
RDFS = CurieNamespace('rdfs', 'http://example.org/UNKNOWN/rdfs/')
SCHEMA = CurieNamespace('schema', 'http://schema.org/')
SKOS = CurieNamespace('skos', 'http://example.org/UNKNOWN/skos/')
UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL = CurieNamespace('uk_cross_government_metadata_exchange_model', 'https://w3id.org/co-cddo/uk-cross-government-metadata-exchange-model/')
XSD = CurieNamespace('xsd', 'http://www.w3.org/2001/XMLSchema#')
DEFAULT_ = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL


# Types

# Class references
class DistributionIdentifier(URIorCURIE):
    pass


class OrganisationIdentifier(URIorCURIE):
    pass


class DataResource(YAMLRoot):
    _inherited_slots: ClassVar[List[str]] = []

    class_class_uri: ClassVar[URIRef] = DCAT.Resource
    class_class_curie: ClassVar[str] = "dcat:Resource"
    class_name: ClassVar[str] = "DataResource"
    class_model_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.DataResource


class DataService(DataResource):
    _inherited_slots: ClassVar[List[str]] = []

    class_class_uri: ClassVar[URIRef] = DCAT.DataService
    class_class_curie: ClassVar[str] = "dcat:DataService"
    class_name: ClassVar[str] = "DataService"
    class_model_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.DataService


@dataclass
class Distribution(YAMLRoot):
    _inherited_slots: ClassVar[List[str]] = []

    class_class_uri: ClassVar[URIRef] = DCAT.Distribution
    class_class_curie: ClassVar[str] = "dcat:Distribution"
    class_name: ClassVar[str] = "Distribution"
    class_model_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.Distribution

    identifier: Union[str, DistributionIdentifier] = None
    mediaType: Union[str, URI] = None
    licence: str = None
    modified: Union[str, XSDDate] = None
    title: str = None
    accessService: Optional[Union[Union[dict, DataService], List[Union[dict, DataService]]]] = empty_list()
    byteSize: Optional[int] = None
    downloadURL: Optional[Union[str, URI]] = None
    accessRights: Optional[Union[str, "AccessRightsValues"]] = None
    description: Optional[str] = None
    issued: Optional[Union[str, XSDDate]] = None

    def __post_init__(self, *_: List[str], **kwargs: Dict[str, Any]):
        if self._is_empty(self.identifier):
            self.MissingRequiredField("identifier")
        if not isinstance(self.identifier, DistributionIdentifier):
            self.identifier = DistributionIdentifier(self.identifier)

        if self._is_empty(self.mediaType):
            self.MissingRequiredField("mediaType")
        if not isinstance(self.mediaType, URI):
            self.mediaType = URI(self.mediaType)

        if self._is_empty(self.licence):
            self.MissingRequiredField("licence")
        if not isinstance(self.licence, str):
            self.licence = str(self.licence)

        if self._is_empty(self.modified):
            self.MissingRequiredField("modified")
        if not isinstance(self.modified, XSDDate):
            self.modified = XSDDate(self.modified)

        if self._is_empty(self.title):
            self.MissingRequiredField("title")
        if not isinstance(self.title, str):
            self.title = str(self.title)

        if not isinstance(self.accessService, list):
            self.accessService = [self.accessService] if self.accessService is not None else []
        self.accessService = [v if isinstance(v, DataService) else DataService(**as_dict(v)) for v in self.accessService]

        if self.byteSize is not None and not isinstance(self.byteSize, int):
            self.byteSize = int(self.byteSize)

        if self.downloadURL is not None and not isinstance(self.downloadURL, URI):
            self.downloadURL = URI(self.downloadURL)

        if self.accessRights is not None and not isinstance(self.accessRights, AccessRightsValues):
            self.accessRights = AccessRightsValues(self.accessRights)

        if self.description is not None and not isinstance(self.description, str):
            self.description = str(self.description)

        if self.issued is not None and not isinstance(self.issued, XSDDate):
            self.issued = XSDDate(self.issued)

        super().__post_init__(**kwargs)


@dataclass
class Organisation(YAMLRoot):
    """
    Represents an Organisation
    """
    _inherited_slots: ClassVar[List[str]] = []

    class_class_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.Organisation
    class_class_curie: ClassVar[str] = "uk_cross_government_metadata_exchange_model:Organisation"
    class_name: ClassVar[str] = "Organisation"
    class_model_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.Organisation

    identifier: Union[str, OrganisationIdentifier] = None
    title: str = None

    def __post_init__(self, *_: List[str], **kwargs: Dict[str, Any]):
        if self._is_empty(self.identifier):
            self.MissingRequiredField("identifier")
        if not isinstance(self.identifier, OrganisationIdentifier):
            self.identifier = OrganisationIdentifier(self.identifier)

        if self._is_empty(self.title):
            self.MissingRequiredField("title")
        if not isinstance(self.title, str):
            self.title = str(self.title)

        super().__post_init__(**kwargs)


@dataclass
class OrganisationCollection(YAMLRoot):
    """
    A holder for Organisation objects
    """
    _inherited_slots: ClassVar[List[str]] = []

    class_class_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.OrganisationCollection
    class_class_curie: ClassVar[str] = "uk_cross_government_metadata_exchange_model:OrganisationCollection"
    class_name: ClassVar[str] = "OrganisationCollection"
    class_model_uri: ClassVar[URIRef] = UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.OrganisationCollection

    entries: Optional[Union[Dict[Union[str, OrganisationIdentifier], Union[dict, Organisation]], List[Union[dict, Organisation]]]] = empty_dict()

    def __post_init__(self, *_: List[str], **kwargs: Dict[str, Any]):
        self._normalize_inlined_as_dict(slot_name="entries", slot_type=Organisation, key_name="identifier", keyed=True)

        super().__post_init__(**kwargs)


# Enumerations
class AccessRightsValues(EnumDefinitionImpl):

    INTERNAL = PermissibleValue(
        text="INTERNAL",
        description="""Not publicly accessible for privacy, security or other reasons.  Usage note: This category may include resources that contain sensitive or personal information. These data resources would only be available to internal government users.""")
    OPEN = PermissibleValue(
        text="OPEN",
        description="""Publicly accessible by everyone.  Usage note: Permissible obstacles include registration and request for API keys, as long as anyone can request such registration and/or API keys. These data resources would be available to any user without a requirement to authenticate, i.e. open data.""")
    COMMERCIAL = PermissibleValue(
        text="COMMERCIAL",
        description="""Only available under certain conditions.  Usage note: This category may include resources that require payment, resources shared under non-disclosure agreements, resources for which the publisher or owner has not yet decided if they can be publicly released. These data resources would be available to any user without a requirement to authenticate, i.e. open data.""")

    _defn = EnumDefinition(
        name="AccessRightsValues",
    )

class DataShareAgreement(EnumDefinitionImpl):

    DATA_SHARE_AGREEMENT = PermissibleValue(
        text="DATA_SHARE_AGREEMENT",
        description="A data share agreement is required to use this data asset.")

    _defn = EnumDefinition(
        name="DataShareAgreement",
    )

# Slots
class slots:
    pass

slots.accessService = Slot(uri=DCAT.accessService, name="accessService", curie=DCAT.curie('accessService'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.accessService, domain=None, range=Optional[Union[Union[dict, DataService], List[Union[dict, DataService]]]])

slots.accessRights = Slot(uri=DCT.accessRights, name="accessRights", curie=DCT.curie('accessRights'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.accessRights, domain=None, range=Optional[Union[str, "AccessRightsValues"]])

slots.byteSize = Slot(uri=DCAT.byteSize, name="byteSize", curie=DCAT.curie('byteSize'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.byteSize, domain=None, range=Optional[int])

slots.description = Slot(uri=DCT.description, name="description", curie=DCT.curie('description'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.description, domain=None, range=Optional[str])

slots.downloadURL = Slot(uri=DCAT.downloadURL, name="downloadURL", curie=DCAT.curie('downloadURL'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.downloadURL, domain=None, range=Optional[Union[str, URI]])

slots.identifier = Slot(uri=DCT.identifier, name="identifier", curie=DCT.curie('identifier'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.identifier, domain=None, range=URIRef)

slots.issued = Slot(uri=DCT.issued, name="issued", curie=DCT.curie('issued'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.issued, domain=None, range=Optional[Union[str, XSDDate]])

slots.licence = Slot(uri=DCT.license, name="licence", curie=DCT.curie('license'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.licence, domain=None, range=str)

slots.mediaType = Slot(uri=DCAT.mediaType, name="mediaType", curie=DCAT.curie('mediaType'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.mediaType, domain=None, range=Union[str, URI])

slots.modified = Slot(uri=DCT.modified, name="modified", curie=DCT.curie('modified'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.modified, domain=None, range=Union[str, XSDDate])

slots.title = Slot(uri=DCT.title, name="title", curie=DCT.curie('title'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.title, domain=None, range=str)

slots.organisationCollection__entries = Slot(uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.entries, name="organisationCollection__entries", curie=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.curie('entries'),
                   model_uri=UK_CROSS_GOVERNMENT_METADATA_EXCHANGE_MODEL.organisationCollection__entries, domain=None, range=Optional[Union[Dict[Union[str, OrganisationIdentifier], Union[dict, Organisation]], List[Union[dict, Organisation]]]])