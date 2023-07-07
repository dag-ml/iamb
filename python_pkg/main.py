import pandas as pd
from constraint_based import iamb


def main():
    # Read the csv file
    l15 = pd.read_csv('data\ko\LSDS-40_microCT_LSDS-40_microCT_KoTRANSFORMED.csv')
    l15 = l15.iloc[1:, 5:]

    adjacency_matrix = iamb(l15, alpha=0.05)
    print(adjacency_matrix)


if __name__ == '__main__':
    main()