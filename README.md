# Natural Selection 2 Container

A containerized Natural Selection 2 server with environment variables to customize server startup behavior.

## Usage

### Docker

Server can quickly be started with...

```shell
docker run -d --name ns2 \
-e NAME="NS2 Server" \
-e PASSWORD="Secret" \
-p 27015:27015 \
-p 27016:27016 \
-v ~/ns2/server:/home/steam/ns2/server \
-v ~/ns2/config:/home/steam/ns2/config \
-v ~/ns2/logs:/home/steam/ns2/logs \
ghcr.io/awlsring/ns2:latest
```

### Docker-Compose

Docker-compose can be used with the following template...

```yaml
version: "3.9"
services:
  ns2:
    image: "ghcr.io/awlsring/ns2:latest"
    ports:
      - "27015:27015/tcp"
      - "27015:27015/udp"
      - "27016:27016/tcp"
      - "27016:27016/udp"
    volumes:
      - ~/ns2/server:/home/steam/ns2/server
      - ~/ns2/config:/home/steam/ns2/config
      - ~/ns2/logs:/home/steam/ns2/logs
    environment:
      NAME: "My NS2 Server"
      PASSWORD: "Secret"
      LIMIT: 16
```


## Environment Variables

_Names and values are case-sesitive._

More details can be found on the [Natural Selection 2 Wiki](https://naturalselection.fandom.com/wiki/Dedicated_Server)

| Name            | Default             | Purpose                                                                                                                                                                                                                   |
| --------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NAME     | `NS2 Server`               | Name of the server that will be shown in the server browser.                                                                                                                                                              |
| PASSWORD        |                     | The password for the server. If not specified none will be set.                                                                                                                                                           |
| PORT            | `27015`             | The port to access the server on. The port one after this will be bound for query data. (Ex. The default connection port is 27015, so the query port would be 27016)                                                      |
| MAP             | `ns2_summit`        | Default map to start the server on.                                                                                                                                                                                       |
| LIMIT           | `24`                | Player limit allowed on server. Max is 24.                                                                                                                                                                                |
| SPECTATOR_LIMIT | `0`                 | Allowed number of spectators on server.                                                                                                                                                                                   |
| CONFIG_PATH     | `/home/steam/ns2/config`                    | Path for server config file.                                                                                                                                                                                              |
| LOG_DIR         |      `/home/steam/ns2/logs`                | Path for where log files are kept.                                                                                                                                                                                                         |
| MODS            |                     | Space seperated list of mod IDs.                                                                                                                                                                                          |
| MOD_DIR     |      `/home/steam/ns2/mods`                | Location mods are stored.                                                                                                                                                                                                 |
| WEB_ADMIN       |                     | If anything is set for this variable, the Web admin will be set.                                                                                                                                                          |
| WEB_PORT       |                     | If not set as enabled, defaults to `80`.                                                                                                                                                          |
| WEB_DOMAIN      |                     | IP address to allow remote access to web server.                                                                                                                                                                          |
| WEB_USER        |                     | User name for logging into web server.                                                                                                                                                                                    |
| WEB_PASSWORD    |                     | Password for logging into web server.                                                                                                                                                                                     |

## Volumes

This container by default stores various server files in subdirectories of `/home/steam/ns2`. These can be mounted to the host for persistence.

It is recommended to mount the `server` directory to the host so that the server will not be reset when the container is updated.

| Path | Purpose |
| ---- | ------- |
| `/home/steam/ns2/server` | This is where all server files are stored. |
| `/home/steam/ns2/config` | This is where the various json config files are stored. |
| `/home/steam/ns2/mods` | This is where mods are stored. |
| `/home/steam/ns2/logs` | This is where the server log is written. |
