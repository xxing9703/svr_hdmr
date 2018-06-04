function [D1,D2,D3]=divide(varargin)
%this function normlize a column vector or multiple from range [min,max] to range [ub,lb]
if (nargin==3) 
    D=varargin{1};
    num1=varargin{2};
    num2=varargin{3};
    [s1,s2]=size(D);
    
    idx=randperm(s1);
   if (num1+num2<=s1)
    idx1=idx(1:num1);
    idx2=idx(num1+1:num1+num2);
    D1=D(idx1,:);
    D2=D(idx2,:);
     if  num1+num2<s1
         idx3=idx(num1+num2+1:s1);
         D3=D(idx3,:);
     else
         idx3=0;
         D3=[];    
     end 
   else
     msgbox('overflow error!');
   end
elseif (nargin==2)
    D=varargin{1};
    option=varargin{2};
    switch (option)
        case 'manual',
        D1=1;
        D2=1;
        D3=1;
        
        case 'auto',
          [D1,D2,D3]=divide_auto(gcf,D);
        
    end
else
    help divide;  
    return   
end
    