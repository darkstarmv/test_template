#!/bin/bash

MAXCONN=<%= @hamaxconn %>

curl -X PUT -d "$MAXCONN" http://localhost:8500/v1/kv/service/haproxy/maxconn
exit 0;
