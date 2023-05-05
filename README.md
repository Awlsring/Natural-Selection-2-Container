# Natural Selection 2 Container

A containerized Natural Selection 2 server with environment variables to customize server startup behavior.

This can be run out of the box with no variables and it will be a functioning server, however you should probably set at least a name to help you identify it in the server browser.

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
| WEB_PORT       |                     | If not set an enabled, defaults to `80`.                                                                                                                                                          |
| WEB_DOMAIN      |                     | IP address to allow remote access to web server.                                                                                                                                                                          |
| WEB_USER        |                     | User name for logging into web server.                                                                                                                                                                                    |
| WEB_PASSWORD    |                     | Password for logging into web server.                                                                                                                                                                                     |

## Examples

### Docker

Server can quickly be started with...

`docker run -d --name ns2 -e NAME=MyServer -e PASSWORD="Secret" -p 27015:27015 -p 27016-27016 ghcr.io/awlsring/ns2:latest`

### Docker-Compose

Docker-compose can be used with the following template...

```
version: "3.9"
services:
  ns2:
    image: "ghcr.io/awlsring/ns2:latest"
    ports:
      - "27015:27015/tcp"
      - "27015:27015/udp"
      - "27016:27016/tcp"
      - "27016:27016/udp"
    environment:
      NAME: "My NS2 Server"
      PASSWORD: "Secret"
      LIMIT: 16
```
