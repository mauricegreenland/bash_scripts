#!/bin/bash
# Delete files from Downloads folder older than x days
find ~/Downloads/ -type f -mtime +2 -exec mv {} ~/.Trash \;
find ~/Downloads/ -type d -mtime +2 -exec mv {} ~/.Trash \;

