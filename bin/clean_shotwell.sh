#!/bin/sh
#Delete files older than 5 days
find $(xdg-user-dir PICTURES)/NotShotwelled/Screenshots -mtime +5 -type f -delete
