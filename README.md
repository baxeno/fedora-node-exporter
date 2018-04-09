# fedora-node-exporter

Setup [Prometheus node-exporter docker](https://hub.docker.com/r/prom/node-exporter/) on a [Fedora Server](https://getfedora.org/en/server/) or [Fedora Workstation](https://getfedora.org/en/workstation/) to allow machine metrics scraping from a [Prometheus](https://prometheus.io/) server.


# Usage

## Setup new machine

- Setup new node-exporter docker container.

```
$ cd scripts
$ sudo ./setup_node_exporter.sh
```

- Verify node-exporter docker container is running.

```
$ sudo docker ps
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                    NAMES
761cac2407ea        prom/node-exporter:v0.15.2   "/bin/node_exporte..."   2 minutes ago       Up 2 minutes        0.0.0.0:9100->9100/tcp   node-exporter
```


## Upgrade node-exporter version


> Discover new versions here: https://hub.docker.com/r/prom/node-exporter/tags/

- Teardown old node-exporter docker container.

`sudo ./teardown_node_exporter.sh`

- Update `REVISION` variable in `cfg.sh` file.

- Setup new node-exporter docker container.

`sudo ./setup_node_exporter.sh`
