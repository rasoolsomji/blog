#!/bin/bash
set -e

DATA_DIR=data
STATIC_ARCHIE_DIR=static/_gen/archie

mkdir -p "$STATIC_ARCHIE_DIR"
# Detector Dag
# Concepts
# I'm alive
archie generate context --scope detector-dag "$DATA_DIR/detectordag/concepts/im-alive.yml" | dot -Tsvg > "$STATIC_ARCHIE_DIR/im-alive-context-device.svg"
# I'm dead
archie generate context "$DATA_DIR/detectordag/concepts/im-dead.yml" | dot -Tsvg > "$STATIC_ARCHIE_DIR/im-dead-context.svg"
archie generate context --scope detector-dag/device "$DATA_DIR/detectordag/concepts/im-dead.yml" | dot -Tsvg > "$STATIC_ARCHIE_DIR/im-dead-context-device.svg"

# Independent
archie generate context --scope detector-dag/device "$DATA_DIR/detectordag/concepts/independent.yml" | dot -Tsvg > "$STATIC_ARCHIE_DIR/independent-context-device.svg"
