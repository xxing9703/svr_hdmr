function output=dnorm(varargin)
%this function normlize a column vector or multiple from range [min,max] to range [ub,lb]
% Xn=dnorm(X,min,max,lb,ub) or Xn=dnorm(X,lb,ub)
if (nargin==3) 
    X=varargin{1};
    lb=varargin{2};ub=varargin{3};
    vmin=min(X); vmax=max(X);
  
elseif (nargin==5)
    X=varargin{1};
    lb=varargin{4};ub=varargin{5};
    vmin=varargin{2};vmax=varargin{3};
else
    help dnorm;  
    return
end

[s1,s2]=size(X);
 b=(ub*vmin-lb*vmax)/(vmax-vmin);
 a=(ub-lb)/(vmax-vmin);
 output=a*X-b;

