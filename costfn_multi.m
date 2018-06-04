function y=costfn_multi(x,handles)

para=get(handles.uitable1,'data');
para(:,3)=(x+1)/2;  % calculate the current input variables from x (-1,1) input and comvert to (0-1)
set(handles.uitable1,'data',para);
drawnow;
s2=size(handles.h.DM,2);

output=svroutput(handles.h.DM(:,1:s2-1),x,handles.h.ker,handles.h.para,handles.h.beta)+handles.h.y0; %prediction

y(1)=output;
set(handles.text_out,'String',num2str(y));
drawnow;
m=get(handles.radiobutton_min,'value');
if m==0
    y(1)=-y(1);
end
y(2)=-sum((x(1:4)+1)/2);
y(3)=sum((x(5:7)+1)/2);
end

