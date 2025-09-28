#!/bin/bash

for file in ../data/post_process/*.obj; do
        if [ -d "$file" ]; then
            echo "$(basename "$file")"
        else
            filename=$(basename "$file")
            ./result_analysis $filename $1 $2 $3
        fi

done



