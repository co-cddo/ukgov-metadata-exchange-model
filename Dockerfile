FROM python:3.10
# Copy configuration files
COPY ./pyproject.toml ./mkdocs.yml /
# Copy license file
COPY ./LICENSE.md ./src/docs/ /docs/
##TODO: Copy across examples
# Copy source files for model
COPY ./src/ /src/
RUN pip install poetry
RUN poetry install
RUN poetry run gen-doc -d /docs --template-directory src/docs/templates src/model/uk_cross_government_metadata_exchange_model.yaml
EXPOSE 8080
CMD poetry run mkdocs serve
