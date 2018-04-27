#!/bin/sh
#Delete files older than 5 days
find /mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Screenshots -mtime +5 -type f -delete
