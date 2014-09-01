function results = perceptRunBlock(p, feedback, conf, ntrials, staircase_reversal, stepsize, adapt, start_x)
% Subfunction to run block of dots task
%
% Either terminates after given number of reversals, or runs fixed number
% of trials
%
% Set ntrials to Inf and staircase_reversal to an integer for former, and
% vice-versa for latter
%
% SF 2013

i_trial = 0;
nreversals = 0;
x(1)= start_x;

while nreversals < staircase_reversal && i_trial < ntrials
    i_trial = i_trial + 1 ;
    n = p.stim.REF+(2*(rand>.5)-1).*max(0,x(i_trial)); % either greater or less than standard, random  (staircase can go negative but only values >=0 are used, avoids boundary problem)
    n = round(n);
    n = max(1,n);
    n = min(n,2*p.stim.REF);    % bound by 1 and 2*REF
    s = (rand>.5);  % choose random side for standard
    if s
        n = [p.stim.REF n];
    else
        n = [n p.stim.REF];
    end
    
    % Draw frames
    Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectL,p.stim.pen_width);
    Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectR,p.stim.pen_width);
    Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossL');
    Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossR');
    Screen('Flip', p.frame.ptr);
    WaitSecs(p.times.fix);
    % Draw dots
    drawnXY = drawDots(p, n);
    DrawFormattedText(p.frame.ptr,'Which has more dots ? ', 'center',  p.my+p.stim.diam+50);
    DrawFormattedText(p.frame.ptr,'[Left] ? [Right]', 'center',  p.my+p.stim.diam+100);
    t=Screen('Flip', p.frame.ptr);
    
    % Check for keypress
    FlushEvents;
    trialComplete = false;
    start_secs = GetSecs;
    secs = start_secs;
    while ~trialComplete & (secs - start_secs) < p.times.dots
        [k respTime keyCode] = KbCheck();
        if strcmp(KbName(keyCode),'a') | strcmp(KbName(keyCode),'d')
            trialComplete = true;
            if strcmp(KbName(keyCode),'a')
                key = 1;
            elseif strcmp(KbName(keyCode),'d')
                key = 2;
            elseif strcmp(KbName(keyCode),'q')
                Screen('CloseAll')
                return
            end
            rt = respTime - t;
            % Show confirmation of choice
            drawDots(p, n, drawnXY);
            DrawFormattedText(p.frame.ptr,'Which has more dots ? ', 'center',  p.my+p.stim.diam+50);
            DrawFormattedText(p.frame.ptr,'[Left] ? [Right]', 'center',  p.my+p.stim.diam+100);
            Screen('TextSize',p.frame.ptr,48);
            if key == 1
                DrawFormattedText(p.frame.ptr,'*', p.stim.rectL(3)-p.stim.diam, p.my-p.stim.diam-50);
            else
                DrawFormattedText(p.frame.ptr,'*', p.stim.rectR(1)+p.stim.diam, p.my-p.stim.diam-50);
            end
            Screen('TextSize',p.frame.ptr,24);
            Screen('Flip', p.frame.ptr);
            WaitSecs(p.times.dots-rt); % keep dots presentation constant
        end
        secs = GetSecs;
    end
    
    % Take dots off the screen, wait for keypress if needed
    Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectL,p.stim.pen_width);
    Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectR,p.stim.pen_width);
    Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossL');
    Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossR');
    DrawFormattedText(p.frame.ptr,'Which has more dots ? ', 'center',  p.my+p.stim.diam+50);
    DrawFormattedText(p.frame.ptr,'[Left] ? [Right]', 'center',  p.my+p.stim.diam+100);
    Screen('TextSize',p.frame.ptr,48);
    if trialComplete
        if key == 1
            DrawFormattedText(p.frame.ptr,'*', p.stim.rectL(3)-p.stim.diam, p.my-p.stim.diam-50);
        else
            DrawFormattedText(p.frame.ptr,'*', p.stim.rectR(1)+p.stim.diam, p.my-p.stim.diam-50);
        end
    end
    Screen('TextSize',p.frame.ptr,24);
    Screen('Flip', p.frame.ptr);
    
    while ~trialComplete
        FlushEvents;
        [k respTime keyCode] = KbCheck();
        if strcmp(KbName(keyCode),'a') | strcmp(KbName(keyCode),'d')
            trialComplete = true;
            if strcmp(KbName(keyCode),'a')
                key = 1;
            elseif strcmp(KbName(keyCode),'d')
                key = 2;
            elseif strcmp(KbName(keyCode),'q')
                Screen('CloseAll')
                return
            end
            rt = respTime - t;
            % Show confirmation of choice
            Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectL,p.stim.pen_width);
            Screen('FrameOval',p.frame.ptr,p.white,p.stim.rectR,p.stim.pen_width);
            Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossL');
            Screen('FillRect', p.frame.ptr,p.white, p.stim.FixCrossR');
            DrawFormattedText(p.frame.ptr,'Which has more dots ? ', 'center',  p.my+p.stim.diam+50);
            DrawFormattedText(p.frame.ptr,'[Left] ? [Right]', 'center',  p.my+p.stim.diam+100);
            Screen('TextSize',p.frame.ptr,48);
            if key == 1
                DrawFormattedText(p.frame.ptr,'*', p.stim.rectL(3)-p.stim.diam, p.my-p.stim.diam-50);
            else
                DrawFormattedText(p.frame.ptr,'*', p.stim.rectR(1)+p.stim.diam, p.my-p.stim.diam-50);
            end
            Screen('TextSize',p.frame.ptr,24);
            Screen('Flip', p.frame.ptr);
        end
    end
    WaitSecs(p.times.postChoice);
    
    % Fill in results
    results.response(i_trial) = key;
    results.rt(i_trial) = rt;
    results.dots(i_trial).xy = drawnXY;
    
    if conf
        % now collect confidence
        [conf RT] = collectConfidence(p.frame.ptr,p);
        
        results.responseConf(i_trial) = conf;
        results.rtConf(i_trial) = RT;
    end
    
    if (key == 1 && n(1)>n(2)) || (key == 2 && n(1)<n(2))
        % Update staircase according to correctness
        results.correct(i_trial) = 1;
    elseif n(1)==n(2)
        results.correct(i_trial) = round(rand);
    else
        % Update staircase according to correctness
        results.correct(i_trial) = 0;
    end
    
    % Update staircase with unequal stepsizes (following Garcia-Perez 1998)
    x(i_trial+1)=x(i_trial);
    if i_trial>2
        if ~results.correct(i_trial)
            x(i_trial+1)=x(i_trial)+(stepsize.*2);
        elseif results.correct(i_trial)==1 && results.correct(i_trial-1)==1
            x(i_trial+1)=x(i_trial)-stepsize;
        end
        if results.correct(i_trial) ~=  results.correct(i_trial-1)
            nreversals=nreversals+1;
            results.i_trial_lastreversal = i_trial;
        end
        
        if adapt
            % Adapt stepsize
            if nreversals == 4
                stepsize = 2;
            elseif nreversals == 8
                stepsize = 1;
            end
        end
    end    
    
    if feedback
        if results.correct(i_trial)
            DrawText(p.frame.ptr,'Correct!', 'c');
        else
            DrawText(p.frame.ptr,'Incorrect', 'c');
        end
        Screen('Flip', p.frame.ptr);
        WaitSecs(p.times.feedback);
    end
    
    %     Screen('Flip', p.frame.ptr);
    %     WaitSecs(p.times.ITI+rand);
    
end
results.contrast = x;