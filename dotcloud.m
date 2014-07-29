function [xy,ra,j,r] = dotcloud(n,s,retry)
% dotcloud - Generate X & Y positions of randomly distributed dots in a
%
%    [xy,ra] = dotcloud(n) generates n dots. xy are the xy euclidian
%    positions, and ra are the polar (radius,angle) ones
%
%     [xy,ra,j,r] = dotcloud(n,s[,retry]) generates n dots of radius s, trying to
%       avoid overlaps, retrying the number of specified times (default:
%       retry=100)
%       j = logical indices of overlapping dots
%       r = number of retries performed
%

% Initialize random seed
rand('state',sum(100*clock));

if nargin<2
    s=0;
end
if any(abs(s)>1)
    error('Size of dots cannot be bigger than 1')
end
if numel(s)==1
    s=repmat(s,[n,1]);
else
    s=s(:);
end
ra=[sqrt(rand(n,1)).*(1-s) 2*pi*rand(n,1)];
xy=[cos(ra(:,2)) sin(ra(:,2))].*(ra(:,1)*[1 1]);
if all(s==0) || n < 2
    return
end
if nargin<3
    retry=100;
end
r=0;
nj=Inf;%sum(j);
[sa,sb]=ndgrid(s,s);
% Distance between dots
d2=sum((repmat(cat(3,xy(:,1),xy(:,2)),1,n)-repmat(cat(3,xy(:,1)',xy(:,2)'),n,1)).^2,3);
while r<retry && nj>0
    d2(d2==0)=Inf;
    r=r+1;
    j = min(sqrt(d2)-sa-sb,[],2) < 0;
    nj=sum(j);
    ra(j,:)=[sqrt(rand(nj,1)).*(1-s(j)) 2*pi*rand(nj,1)];
    xy(j,:)=[cos(ra(j,2)) sin(ra(j,2))].*(ra(j,1)*[1 1]);
    % Distance between dots
    d2=sum((repmat(cat(3,xy(:,1),xy(:,2)),1,n)-repmat(cat(3,xy(:,1)',xy(:,2)'),n,1)).^2,3);    
end
if r==retry & nj>0
    warning('Still some overlap!');
end
return
