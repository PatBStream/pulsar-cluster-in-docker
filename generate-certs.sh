#!/bin/bash

# Create directories
mkdir -p pulsar/certs
cd pulsar/certs

# Generate CA private key and public certificate
openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
  -keyout ca.key.pem -out ca.cert.pem \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=CARoot"

# Generate broker private key and CSR
openssl req -newkey rsa:2048 -nodes \
  -keyout broker.key.pem -out broker.csr \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=broker"

# Sign the broker CSR with the CA
openssl x509 -req -days 365 \
  -in broker.csr -out broker.cert.pem \
  -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial

# Convert broker key to PKCS8 format (required by Pulsar)
openssl pkcs8 -topk8 -nocrypt \
  -in broker.key.pem -out broker.key-pk8.pem

# Generate client private key and CSR
openssl req -newkey rsa:2048 -nodes \
  -keyout client.key.pem -out client.csr \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=client"

# Sign the client CSR with the CA
openssl x509 -req -days 365 \
  -in client.csr -out client.cert.pem \
  -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial

# Convert client key to PKCS8 format
openssl pkcs8 -topk8 -nocrypt \
  -in client.key.pem -out client.key-pk8.pem

# Clean up temporary files
rm *.csr *.srl

# Set appropriate permissions
chmod 644 *.pem
