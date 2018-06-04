function [nsv, beta] = svrsolver(varargin)
%SVR Support Vector Regression
%
%  Usage: [nsv beta] = svrsolver(X,Y,ker,para)
%
%  Parameters: X,Y      - Training data
%              ker    - kernel name
%              para   - parameters (C, err, p1...)
%              nsv    - number of support vectors
%              beta   - Difference of Lagrange Multipliers
if isempty(gcp('nocreate'))
    worker=0;
else
    a=gcp;
    worker=a.NumWorkers;
end

  if (nargin <4) % check correct number of arguments
    help svrsolver
  else
    X=varargin{1};
    Y=varargin{2};
    ker=varargin{3};
    para=varargin{4};
    
    
    %X=D(:,1:s2-1);
    %Y=D(:,s2);
    C=para(1);
    e=para(2)*std(Y);
   
    fprintf('SVR kernel calculation....\n')
  
    n = size(X,1);
    % tolerance for Support Vector Detection
    epsilon = C*1e-6;
    % Construct the Kernel matrix
    st = cputime;
    H = zeros(n,n); 
    fprintf('--------------\n');
    tic
    parfor (i=1:n,worker)
       for j=1:n
           H(i,j) = svrkernel(ker,X(i,:),X(j,:),para); 
       end
    end
    toc
    %fprintf('kernel time : %4.1f seconds\n',cputime - st);
    % Set up the parameters for the Optimisation problem
        Hb = [H -H; -H H];
        c = [(e*ones(n,1) - Y); (e*ones(n,1) + Y)];  
        vlb = zeros(2*n,1);    % Set the bounds: alphas >= 0
        vub = C*ones(2*n,1);   %                 alphas <= C
        x0 = zeros(2*n,1);     % The starting point is [0 0 0 0]
        A = [];, b = []; 
      % Add small amount of zero order regularisation

   Hb = Hb+1e-10*eye(size(Hb));
    % Solve the Optimisation Problem    
    fprintf('SVR optimising ...\n');
    st = cputime;
    %[alpha lambda how] = qp(Hb, c, A, b, vlb, vub, x0, 0);  % home-made qp in C 
    options = optimoptions('quadprog','Display','off');
    alpha = quadprog(Hb,c,A,b,[],[],vlb,vub,x0,options);
    fprintf('optimization time : %4.1f seconds\n',cputime - st);
    beta =  alpha(1:n) - alpha(n+1:2*n);
   
    % Compute the number of Support Vectors
    svi = find( abs(beta) > epsilon );
    nsv = length( svi );
    %fprintf('Support Vectors : %d (%3.1f%%)\n',nsv,100*nsv/n);
  end

