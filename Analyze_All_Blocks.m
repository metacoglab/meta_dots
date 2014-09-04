% Code for AUROC blockwise analysis

% loop solution
% for i=1:8
% type2roc(DATA(i).results.correct, DATA(i).results.responseConf, 6)
% end

% Ugly, clunky version
fprintf('Block 1')
type2roc(DATA(1).results.correct, DATA(1).results.responseConf, 6)
fprintf('Block 2')
type2roc(DATA(2).results.correct, DATA(2).results.responseConf, 6)
fprintf('Block 3')
type2roc(DATA(3).results.correct, DATA(3).results.responseConf, 6)
fprintf('Block 4')
type2roc(DATA(4).results.correct, DATA(4).results.responseConf, 6)
fprintf('Block 5')
type2roc(DATA(5).results.correct, DATA(5).results.responseConf, 6)
fprintf('Block 6')
type2roc(DATA(6).results.correct, DATA(6).results.responseConf, 6)
fprintf('Block 7')
type2roc(DATA(7).results.correct, DATA(7).results.responseConf, 6)
fprintf('Block 8')
type2roc(DATA(8).results.correct, DATA(8).results.responseConf, 6)