function p = perceptGetParams
% Params for perceptual metacognition task
%
% SF 2012

%% Subject parameters
p.subID = inputdlg('Please Enter SubjectID','SubjectID');
p.age = inputdlg('Age? ','Age');
p.gender = inputdlg('Gender? M/F','Gender');
p.hand = inputdlg('Handedness? R/L ','Hand');

p.filename = ['perceptData' p.subID{1} '.mat'];

if IsWin
    dataDir = [pwd '\perceptData\'];
else
    dataDir = [pwd '/perceptData/'];
end
if ~exist('perceptData')
    mkdir perceptData
end

p.filename = [dataDir p.filename];

%% Window parameters

p.sittingDist = 40;
p.BackgroundColor = 0;
% p.windowsize =  []; % empty for full screen
p.windowsize = [1000 800];
p.frame = OpenDisplay(p.windowsize,p.BackgroundColor);
t=Screen('Flip', p.frame.ptr); 
% Size of the display
p.fov = min(p.frame.size);
p.frame.color = p.BackgroundColor;
% Colors
p.white = WhiteIndex(p.frame.ptr);
[p.mx,p.my] = getScreenMidpoint(p.frame.ptr);

%% Stimuli

% Diameter of the circle relative to the screen
p.stim.inner_circle = .45;
p.stim.pen_width = p.stim.inner_circle / 20;

% Draw inner circle
rect = p.stim.inner_circle*p.fov*[1 1];
p.stim.diam = (p.stim.inner_circle.*p.fov)./2;
% Bounding box of the Left circle
p.stim.rectL = RectAlign(rect,p.frame.size,'llc');
% Bounding box of the Right circle
p.stim.rectR = RectAlign(rect,p.frame.size,'rrc');
% Easy call to each circle
p.stim.rect = [p.stim.rectL ; p.stim.rectR ];
p.stim.centers = [p.stim.rect(:,3)+p.stim.rect(:,1) p.stim.rect(:,4)+p.stim.rect(:,2)]/2;

%Fixation Cross
[xL,yL] = RectCenter(p.stim.rectL);
[xR,yR] = RectCenter(p.stim.rectR);
p.stim.FixCrossL = [xL-1,yL-20,xL+1,yL+20;xL-20,yL-1,xL+20,yL+1];
p.stim.FixCrossR = [xR-1,yR-20,xR+1,yR+20;xR-20,yR-1,xR+20,yR+1];

% Points' number reference
p.stim.REF = 50;
% Size of the dots:
p.stim.dotsize = 0.03; 

% confidence scale
p.stim.VASwidth_inDegrees = 20;
p.stim.VASheight_inDegrees = 2;
p.stim.VASoffset_inDegrees = 0;
p.stim.arrowWidth_inDegrees = 0.5;

p.stim.VASwidth_inPixels = degrees2pixels(p.stim.VASwidth_inDegrees, p.sittingDist);
p.stim.VASheight_inPixels = degrees2pixels(p.stim.VASheight_inDegrees, p.sittingDist);
p.stim.VASoffset_inPixels = degrees2pixels(p.stim.VASoffset_inDegrees, p.sittingDist);
p.stim.arrowWidth_inPixels = degrees2pixels(p.stim.arrowWidth_inDegrees, p.sittingDist);

%% Timings

p.times.fix = 1;
p.times.dots = 0.7;
p.times.postChoice = 0.5;
p.times.confDuration_inSecs = 3;
p.times.confFBDuration_inSecs = 0.5;
p.times.feedback = 2;
p.times.ITI = 0.5;