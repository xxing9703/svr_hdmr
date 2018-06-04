function [out1,out2,idx]=redist(D,size1,size2,option)
[s1,s2]=size(D);
if option=='rand'
  idx=randperm(s1);
else
  idx=randperm(s1);
end
idx1=idx(1:size1);
idx2=idx(size1+1:size1+size2);
out1=D(idx1,:);
out2=D(idx2,:);
