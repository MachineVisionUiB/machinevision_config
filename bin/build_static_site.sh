#!/bin/bash

# Export all content til JSON files and create
# a static HTML version of the site.

cd web || exit 1

../vendor/bin/drush tome:static --uri=http://static.machinevision.local
