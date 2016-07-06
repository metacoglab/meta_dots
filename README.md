meta_dots
=========

Code for running a dot-density perceptual decision experiment + confidence ratings

This code will run a dot-density perceptual decision experiment and collect confidence ratings. Performance is controlled online by a one-up two-down staircase procedure to ensure a sufficient number of correct/error trials for measuring metacognitive efficiency. Metacognitive efficiency can be measured by analysing the correspondence between accuracy and confidence, for instance with type 2 ROC analysis (using the type2roc code included), or meta-d' (http://www.columbia.edu/~bsm2105/type2sdt/ and github.com/smfleming/HMM). See Fleming & Lau (2014) How to measure metacognition doi: 10.3389/fnhum.2014.00443 for more details.

Running these scripts should be fairly simple. The first step is to ensure PsychToolbox is installed on the host machine; this can be done by following the instructions here: http://psychtoolbox.org/PsychtoolboxDownload

Then:

1) cd into the meta_dots directory
2) run perceptWrapper.m (type perceptWrapper at the command line)
3) Enter the relevant subject variables
4) Check data is being saved in the /data folder

In the first phase, example stimuli are shown with text below the circles indicating the number of dots in each circle (e.g., “40 vs. 60”). In the second phase there are a series of dot judgments without confidence ratings. This phase familiarizes participants with the task and also titrates a subject-specific level of difficulty by initiating the staircase procedure. The last phase consists of 10 practice trials that simulate the main task so that participants become familiar with indicating their confidence.

Any questions, comments or bugs please email stephen.fleming@ucl.ac.uk
