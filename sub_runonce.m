function [YMD1,YMD2,YMD3,handles]=sub_runonce(handles,option)
[s1,s2]=size(handles.D1);
 % start svr---------------------------------------------------
    
     
  ker=handles.ker;
  paradata=get(handles.uitable1,'data');
  para=paradata(:,3);
  
XXD1=handles.D1(:,1:s2-1);
XXD2=handles.D2(:,1:s2-1);
XXD3=handles.D3(:,1:s2-1);
XXDM=handles.DM(:,1:s2-1);
YD1=handles.D1(:,s2);
YDM=handles.DM(:,s2);

cc.para=para(3:end);
cc.s2=s2-1;
set(handles.text_status,'string','SVR kernel...'); %status
set(handles.text_status,'BackgroundColor','red'); %status
fprintf('--------------------\n');
drawnow;

if strcmp(ker, 'hdmra_poly') || strcmp(ker, 'hdmra_rbf')|| strcmp(ker, 'hdmra_exp')||strcmp(ker, 'additive_poly') ||strcmp(ker, 'additive_rbf')
[H,Hbase]=sub_kernel_matrix(ker,XXDM,XXDM,cc);
else
 H=sub_kernel_matrix(ker,XXDM,XXDM,cc);   
end
 set(handles.text_status,'string','SVR optimization...'); %status
 set(handles.text_status,'BackgroundColor','red'); %status
 drawnow;

[~,beta]=sub_solver(XXDM,YDM-handles.y0,para(1),para(2),H);
y=H*beta;
handles.beta=beta;

b.beta=beta;
b.para=para;
b.DM=handles.DM;
b.colname=handles.colname;
b.y0=handles.y0;
b.ker=handles.ker;
b.pred=y+handles.y0;
b.y=y;

if strcmp(ker, 'hdmra_poly') || strcmp(ker, 'hdmra_rbf')|| strcmp(ker, 'hdmra_exp')||strcmp(ker, 'additive_poly') ||strcmp(ker, 'additive_rbf')
[~, y1, y2]=sub_output(H,Hbase,beta,cc);
b.y1=y1;
b.y2=y2;
end

handles.b=b;



if option(1)==1
  set(handles.text_status,'string','Training...'); %status
  set(handles.text_status,'BackgroundColor','green'); %status
  drawnow;
  if (size(XXDM,1)==size(XXD1,1))
      YMD1=H*beta+handles.y0;
  else
  YMD1=sub_output_pred(ker,XXDM,XXD1,beta,cc)+handles.y0;  % predict Y of train data  
  end
else
    YMD1=0;
end
if option(2)==1
  set(handles.text_status,'string','Validating...'); %status
  set(handles.text_status,'BackgroundColor','yellow'); %status
  drawnow;
 YMD2=sub_output_pred(ker,XXDM,XXD2,beta,cc)+handles.y0;  % predict Y of validating data
else
    YMD2=0;
end
if option(3)==1
  set(handles.text_status,'string','Testing...'); 
  set(handles.text_status,'BackgroundColor',[0.6,0.6,1]); %status
  drawnow;
YMD3=sub_output_pred(ker,XXDM,XXD3,beta,cc)+handles.y0;  % predict Y of testing data
else
    YMD3=0;
end
set(handles.text_tr,'string',strcat('Train:  ',num2str(size(handles.D1,1))));
set(handles.text_va,'string',strcat('Valid:  ',num2str(size(handles.D2,1))));


