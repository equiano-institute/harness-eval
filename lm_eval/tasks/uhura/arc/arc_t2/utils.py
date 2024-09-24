# def doc_to_target(doc):
#     return eval(doc['choices']['label'])
import ast

def doc_to_choice(doc):
    return ast.literal_eval(doc['choices'])['text']

def doc_to_target(doc):
    return ast.literal_eval(doc['choices'])['label'].index(doc['answerKey'])
    

def doc_to_text(doc):
    choices = ast.literal_eval(doc['choices'])['text']

    # print(doc)
    # print(choices)
    # print(len(choices))
    
    q = """Given a question and multiple-choice answers, return the letter corresponding to the correct answer.

        Question: {question} 
        
        Options: \n"""
    choice_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    
    # print(choices,choice_labels)
    for i, choice in enumerate(choices):
        q += f"\n{choice_labels[i]}: {choice}\n"
    
    q += "\n Correct Answer:"
    
    return q.format(question=doc['question'].replace('{','{\{').replace('}','}\}'))