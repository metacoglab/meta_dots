KbName('UnifyKeyNames');


% To validate, SS press
% Esc = 27(41) or SPACE = 32(44) or RETURN = 13(40)
OkKey = [44 40 5];
EscKey = 41;



if keyCode(82)
        c=min(c+inc,nlevels);
    elseif keyCode(81)
        c=max(c-inc,0);