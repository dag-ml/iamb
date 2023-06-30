import numpy as np
import pandas as pd
from scipy.stats import chi2, chi2_contingency

def iamb(data, alpha=0.05):
    num_variables = data.shape[1]
    adjacency_matrix = np.zeros((num_variables, num_variables), dtype=bool)
    
    for target_variable in range(num_variables):
        parents = []
        candidate_parents = list(range(num_variables))
        candidate_parents.remove(target_variable)
        
        while len(candidate_parents) > 0:
            scores = []
            for candidate_parent in candidate_parents:
                potential_parents = parents + [candidate_parent]
                score = score_iamb(data, target_variable, potential_parents)
                scores.append(score)
            
            best_parent_index = np.argmax(scores)
            best_parent = candidate_parents[best_parent_index]
            
            if scores[best_parent_index] > alpha:
                parents.append(best_parent)
                candidate_parents.remove(best_parent)
            else:
                break
        
        adjacency_matrix[target_variable, parents] = True
    
    return adjacency_matrix

def score_iamb(data, target_variable, parents):
    contingency_table = create_contingency_table(data, target_variable, parents)
    chi2_value = chi2_contingency(contingency_table)[0]
    score = 1 - chi2.cdf(chi2_value, df=(contingency_table.shape[0] - 1) * (contingency_table.shape[1] - 1))
    return score

def create_contingency_table(data, target_variable, parents):
    if len(parents) == 0:
        return pd.crosstab(data[:, target_variable], columns='count')
    
    columns = parents + [target_variable]
    return pd.crosstab(index=data[:, target_variable], columns=data[:, columns].T, rownames=[target_variable], colnames=columns)

# Example usage:
data = np.array([[0, 1, 0],
                 [1, 0, 1],
                 [0, 1, 1],
                 [1, 1, 0]])

adjacency_matrix = iamb(data, alpha=0.05)
print(adjacency_matrix)
