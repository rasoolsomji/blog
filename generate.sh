#!/bin/bash
set -e

DATA_DIR=data
STATIC_ARCHIE_DIR=static/_gen/archie

mkdir -p "$STATIC_ARCHIE_DIR"
# Detector Dag
# Concepts
# I'm alive
archie generate context --scope detector-dag "$DATA_DIR/detectordag/concepts/im-alive.yml" | dot -Tpng > "$STATIC_ARCHIE_DIR/im-alive-context-device.png"
# I'm dead
archie generate context "$DATA_DIR/detectordag/concepts/im-dead.yml" | dot -Tpng > "$STATIC_ARCHIE_DIR/im-dead-context.png"
archie generate context --scope detector-dag/device "$DATA_DIR/detectordag/concepts/im-dead.yml" | dot -Tpng > "$STATIC_ARCHIE_DIR/im-dead-context-device.png"

# Independent
archie generate context --scope detector-dag/device "$DATA_DIR/detectordag/concepts/independent.yml" | dot -Tpng > "$STATIC_ARCHIE_DIR/independent-context-device.png"
