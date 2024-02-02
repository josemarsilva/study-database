README
======

1. Build image Construir a imagem do MSSQL com o database de exemplo Northwind

    $ docker image build --no-cache -t josemarsilva/mssql-labdb-2019:v1 .
    $ docker tag josemarsilva/mssql-labdb-2019:v1 josemarsilva/mssql-labdb-2019:latest
	
    $ docker image ls | grep mssql-labdb
	... or ...
	> docker image ls | findstr mssql-labdb

    PS:
    (1) Force remove if necessary
        $ docker container rm -f mssql-labdb-2019
        $ docker image rm josemarsilva/mssql-labdb:latest
        $ docker image rm josemarsilva/mssql-labdb-2019:v1
        $ docker image ls | grep mssql-labdb-2019
    (2) Optionally Push image to registry
        $ docker image ls | grep mssql-labdb-2019
        $ docker push josemarsilva/mssql-labdb-2019:latest
    (3) Login if necessary:
        $ docker login -u josemarsilva

2. Run START background deamon SQLServer

    # JosemarSilva mssql-labdb-2019:latest
    # docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -d josemarsilva/mssql-labdb-2019:latest

    # MS SQL Server 2019
    # docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
    # docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share -d mcr.microsoft.com/mssql/server:2019-latest

    # MS SQL Server 2022   
    # docker run --name mssql-labdb-2022 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest

    PS:
    (1) Remove previous inactive container if necessary
	
        > # Windows Terminal
        > docker container ls -a | findstr mssql-labdb-2019

        $ # Linux
        $ docker container ls -a | grep mssql-labdb-2019

        > docker container rm -f mssql-labdb-2019
        $ docker container rm -f mssql-labdb-2019

	(2) Add shared Volume parameter to share a local folder with a container folder
		
		$ # after : ... -p 1433:1433
		$ "... -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share ..."
		$ # before: -d mcr.microsoft.com/mssql/ ...
	


4. Connect to SQL Server using the sqlcmd tool inside of the container

    $ docker container ls
    CONTAINER ID   IMAGE                                        COMMAND                  CREATED              STATUS              PORTS                    NAMES
    5e3030a0cbb2   mcr.microsoft.com/mssql/server:2019-latest   "/opt/mssql/bin/perm…"   About a minute ago   Up About a minute   0.0.0.0:1433->1433/tcp   mssql-labdb-2019

    $ docker container logs mssql-labdb-2019 -f
    ^C (to abort)

    $ echo "Warning: Works only when you build image on step (1)"
    $ docker container exec -it mssql-labdb-2019 -- bash
    root@71df89e49200:/usr/src/app# ls 
    entrypoint.sh          script-deploy-01.log  script-deploy-01.sql
    is-mssql-ready.log     is-mssql-ready.sql    run-initialization.sh

    $ docker container exec -it mssql-labdb-2019 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password@123
    SELECT * FROM INFORMATION_SCHEMA.TABLES
    GO

5. Connect to SQL Server using SSMS
	* Tipo de servidor: Mecanismo de Banco de Dados`: Mecanismo de Banco de Dados
	* Nome do servidor: 127.0.0.1
	* Autenticação: Autenticação do SQL Server
	* Login: sa
	* Senha: Password@123



REFERENCES
==========

* https://hub.docker.com/_/microsoft-mssql-server
* https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container
