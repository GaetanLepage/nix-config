
num_gpus=$(nvidia-smi -L | wc -l)

get_ramp () {
    level=$1

    ramp=""

    if ((level<=12))
    then
        ramp="▁"
    elif ((level<=25))
    then
        ramp="▂"
    elif ((level<=37))
    then
        ramp="▃"
    elif ((level<=50))
    then
        ramp="▄"
    elif ((level<=62))
    then
        ramp="▅"
    elif ((level<=75))
    then
        ramp="▆"
    elif ((level<=87))
    then
        ramp="▇"
    else
        ramp="█"
    fi

    echo $ramp
#ramp-coreload-0-foreground = #aaff77
#ramp-coreload-1-foreground = #aaff77
#ramp-coreload-2-foreground = #aaff77
#ramp-coreload-3-foreground = #aaff77
#ramp-coreload-4-foreground = #fba922
#ramp-coreload-5-foreground = #fba922
#ramp-coreload-6-foreground = #ff5555
#ramp-coreload-7-foreground = #ff5555
}


apply_padding () {
    percentage=$1

    if ((percentage<10))
    then
        #echo "<10"
        percentage=" ${percentage}"
    elif ((percentage<99))
    then
        #echo "<100"
        percentage="${percentage}"
    fi

    echo "${percentage}"
}


gpu_output () {
    id=$1
    gpu_utilization=$(nvidia-smi -i $id --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    ramp_utilization=$(get_ramp $gpu_utilization)
    gpu_utilization=$(apply_padding $gpu_utilization)
    #echo "gpu_utilization="$gpu_utilization

    gpu_memory=$(nvidia-smi -i $id --query-gpu=utilization.memory --format=csv,noheader,nounits)
    ramp_memory=$(get_ramp $gpu_memory)
    gpu_memory=$(apply_padding $gpu_memory)

    echo "["${gpu_utilization}"% $ramp_utilization | ${gpu_memory}% $ramp_memory]"
}


gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

#echo "GPU 0: $gpu_usage %"


output="GPU "
for ((gpu_id=0;gpu_id<$num_gpus;gpu_id++));
do
    #gpu_output $gpu_id
    output="${output}$(gpu_output $gpu_id)"
done

echo ${output}

#apply_padding 12
