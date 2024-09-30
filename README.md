Hello!

Welcome to the analsysis of my internship project with PhD student Helena Kooi. I analysed all data stored here using MATLAB (online version).

As described before, this project works on the LIPSTIC technique. Initially it being tested on K562 cells due to their wide availability and similarity to the target cells. Eventually we will test this technique on our target cells, which are Hemtopoetic Stem Cells (HSC's). With it, we hope to be able to identify which cells were in close proximity to each other, and with the data from the timing this proximity took to happenn, and from the amount of tagged aproximations, we can infer if an interaction occured or not.

We are using constructs containing PDGFRB-SrtA-eGFP for the donor cells and Thy-1.1-G5-mScarlet for the acceptor cells, with the hopes that they will fluorescently tag cells. 

I would like to start this project by clarifying a few acronyms used to describe the samples:
EV = Empty Vector, this it the control construct containing only eGPF (donor) or mScarlet (acceptor) for the expression of fluorescent protein in our target cells.
LS1 = LIPSTIC 1, this is the vector contianing the green (donor-cell) construct.
LS2 = LIPSTIC 2, this is the vector containing the red (acceptor-cell) construct.
PEP = Peptide, this is our interaction-tagging peptide (LPETG-Biotin).

Some calculations were done using excel first and then the results obtained was used to further process our data into the final form we need. For exmaple, the weighted average of the geometric mean of the fluorescence signal (gMFI) was calculated using excel. All the files contianing these calcualtions used prior to MATLAB are stored are excel files in this repository.
