#!/usr/bin/env bash

find ./ -name "*.sh" -exec chmod +x {} \;
./mh_keystore_setup.sh
./swarm_cluster_setup.sh
./network_setup.sh
