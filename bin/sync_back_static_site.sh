#!/bin/bash

cd ../../machinevision || exit 1
rsync -a -v cloud-user@158.39.77.25:/home/cloud-user/static_version .
rsync -a -v cloud-user@158.39.77.25:/home/cloud-user/static_version/html machinevisionuib.github.io/

cd machinevisionuib.github.io || exit 1
git add .
git commit -m "Update build"
git push origin main

