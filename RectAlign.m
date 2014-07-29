function [xywh] = RectAlign(wh,scr,varargin)
%RectAlign - Compute coordinates to align rectangular objects 
%   [xywh] = RectAlign(wh,r,alignment)
%       wh = the N-by-2 array of widths and heights of the object to align
%       r  = the [width height] of the containing rectangle/window 
%            or a screen number/pointer, or a screen resolution structure,
%            as output by Screen('Resolution')
%       alignment is a string specifying the style of alignment to use :
%           '[C]' for centered (default) | '[L]eft' | '[R]ight' |
%           '[T]op' | '[M]iddle' | '[B]ottom' (or any combination of these
%           letters, e.g., 'ctm' for horizontally centered but vertically
%           at mid-way between the top and the middle of the screen. 
%
%OUTPUTS:
%   xywh = a N-by-4 array with:
%           xywh(:,1) = the horizontal displacement(s)
%           xywh(:,2) = the vertical displacement(s)
%           xywh(:,3) = right border,  i.e. xywh(:,3)-xywh(:,1) = wh(:,1)
%           xywh(:,4) = bottom border, i.e. xywh(:,4)-xywh(:,2) = wh(:,2)
%           
%   Example
%      RectAlign([300 200], [640 480])
%
%   See also

% Author: Karim NDiaye
% Created: Jan 2009
% Copyright 2009

if nargin<2
    scr = 0;
end
if numel(scr)==1
    scr = Screen('Rect',scr);
end
if isstruct(scr)
    scr = [scr.width scr.height];
end

if nargin<3
    alignment='';
else
    alignment=varargin{1};
end
if isnumeric(alignment)
    if size(alignment,2) == 2
        x=alignment(:,1);
        y=alignment(:,2);
    else
        error('Wrong numeric alignment')
    end
else
    alignment=lower(alignment);
    if isequal(alignment, 'center')
        alignment='c';
    end
    if isequal(alignment, 'right')
        alignment='r';
    end
    if isequal(alignment, 'left')
        alignment='l';
    end
    if isequal(alignment, 'top')
        alignment='t';
    end
    if isequal(alignment, 'middle')
        alignment='m';
    end
    if isequal(alignment, 'bottom')
        alignment='b';
    end
    [z,z]=ismember(alignment,'lcrtmb');
    if any(z==0)
        error('Wrong alignment parameter!');
    end
    if any(z<=3)
        x=mean(z(z<=3))-2;
    else
        x=NaN;
    end
    if isnan(x)
        x=0;
    end
    if any(z>=4)
        y=mean(z(z>=4))-5;
    else
        y=NaN;
    end
    if isnan(y)
        y=0;
    end
end
xywh(:,1) = (1+x) * (scr(1)-wh(:,1))/2;
xywh(:,2) = (1+y) * (scr(2)-wh(:,2))/2;
xywh(:,3) = xywh(:,1) + wh(:,1);
xywh(:,4) = xywh(:,2) + wh(:,2);
