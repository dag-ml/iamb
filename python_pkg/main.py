import bnlearn as bn
import pandas as pd

# # df = bn.import_example()
# df = pd.read_csv('data\osd_489\LSDS-15_microCT_alwoodTRANSFORMED.csv')
# df = df.iloc[:, 3:]

# model = bn.structure_learning.fit(df)
# model = bn.independence_test(model, df)     # Compute edge strength with the chi_square test statistic
# G = bn.plot(model)

# Read the csv file
l9 = pd.read_csv('data\osd_351\LSDS-9_microCT_turnerTRANSFORMED.csv')
l40 = pd.read_csv('data\osd_477\LSDS-40_microCT_LSDS-40_microCT_KoTRANSFORMED.csv', skiprows=1)
l15 = pd.read_csv('data\osd_489\LSDS-15_microCT_alwoodTRANSFORMED.csv')

# Print out the header columns 
print(l9.columns, '\n\n')
print(l40.columns, '\n\n')
print(l15.columns, '\n\n')