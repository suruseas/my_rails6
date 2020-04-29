#!/bin/bash
set -e
rm -rf /app/tmp/pids/server.pids
exec "$@"