#!/bin/sh

#
# Get Git for MacOSX from here: http://git-scm.com/download/mac
#

server_host="https://github.com/projectanarchy/projectanarchy.git"
temp_folder="_git_temp"

[ -d .git ] && rm -rf .git
[ -d $temp_folder ] && rm -rf $temp_folder

git clone --no-checkout $server_host $temp_folder

cd $temp_folder

mv .git ..
cd ..

git reset --hard HEAD

[ -d $temp_folder ] && rm -rf $temp_folder
