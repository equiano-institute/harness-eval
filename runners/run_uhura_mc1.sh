models=(
  "ebayes/uhura-llama-2-7b-instruct"
)

languages=('am' 'ha' 'nso' 'sw' 'yo')
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
                                        --log_samples \
                                        --wandb_args project=uhura,name="$lan"_truthfulqa_mc1_"$examples"_"$model"_"$temp"
                        done
                done
        done
                     
done