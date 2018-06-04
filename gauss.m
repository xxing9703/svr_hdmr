data=zeros(500,11);
for i=1:500
    x=rand(1,10)*2-1;
    y=-sum(x.^2);
   data(i,:)=[x,y]; 
end

