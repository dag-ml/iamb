# Self-Compatibility: Evaluating Causal Discovery without Ground Truth


Building causal models is hard --> Causal discovery algorithms are used to infer causal
relationships from observational and simulated data. Meaning:
    - No ground truth
    - Simulations only reflect common preconceptions
    - Built on assumptions such as faithfulness or independence principles. 


Novel method for falsifying the output of a causal discovery algorithm in the absence of ground truth: 
    - Statistical learning --> seek stability across subsets of data points
    - Causal learning --> seek stability across subsets of variables 


Idea: 
    - To detect incompatibilities --> falsify wrongly inferred causal relations due to 
    violation of assumptions or errors from finite sample effects. 

    - Passing such compatibility tests:
        + Necessary criterion for good performance
        + Provides strong evidence for how how variables co-occur, increasing confidence of the causal models 


----


Framework to evaluate causal graphs in the absence of ground truth:

    1. Prove that if the assumptions of a causal discovery algorithm are met, it’s outputs are compatible.
    
        Whatever the premise of the algorithm's design or operation is based on, it might work under 
        certain assumptions, these assumptions might not always hold true in others. Reliability and 
        effectiveness are subjects of uncertainty and debate

            Bayesian priors: Probabilities of different events occurring, based on prior knowledge or beliefs.

            Independence testing: Certain variables are independent of each other (changes in one variable don't affect the other).

            Additive noise assumptions: Relationship between variables can be modeled with the addition of some random noise.

            Faithfulness: Relationships discovered by the algorithm are faithful representations of the true causal relationships.

            Post-nonlinear models: Mathematical models that account for non-linear relationships between variables.



    2. Looking at compatibility -> Identify cases where an algorithm's outputs might be incorrect or flawed



    3. Self-compatibility score: Quantifies the level of incompatibility of the outputs of causal discovery. 
    Serve as a proxy for measures like Structural Hamming distance (SHD) which require access to ground truth.

        Quantifies “how compatible” the outputs of an algorithm applied to different subsets of variables are. 

            For example, if you have a dataset with variables A, B, C, and D, you might run the algorithm on subsets 
            like {A, B}, {A, C}, {A, D}, {B, C}, and so on --> Trying to find causal relationships between different 
            pairs of variables or sets of variables.
        

        Perfect score indicates self-compatibility and in this sense the score can be used to falsify the outputs 
        of the causal discover algorithm.

           Instead of just saying it is completely compatible or not (yes or no, 1 or 0, binary)
           
           This score provides a more nuanced measure of compatibility by considering how much the algorithm's outputs 
           align across different subsets.

           If the algorithm's outputs are inconsistent when applied to different subsets, it suggests a lack of compatibility. 
           This inconsistency could indicate that the algorithm's results might not be reliable --> discredit the algorithm.
        

        Continuous score could be used to evaluate causal discovery algorithms in the sense that it could be used 
        as a “proxy” for the structural Hamming distance, which cannot be evaluated without ground truth knowledge.

            Since the true causal relationships are often unknown, this distance can't be directly calculated. 
            The compatibility score could provide a more accessible and meaningful metric to assess the performance of the algorithm.



    4. Paper shows significant correlation between their self-compatibility score and SHD.


----


Good place to look next, since we all have a dozen different algorithms to choose from. I think maybe one possible
next step, is for each of us to run the self-compatibility score on our algorithms and see how they do with the Ko
data set. See which one is most compatible and reliable.


THOUGH:

The paper did outlined some limitations of their approach:

    - Not possible to guarantee that a causal discovery algorithm with a high self-compatibility score will 
    accurately predict system behavior.

    - No hard theoretical guarantees that ensure good performance for good self-compatibility scores.