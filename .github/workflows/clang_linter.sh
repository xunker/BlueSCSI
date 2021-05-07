#!/bin/bash
# Credit: https://medium.com/swlh/how-to-create-an-automated-build-pipeline-for-your-arduino-project-1df9826f2a5e

# Exit immediately if a command exits with a non-zero status.
set -e

# Enable the globstar shell option
shopt -s globstar

# Make sure we are inside the github workspace
cd $GITHUB_WORKSPACE

# Install clang-format
sudo apt-get -y install clang-format-10

for f in **/*.{h,c,hpp,cpp,ino} ; do
  if [ -f "$f" ]; then
    diff $f <(clang-format -assume-filename=main.cpp $f) 1>&2
  fi
done
