# def doc_to_target(doc):
#     return eval(doc['choices']['label'])
import ast

def doc_to_choice(doc):
    return doc['choices']['text']

def doc_to_target(doc):
    return doc['choices']['label'].index(doc['answerKey'])
    

def doc_to_text(doc):
    choices = doc['choices']['text']

    # print(doc)
    # print(choices)
    # print(len(choices))
    
    q = """Answer the following question by choosing from given choices
    
        {question} \n """.format(question=doc['question'])
    choice_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    
    # print(choices,choice_labels)
    for i, choice in enumerate(choices):
        q += f"\n{choice_labels[i]}: {choice}\n"
    
    q += "\n Answer:"
    
    return q