models=(
  "meta-llama/Meta-Llama-3-8B-Instruct"
)

templates=('t1' 't2' 't3' 't4' 't5')

for model in "${models[@]}"
do
        for temp in "${templates[@]}"; do
                for fewshot in 0 5; do
                        echo "$lan"_truthfulqa_gen
                        python3 -m lm_eval --model hf \
                                --model_args pretrained=$model,parallelize=True  \
                                --tasks am_truthfulqa_gen_$temp,en_truthfulqa_gen_$temp,ha_truthfulqa_gen_$temp,nso_truthfulqa_gen_$temp,sw_truthfulqa_gen_$temp,yo_truthfulqa_gen_$temp  \
                                --batch_size 1 \
                                --verbosity DEBUG \
                                --num_fewshot $fewshot \
                                --output_path "output/$model" \
                                --log_samples \
                                --wandb_args project=uhura,name=generation_"$temp"_"$fewshot"_shots
                done
        done              
done