'''
Chromosomes 1-19: These are called autosomes, and they contain the majority of an individual's genetic information. 
    They are responsible for most of the body's functions and traits.

Chromosome M (Mitochondrial DNA): Mitochondrial DNA is found in the mitochondria, the energy-producing structures 
    within cells. It is inherited exclusively from the mother and is involved in energy production.

Chromosome X and Y: These are the sex chromosomes. Typically, females have two X chromosomes (XX), while males have 
    one X and one Y chromosome (XY). These chromosomes determine an individual's sex and carry genes related to sexual development and some other traits.
'''

import pandas as pd
import bnlearn as bn


def preprocess():
    df = pd.read_csv('data/GLDS-366/GLDS-366_GWAS_processed_associations.csv')
    df = df.drop(df.columns[34:], axis=1)                       # Drop all columns after 34th column
    df = df.dropna(axis=0, how='all', subset=df.columns[3:])    # Drop all rows with NaN in columns 3 to end
    df = df.drop(df.columns[1], axis=1)                         # Drop "position.b38"

    # Create 3 new starting columns: "Autosomes", "Mitochodrial M", "Sex XY"
    df.insert(1, "Autosomes 1-19", 0)
    df.insert(2, "Mitochondrial M", 0)
    df.insert(3, "Sex XY", 0)

    # Loop through the dataframe, if chromosome is 1-19 set "Autosomes" to 1. If 20 then "Mitochondrial M" to 1 else "Sex XY" to 1
    for i in range(len(df)):
        chrm = df.iloc[i, 0]
        if chrm in range(1, 20):
            df.iloc[i, 1] = 1
        elif chrm == 20:
            df.iloc[i, 2] = 1
        else:
            df.iloc[i, 3] = 1

    # Drop dumb columns
    col = [0, 29, 30]
    for i in col:
      df = df.drop(df.columns[i], axis=1) 

    df = df.drop_duplicates()   # Keep only unique rows

    print(df.shape)

    df.to_csv('data/GLDS-366/PROCESSED_GLDS-366_GWAS_processed_associations.csv', index=False) # Save to csv



def chou_liu(df):
    dfhot, dfnum = bn.df2onehot(df)

    # Structure learning
    model = bn.structure_learning.fit(dfnum, methodtype='cl', black_list=['Embarked','Parch','Name'], root_node='Survived', bw_list_method='nodes')
    # Plot detected DAG
    G = bn.plot(model)

    # Compute edge strength using chi-square independence test and remove (prune) the not-signficant edges
    model1 = bn.independence_test(model, dfnum, alpha=0.05, prune=True)
    # [bnlearn] >Edge [Ticket <-> Sex] [P=0.714624] is excluded because it was not significant (P<0.05) with [chi_square]

    # Plot
    bn.plot(model1, pos=G['pos'])


def naive_bayes(df):
    # Structure learning
    model = bn.structure_learning.fit(df, methodtype='naivebayes', root_node="B")
    # Compute edge strength using chi-square independence test
    model = bn.independence_test(model, df, prune=False)
    # Plot
    bn.plot(model)

    # Prune using the chi-square independence test
    model = bn.independence_test(model, df, prune=True)
    # [bnlearn] >Compute edge strength with [chi_square]
    # [bnlearn] >Edge [B <-> A] [P=0.240783] is excluded because it was not significant (P<0.05) with [chi_square]
    # [bnlearn] >Edge [B <-> C] [P=0.766384] is excluded because it was not significant (P<0.05) with [chi_square]
    # [bnlearn] >Edge [B <-> D] [P=0.382504] is excluded because it was not significant (P<0.05) with [chi_square]
    # Plot
    bn.plot(model)


def constraint_based(df):
    # Structure learning
    model = bn.structure_learning.fit(df, methodtype='cs')
    # Plot detected DAG
    G = bn.plot(model)

    # Compute edge strength using chi-square independence test
    model = bn.independence_test(model, df, alpha=0.05, prune=True)
    bn.plot(model, pos=G['pos'])


def main():
    df = pd.read_csv('data/GLDS-366/foci_per_gy.csv')
    model = bn.structure_learning.fit(df, methodtype='ex', scoretype='bic')
    model = bn.independence_test(model, df, alpha=0.05, prune=True)
    bn.plot(model)


if __name__ == '__main__':
    main()