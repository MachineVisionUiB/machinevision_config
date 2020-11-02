#!/bin/bash

# File sync, images, video etc.
rsync -av --exclude=bootstrap --exclude=ctools --exclude=styles --exclude=php --exclude=css --exclude=js mvision:/var/www/drupal/machinevision/machinevision/web/sites/default/files/ /Users/steinmb/sites/machinevision/machinevision/web/sites/default/files

# Grab live database.
rsync -av mvision:/var/www/drupal/machinevision/latest.sql.gz /Users/steinmb/sites/machinevision

# Nuke old db. and import from prod. snapshot.
cd /Users/steinmb/sites/machinevision/machinevision/web || exit
drush sql-drop --yes
gunzip /Users/steinmb/sites/machinevision/latest.sql.gz
mysql mvisiond8 < ../../latest.sql

# Clear caches and authenticate.
drush cr
drush uli -l machinevision.local
