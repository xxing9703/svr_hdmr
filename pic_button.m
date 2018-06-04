function pic_button(bt,string,rt)
[a,map]=imread(string);
[r,c,d]=size(a); 
x=ceil(r/rt); 
y=ceil(c/rt); 
g=a(1:x:end,1:y:end,:);
%g(g==255)=5.5*255;
set(bt,'CData',g);