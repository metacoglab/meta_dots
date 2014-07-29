function [rt, k, t0, t] = WaitAnyPress(keys, timeout)
% WaitAnyPress - Wait for a button or a key press
%   Keyboard keys are mapped on 1:256
%   LENA-Buttons are read using ReadParPort and mapped on codes:
%       257 (for 1, left)
%       258 (for 2, middle)
%       259 (for 4, right)
%   By default, mouse clicks (which are mapped on 1=Left, 2=Right, 3=??,
%   4=Middle, 5=Backward, 6=Forward) are not listened to and LENA-buttons
%   are read only if OpenParPort is active.
%
%   [rt, k, t0, t] = WaitAnyPress(keys, timeout)
%
%OUPUTS:
%   rt: reaction time (NaN if no key was pressed before timeout)
%   k : array with 1's for the button/key which have been pressed
%   t0: start time of the wait
%   t : real time of the press, so that rt = t - t0
%
%See also: WaitAnyRelease, ReadParPort

% Author: K. N'Diaye (kndiaye01<at>yahoo.fr)
% Copyright (C) 2009 
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by  the
% Free Software Foundation; either version 2 of the License, or (at your
% option) any later version: http://www.gnu.org/copyleft/gpl.html
%
% ----------------------------- Script History ---------------------------------
% KND  2009-03-13 Creation
% KND  2009-03-30 Test OpenParPort to set default keys                  
% ----------------------------- Script History ---------------------------------

t0=GetSecs;
t=0;
rt=nan;
if nargin<2
    timeout = Inf;
end
btnCode = 256+[1:3];
if nargin<1
    keys=[];
end
if isempty(keys)
    % Not accepting mouse buttons (from 1 to 7)
    keys = [ 8:256 ];
    global PAR_PORT
    if ~isempty(PAR_PORT)
        keys = [ keys btnCode ];
    end    
end
if any(keys>256)
    checkButtons = 1;
else
    checkButtons = 0;
end
if any(keys<1)
    error('Can''t map keys below 1');
end
k=zeros(1,max(keys));
while ~any(k(keys)) && ((t-t0) < timeout)
    [keyIsDown,t,k] = KbCheck;
    if checkButtons
        [btnState] = ReadParPort(0);
        k(btnCode) = 0;
        k(btnCode(logical(bitget(btnState,1:3)))) = 1;
    end
end
if any(k(keys))
    rt = t-t0;
end