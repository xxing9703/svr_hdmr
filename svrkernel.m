function k = svrkernel(varargin)
%hdmrkernel for SVR
%  Usage: k = kernel(ker,u,v,para,subk)
%
%  Parameters: ker - kernel type
%              u,v - Xi, Xj, 
%              para - svr parameters (Cval, Loss, p, s...)                             
    ker=varargin{1};
    u=varargin{2};
    v=varargin{3};
    para=varargin{4};
    [s1,s2]=size(u);
    sp=length(para);
    para=para(3:sp);
    kbase=zeros(s2,1)';
    kbase1=zeros(s2,1)';
    kbase2=zeros(s2,1)';
    
    switch lower(ker) 
case {'hdmra_poly','additive_poly'}
        p=para(1:s2);
        sig=para(s2+1:sp-2);
        order=length(sig);
        p=round(p);
        deconst=zeros(s2,1);

        for i=1:s2
           for j=1:round((p(i)+1)/2) %deconst
             nck(i,j)=prod(1:p(i)+1)/prod(1:2*j-1)/prod(1:p(i)+1-2*j+1);
             deconst(i)=deconst(i)+(p(i)+1)*nck(i,j)/(2*j-1);
           end
           kbase1(i)=0;  %kbase1
           for j=1:round((p(i)+1)/2)
             kbase1(i)=kbase1(i)+nck(i,j)*u(i)^(2*(j-1));
           end
           kbase2(i)=0;  %kabse2
           for j=1:round((p(i)+1)/2)
             kbase2(i)=kbase2(i)+nck(i,j)*v(i)^(2*(j-1));
           end
           kbase(i)=(u(i)*v(i)+1)^p(i)-kbase1(i)*kbase2(i)/deconst(i);
           if strcmp(ker, 'additive_poly')
               kbase(i)=(u(i)*v(i)+1)^p(i);
           end
        end
       
        for i=1:order
          s(i)= sum(kbase.^i);
        end
        
        e(1)=sum(kbase);
        for n=2:order
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
        k=sum(e.*sig');
           
case {'hdmra_rbf','hdmra_exp','additive_rbf','additive_exp'}
        p=para(1:s2);
        sig=para(s2+1:sp-2);
        order=length(sig);
        pp=10.^p;
       
        for i=1:s2             
           if strcmp(ker, 'hdmra_rbf')
            kbase(i)=exp(-(u(i)-v(i))^2/(2*pp(i)^2))-(erf((1+u(i))/sqrt(2)/pp(i))+erf((1-u(i))/sqrt(2)/pp(i)))*(erf((1+v(i))/sqrt(2)/pp(i))+erf((1-v(i))/sqrt(2)/pp(i)))/(4*sqrt(2/pi)*erf(sqrt(2)/pp(i))/pp(i)+(4/pi)*(exp(-2/pp(i)/pp(i))-1));
           elseif strcmp(ker, 'hdmra_exp')
            kbase(i)=exp(-(abs(u(i)-v(i))/(2*pp(i)^2)))-(2-exp(-(1+u(i))/(2*pp(i)^2))-exp(-(1-u(i))/(2*pp(i)^2)))*(2-exp(-(1+v(i))/(2*pp(i)^2))-exp(-(1-v(i))/(2*pp(i)^2)))/(2*(1/pp(i)^2-1+exp(-1/pp(i)^2)));
           elseif strcmp(ker, 'additive_rbf')
            kbase(i)=exp(-(u(i)-v(i))^2/(2*pp(i)^2));
           else 
            kbase(i)=exp(-(abs(u(i)-v(i))/(2*pp(i)^2)));
           end
        end
            e(1)=sum(kbase);
            
        for i=1:order
             s(i)= sum(kbase.^i); %s(i) is used to construct higher order terms
        end
             for n=2:order
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
             
         k=sum(e.*sig');
             %end of hdmr_rbf
case 'hdmra_fourier'
        sig=para(1:sp-2);
        order=length(sig);
             for i=1:s2
                % u(i)=(u(i)+1)*pi;
                % v(i)=(v(i)+1)*pi;
       %           kbase1=[cos(u(i)) sin(u(i)) cos(2*u(i)) sin(2*u(i))];
       %           kbase2=[cos(v(i)) sin(v(i)) cos(2*v(i)) sin(2*v(i))];
                kbase1=[cos(u(i)) sin(u(i)) cos(2*u(i)) sin(2*u(i)) cos(-u(i)) sin(-u(i)) cos(-2*u(i)) sin(-2*u(i))];
                kbase2=[cos(v(i)) sin(v(i)) cos(2*v(i)) sin(2*v(i)) cos(-v(i)) sin(-v(i)) cos(-2*v(i)) sin(-2*v(i))];
   
                 kbase(i)=kbase1*kbase2';
              end
                 for i=1:s2
                    s(i)= sum(kbase.^i);
                 end
                    e(1)=sum(kbase);
                    
                 for n=2:order
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
                 k=sum(e.*sig');
         
    otherwise
        k = u*v';
    end           
             
 %--------------------------------------------------------------------
   if (nargin == 5)
            s2= varargin{5};
            k=zeros(s2);
            for i=1:s2
                for j=1:s2
                   if (i==j)
                     k(i,j)=kbase(i)*sig(1);  % 1st order
                   elseif (i<j)
                     k(i,j)=kbase(i)*kbase(j)*sig(2); %2nd order
                   elseif (i==j+1)
                        if i<=order   
                        k(i,j)=e(i)*sig(i);  % sum of a given order
                       end
                   end
                end
            end                                       
   end
            

 

