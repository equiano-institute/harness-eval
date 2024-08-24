models=(
  ""meta-llama/Meta-Llama-3-8B""
)

languages=('am' 'en' 'ha' 'nso' 'sw' 'yo')
prompt_tempaltes=('t1' 't2' 't3' 't4' 't5')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do
                for examples in 0 5; do
                        for temp in "${prompt_tempaltes[@]}"; do
                                echo "$lan"_truthfulqa_gen_$examples
                                python3 -m lm_eval --model hf \
                                        --model_args pretrained=$model,parallelize=True  \
                                        --tasks "$lan"_truthfulqa_mc1_$temp   \
                                        --batch_size 1 \
                                        --num_fewshot $examples \
                                        --verbosity DEBUG \
                                        --output_path "output/$model" \
                                        --limit 5 \
                                        --log_samples \
                                        --wandb_args project=uhura-cluster,name="$lan"_truthfulqa_mc1_"$examples"_"$model"_"$temp"
                        done
                done
        done
                     
done