% Demo script for how to prepare output of dots task for AUROC2/meta-d analysis
%
% SF 2017

% Convert 0-1 proportion into 6-point confidence
Nratings = 6;
confidence = (DATA.results.responseConf.*5) + 1;
accuracy = DATA.results.correct;

auroc2 = type2roc(accuracy, confidence, Nratings);

% Prepare data for meta-d' (need to know both stimulus and response class,
% not just accuracy)
binaryConf = (confidence > 3) + 1;
for i = 1:2
    % sum stimulus=X, response=Y, conf = i
    sR_rR(i) = sum(binaryConf(DATA.results.response == 2 & DATA.results.correct) == i);
    sL_rR(i) = sum(binaryConf(DATA.results.response == 2 & ~DATA.results.correct) == i);
    sR_rL(i) = sum(binaryConf(DATA.results.response == 1 & ~DATA.results.correct) == i);
    sL_rL(i) = sum(binaryConf(DATA.results.response == 1 & DATA.results.correct) == i);    
end
nR_S1 = [sL_rL(end:-1:1) sL_rR];    % flip vectors so they read high->low->low->high confidence
nR_S2 = [sR_rL(end:-1:1) sR_rR];
