function [YMD1,YMD2,YMD3,beta]=runonce(handles,option)
[s1,s2]=size(handles.D1);
 % start svr---------------------------------------------------
     set(handles.text_status,'string','SVR optimization...'); %status
     set(handles.text_status,'BackgroundColor','red'); %status
     drawnow;
  ker=handles.ker;
  paradata=get(handles.uitable1,'data');
  para=paradata(:,3);
  
XXD1=handles.D1(:,1:s2-1);
XXD2=handles.D2(:,1:s2-1);
XXD3=handles.D3(:,1:s2-1);
XXDM=handles.DM(:,1:s2-1);
YD1=handles.D1(:,s2);
YDM=handles.DM(:,s2);

[nsv, beta]=p_svr_solver(XXDM,YDM-handles.y0,ker,para(1),para(2),para(3:end));


if option(1)==1
  set(handles.text_status,'string','Training...'); %status
  set(handles.text_status,'BackgroundColor','green'); %status
  drawnow;
 y=p_svr_output(XXDM,XXD1,ker,para(3:end),beta);  % predict Y of train data  
 YMD1=y+handles.y0;
else
    YMD1=0;
end
if option(2)==1
  set(handles.text_status,'string','Validating...'); %status
  set(handles.text_status,'BackgroundColor','yellow'); %status
  drawnow;
 YMD2=p_svr_output(XXDM,XXD2,ker,para(3:end),beta)+handles.y0;  % predict Y of validating data
else
    YMD2=0;
end
if option(3)==1
  set(handles.text_status,'string','Testing...'); 
  set(handles.text_status,'BackgroundColor',[0.6,0.6,1]); %status
  drawnow;
YMD3=p_svr_output(XXDM,XXD3,ker,para(3:end),beta)+handles.y0;  % predict Y of testing data
else
    YMD3=0;
end
set(handles.text_tr,'string',strcat('Train:  ',num2str(size(handles.D1,1))));
set(handles.text_va,'string',strcat('Valid:  ',num2str(size(handles.D2,1))));


