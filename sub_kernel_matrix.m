function varargout=sub_kernel_matrix(ker,u,v,cc)
fprintf('%%SVM kernel--');
tic
if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end    

m=size(u,1);
n=size(v,1);
H=zeros(m,n);
cc=sub_kernel_prep(ker,cc);

if(nargout==1)
     parfor (i=1:m,worker)
      for j=1:n          
            k =sub_kernel(ker,u(i,:),v(j,:),cc);
            H(i,j)=k;
            
      end
     end
   
 varargout{1}=H;
else
   
 Hbase=zeros(m,n,cc.s2);   
 parfor (i=1:m,worker)
      for j=1:n          
            [k,kbase] =sub_kernel(ker,u(i,:),v(j,:),cc);
            H(i,j)=k;
            Hbase(i,j,:)=kbase;
       end
 end
   
varargout{1}=H;
varargout{2}=Hbase;
end
toc


    
