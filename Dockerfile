FROM python:3.10

# Install make
RUN apt update && apt install -y make

# Install poetry
RUN pip install poetry

# Copy all files to app
COPY ./ /app

# set working directory
WORKDIR /app

# Setup environment
RUN make install
RUN make update

# make docs
RUN make doc-setup

# serve docs
EXPOSE 8080
CMD make serve
