
# [<img src=".bluebeluga.png" height="100" width="200" style="border-radius: 50%;"/>](https://github.com/blue-beluga/docker-zookeeper) bluebeluga/zookeeper

[Zookeeper](http://zookeeper.apache.org/) is a distributed coordination and consensus service.

## Installation and Usage

This image can be used to run one or more instances of Zookeeper required by brokers running in other containers. If running a single instance, the defaults are often good enough, especially for simple evaluations and demonstrations. However, when running multiple instances you will need to use the environment variables.

Production environments require running multiple instances of each service running on multiple hosts and machines to provide the performance, reliability, replication, and fault tolerance.

### Start Zookeeper

Starting a Zookeeper instance using this image is simple:

    docker run -d --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888 bluebeluga/zookeeper

### Display Zookeeper status

If you already have one or more containers running Zookeeper, you can use this image to start _another_ container that connects to the running instance(s) and displays the status:

    docker run -it --rm bluebeluga/zookeeper status

The container will exit as soon as the status is displayed, and because `--rm` is used the container will be immediately removed. You can run this command as many times as necessary.

### Use the Zookeeper CLI

If you already have one or more containers running Zookeeper, you can use this image to start _another_ container that connects to the running instance(s) and starts the Zookeeper CLI:

    docker run -it --rm bluebeluga/zookeeper cli

The container will exit as soon as you exit the CLI, and because `--rm` is used the container will be immediately removed.
You can run this command as many times as necessary.

## Environment variables

The Zookeeper image uses several environment variables.

### `SERVER_ID`

This environment variable defines the numeric identifier for this Zookeeper server. The default is '1' and is only applicable for a single standalone Zookeeper server that is not replicated or fault tolerant. In all other cases, you should set the server number to a unique value within your Zookeeper cluster.

### `SERVER_COUNT`

This environment variable defines the total number of Zookeeper servers in the cluster. The default is '1' and is only applicable for a single standalone Zookeeper server. In all other cases, you must use this variable to set the total number of servers in the cluster.

### `LOG_LEVEL`

This environment variable is optional. Use this to set the level of detail for Zookeeper's application log written to STDOUT and STDERR. Valid values are `INFO` (default), `WARN`, `ERROR`, `DEBUG`, or `TRACE`."

## Ports

Containers created using this image will expose ports 2181, 2888, and 3888. These are the standard ports used by Zookeeper. You can  use standard Docker options to map these to different ports on the host that runs the container.

## Data Volumes

### Zookeeper data

This image defines a data volume at `/zookeeper/data`, and it is in this directory that the Zookeeper server will persist all of its data. You must mount it appropriately when running your container to persist the data after the container is stopped; failing to do so will result in all data being lost when the container is stopped.

### Log files

Although this image will send Zookeeper's log output to standard output so it is visible as Docker logs, this image also configures Zookeeper to write out more detailed lots to a data volume at `/zookeeper/logs`. You must mount it appropriately when running your container to persist the logs after the container is stopped; failing to do so will result in all logs being lost when the container is stopped.

### Configuration

This image defines a data volume at `/zookeeper/conf` where the Zookeeper server's configuration files are stored. Note that these configuration files are always modified based upon the environment variables and linked containers. The best use of this data volume is to be able to see the configuration files used by Zookeper, although with some care it is possible to supply custom configuration files that will be adapted and used upon container startup.
