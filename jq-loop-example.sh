#!/bin/bash

#Script that shows how you can parse a JSON from shell and create a for loop
ids=$(curl -XGET "http://elastic-host:9200/my_index/_search/?stored_fields=id&sort=id&size=10&from=0" | jq -r '.hits.hits[]._id' | xargs -n1 echo | cat)

for id in $ids
do
    echo "Operate over $id.."
    #Here you can do your operation
done

echo "\nScript done."
