# filename   : Dockerfile
# Description: Dockerfile MSSQL initialized for api-events project
# Remarks    :
#               - https://hub.docker.com/_/microsoft-mssql-server
#               - https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container

# Base Docker images
# FROM mcr.microsoft.com/mssql/server:2019-CU15-ubuntu-20.04
FROM mcr.microsoft.com/mssql/server:2019-latest

# Switch to root user for access to apt-get install
USER root

# Install packages
RUN apt-get -y update  && \
    apt-get install -y curl  && \
    apt-get install -y dos2unix

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Environment variables

# Copy initialization scripts
COPY entrypoint.sh .
COPY run-initialization.sh .
COPY *.sql .
#COPY *.csv .

# Grant permissions for the `run-initialization.sh` script to be executable and read-write to `/usr/src/app/`
RUN chmod -R ugo+rw /usr/src/app/
RUN chmod +x /usr/src/app/run-initialization.sh

# Switch back to mssql user and run the entrypoint script
USER mssql

# Entrypoint
ENTRYPOINT /bin/bash ./entrypoint.sh
# CMD ["/bin/bash", "/usr/src/app/entrypoint.sh"]