#!/bin/bash

cur_dir=$(pwd -P)

cd ..

output_options_array=("")
interval_options_array=("-i 2 --keep-trajectories" "--keep-histograms")
models_array=("heat_shock_10x.xml" "schlogl.xml" "stochkit_events.xml")
output_dir_array=("heat_shock_10x_output_case2-" "schlogl_output_case2-" "stochkit_events_output_case2-")

seed_array=("75052381" "1398073729" "5680007" "1077743024" "2118936082" "664369650" "2055419909" "760559220" "1023622860" "2036910381" "1642909878" "1431171429" "1306538207" "2030777300" "888739240" "314621099" "61595042" "1815770255" "1865208005" "1975984741" "508256436" "1253109497" "622203109" "489785400" "1102076933" "1879248251" "1546058063" "503837780" "949504794" "997401045" "2050241623" "15124994" "2105646627" "1400994527" "1451888834" "1083425801" "1823063452" "308643723" "1323085576" "60255907" "1626007597" "1950371779" "925458291" "1790796785" "474053408" "1378961675" "811650154" "1490749646" "443495973" "80322276" "2067643682" "60826091" "2143549476" "122490661")
method_array=("Direct" "ODM" "NRM" "ConstantTime")

count=0

for (( model_index = 0 ; model_index < ${#models_array[@]} ; model_index++ ))
do
    model_item=${models_array[$model_index]}
    output_dir_item=${output_dir_array[$model_index]}

    method_index=0

    for (( output_index = 0 ; output_index < ${#output_options_array[@]} ; output_index++ ))
    do
       output_item=${output_options_array[$output_index]}
       method_item=${method_array[$method_index]}

       for (( interval_index = 0 ; interval_index < ${#interval_options_array[@]} ; interval_index++ ))
       do
          interval_item=${interval_options_array[$interval_index]}
          printf -v count_pad "%02d" $count
          echo "case$count_pad" "$model_item" "$output_item" "$interval_item"
          if [ ! -d "$cur_dir/logs/case$count_pad" ]
          then
             mkdir -m 700 "$cur_dir/logs/case$count_pad"
          fi
          seed_item=${seed_array[$count]}
          ./ssa -m "models/examples/$model_item" -t 2 -r 2 $interval_item --method "$method_item" --out-dir "models/examples/$output_dir_item$count_pad" "$output_item" -f --seed "$seed_item" -p 7 >"$cur_dir/logs/case$count_pad/stdout3.txt" 2>&1
          let count=count+1
          let method_index=method_index+1
       done
    done
done
