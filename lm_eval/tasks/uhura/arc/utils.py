# def doc_to_target(doc):
#     return eval(doc['choices']['label'])
import ast

def doc_to_choice(doc):
    return ast.literal_eval(doc['choices'])['text']

def doc_to_target(doc): 
    try:
        return ast.literal_eval(doc['choices'])['label'].index(doc['answerKey'])
    except:
        return -1
# def doc_to_text(doc):
#     q = """Question: {question} 

#         A: {a[0]}
#         B: {a[1]}
#         C: {a[2]}
#         D: {a[3]}
        
#         Answer:"""
    
#     return q.format(question=doc['question'],a=ast.literal_eval(doc['choices'])['text'])

def doc_to_text(doc):
    choices = ast.literal_eval(doc['choices'])['text']
    
    q = "Question: {question}\n\n"
    choice_labels = ['A', 'B', 'C', 'D']
    
    for i, choice in enumerate(choices):
        q += f"{choice_labels[i]}: {choice}\n"
    
    q += "\nAnswer:"
    
    return q.format(question=doc['question'])