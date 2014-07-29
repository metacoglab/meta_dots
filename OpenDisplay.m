function [window] = OpenDisplay(subscreen,color)
% OpenDisplay - Easy open of the display using Psychtoolbox's Screen

AssertOpenGL;
scr.Screens = Screen('Screens');
scr.screenNumber = max(scr.Screens);
%scr.Resolution = Screen('Resolution',scr.screenNumber);

if nargin<1
    subscreen = [ 640 480 ];    
end
if nargin<2
    color=[0 0 100];
end

if numel(subscreen)==2
    [wh]=Screen('Rect', scr.screenNumber);
    subscreen = RectAlign(subscreen,[wh(3:4)-wh(1:2)],'rctm');
end
Screen('Preference', 'Verbosity', 1);
Screen('Preference', 'VBLTimeStampingMode', -1);
Screen('Preference', 'SkipSyncTests', 1);
window = struct;

% kPsychNeedFastOffscreenWindows
kPNFOW = [];
global EXPERIMENT
try
    if ~EXPERIMENT.DEBUG
        kPNFOW = kPsychNeedFastOffscreenWindows;
        Screen('Preference', 'SkipSyncTests', 0);
    end
catch 
    EXPERIMENT.DEBUG = 1 ;
end

if numel(subscreen)==0
    % Open whole screen display
    [window.ptr, window.rect] = Screen('OpenWindow', ...
        scr.screenNumber, color, [], [], [], [], [], ...
        kPNFOW);
else
     %Open a smaller graphic window in the screen
    [window.ptr, window.rect] = Screen('OpenWindow', ...
        scr.screenNumber, color, subscreen, [], [], [], [], ...
        kPNFOW);
end
window.color=color;
[window.size(1), window.size(2)] = Screen('WindowSize', window.ptr);
% Enable alpha blending with proper blend-function. We need it
% for drawing of smoothed points:
Screen('BlendFunction', window.ptr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
Screen('Flip', window.ptr);

try
    if ~EXPERIMENT.DEBUG
        HideCursor;
        Priority(MaxPriority(window.ptr));
        % Retrieves flip interval only for fullscreen mode
        window.ifi = Screen('GetFlipInterval', window.ptr, 100, 50e-6, 10);
        % Retrieves number of frames per second
        window.fps = Screen('FrameRate', window.ptr);
        if window.fps==0
            window.fps=1/window.ifi;
        end;

        % Color calibration
        % LoadIdentityClut(window.ptr);
        % window.clut = CreateCalibratedClut(screen);
    else
           fprintf('Debug mode required\n');
    end
catch
    fprintf('Debug mode\n');
end



return