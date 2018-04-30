#!/bin/bash

BLOG="../Ali1213.github.io";

rm -rf $BLOG/*;

hugo;

git add . ;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;

# mv -f public/* $BLOG;

cd  $BLOG;

git add .;

git commit -a -m "auto commit by ali at `date +%Y%m%d`";

git push origin master;