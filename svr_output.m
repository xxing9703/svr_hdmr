function varargout = svr_output(trnX,tstX,ker,para,beta)
%SVR output
%Usage: y = svr_output(trnX,tstX,ker,para,beta)
%  or [y,y1] = svr_output(trnX,tstX,ker,para,beta)
%  or [y,y1,yall] = svr_output(trnX,,tstX,ker,para,beta)
%  or [y,y1,y2,yall] = svr_output(trnX,tstX,ker,para,beta)
if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end
tic
    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,n); 
 
switch nargout
 case 1
     parfor (i=1:m,worker)
      for j=1:n          
              k = svm_kernel(ker,tstX(i,:),trnX(j,:),para);
              H(i,j)=k;
       end
     end
     Y= H*beta;
     varargout{1}=Y;
    
  case 2   
     parfor (i=1:m,worker)
        for j=1:n          
            [k,k1] = svm_kernel(ker,tstX(i,:),trnX(j,:),para);
            H(i,j)=k;
            H1(i,j,:)=k1;
        end
     end
     Y= H*beta;
     varargout{1}=Y;
     
     for i=1:size(H1,3)
        Y1(:,i)= H1(:,:,i)*beta;
     end
       varargout{2}=Y1;
       
  case 3   
     parfor (i=1:m,worker)
      for j=1:n          
            [k,k1,kall] = svm_kernel(ker,tstX(i,:),trnX(j,:),para);
            H(i,j)=k;
            H1(i,j,:)=k1;
            Hall(i,j,:)=kall;
       end
     end
     Y= H*beta;
     varargout{1}=Y;
     for i=1:size(H1,3)
        Y1(:,i)= H1(:,:,i)*beta;
     end
       varargout{2}=Y1;
     for i=1:size(Hall,3)
        Yall(:,i)= Hall(:,:,i)*beta;
     end
       varargout{3}=Yall;
       
  case 4   
     parfor (i=1:m,worker)
      for j=1:n          
            [k,k1,k2,kall] = svm_kernel(ker,tstX(i,:),trnX(j,:),para);
            H(i,j)=k;
            H1(i,j,:)=k1;
            H2(i,j,:)=k2;
            Hall(i,j,:)=kall;
       end
     end
     Y= H*beta;
     varargout{1}=Y;
     for i=1:size(H1,3)
        Y1(:,i)= H1(:,:,i)*beta;
     end
       varargout{2}=Y1;
     for i=1:size(H2,3)
        Y2(:,i)= H2(:,:,i)*beta;
     end
       varargout{3}=Y2;
     for i=1:size(Hall,3)
        Yall(:,i)= Hall(:,:,i)*beta;
     end
       varargout{4}=Yall;
end      
  toc

