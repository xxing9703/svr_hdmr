function tstY = svroutput(varargin)
%SVRMSE Calculate SVR Output
%
%  Usage: tstY = svroutput(trnX,tstX,ker,para,beta,[subk])
%
%  Parameters: trnX   - Training inputs
%              tstX   - Test inputs
%              ker    - kernel function
%              para   - parameters
%              beta   - Difference of Lagrange Multipliers
%              [subk] - [index1, index2]


      trnX=varargin{1};
      tstX=varargin{2};
      ker=varargin{3};
      para=varargin{4};
      beta=varargin{5};
      
    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,n); 
    
    if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end
    
    tic
  if (nargin == 5) % check correct number of arguments
     parfor (i=1:m,worker)
      for j=1:n
            H(i,j) = svrkernel(ker,tstX(i,:),trnX(j,:),para);
      end
     end
     tstY= H*beta;
     
  elseif  (nargin == 6)
     s2=varargin{6};
     parfor (i=1:m,worker)
      for j=1:n
         subk = svrkernel(ker,tstX(i,:),trnX(j,:),para,s2);
           for u=1:s2
               for v=1:s2
           H(i,j,u,v)=subk(u,v);
               end
           end
      end
     end

   for u=1:s2
       for v=1:s2
         tstY(:,u,v) = H(:,:,u,v)*beta;
       end
   end
   
  end
 toc
   
