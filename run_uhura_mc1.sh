models=(
  "meta-llama/Meta-Llama-3-8B"
)

languages=('am' 'ha' 'sw' 'yo')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do

            echo "$lan"_truthfulqa_gen
            python3 -m lm_eval --model hf \
                    --model_args pretrained=$model,parallelize=True  \
                    --tasks "$lan"_truthfulqa_mc1   \
                    --batch_size 1 \
                    --verbosity DEBUG \
                    --output_path "output/$model" \
                    --log_samples \
                    --limit 5 \
                    --wandb_args project=uhura,name="$lan"_truthfulqa_mc1
        done
                     
done