import bnlearn as bn

df = bn.import_example()
# df = pd.read_csv('sprinkler_data.csv')


model = bn.structure_learning.fit(df)
# Compute edge strength with the chi_square test statistic
model = bn.independence_test(model, df)
G = bn.plot(model)