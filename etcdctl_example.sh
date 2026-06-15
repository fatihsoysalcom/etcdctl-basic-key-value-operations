#!/bin/bash

# This script demonstrates basic etcdctl operations for managing key-value pairs.
# It assumes an etcd server is running and accessible at the default port.

# --- Configuration ---
# If your etcd is not running on localhost:2379, uncomment and modify the following line:
# ETCDCTL_ENDPOINTS="http://your-etcd-host:2379"

# --- Helper function for output ---
print_section() {
    echo "\n----------------------------------------"
    echo "$1"
    echo "----------------------------------------"
}

# --- 1. Set a key-value pair ---
print_section "Setting key 'mykey' to value 'myvalue'"
etcdctl put mykey myvalue

# Verify the operation (optional, etcdctl put usually exits with 0 on success)
if [ $? -eq 0 ]; then
    echo "Successfully set 'mykey'."
else
    echo "Failed to set 'mykey'. Please ensure etcd is running."
    exit 1
fi

# --- 2. Get the value of a key ---
print_section "Getting value for key 'mykey'"
etcdctl get mykey

# --- 3. Set another key-value pair ---
print_section "Setting key 'config/database/url' to value 'postgres://user:pass@host:5432/db'"
etcdctl put config/database/url "postgres://user:pass@host:5432/db"

# --- 4. Get a key with a prefix ---
print_section "Getting all keys with prefix 'config/'"
etcdctl get config/

# --- 5. List all keys (if any)
# print_section "Listing all keys"
# etcdctl ls

# --- 6. Delete a key ---
print_section "Deleting key 'mykey'"
etcdctl del mykey

# Verify deletion
print_section "Verifying deletion of 'mykey'"
etcdctl get mykey

# --- 7. Get a non-existent key ---
print_section "Attempting to get a non-existent key 'nonexistentkey'"
etcdctl get nonexistentkey

# --- 8. Put a key with TTL (Time To Live) ---
# This key will expire after 5 seconds.
print_section "Setting key 'tempkey' with a TTL of 5 seconds"
etcdctl put tempkey tempvalue --ttl 5

echo "Waiting for 6 seconds to demonstrate TTL expiration..."
sleep 6

print_section "Attempting to get 'tempkey' after TTL expiration"
etcdctl get tempkey

print_section "Script finished."