models=(
  "meta-llama/Meta-Llama-3-8B-Instruct"
  "meta-llama/Meta-Llama-3-8B"
  "meta-llama/Meta-Llama-3.1-8B"
  "meta-llama/Meta-Llama-3.1-8B-Instruct"
  "LLaMAX/LLaMAX3-8B"
)

languages=('am' 'ha' 'nso' 'sw' 'yo')
prompt_tempaltes=('t1' 't2' 't3' 't4' 't5')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do
               for examples in 0 5 ; do
                        for temp in "${prompt_tempaltes[@]}"; do
                                echo "$lan"_arc_challenge
                                python3 -m lm_eval --model hf \
                                        --model_args pretrained=$model,parallelize=True  \
                                        --tasks "$lan"_arc_challenge   \
                                        --batch_size 1 \
                                        --verbosity DEBUG \
                                        --num_fewshot $examples \
                                        --output_path "output/$model" \
                                        --log_samples \
                                        --wandb_args project=uhura,name="$lan"_arc_challenge
                        done
                done
        done
                     
done