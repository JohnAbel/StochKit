#!/bin/bash

cur_dir=$(pwd -P)

cd ..

# options for each of the trials
output_options_array=("" "" "" "--keep-trajectories" "--keep-histograms")

# options for seeds
seed_array=("75052381" "1398073729" "5680007" "1077743024" "2118936082")

# options for models
model_array=("dimer_decay.xml" "heat_shock_mass_action.xml" "heat_shock_mixed.xml" "heat_shock_10x.xml" "events1.xml")

# options for intervals
interval_array=("-i 2" "" "" "" "")

# options for solvers
method_array=("DM" "ODM" "ConstantTime" "NRM" "")

# options for outputs
output_dir_array=("dimer_decay_output_case2-" "heat_shock_mass_action_output_case2-" "heat_shock_mixed_output_case2-" "heat_shock_10x_output_case2-" "events1_output_case2-")

count=0

# run the loop 
for (( index = 0 ; index < ${#model_array[@]} ; index++ ))
do
    # set up selected items
    output_options_item=${output_options_array[$index]}
    seed_item=${seed_array[$index]}
    model_item=${models_array[$index]}
    output_dir_item=${output_dir_array[$index]}
    method_item=${method_array[$index]}
    interval_item=${interval_options_array[$index]}
    
    #print what we are doing
    printf -v count_pad "%02d" $count
    echo "we made it"
    echo "case$count_pad" "$model_item" "$output_item" "$interval_item"

    if [ ! -d "$cur_dir/logs/case$count_pad" ]
    then
       mkdir -m 700 "$cur_dir/logs/case$count_pad"
    fi

    #run the solver
    ./ssa -m "models/examples/$model_item" -t 10 -r 10 --method $method_item $interval_item --out-dir "models/examples/$output_dir_item$count_pad" "$output_item" -f --seed "$seed_item" >"$cur_dir/logs/case$count_pad/stdout2.txt" 2>&1

    let count=count+1

done
