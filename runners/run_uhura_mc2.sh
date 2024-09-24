models=(
  "qwen2-0.5b-instruct"
)

languages=('am') # 'ha' 'sw' 'yo')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do

            echo "$lan"_truthfulqa_mc2
            python3 -m lm_eval --model hf \
                    --model_args pretrained=$model,parallelize=True,dtype=bfloat16  \
                    --tasks "$lan"_truthfulqa_mc2   \
                    --batch_size 1 \
                    --verbosity DEBUG \
                    --output_path "output/$model" \
                    --log_samples \
                    --limit 5 \
                    --wandb_args project=uhura,name="$lan"_truthfulqa_mc2
        done
                     
done