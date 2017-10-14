# MariaDB on Alpine Linux 3.6
This is a docker image with MariaDB/MySQL based on Alpine Linux 3.6.

 ## Environment variables
Various env vars can be set at runtime via your docker command or docker-compose environment section.

| Name                 | Default | Description            |
| -------------------- | ------- | ---------------------- |
| MYSQL_ROOT_PASSWORD  | root    | Password for root user |

## Usage
To use this start the container on port 3306 with:

```
docker run -d --name mysql -p 3306:3306 kalicki2k/alpine-mariadb
```

Or with environments:
```
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=secret -p 3306:3306 kalicki2k/alpine-mariadb

```
