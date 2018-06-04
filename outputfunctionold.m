function Y=outputfunction(Xvector)
%usage: Y=outputfunction([75 12 1.25; 75 9 1])
   hd=load('kate3d.mat');
   b=hd.b;
    XXDM=b.DM(:,1:end-1);%training
    Y=b.DM(:,end);
   
    %normalize to [-1,1]  
     Xvector(:,1)=(Xvector(:,1)-50)/25;
     Xvector(:,2)=(Xvector(:,2)-9)/3;
     Xvector(:,3)=(Xvector(:,3)-1)/0.25;
    %%% 
      para=b.para;  
      ker='additive_poly';
      beta=b.beta;     
      [s1,s2]=size(Xvector);
      sp=length(para);
      para=para(3:end);
    nn = size(XXDM,1);
    mm = size(Xvector,1);
    H = zeros(mm,nn); 
  
     for ii=1:mm
      for jj=1:nn
        p=para(1:s2);
        sig=para(s2+1:sp-2);
        order=length(sig);
        p=round(p);
        deconst=zeros(s2,1);
         u=Xvector(ii,:);
         v=XXDM(jj,:);

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
         
         H(ii,jj)=k; 
      end
     end
     Y=H*beta+b.y0;
     
           
    
    
    
   