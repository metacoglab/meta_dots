        function perceptWrapper
% Dots task for perceptual metacognition
% Sebastien Massoni, modified by SF 2013

clear all
clc
addpath('mypsychtoolbox')
KbName('UnifyKeyNames');
PsychJavaTrouble()
%% Parameters
p = perceptGetParams;
Screen('TextSize',p.frame.ptr,24);

HideCursor;
%% Introduct ion
DrawText(p.frame.ptr,{'Welcome to this experiment!',' ',...
    'Press space bar to find out what the task involves!'},'c');
Screen('Flip', p.frame.ptr);
WaitSecs(1);
WaitAnyPress(KbName('space'));

%% Example stimul i

DrawText(p.frame.ptr,{'You will see two circles on the screen' ,'each with a number of dots inside.',' ' , ...
    ' ', 'Your task is to try to guess', 'which circle contains the most points.',...
    ' ', 'Then we will ask you to rate','your confidence in your decision.', ...
    ' ', 'Please press the space bar to continue'},'c');
Screen('Flip', p.frame.ptr);
WaitSecs(2);
WaitAnyPress(KbName('space'));

DrawText(p.frame.ptr,'Here are some example stimuli', 'c');
Screen('Flip', p.frame.ptr);
WaitSecs(1.0);

n=[40 60];
drawDots(p, n);
DrawFormattedText(p.frame.ptr,'40 vs 60', 'center', p.my+p.stim.diam+50);
t=Screen('Flip', p.frame.ptr);
WaitSecs(3);

n=[50 30];
drawDots(p, n);
DrawFormattedText(p.frame.ptr,'50 vs 30', 'center', p.my+p.stim.diam+50);
t=Screen('Flip', p.frame.ptr);
WaitSecs(3);

n=[53 58];
drawDots(p, n);
DrawFormattedText(p.frame.ptr,'53 vs 58', 'center', p.my+p.stim.diam+50);
t=Screen('Flip', p.frame.ptr);
WaitSecs(3);

n=[35 25];
drawDots(p, n);
DrawFormattedText(p.frame.ptr,'35 vs 25', 'center', p.my+p.stim.diam+50);
t=Screen('Flip', p.frame.ptr);
WaitSecs(3);

%% Main task blocks (8 blocks of 25 trials)
DrawFormattedText(p.frame.ptr, ['Please press the space bar to start...'], 'center', 'center');
Screen('Flip', p.frame.ptr);
WaitSecs(0.5);
WaitAnyPress(KbName('space'));
nblocks = 1;
feedback = 0;
conf = 1;
ntrials = 10;
staircase_reversal = Inf;
stepsize = 1;
adapt = 0;
for b = 1:nblocks
    start_x = 4;    % hardcode a starting offset of 4 dots
    results = perceptRunBlock(p, feedback, conf, ntrials, staircase_reversal, stepsize, adapt, start_x);
    xc=median(results.contrast(results.i_trial_lastreversal:end)  ); % contrast at end of block
    DrawFormattedText(p.frame.ptr, ['All done, take a break!'], 'center', 'center');
    Screen('Flip', p.frame.ptr);
    WaitSecs(0.5);
    WaitAnyPress(KbName('space'));    
    DATA(b).results = results;
    
    save(p.filename,'DATA');
end

%% Save the data and exit
Screen('Closeall')
