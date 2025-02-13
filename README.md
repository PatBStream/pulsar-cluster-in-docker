# Pulsar-mini-cluster-in-docker
## Example Apache Pulsar mini-cluster running in Docker
How to run a mini Apache Pulsar Cluster in Docker, with TLS enabled
Mini cluster of 1 Zookeeper, 1 Bookie, and 1 Broker container.

### Create directories for Docker to mount for Pulsar
```bash
mkdir -p pulsar/data/zookeeper pulsar/data/bookkeeper pulsar/certs pulsar/conf
sudo chown -R 10000 pulsar/data pulsar/certs pulsar/conf
```
**Note:** You must create the directories `pulsar/data/zookeeper` and `pulsar/data/bookkeeper` or Pulsar will NOT start in Docker.

### Run bash script to create self-signed CERTS for TLS connections between Clients and Brokers
```bash
sudo ./generate-certs.sh
```

### Edit "compose.yml" with your directory names
Update the **"volume:"** parameters with your directory names.

### Start Pulsar in Docker
Run Docker Compose command to create and start the Pulsar Cluster:
```bash
docker compose -f compose.yml up -d
```
Check logs to ensure Pulsar is running:
```
docker compose -f compose.yml logs | grep -i "PulsarService started"
docker compose -f compose.yml ps
```
### Cleanup and remove Pulsar in DOcker
```bash
docker compose -f compose.yml down
```