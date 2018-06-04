function varargout =p_svr_sa(M)
%SVR-HDMR sensitivity analysis, for additive only!
%Usage: [tb1] = p_svr_sa(M)
%   or: [tb1,tb2] = p_svr_sa(M)


%Parameters:
%   M:model file {ker,y0,DM,pred,para,beta,colname}
%   tb1,tb2,tball: tables
%   Ym: decomposed output
%---------------load model

ker=M.ker;
DM=M.DM;
y0=M.y0;
y=M.y;
Y1=M.y1;
Y2=M.y2;
trnX=DM(:,1:end-1);
trnY=DM(:,end);
%SVC predY=M.pred;
beta=M.beta;
p=M.para;
para=p(3:end);%C=p(1), e=p(2),kernal parameters start from p(3)
[s1,s2]=size(DM);s2=s2-1;

   %  [y,Y1,Y2]=p_svr_output(trnX,trnX,ker,para,beta); 

      n=size(Y1,2);
      S=zeros(1,n);Sa=zeros(1,n);
      for i=1:n
        S(i)=mean((trnY-y0).*Y1(:,i))/mean((trnY-y0).*(trnY-y0));
        Sa(i)=mean(Y1(:,i).*Y1(:,i))/mean((trnY-y0).*(trnY-y0));
      end
        Sb=S-Sa;
        
        idx=1:n;
        tb1=[idx',Sa',Sb',S'];
        [~,ind]=sort(-abs(tb1(:,2)));
        tb1=tb1(ind,:);
        varargout{1}=tb1;
sum1_Sa=sum(Sa);
sum1_Sb=sum(Sb);
sum1_S=sum(S);

 if nargout>1      
         n=size(Y2,2);
                S=zeros(1,n);Sa=zeros(1,n);
              for i=1:n
                S(i)=mean((trnY-y0).*Y2(:,i))/mean((trnY-y0).*(trnY-y0));
                Sa(i)=mean(Y2(:,i).*Y2(:,i))/mean((trnY-y0).*(trnY-y0));
              end
                Sb=S-Sa;
                k=1;
                for i=1:s2-1
                   for j=(i+1):s2
                    tb2(k,:)=[i,j,Sa(k),Sb(k),S(k)];
                    k=k+1;
                   end
                end
                 [~,ind]=sort(-abs(tb2(:,3)));
                tb2=tb2(ind,:);
                varargout{2}=tb2;
                
sum2_Sa=sum(Sa);
sum2_Sb=sum(Sb);
sum2_S=sum(S);
 end
   if nargout>2
        n=size(y,2);
      S=zeros(1,n);Sa=zeros(1,n);
      for i=1:n
        S(i)=mean((trnY-y0).*y(:,i))/mean((trnY-y0).*(trnY-y0));
        Sa(i)=mean(y(:,i).*y(:,i))/mean((trnY-y0).*(trnY-y0));
      end
        Sb=S-Sa;
        idx=1:n;
        %tball=[idx',Sa',Sb',S'];
        %total=[0,sum(Sa),sum(Sb),sum(S)];
        %tball=[tball;total];
       tball=[1,sum1_Sa,sum1_Sb,sum1_S;2,sum2_Sa,sum2_Sb,sum2_S;0,0,0,S];
       varargout{3}=tball;
   end

