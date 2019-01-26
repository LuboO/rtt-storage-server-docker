#! /bin/bash

# Create required directories and files - explicitly setting owners and permissions
# Owned by root
mkdir -p $1/storage
chmod -R 755 $1
chown -R root:root $1

# Owned by rtt_storage_user
touch $1/authorized_keys
mkdir -p $1/storage/config_files $1/storage/data_files
chmod -R 700 $1/storage/*
chmod 600 $1/authorized_keys $1/storage/*/*
chown -R rtt_storage_user:rtt_storage_user $1/authorized_keys $1/storage/*

# Run ssh daemon
/usr/sbin/sshd -D
