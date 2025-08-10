#!/bin/bash

get_executable_name() {
    case $1 in
        0)
            echo "pre_process"
            ;;
        1)
            echo "generate_cross_field"
            ;;
        2)
            echo "generate_layout"
            ;;
        3)
            echo "simplify_layout"
            ;;
        4)
            echo "straighten_layout"
            ;;   
        5)
            echo "subdivide_layout"
            ;;   
        6)
            echo "generate_closed_form_quad"
            ;;   
        7)
            echo "generate_pattern_based_quad"
            ;;
        8)
            echo "generate_triangle_face"
            ;;
        9)
            echo "post_process"
            ;;
        *)
            echo "未知的选择"
            ;;
    esac
}


start_time=$(date +%s)
end_time=$(date +%s)

if [ "$1" == "-a" ]; then
    > error.txt
    > time.txt
    begin_idx=0
    end_idx=9
    length=1.0

    if [ $# -gt 2 ]; then
        begin_idx=$2
        end_idx=$3
    fi

    if [ $# -gt 3 ]; then
        length=$4
    fi
    

    for file in ../data/input/*.obj; do
        execution_time=()
        if [ -d "$file" ]; then
            echo "$(basename "$file")"
        else 
            filename=$(basename "$file")
            filename_no_extension="${filename%.*}"
            for (( i=begin_idx; i<=end_idx; i++ )); do
                executable=$(get_executable_name $i)
                if [ -x "$executable" ]; then
                    
                    start_time=$(date +%s)
                    timeout 900 ./$executable $filename_no_extension 0 $length
                    exit_status=$? 
                    end_time=$(date +%s)
                    tmp_time=$((end_time-start_time))
                    if [ $exit_status -eq 124 ]; then
                        echo "$filename_no_extension $executable 超时" >> error.txt
                    fi
                    if [ $exit_status -ne 0 ]; then
                        echo "$filename_no_extension $executable 失败" >> error.txt
                    fi
                    execution_time+=("$tmp_time")
                else
                    echo "找不到可执行文件: $executable"
                fi
            done
        
        fi
        IFS=','
        echo "$filename_no_extension,${execution_time[*]}" >> time.txt
    done
    cp time.txt ../data/
    cp error.txt ../data/

    
elif [ "$1" == "-f" ]; then
    begin_idx=0
    end_idx=9
    debug_level=0
    length=1.0
    if [ $# -gt 2 ]; then
        begin_idx=$3
    fi

    if [ $# -gt 3 ]; then
        end_idx=$4
    fi

    if [ $# -gt 4 ]; then
        debug_level=$5
    fi

     if [ $# -gt 5 ]; then
        length=$6
    fi

  execution_time=()


    for (( i=begin_idx; i<=end_idx; i++ )); do
        executable=$(get_executable_name $i)
        if [ -x "$executable" ]; then
            start_time=$(date +%s)
            timeout 900 ./$executable $2 $debug_level $length
            exit_status=$?  
            end_time=$(date +%s)
            tmp_time=$((end_time-start_time))

            if [ $exit_status -eq 0 ]; then
                execution_time+=("$tmp_time")
            elif [ $exit_status -eq 124 ]; then
                echo "程序 $executable 超过 900s，已被终止"
                exit 1
            else
                echo "程序 $executable 执行失败，返回状态: $exit_status"
                exit 1
            fi
        else
            echo "找不到可执行文件: $executable"
        fi
    done
    IFS=','
        echo "$2,${execution_time[*]}" >> time.txt

    exit 0
elif [ "$1" == "-c" ]; then
    TARGET_DIR="../data/"
    if [ ! -d "$TARGET_DIR" ]; then
        echo "目录 $TARGET_DIR 不存在！"
        exit 1
    fi

    for dir in "$TARGET_DIR"/*/; do
        if [[ "$dir" != "$TARGET_DIR/origin/" && "$dir" != "$TARGET_DIR/result_analysis/"&& "$dir" != "$TARGET_DIR/input/" ]]; then
            rm -rf "${dir}"*
        fi
    done
    echo "已删除 $TARGET_DIR 下所有子文件夹的内容。"
    exit 0


    echo "使用error_models.txt执行-a操作"
    > error.txt
    > time.txt
    begin_idx=0
    end_idx=9

    if [ $# -gt 2 ]; then
        begin_idx=$2
        end_idx=$3
    fi

    while read -r filename; do
        # echo $filename
        execution_time=()
        for (( i=begin_idx; i<=end_idx; i++ )); do
            executable=$(get_executable_name $i)
            start_time=$(date +%s)
            timeout 600 ./$executable $filename 0 1.0
            exit_status=$? 
            end_time=$(date +%s)
            tmp_time=$((end_time-start_time))
            if [ $exit_status -eq 124 ]; then
                echo "$filename $executable 超时" >> error.txt
            fi
            if [ $exit_status -ne 0 ]; then
                echo "$filename $executable 失败" >> error.txt
            fi
            execution_time+=("$tmp_time")

        done
        IFS=','
        echo "$filename,${execution_time[*]}" >> time.txt
    done < "error_models.txt"
      exit 0
else
    echo "未知选项：$1"
    exit 0
fi
