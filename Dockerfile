FROM python:3.10
# Install make
RUN apt update && apt install -y make

# Copy configuration files
COPY ./pyproject.toml ./mkdocs.yml /

# Copy license file
COPY ./LICENSE.md ./src/docs/ /docs/

##TODO: Copy across examples and convert to JSON
## Examples won't show until the above is done!
# Copy source files for model
COPY ./ /app
WORKDIR /app
RUN pip install poetry
RUN make install
RUN make update
RUN make doc-setup
EXPOSE 8080
CMD make serve
