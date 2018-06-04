function varargout = gui_sens(varargin)
% GUI_SENS MATLAB code for gui_sens.fig
%      GUI_SENS, by itself, creates a new GUI_SENS or raises the existing
%      singleton*.
%
%      H = GUI_SENS returns the handle to a new GUI_SENS or the handle to
%      the existing singleton*.
%
%      GUI_SENS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SENS.M with the given input arguments.
%
%      GUI_SENS('Property','Value',...) creates a new GUI_SENS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_sens_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_sens_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_sens

% Last Modified by GUIDE v2.5 22-Jan-2016 16:34:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_sens_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_sens_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_sens is made visible.
function gui_sens_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_sens (see VARARGIN)

% Choose default command line output for gui_sens
handles.output = hObject;
handles.filename='';
guidata(hObject, handles);
if nargin>3 
 handles.h=varargin{1};
 handles.filename='N/A'; 
 guidata(hObject, handles);
 pushbutton1_Callback(hObject, eventdata, handles)
end






% UIWAIT makes gui_sens wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_sens_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~strcmp(handles.filename,'N/A')
 [filename, pathname] = uigetfile('*.mat','Load the model file');
 M=load(fullfile(pathname, filename));
 handles.h=M.b;
 handles.filename=filename;
 guidata(hObject, handles);
else
 handles.filename='ext'; 
 guidata(hObject, handles);
end

set(handles.text_model,'string',handles.filename);
set(handles.text_status,'string','Ready'); 
drawnow;

set(handles.uitable1, 'columnname', handles.h.colname);
set(handles.uitable1, 'data', handles.h.DM);

set(handles.popupmenu1,'enable','on');
set(handles.popupmenu1,'string',{'Data'});
set(handles.popupmenu1,'value',1);
status(handles,{'on','on','off','off','off'});

guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status(handles,{'off','off','off','off','off'});
set(handles.text_status,'string','Calculating... SA'); 
drawnow;
[handles.tb1,handles.tb2,handles.tb3]=p_svr_sa(handles.h);
guidata(hObject, handles);

set(handles.popupmenu1,'enable','on');
set(handles.popupmenu1,'string',{'Data','1st order','2nd order','sum'});
set(handles.popupmenu1,'value',2);

set(handles.uitable1, 'columnname', {'Xi', 'Sa', 'Sb', 'S'});
set(handles.uitable1,'data',handles.tb1);


set(handles.text_status,'string','Ready'); 
drawnow;
status(handles,{'on','on','on','on','on'});

 [~,ind]=sort(handles.tb1(:,1));
        tb1a=handles.tb1(ind,:);
figure
p=bar([tb1a(:,2) tb1a(:,4)]);
AX=legend(p, {'Sa','S'}, 'Location','Best');
title('1st order sensitivity index');
ylabel('sensitivity');
s2=length(handles.h.colname);
xlim([0 s2]);
x=gca;
set(x,'XTick',1:s2-1);
set(x,'XTickLabel',handles.h.colname);
x.XTickLabelRotation=45;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status(handles,{'off','off','off','off','off'});
set(handles.text_status,'string','Calculating... 1st order'); 
drawnow;
ub=1;lb=-1;
%ub=3;lb=-3;
npmax=size(handles.tb1,1);
prompt = {'Enter grid size(50):','Enter number of plots:'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'50',num2str(npmax)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if ~isempty(answer)
gsize=str2num(answer{1});

Xa=lb:(ub-lb)/gsize:ub;
trnX=handles.h.DM(:,1:end-1);
trnY=handles.h.DM(:,end);

s2=size(trnX,2);
tstX=repmat(Xa',1,s2);

[y,Ym1]=p_svr_output(trnX,tstX,handles.h.ker,handles.h.para(3:end),handles.h.beta);

np=str2num(answer{2});
if np>npmax 
    np=npmax;
end
a1=round(sqrt(np));
a2=ceil(np/a1);
%-------------find ylimit
i=handles.tb1(1,1);
YY=Ym1(:,i);
ylimit=max(abs(min(YY)), abs(max(YY)))*1.1;
%------------------------plot 1st order component functions
figure
export1=Xa';
for n=1:np 
subplot(a1,a2,n)
i=handles.tb1(n,1); 
 Ya=Ym1(:,i);
 plot(Xa,Ya);
 export1=[export1,Ya];
 hold on
 plot([min(tstX(:,i)),max(tstX(:,i))],[0,0],':k');
 xlabel(strcat('X',num2str(i)));
 ylabel(strcat('f(x',num2str(i),')'));
 xlim([lb,ub]);
 ylim([-ylimit,ylimit]);
end
set(handles.text_status,'string','Ready'); 
drawnow;

choice = questdlg('Save the plot data?', '1st order plots', ...
	'Yes','No','No');
if strcmp(choice,'Yes')
    [filename,pathname] = uiputfile({'*.txt'},'Save sensitivity index');
      if pathname==0, 
       return;
      else
      fname=fullfile(pathname,filename);
      dlmwrite(fname,export1,'delimiter','\t','newline', 'pc');
      end
end
end
status(handles,{'on','on','on','on','on'});


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
status(handles,{'off','off','off','off','off'});
set(handles.text_status,'string','Calculating... 2nd order'); 
drawnow;

npmax=size(handles.tb2,1);
if npmax>9
    npmax=9;
end

prompt = {'Enter grid size(5X5):','Enter number of plots:'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'5',num2str(min(npmax,4))};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

if ~isempty(answer)

np=str2num(answer{2});
if np>npmax 
    np=npmax;
end
a1=round(sqrt(np));
a2=ceil(np/a1);

 trnX=handles.h.DM(:,1:end-1);
 trnY=handles.h.DM(:,end);
 s2=size(trnX,2);
 %------------------------plot 2st order component functions
gsize=str2num(answer{1});
ub=1;lb=-1;
%ub=3;lb=-3;
[Xa,Ya] = meshgrid(lb:(ub-lb)/gsize:ub, lb:(ub-lb)/gsize:ub);
x1=reshape(Xa,size(Xa,1)*size(Xa,2),1);
y1=reshape(Ya,size(Xa,1)*size(Ya,2),1);
sampleX=repmat(x1,1,s2);
export2=[x1,y1];
figure
for n=1:np 
subplot(a1,a2,n) 
i=handles.tb2(n,1);j=handles.tb2(n,2); 
 if np==1;
    prompt = {'Xi:','Xj:'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {num2str(i),num2str(j)};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    i=str2num(answer{1});
    j=str2num(answer{2});    
 end
 
 tstX=sampleX;
 tstX(:,j)=y1;

 [~,~,Ym2]=p_svr_output(trnX,tstX,handles.h.ker,handles.h.para(3:end),handles.h.beta);
  Z1=Ym2(:,(s2+s2-i)*(i-1)/2+j-i);
 export2=[export2,Z1];
 Za=reshape(Z1,size(Xa,1),size(Xa,2));
 surf(Xa,Ya,Za);
   
  
  colormap('jet');
 
 xlabel(strcat('x',num2str(i)));
 ylabel(strcat('x',num2str(j)));
 %title(['(x',num2str(i),', x',num2str(j),')']);
 %zlabel(strcat('f(x',num2str(i),',x',num2str(j),')'),'FontSize', 0.05,'FontUnits','normalized');
 
 %----------------zlimit
i=handles.tb2(1,1);j=handles.tb2(1,2);
z=Ym2(:,(s2+s2-i)*(i-1)/2+j-i);
zlimit=max(abs(min(z)), abs(max(z)))*1.1;

 xlim([lb,ub]);
 ylim([lb,ub]);
 zlim([-zlimit,zlimit]);
axis vis3d
shading interp
drawnow; 
end
set(handles.text_status,'string','Ready'); 
drawnow;

choice = questdlg('Save the plot data?', '2nd order plots', ...
	'Yes','No','No');
% Handle response
if strcmp(choice,'Yes')
    [filename,pathname] = uiputfile({'*.txt'},'Save sensitivity index');
      if pathname==0, 
       return;
      else
      fname=fullfile(pathname,filename);
      dlmwrite(fname,export2,'delimiter','\t','newline', 'pc');
      end
end
end
status(handles,{'on','on','on','on','on'});


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
menu=get(handles.popupmenu1,'value');
switch menu
    case 1
set(handles.uitable1, 'columnname', handles.h.colname);
set(handles.uitable1, 'data', handles.h.DM);
    case 2
set(handles.uitable1, 'columnname', {'Xi', 'Sa', 'Sb', 'S'});
set(handles.uitable1,'data',handles.tb1);
    case 3
set(handles.uitable1, 'columnname', {'Xi','Xj','Sa', 'Sb', 'S'});
set(handles.uitable1,'data',handles.tb2);
    case 4
set(handles.uitable1, 'columnname', {'order', 'Sa', 'Sb', 'S'});      
set(handles.uitable1,'data',handles.tb3);
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uiputfile({'*.txt'},'Save sensitivity index');
if pathname==0, 
    return;
else
fname=fullfile(pathname,filename);
%T1=array2table(handles.tb1,'VariableNames',{'Xi', 'Sa', 'Sb', 'S'});
%T2=array2table(handles.tb1,'VariableNames',{'Xi','Xj','Sa', 'Sb', 'S'});
%T3=array2table(handles.tb1,'VariableNames',{'order', 'Sa', 'Sb', 'S'});
fid=fopen(fname,'w');
fprintf(fid,'%4s\t %6s\t %6s\t %6s\r\n','Xi', 'Sa', 'Sb', 'S');
fprintf(fid,'%4d\t %6.3f\t %6.3f\t %6.3f\r\n',handles.tb1');
fprintf(fid,'\r\n');
fprintf(fid,'%4s\t %4s\t %6s\t %6s\t %6s\r\n','Xi','Xj','Sa', 'Sb', 'S');
fprintf(fid,'%4d\t %4d\t %6.3f\t %6.3f\t %6.3f\r\n',handles.tb2');
fprintf(fid,'\r\n');
fprintf(fid,'%4s\t %6s\t %6s\t %6s\r\n','order', 'Sa', 'Sb', 'S');
fprintf(fid,'%4d\t %6.3f\t %6.3f\t %6.3f\r\n',handles.tb3');
fclose(fid);
end
type(fname);

function status(handles,enable)
set(handles.pushbutton1,'enable',enable{1});
set(handles.pushbutton2,'enable',enable{2});
set(handles.pushbutton3,'enable',enable{3});
set(handles.pushbutton4,'enable',enable{4});
set(handles.pushbutton5,'enable',enable{5});


% --- Executes on button press in checkbox_parallel.
function checkbox_parallel_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_parallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_parallel
