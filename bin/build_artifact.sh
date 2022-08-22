#!/bin/bash

LIVE_SITE=machine-vision.no
HOMEDIR=${PWD}
LIVE_HOMEDIR=/var/www/drupal/machinevision/machinevision
REPO=https://github.com/MachineVisionUiB/machinevision_config.git

# Clean clone.
cd "$HOMEDIR"/.. || exit 1
git clone "$REPO" mv_artifact

# Build it.
cd mv_artifact || exit 1
composer install --no-dev

# Create storage and copy files from live.

# Copy settings.

# Get a copy of the database.
rsync -av $LIVE_SITE:"$LIVE_HOMEDIR"/../latest.sql.gz "$HOMEDIR"/..
