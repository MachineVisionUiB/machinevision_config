#!/bin/bash

LIVE_SITE=machine-vision.no
HOMEDIR=${PWD}
LIVE_HOMEDIR=/var/www/drupal/machinevision/machinevision

# File sync of user generated images, videos etc.
rsync -av --dry-run \
--exclude=bootstrap --exclude=ctools --exclude=styles --exclude=php --exclude=css --exclude=js \
$LIVE_SITE:"$LIVE_HOMEDIR"/web/sites/default/files/ \
"$HOMEDIR"/web/sites/default/files

# Grab live database.
rsync -av $LIVE_SITE:"$LIVE_HOMEDIR"/../latest.sql.gz "$HOMEDIR"/..

# Nuke old db. and import db dump from from production.
cd "$HOMEDIR"/web || exit
../vendor/bin/drush sql-drop --yes
gunzip --force "$HOMEDIR"/../latest.sql.gz
mysql mvisiond8 < ../../latest.sql

# Clear caches and authenticate.
../vendor/bin/drush cr
../vendor/bin/drush uli -l machinevision.local
