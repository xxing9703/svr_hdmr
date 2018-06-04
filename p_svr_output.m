function varargout = p_svr_output(trnX,tstX,ker,para,beta)
%SVR output
%Usage: y = p_svr_output(trnX,tstX,ker,para,beta)
%  or [y,y1] = p_svr_output(trnX,tstX,ker,para,beta)
%  or [y,y1,y2] = p_svr_output(trnX,,tstX,ker,para,beta)
tic
if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end

    s2=size(trnX,2);
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
    

    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,n); 
%-------kernel calculations
    cc.para=para;
    cc.s2=size(trnX,2);
    cc=sub_kernel_prep(ker,cc);  
Hbase=zeros(m,n,cc.s2); 
 parfor (i=1:m,worker)
      for j=1:n          
            [k,kbase] =sub_kernel(ker,tstX(i,:),trnX(j,:),cc);
            H(i,j)=k;
            Hbase(i,j,:)=kbase;
       end
 end
  
%-------------------------------
Y= H*beta;
varargout{1}=Y;

switch nargout
 case 1
       
 case 2   
  for i=1:s2
   Y1(:,i)=Hbase(:,:,i)*sig(1)*beta;
  end
 varargout{2}=Y1; 
 

 case 3 
  for i=1:s2
   Y1(:,i)=Hbase(:,:,i)*sig(1)*beta;
  end
 varargout{2}=Y1;
 
   count=1;
  for i=1:(s2-1)
   for j=(i+1):s2
    Y2(:,count)=(Hbase(:,:,i).*Hbase(:,:,j))*sig(2)*beta;
    count=count+1;
   end
  end
  varargout{3}=Y2;

end  
toc


