#!/bin/bash

BUILD_COMPUTE=158.39.77.25
BUILD_USER=cloud-user

# Export all content til JSON files and create
# a static HTML version of the site.

# Override default search permissions. Preventing non logged in users
# access to search for non logged in users prevents static
# builder from building them.
cp -v bin/views.view.search.yml config/sync || exit 1
cd web || exit 1
../vendor/bin/drush config:import --yes

# Remove data and uninstall modules not needed on during the build.
# Avoid us spend time building data objects we don't need.
../vendor/bin/drush scr ../bin/remove_redirects.php
../vendor/bin/drush pmu redirect --yes
../vendor/bin/drush pmu dblog --yes

# Create a database backup of the stripped down version and sync
# it all to the build node.
../vendor/bin/drush sql-dump --result-file=../bin/static_db.sql

rsync -a -v ../../machinevision "$BUILD_USER"@"$BUILD_COMPUTE":/home/cloud-user/

## BUILD ON COMPUTE NODE ##
#
# ls -l ../bin/static_db.sql || exit 1
# ../vendor/bin/drush sql-drop --yes
# sudo mysql mvisiond8 < ../bin/static_db.sql
# ../vendor/bin/drush cr
#../vendor/bin/drush tome:static -v --uri=https://machinevisionuib.github.io
