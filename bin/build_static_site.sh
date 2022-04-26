#!/bin/bash

# Export all content til JSON files and create
# a static HTML version of the site.

cp -v bin/views.view.search.yml config/sync || exit 1

cd web || exit 1
../vendor/bin/drush config:import --yes
echo "Removes redirects"
../vendor/bin/drush scr ../bin/remove_redirects.php
../vendor/bin/drush pmu redirect --yes
../vendor/bin/drush sql-dump --result-file=../bin/static_db.sql

rsync -a -v ../../machinevision cloud-user@158.39.77.25:/home/cloud-user/

# ls -l ../bin/static_db.sql || exit 1
# ../vendor/bin/drush sql-drop --yes
# sudo mysql mvisiond8 < ../bin/static_db.sql
# ../vendor/bin/drush cr
#../vendor/bin/drush tome:static -v --uri=https://machinevisionuib.github.io
