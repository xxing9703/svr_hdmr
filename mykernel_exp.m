function G = mykernel_exp(U,V,para)
size(U)
su=size(U,1);
sv=size(V,1);
s2=size(U,2);
G=zeros(su,sv);
for x=1:su
    for y=1:sv
kbase=zeros(s2,1)';
p=zeros(s2,1);
 pp=10.^p; 
 order=2;
for i=1:s2
    kbase(i)=exp(-(abs(U(i)-V(i))/(2*pp(i)^2)))-(2-exp(-(1+U(i))/(2*pp(i)^2))-exp(-(1-U(i))/(2*pp(i)^2)))*(2-exp(-(1+V(i))/(2*pp(i)^2))-exp(-(1-V(i))/(2*pp(i)^2)))/(2*(1/pp(i)^2-1+exp(-1/pp(i)^2)));
end
e=hdmrker(kbase,order);
G(x,y)=sum(e.*sig');

    end
end


end

function e=hdmrker(kbase,order)
     e(1)=sum(kbase);  %sum of 1st order kernels
           if order>1  %higher orders
            for i=1:order
                s(i)= sum(kbase.^i);
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
                   e(n)=sum(tp)/n;  %sum of nth order kernels
                end
           end  
 end