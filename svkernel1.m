function k = svkernel1(varargin)
%SVKERNEL kernel for Support Vector Methods
%
%  Usage: k = svkernel(ker,u,v,subk)
%
%  Parameters: ker - kernel type
%              u,v - kernel arguments
%              subk - kernel subset for sensitivity analysis (optional)
%     
%
%  Values for ker: 'linear'  -
%                  'poly'    - p(1) is degree of polynomial
%                  'rbf'     - p(1) is width of rbfs (sigma)
%                  'sigmoid' - p(1) is scale, p(2) is offset
%                  'spline'  -
%                  'bspline' - p(1) is degree of bspline
%                  'fourier' - p(1) is degree
%                  'erfb'    - p(1) is width of rbfs (sigma)
%                  'anova'   - p(1) is max order of terms
%                  'hdmra'   - p(n) first order para, sig(n) weighting factors              
%                  'hdmrb'   - TBD               
%                             
%
%  Author: Steve Gunn (srg@ecs.soton.ac.uk)

  if (nargin < 1) % check correct number of arguments
     help svkernel
  else
     
    global p;
    global sig;
    ker=varargin{1};
    u=varargin{2};
    v=varargin{3};
    
    
    switch lower(ker)
      case 'linear'
        k = u*v';
      case 'poly'
        k = (u*v' + 1)^p(1);
      case 'rbf'
        k = exp(-(u-v)*(u-v)'/(2*p(1)^2));
      case 'erbf'
        k = exp(-sqrt((u-v)*(u-v)')/(2*p(1)^2));
      case 'sigmoid'
        k = tanh(p(1)*u*v'/length(u) + p(2));
      case 'fourier'
        tp1=((u-v)*2*pi)/p(1);
        htp1=cos(p(2)*tp1).*exp(-tp1.*tp1/2);
        k=prod(htp1);
      case 'spline'
        z = 1 + u.*v + (1/2)*u.*v.*min(u,v) - (1/6)*(min(u,v)).^3;
        k = prod(z);
      case 'bspline'
        z = 0;
        for r = 0: 2*(p(1)+1)
          z = z + (-1)^r*binomial(2*(p(1)+1),r)*(max(0,u-v + p(1)+1 - r)).^(2*p(1) + 1);
        end
        k = prod(z);
      case 'anovaspline1'
        z = 1 + u.*v + u.*v.*min(u,v) - ((u+v)/2).*(min(u,v)).^2 + (1/3)*(min(u,v)).^3;
        k = prod(z); 
      case 'anovaspline2'
        z = 1 + u.*v + (u.*v).^2 + (u.*v).^2.*min(u,v) - u.*v.*(u+v).*(min(u,v)).^2 + (1/3)*(u.^2 + 4*u.*v + v.^2).*(min(u,v)).^3 - (1/2)*(u+v).*(min(u,v)).^4 + (1/5)*(min(u,v)).^5;
        k = prod(z);
      case 'anovaspline3'
        z = 1 + u.*v + (u.*v).^2 + (u.*v).^3 + (u.*v).^3.*min(u,v) - (3/2)*(u.*v).^2.*(u+v).*(min(u,v)).^2 + u.*v.*(u.^2 + 3*u.*v + v.^2).*(min(u,v)).^3 - (1/4)*(u.^3 + 9*u.^2.*v + 9*u.*v.^2 + v.^3).*(min(u,v)).^4 + (3/5)*(u.^2 + 3*u.*v + v.^2).*(min(u,v)).^5 - (1/2)*(u+v).*(min(u,v)).^6 + (1/7)*(min(u,v)).^7;
        k = prod(z);
      case 'anovabspline'
        z = 0;
        for r = 0: 2*(p(1)+1)
          z = z + (-1)^r*binomial(2*(p(1)+1),r)*(max(0,u-v + p(1)+1 - r)).^(2*p(1) + 1);
        end
        k = prod(1 + z);

      case 'hdmrb'
        [num_rows_s, n] = size(u);
        [num_rows_t, m] = size(v);

        kbase(1)=exp(-(u(1)-v(1))^2/(2*p(1)^2));
        kbase(2)=exp(-(u(2)-v(2))^2/(2*p(2)^2));
        kbase(3)=exp(-(u(3)-v(3))^2/(2*p(3)^2));
        
        % kp(1)=kbase*sig';
        %kp(2)=[kbase(1)*kbase(2),kbase(1)*kbase(3),kbase(2)*kbase(3)]*[p(5); p(6); p(7)];
        %kp(3)=kbase(1)*kbase(2)*kbase(3)*p(8);
        
        kp(1)=sum(kbase);
        kp(2)=kbase(1)*kbase(2)+kbase(1)*kbase(3)+kbase(2)*kbase(3);
        kp(3)=kbase(1)*kbase(2)*kbase(3);
        
        k=sum(kp);
        
      %---------------------------  
      case 'hdmra' 
        [s1,num] = size(u)
        pp=10.^p
        for i=1:num  
            
          %  kbase(i)=exp(-(u(i)-v(i))^2/(2*p(i)^2));
            kbase(i)=exp(-(u(i)-v(i))^2/(2*pp(i)^2))-(erf((1+u(i))/sqrt(2)/pp(i))+erf((1-u(i))/sqrt(2)/pp(i)))*(erf((1+v(i))/sqrt(2)/pp(i))+erf((1-v(i))/sqrt(2)/pp(i)))/(4*sqrt(2/pi)*erf(sqrt(2)/pp(i))/pp(i)+(4/pi)*(exp(-2/pp(i)/pp(i))-1));
        end
        for i=1:num  
             s(i)= sum(kbase.^i);
        end
        e(1)=sum(kbase);
            for n=2:num
                 tp=0;
                 for k=1:n  
                      if(n==k)
                         tp(k)=(-1)^(k-1)*s(k);
                      else
                         tp(k)=(-1)^(k-1)*e(n-k)*s(k);
                      end
                 end
                 e(n)=sum(tp)/n;
            end
         k=sum(e.*sig);
      %---------------------------subKernel request only when there's 4th input varargin{4}=[i,j] 
      if (nargin == 4)
          index= varargin{4};
          
          if (index(1)==index(2))
                 k=kbase(index(1))*sig(1);
          elseif (index(1)<index(2))
                 k=kbase(index(1))*kbase(index(2))*sig(2);
          else
              k=e(index(1))*sig(index(1));
          end
          
      
      
      
      
      end
      
            
        
        
        
        
        
        
        
        
        
      otherwise
        k = u*v';
    end

  end


