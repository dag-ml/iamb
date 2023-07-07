import pandas as pd
from constraint_based import iamb


def main():
    # Read the csv file
    l15 = pd.read_csv('data\\alwood\LSDS-15_microCT_alwoodTRANSFORMED.csv')
    l15 = l15.iloc[:, 3:]

    adjacency_matrix = iamb(l15, alpha=0.05)
    print(adjacency_matrix)


if __name__ == '__main__':
    main()