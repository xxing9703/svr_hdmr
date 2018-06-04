function cc=sub_kernel_prep(ker,cc)
    s2=cc.s2;
    para=cc.para;
    p=para(1:s2);  %p1 to pn
    p=round(p);
if strcmp(ker, 'hdmra_poly')  
      deconst=zeros(s2,1); 
      for i=1:s2
           for j=1:round((p(i)+1)/2) %deconst
             nck(i,j)=prod(1:p(i)+1)/prod(1:2*j-1)/prod(1:p(i)+1-2*j+1);
             deconst(i)=deconst(i)+(p(i)+1)*nck(i,j)/(2*j-1);
           end
       end
       cc.nck=nck;
       cc.deconst=deconst;
else
end


