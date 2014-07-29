meta_dots
=========

Code for running a dot-density perceptual decision experiment + confidence ratings

This code will run a dot-density perceptual decision experiment and collect confidence ratings. Performance is controlled online by a one-up two-down staircase procedure to ensure a sufficient number of correct/error trials for measuring metacognitive efficiency. Metacognitive efficiency can be measured by analysing the correspondence between accuracy and confidence, for instance with type 2 ROC analysis (using the AUROC2 code included), or meta-d' ( and github.com/smfleming/HMM). See Fleming & Lau (2014) How to measure metacognition doi: 10.3389/fnhum.2014.00443 for more details.

Running these scripts should be fairly simple. The first step is to ensure PsychToolbox is installed on the host machine; this can be done by following the instructions here: http://psychtoolbox.org/PsychtoolboxDownload

Then:

1) cd into the meta_dots directory
2) run perceptWrapper.m (type perceptWrapper at the command line)
3) Enter the relevant subject variables
4) Check data is being saved in the /data folder

Any questions, comments or bugs please email sf102@nyu.edu
