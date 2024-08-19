models=(
  "meta-llama/Meta-Llama-3-8B-Instruct"
  "meta-llama/Meta-Llama-3-8B"
  "meta-llama/Meta-Llama-3.1-8B"
  "meta-llama/Meta-Llama-3.1-8B-Instruct"
  "LLaMAX/LLaMAX3-8B"
)

languages=('am' 'ha' 'nso' 'sw' 'yo')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do
                for fewshot in 0 5; do
                        echo "$lan"_truthfulqa_gen
                        python3 -m lm_eval --model hf \
                                --model_args pretrained=$model,parallelize=True  \
                                --tasks "$lan"_truthfulqa_gen   \
                                --batch_size 1 \
                                --verbosity DEBUG \
                                --num_fewshot $fewshot \
                                --output_path "output/$model" \
                                --log_samples \
                                --wandb_args project=uhura,name="$lan"_generation
                done
        done              
done