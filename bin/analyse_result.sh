#!/bin/bash

for file in ../data/regular_quad_mesh/*.obj; do
        if [ -d "$file" ]; then
            echo "$(basename "$file")"
        else
            filename=$(basename "$file")
            ./result_analysis $filename $1 $2 $3
        fi

done



