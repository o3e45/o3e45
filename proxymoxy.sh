#!/bin/bash

# Function to stop Proxmox services and remove cluster config
remove_cluster() {
    # Stop Corosync and Proxmox cluster services
    echo "Stopping Corosync..."
    systemctl stop corosync
    echo "Corosync stopped."

    # Remove Corosync configuration files
    echo "Removing Corosync configuration files..."
    rm -rf /etc/corosync/*
    rm -rf /var/lib/corosync/*
    echo "Corosync configuration files removed."

    # Stop the Proxmox cluster service and back up config
    echo "Stopping Proxmox cluster service..."
    systemctl stop pve-cluster
    cp /var/lib/pve-cluster/config.db{,.bak}
    echo "Proxmox cluster service stopped and config backed up."

    # Start pmxcfs in local mode
    echo "Starting pmxcfs in local mode..."
    pmxcfs -l
    echo "pmxcfs started in local mode."

    # Remove the virtual cluster config file
    echo "Removing corosync.conf to disjoin from cluster..."
    rm /etc/pve/corosync.conf
    echo "corosync.conf removed."

    # Kill local pmxcfs instance and restart pve-cluster service
    echo "Killing local pmxcfs instance and restarting pve-cluster..."
    killall pmxcfs
    systemctl start pve-cluster
    echo "Proxmox cluster service restarted."

    # Optional: Clean up leftover node entries
    echo "Cleaning up leftover node entries..."
    cd /etc/pve/nodes/
    ls -l
    echo "Please remove any leftover node directories manually (if any)."
    echo "Example: rm -rf other_node_name_left_over"
    echo "Or move them to /root/ if you're unsure: mv other_node_name_left_over /root/"
    echo "Cleanup done."
}

# Run the function to convert the Proxmox node to standalone
remove_cluster
