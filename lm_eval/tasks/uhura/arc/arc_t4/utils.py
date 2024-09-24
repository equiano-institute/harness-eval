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
    
    q = """Here's a problem to solve: {question} 
            Among the 4 following options, which is the correct answer?

            Options: \n""".format(question=doc['question'])
    choice_labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    
    # print(choices,choice_labels)
    for i, choice in enumerate(choices):
        q += f"\n{choice_labels[i]}: {choice}\n"
    
    q += "\n Correct Answer:"
    
    return q