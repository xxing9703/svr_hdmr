
function [k,kbase]=sub_kernel(ker,u,v,cc)

%hdmrkernel for SVR
%  Usage: k = svm_kernel(ker,u,v,para)
%      or [k,kbase]=svm_kernel(ker,u,v,para)
%      
%  Parameters: ker - kernel type
%              u,v - Xi, Xj, 
%              para - svr parameters (p1,p2,...sig1,sig2...)     
%  Output: k - kernel scaler value
%          k - HDMR kernel vector

   s2=cc.s2;
   para=cc.para;
   
    n=length(para);
    p1=para(1);   %first para is p1
     if n>1 
          p2=para(2);  %second para is p2
     end
   
    if n>s2   
     p=para(1:s2);  %p1 to pn
     sig=para(s2+1:end);  %sig1 to sign
     order=length(sig);  %orders
    end
    
switch lower(ker) 
   case {'hdmra_poly','additive_poly'}
        p=round(p);  %integer p
        %deconst=zeros(s2,1);
        kbase=zeros(s2,1)';
        kbase1=zeros(s2,1)';
        kbase2=zeros(s2,1)';
    
       if strcmp(ker, 'hdmra_poly')    
        nck=cc.nck;
        deconst=cc.deconst;
        
        for i=1:s2
            kbase1(i)=0;  %kbase1
           for j=1:round((p(i)+1)/2)
            kbase1(i)=kbase1(i)+nck(i,j)*u(i)^(2*(j-1));
           end   
           kbase2(i)=0;  %kabse2
           for j=1:round((p(i)+1)/2)
             kbase2(i)=kbase2(i)+nck(i,j)*v(i)^(2*(j-1));
           end
          kbase(i)=(u(i)*v(i)+1)^p(i)-kbase1(i)*kbase2(i)/deconst(i);  %hdmra_poly
        end
      else %strcmp(ker, 'additive_poly')
          for i=1:s2
           kbase(i)=(u(i)*v(i)+1)^p(i);%additive_poly
          end
        
      end
         e=hdmrker(kbase,order);%higher orders
         k=sum(e.*sig');  % final kernel, sum over all orders weighted by sig
        
   case {'hdmra_rbf','hdmra_exp','additive_rbf','additive_exp'}
      
       pp=10.^p; %log10 scale, pp>0, but p can be[-n n]
      %{  
       kbase=zeros(s2,1)';
         for i=1:s2             
           if strcmp(ker, 'hdmra_rbf')
            kbase(i)=exp(-(u(i)-v(i))^2/(2*pp(i)^2))-(erf((1+u(i))/sqrt(2)/pp(i))+erf((1-u(i))/sqrt(2)/pp(i)))*(erf((1+v(i))/sqrt(2)/pp(i))+erf((1-v(i))/sqrt(2)/pp(i)))/(4*sqrt(2/pi)*erf(sqrt(2)/pp(i))/pp(i)+(4/pi)*(exp(-2/pp(i)/pp(i))-1));
           elseif strcmp(ker, 'hdmra_exp')
            kbase(i)=exp(-(abs(u(i)-v(i))/(2*pp(i)^2)))-(2-exp(-(1+u(i))/(2*pp(i)^2))-exp(-(1-u(i))/(2*pp(i)^2)))*(2-exp(-(1+v(i))/(2*pp(i)^2))-exp(-(1-v(i))/(2*pp(i)^2)))/(2*(1/pp(i)^2-1+exp(-1/pp(i)^2)));
           elseif strcmp(ker, 'additive_rbf')
            kbase(i)=exp(-(u(i)-v(i))^2/(2*pp(i)^2));
           else  %ker='additive_exp'
            kbase(i)=exp(-(abs(u(i)-v(i))/(2*pp(i)^2)));
           end
        end
      %}
     if strcmp(ker, 'hdmra_rbf')   
       kbase=exp(-(u-v).^2./(2*pp'.^2))-(erf((1+u)/sqrt(2)./pp')+erf((1-u)/sqrt(2)./pp')).*(erf((1+v)/sqrt(2)./pp')+erf((1-v)/sqrt(2)./pp'))./(4*sqrt(2/pi)*erf(sqrt(2)./pp')./pp'+(4/pi)*(exp(-2./pp'./pp')-1));
     elseif strcmp(ker, 'hdmra_exp')
       kbase=exp(-(abs(u-v)./(2*pp'.^2)))-(2-exp(-(1+u)./(2*pp'.^2))-exp(-(1-u)./(2*pp'.^2))).*(2-exp(-(1+v)./(2*pp'.^2))-exp(-(1-v)./(2*pp'.^2)))./(2*(1./pp'.^2-1+exp(-1./pp'.^2)));
     elseif strcmp(ker, 'additive_rbf') 
       kbase=exp(-(u-v).^2./(2*pp'.^2));
     else  %ker='additive_exp'
       kbase=exp(-(abs(u-v)./(2*pp'.^2)));
     end
       
     e=hdmrker(kbase,order);%higher orders
        
     k=sum(e.*sig');  % final kernel, sum over all orders weighted by sig
         
  case 'hdmra_fourier'
     sig=para(1:end);
     order=length(sig);
       kbase=zeros(s2,1)';
          for i=1:s2
                kbase1=[cos(u(i)) sin(u(i)) cos(2*u(i)) sin(2*u(i)) cos(-u(i)) sin(-u(i)) cos(-2*u(i)) sin(-2*u(i))];
                kbase2=[cos(v(i)) sin(v(i)) cos(2*v(i)) sin(2*v(i)) cos(-v(i)) sin(-v(i)) cos(-2*v(i)) sin(-2*v(i))];
                kbase(i)=kbase1*kbase2';
          end
    
          e=hdmrker(kbase,order);%higher orders
          k=sum(e.*sig');  % final kernel, sum over all orders weighted by sig
     
   %non HDMR or additive kernels
     case 'linear'
        k = u*v';
      case 'poly'
        k = (u*v' + 1)^p1;
      case 'rbf'
        k = exp(-(u-v)*(u-v)'/(2*p1^2));
      case 'erbf'
        k = exp(-sqrt((u-v)*(u-v)')/(2*p1^2));
      case 'sigmoid'
        k = tanh(p1*u*v'/length(u) + p2);
      case 'fourier'
        z = sin(p1 + 1/2)*2*ones(length(u),1);
        i = find(u-v);
        z(i) = sin(p1 + 1/2)*(u(i)-v(i))./sin((u(i)-v(i))/2);
        k = prod(z);
      case 'spline'
        z = 1 + u.*v + (1/2)*u.*v.*min(u,v) - (1/6)*(min(u,v)).^3;
        k = prod(z);
      case 'bspline'
        z = 0;
        for r = 0: 2*(p1+1)
          z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,u-v + p1+1 - r)).^(2*p1 + 1);
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
        for r = 0: 2*(p1+1)
          z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,u-v + p1+1 - r)).^(2*p1 + 1);
        end
        k = prod(1 + z);
    otherwise
     k = u*v';
end   
   varargout{1}=k;           %kernel output
 %--------------------------------------------------------------------
 if(nargout==2)     
    varargout{2}=kbase;
 end
  
end
 

 
 
 


 
%sub function used to calculate higher order>1 hdmr kernel (hdmr or additive kernel only)
 function e=hdmrker(kbase,order)
 e=zeros(1,order); 
 s=zeros(1,order);
    e(1)=sum(kbase);  %sum of 1st order kernels
    if order>1
      e(2)=0.5*(e(1)^2-sum(kbase.^2));
    end
         if order>2  %higher orders
            for i=1:order
                s(i)= sum(kbase.^i);
            end
                for n=2:order
                   tp=zeros(order,1);
                   for k=1:n-1
                     tp(k)=(-1)^(k-1)*e(n-k)*s(k);
                   end
                     tp(n)=(-1)^(n-1)*s(n);
                   e(n)=sum(tp)/n;  %sum of nth order kernels
                end
         end  
 end
   
      
                              
      




