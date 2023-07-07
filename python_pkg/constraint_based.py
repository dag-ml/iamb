import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency

def conditional_independence_test(data, xi, xj, z_list):
    contingency_table = pd.crosstab(index=data[xi], columns=data[xj], margins=False)

    for z in z_list:
        contingency_table = contingency_table.stack(z)
    
    # Flatten the contingency table to a 2D array
    observed = contingency_table.values
    
    # Perform the chi-square test
    chi2, p_value, _, _ = chi2_contingency(observed)

    return p_value

def iamb(data, alpha=0.05):
    variables = list(data.columns)
    adjacency_matrix = np.zeros((len(variables), len(variables)))

    for i in range(len(variables)):
        for j in range(i+1, len(variables)):
            if adjacency_matrix[i][j] == 0:
                adj_set = set(range(len(variables))) - {i, j}
                xi = variables[i]
                xj = variables[j]

                # Step 1: Find all variables Z that are adjacent to both Xi and Xj
                z_list = []
                for z in adj_set:
                    xz = variables[z]
                    if (adjacency_matrix[i][z] == 1) and (adjacency_matrix[j][z] == 1):
                        z_list.append(xz)

                # Step 2: Test independence of Xi and Xj conditioned on Z
                p_value = conditional_independence_test(data, xi, xj, z_list)

                # Step 3: Orient the edges based on the independence test
                if p_value > alpha:
                    adjacency_matrix[i][j] = 1
                elif p_value > alpha:
                    adjacency_matrix[j][i] = 1

    return adjacency_matrix