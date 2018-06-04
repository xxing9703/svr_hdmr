function [Y Y1 Y2]=sub_output(H,Hbase,beta,cc)
para=cc.para;
s2=cc.s2;
p=para(1:s2);  %p1 to pn
sig=para(s2+1:end);

Y= H*beta;


for i=1:s2
   Y1(:,i)=Hbase(:,:,i)*sig(1)*beta;
end

 
   count=1;
for i=1:(s2-1)
  for j=(i+1):s2
    Y2(:,count)=(Hbase(:,:,i).*Hbase(:,:,j))*sig(2)*beta;
    count=count+1;
  end
end
