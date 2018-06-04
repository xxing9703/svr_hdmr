function [nsv, beta] = p_svr_solver(X,Y,ker,C,e,para)
%SVR solver
%
%  Usage: [nsv beta] =  svr_solver(X,Y,ker,C,e,para,worker)
%
%  Parameters: X,Y      - Training data
%              ker    - kernel name
%              C      - svr parameter(upper bound)
%              e      - svr parameter (error)
%              para   - kernel parameters 
%              nsv    - number of support vectors
%              beta   - Difference of Lagrange Multipliers  
if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end

    n = size(X,1);
    epsilon = C*1e-6;
    e=e*std(Y);
    % Construct the Kernel matrix
  fprintf('--------------\n');
  fprintf('SVM_kernel\n');
   tic
    H = zeros(n,n); 
    cc.para=para;
    cc.s2=size(X,2);
    cc=sub_kernel_prep(ker,cc);
    parfor (i=1:n,worker)
       for j=1:n
          [k,kbase] = sub_kernel(ker,X(i,:),X(j,:),cc);
          H(i,j)=k;
       end
    end
    toc

    % Set up the parameters for the Optimisation problem   
        Hb = [H -H; -H H];
        c = [(e*ones(n,1) - Y); (e*ones(n,1) + Y)];  
        vlb = zeros(2*n,1);    % Set the bounds: alphas >= 0
        vub = C*ones(2*n,1);   %                 alphas <= C
        x0 = zeros(2*n,1);     % The starting point is [0 0 0   0]
        A = []; b = []; 
  
  % Add small amount of zero order regularisation to 
   Hb = Hb+1e-10*eye(size(Hb));
      %quadratic programing start-------------
    options = optimoptions('quadprog','Display','off');
    alpha = quadprog(Hb,c,A,b,[],[],vlb,vub,x0,options);
    %quadratic programing end-------------
    
    beta =  alpha(1:n) - alpha(n+1:2*n);
      
   % fprintf('|w0|^2    : %f\n',beta'*H*beta);  
   % fprintf('Sum beta : %f\n',sum(beta));
    % Compute the number of Support Vectors
    svi = find( abs(beta) > epsilon );
    nsv = length( svi );
    fprintf('Support Vectors : %d (%3.1f%%)\n',nsv,100*nsv/n);

 
