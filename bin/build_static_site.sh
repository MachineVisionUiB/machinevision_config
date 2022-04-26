#!/bin/bash

# Export all content til JSON files and create
# a static HTML version of the site.

cp -v bin/views.view.search.yml config/sync || exit 1

cd web || exit 1
../vendor/bin/drush config:import --yes
../vendor/bin/drush sql-dump --result-file=../bin/static_db.sql

rsync -a -v ../../machinevision cloud-user@158.39.77.25:/home/cloud-user/

#../vendor/bin/drush tome:static -v --uri=https://machinevisionuib.github.io
