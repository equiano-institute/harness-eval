models=(
  "LLaMAX/LLaMAX3-8B"
)

languages=('am' 'ha' 'sw' 'yo')

for model in "${models[@]}"
do
        for lan in "${languages[@]}"; do
                for examples in 0 5
                do
                        echo "$lan"_truthfulqa_gen_$examples
                        python3 -m lm_eval --model hf \
                                --model_args pretrained=$model,parallelize=True  \
                                --tasks "$lan"_truthfulqa_mc1   \
                                --batch_size 1 \
                                --num_fewshot $examples \
                                --verbosity DEBUG \
                                --output_path "output/$model" \
                                --log_samples \
                                --wandb_args project=uhura,name="$lan"_truthfulqa_mc1_$examples
                done
        done
                     
done