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
### Cleanup and remove Pulsar in Docker
```bash
docker compose -f compose.yml down
```

# AI Chat prompts 
Claude Sonnet 3.5 was used to create "compose.yml" and self-signed CERTS script.  The prompt text used:
```
You are an expert in Apache Pulsar, and an expert in TLS encrypted TCP connections. 
Use Docker Compose to create a Pulsar cluster with TLS enabled between the broker and clients.
The docker compose conf file should create a cluster with 1 Zookeeper, 1 Bookie, and 1 Broker as an example running cluster.
```
Results from Claude created the compose.yml and generate-certs.sh script files.