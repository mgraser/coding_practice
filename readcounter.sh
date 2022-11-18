#! /bin/bash

file=$1

for line in $file
do
paste <( awk '{print $4}' $line | awk -F "/" '{ print $NF }') <( awk '{print $4}' $line | xargs gunzip -c | grep "@" | wc -l) <( awk '{print $5}' $line | awk -F "/" '{ print $NF }') <( awk '{print $5}' $line | xargs gunzip -c | grep "@" | wc -l)
done
