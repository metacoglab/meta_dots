function [Staircase, IsReversal] = UpdateStaircase(Condit, InStairs, StepSize)
%[Staircase IsReversal] = UpdateStaircase(Condit, InStairs, StepSize)
% 
% Updates the staircase for stimulus condition Condit. If the criterion for a 
% step are fulfilled, the Signal is changed accordingly. For a downwards staircase 
% (e.g. contrast-detection) the StepSize is negative. If the current step is a 
% reversal, the flag IsReversal is set.
% 

Staircase = InStairs;

IsReversal = 0;

if Staircase.Correct(Condit) >= Staircase.UpDown(1)
    % Step up i.e. harder
    Staircase.Correct(Condit) = 0;
    Staircase.Incorrect(Condit) = 0;
    % Is this a reversal?
    if Staircase.Previous(Condit) ~= 1 
        IsReversal = 1;
        Staircase.Reversals(Condit) = Staircase.Reversals(Condit) + 1;
    end
    Staircase.Previous(Condit) = 1;
    Staircase.Signal(Condit) = Staircase.Signal(Condit) + StepSize;
    if Staircase.Signal(Condit) < Staircase.Range(1)
        Staircase.Signal(Condit) = Staircase.Range(1);
    end    
    if Staircase.Signal(Condit) > Staircase.Range(2)
        Staircase.Signal(Condit) = Staircase.Range(2);
    end    
elseif Staircase.Incorrect(Condit) >= Staircase.UpDown(2)
    % Step down i.e. easier
    Staircase.Correct(Condit) = 0;
    Staircase.Incorrect(Condit) = 0;
    % Is this a reversal?
    if Staircase.Previous(Condit) ~= -1 
        IsReversal = 1;
        Staircase.Reversals(Condit) = Staircase.Reversals(Condit) + 1;
    end
    Staircase.Previous(Condit) = -1;
    Staircase.Signal(Condit) = Staircase.Signal(Condit) - StepSize;
    if Staircase.Signal(Condit) < Staircase.Range(1)
        Staircase.Signal(Condit) = Staircase.Range(1);
    end    
    if Staircase.Signal(Condit) > Staircase.Range(2)
        Staircase.Signal(Condit) = Staircase.Range(2);
    end    
end

