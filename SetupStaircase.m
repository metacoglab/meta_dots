function Staircase = SetupStaircase(Condts, Signal, SigRng, UpDown)
%Staircase = SetupStaircase(Condts, Signal, SigRng, UpDown)
%
% Sets up a staircase procedure.
%
% Parameters:
%   Condts :    Number of stimulus conditions/levels etc.
%   Signal :    Stimulus signal level at beginning.
%   SigRng :    1 x 2 vector with range of stimulus levels
%   UpDown :    1 x 2 vector containing the criterion number of trials.
%               for going up and down, respectively.
%
% Returns a structure containing:
%     UpDown = Same as input argument 
%     Rising = Same as inpur argument
%     Accuracy = Staircase converges on this accuracy (2AFC design)
%     Correct = Counter of correct trials per condition
%     Incorrect = Counter of incorrect trials per condition
%     Previous = Was previous step up(+) or down(-) per condition?
%     Reversals = Counter of reversals per condition
%     Signal = Stimulus level per condition
%     Range = Range of stimulus range
%

Staircase = struct;

Staircase.UpDown = UpDown;
Up = UpDown(1);
Down = UpDown(2);
Staircase.Accuracy = 0.5 ^(Down/Up);

Staircase.Correct = zeros(1,Condts);
Staircase.Incorrect = zeros(1,Condts);
Staircase.Previous = ones(1,Condts);
Staircase.Reversals = zeros(1,Condts);

Staircase.Signal = ones(1,Condts) * Signal; 
Staircase.Range = SigRng;
