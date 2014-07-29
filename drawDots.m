function drawnXY = drawDots(p, n, XY)
% Subfunction for perceptual metacognition task
%
% SF 2012

Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectL,p.stim.pen_width);
Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectR,p.stim.pen_width);
for side = 1:2
    % Override calculation of xy if present as input
    if nargin > 2
        xy = XY{side};
        drawnXY{side} = xy;
    else
        xy = dotcloud(n(side),p.stim.dotsize);
        xy = xy*0.95*p.stim.inner_circle*p.fov;
        xy = xy/2*eye(2);
        drawnXY{side} = xy;
    end
    z = p.stim.dotsize*0.95*p.stim.inner_circle*p.fov;
    
    for i=1:n(side)
        wh = xy(i,[1 2 1 2])  +  [-z/2 -z/2 z/2 +z/2] + [ p.stim.centers(side,:) p.stim.centers(side,:) ];
        Screen('FillOval', p.frame.ptr, p.white,wh);
    end
end