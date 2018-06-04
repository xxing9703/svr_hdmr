function varargout =p_svr_sa(M)
%SVR-HDMR sensitivity analysis, for additive only!
%Usage: [tb1] = svr_sa(M)
%   or: [tb1,tball] = svr_sa(M)
%   or: [tb1,tb2,tball] = svr_sa(M)

%Parameters:
%   M:model file {ker,y0,DM,pred,para,beta,colname}
%   tb1,tb2,tball: tables
%   Ym: decomposed output
%---------------load model
ker=M.ker;
DM=M.DM;
y0=M.y0;
trnX=DM(:,1:end-1);
trnY=DM(:,end);
%SVC predY=M.pred;
beta=M.beta;
p=M.para;
para=p(3:end);%C=p(1), e=p(2),kernal parameters start from p(3)
[s1,s2]=size(DM);s2=s2-1;

%SVC trnY=predY; %Use the predicted Y of the modeling data instead.

switch nargout
    case 1
     [y,Y1]=svr_output(trnX,trnX,ker,para,beta);
     %SVC [y,Y1]=svc_output(trnX,predY,trnX,ker,para,beta);
    case 2
     [y,Y1,Yall]=svr_output(trnX,trnX,ker,para,beta); 
     %SVC [y,Y1,Yall]=svc_output(trnX,predY,trnX,ker,para,beta);
    case 3
     [y,Y1,Y2,Yall]=svr_output(trnX,trnX,ker,para,beta);
     %SVC [y,Y1,Y2,Yall]=svc_output(trnX,predY,trnX,ker,para,beta);
end
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

  if nargout>1      
      n=size(Yall,2);
      S=zeros(1,n);Sa=zeros(1,n);
      for i=1:n
        S(i)=mean((trnY-y0).*Yall(:,i))/mean((trnY-y0).*(trnY-y0));
        Sa(i)=mean(Yall(:,i).*Yall(:,i))/mean((trnY-y0).*(trnY-y0));
      end
        Sb=S-Sa;
        idx=1:n;
        tball=[idx',Sa',Sb',S'];
        total=[0,sum(Sa),sum(Sb),sum(S)];
        tball=[tball;total];
        varargout{2}=tball;
          if nargout>2
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
                varargout{3}=tball;
          end
  end

