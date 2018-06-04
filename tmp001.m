     tic 
        for i=1:s2
           for j=1:round((p(i)+1)/2) %deconst
             nck(i,j)=prod(1:p(i)+1)/prod(1:2*j-1)/prod(1:p(i)+1-2*j+1);
             deconst(i)=deconst(i)+(p(i)+1)*nck(i,j)/(2*j-1);
           end
        end
     
        for i=1:s2
            kbase1(i)=0;  %kbase1
           for j=1:round((p(i)+1)/2)
             kbase1(i)=kbase1(i)+nck(i,j)*u(i)^(2*(j-1));
           end          
           kbase2(i)=0;  %kabse2
           for j=1:round((p(i)+1)/2)
             kbase2(i)=kbase2(i)+nck(i,j)*v(i)^(2*(j-1));
           end
        end
 toc    