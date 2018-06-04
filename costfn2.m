function var=costfn2(x,handles)

para=get(handles.uitable1,'data');
para(:,3)=(x+1)/2;
set(handles.uitable1,'data',para);
drawnow;
s2=size(handles.h.DM,2);

output=svroutput(handles.h.DM(:,1:s2-1),x,handles.h.ker,handles.h.para,handles.h.beta)+handles.h.y0; %prediction
var=eval(get(handles.edit_fitness,'string'));
set(handles.text_out,'String',num2str(var));
drawnow;
m=get(handles.radiobutton_min,'value');
if m==0
    var=-var;
end

end

