models=(
  "meta-llama/Meta-Llama-3-8B-Instruct"
  "meta-llama/Meta-Llama-3-8B"
  "meta-llama/Meta-Llama-3.1-8B"
  "meta-llama/Meta-Llama-3.1-8B-Instruct"
  "LLaMAX/LLaMAX3-8B"
)


prompt_tempaltes=('t1' 't2' 't3' 't4' 't5')

for model in "${models[@]}"
do
        for examples in 0 5 ; do
                for temp in "${prompt_tempaltes[@]}"; do
                        echo "$lan"_arc_challenge
                        python3 -m lm_eval --model hf \
                                --model_args pretrained=$model,parallelize=True  \
                                --tasks am_arc_challenge_$temp,am_arc_challenge_$temp,en_arc_challenge_$temp,ha_arc_challenge_$temp,nso_arc_challenge_$temp,sw_arc_challenge_$temp,yo_arc_challenge_$temp   \
                                --batch_size 1 \
                                --verbosity DEBUG \
                                --num_fewshot $examples \
                                --output_path "output/$model" \
                                --log_samples \
                                --wandb_args project=uhura,name=arc_challenge_"$model"_"$temp"
                done
        done
                     
done