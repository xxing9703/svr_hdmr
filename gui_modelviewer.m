function varargout = gui_modelviewer(varargin)
% GUI_MODELVIEWER MATLAB code for gui_modelviewer.fig
%      GUI_MODELVIEWER, by itself, creates a new GUI_MODELVIEWER or raises the existing
%      singleton*.
%
%      H = GUI_MODELVIEWER returns the handle to a new GUI_MODELVIEWER or the handle to
%      the existing singleton*.
%
%      GUI_MODELVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODELVIEWER.M with the given input arguments.
%
%      GUI_MODELVIEWER('Property','Value',...) creates a new GUI_MODELVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_modelviewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_modelviewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_modelviewer

% Last Modified by GUIDE v2.5 04-May-2015 15:12:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_modelviewer_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_modelviewer_OutputFcn, ...
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


% --- Executes just before gui_modelviewer is made visible.
function gui_modelviewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_modelviewer (see VARARGIN)

% Choose default command line output for gui_modelviewer
handles.output = hObject;
handles.h=[];
rt=40;
pic_button(handles.bt_load,'bt_loadmd.jpg',rt);
pic_button(handles.bt_run,'bt_run.jpg',rt);
pic_button(handles.bt_surf,'bt_surf.jpg',rt);
pic_button(handles.bt_opt,'bt_search.jpg',rt);
pic_button(handles.bt_exit,'bt_close.jpg',rt);

set(handles.bt_load, 'TooltipString', 'load the model');
set(handles.bt_surf, 'TooltipString', 'surface plot in low dimension');
set(handles.bt_opt, 'TooltipString', 'optimal search');
set(handles.bt_exit, 'TooltipString', 'Exit');




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_modelviewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_modelviewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile({'*.mat'},'load model');
%set(handles.text5,'string',['Model:', pathname,filename]);
handles.marksz=15;
handles.fontsz=15;
guidata(hObject, handles);
if pathname==0
else
    hd=load (fullfile(pathname,filename));
    handles.h=hd.b; %handles.h is the handle to assess model
    guidata(hObject, handles);
    XXDM=handles.h.DM(:,1:end-1);
    XXDM=(XXDM+1)/2; %model [-1,1]--> display [0 1]
    Y=handles.h.DM(:,end);
    Ypred=handles.h.pred;
    DM=[XXDM,Y,Ypred];
    colname=[handles.h.colname,'prediction'];
    set(handles.uitable1,'data',DM);
    set(handles.uitable1,'ColumnName',colname);
 %Plot 1:  truth plot
    lb=min([Y;Ypred]);
    ub=max([Y;Ypred]);
    scope=ub-lb;
    lb=lb-scope*0.08;
    ub=ub+scope*0.08;
    plot(handles.axes1,Y,Ypred,'o',[lb,ub],[lb,ub],'r.-','MarkerFaceColor','r','Markersize',3);
    xlabel(handles.axes1,'Exp. Data', 'FontSize', 0.1,'FontUnits','normalized');
    ylabel(handles.axes1,'Model Prediction', 'FontSize', 0.1,'FontUnits','normalized');
    title(handles.axes1,'Truth Plot');
    xlim(handles.axes1,[lb,ub]);
    ylim(handles.axes1,[lb,ub]);
  %plot 2: 3D plot  
set(handles.pop_x,'string',handles.h.colname);
set(handles.pop_y,'string',handles.h.colname);
set(handles.pop_x,'value',1);
set(handles.pop_y,'value',2);
plot3D(handles);

%plot middle: output overlay
plot(handles.axes3,Y,'.b','markersize',5);
  hold (handles.axes3,'on');
plot(handles.axes3,Ypred,'or','markersize',5);
  hold (handles.axes3,'off');
 xlabel(handles.axes3,'Index','FontSize', 0.1,'FontUnits','normalized');
 ylabel(handles.axes3,'Output values','FontSize', 0.1,'FontUnits','normalized');
end

% --- Executes on button press in bt_run.
function bt_run_Callback(hObject, eventdata, handles)
% hObject    handle to bt_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[DD,colname]=loadhdd('Load data for prediction');
s2=size(handles.h.DM,2);
if size(DD,2)==s2-1;
    DD=[DD,zeros(size(DD,1),1)];
end
set(handles.uitable1,'data',DD);
bt_pred_Callback(hObject, eventdata, handles);
% DD=get(handles.uitable1,'Data');
 % Xvector=DD(:,1:end-1)*2-1;
 % Ypred=svroutput(handles.h.DM(:,1:end-1),Xvector,handles.h.ker,handles.h.para,handles.h.beta)+handles.h.y0; %prediction in an array
 % data=[DD,Ypred];
 %  set(handles.uitable1,'Data',data);
 %



% --- Executes on button press in bt_surf.
function bt_surf_Callback(hObject, eventdata, handles)
% hObject    handle to bt_surf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.h)
    gui_surf(handles.h);
else
    msgbox('Load the model first!','Alert');
end




% --- Executes on button press in bt_opt.
function bt_opt_Callback(hObject, eventdata, handles)
% hObject    handle to bt_opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.h)
    gui_search(handles.h);
else
    msgbox('Load the model first!','Alert');
end



% --- Executes on button press in bt_exit.
function bt_exit_Callback(hObject, eventdata, handles)
% hObject    handle to bt_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on selection change in pop_x.
function pop_x_Callback(hObject, eventdata, handles)
% hObject    handle to pop_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_x contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_x
plot3D(handles);

% --- Executes during object creation, after setting all properties.
function pop_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_z.
function pop_z_Callback(hObject, eventdata, handles)
% hObject    handle to pop_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_z contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_z


% --- Executes during object creation, after setting all properties.
function pop_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_y.
function pop_y_Callback(hObject, eventdata, handles)
% hObject    handle to pop_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_y contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_y
plot3D(handles);

% --- Executes during object creation, after setting all properties.
function pop_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plot3D(handles)
 %plot 3D
 h=handles.axes2;
% figure;
% h=subplot(1,1,1);
DD=get(handles.uitable1,'data');
colname=get(handles.uitable1,'ColumnName');
axe1=get(handles.pop_x,'value');
axe2=get(handles.pop_y,'value');

x1=DD(:,axe1);
x2=DD(:,axe2);

y=DD(:,end-1);
yy=DD(:,end);
if sum(y)~=0
 scatter3(h,x1,x2,y,handles.marksz,'blue','filled');
 hold (h,'on');
end
 scatter3(h,x1,x2,yy,30,'red');
 hold (h,'off');
  xlabel(h,colname(axe1), 'FontSize', handles.fontsz);
   ylabel(h,colname(axe2), 'FontSize', handles.fontsz);
   zlabel(h,colname(end-1), 'FontSize', handles.fontsz);
    %  zlabel(h,'Output', 'FontSize', handles.fontsz);
   rotate3d on;


% --- Executes on button press in bt_open.
function bt_open_Callback(hObject, eventdata, handles)
% hObject    handle to bt_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[DD,colname]=loadhdd('testing data');
s2=size(handles.h.DM,2);
if size(DD,2)==s2-1;
    DD=[DD,zeros(size(DD,1),1)];
    set(handles.uitable1,'data',DD);
elseif size(DD,2)==s2;
     set(handles.uitable1,'data',DD);
else
    msgbox('Wrong data!','Alert');
end



% --- Executes on button press in bt_pred.
function bt_pred_Callback(hObject, eventdata, handles)
% hObject    handle to bt_pred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'string','Working...'); 
set(handles.text_status,'BackgroundColor','red'); %status
drawnow;

s2=size(handles.h.DM,2);
  DD=get(handles.uitable1,'Data');
  Xvector=DD(:,1:s2-1)*2-1;
  %Xvector=DD(:,1:s2-1);
  
Ypred=svroutput(handles.h.DM(:,1:s2-1),Xvector,handles.h.ker,handles.h.para,handles.h.beta)+handles.h.y0; %prediction in an array
  data=[DD(:,1:s2-1),DD(:,s2),Ypred];
  set(handles.uitable1,'Data',data);
  
  axe1=get(handles.pop_x,'value');
  axe2=get(handles.pop_y,'value');
  %..plot
  x1=DD(:,axe1);
  x2=DD(:,axe2);
  scatter3(handles.axes2,x1,x2,Ypred,handles.marksz,'blue','filled');

%plot middle: output 

plot(handles.axes3,Ypred,'or','markersize',3);
  hold (handles.axes3,'off');
 xlabel(handles.axes3,'Index','FontSize', 0.1,'FontUnits','normalized');
 ylabel(handles.axes3,'Output values','FontSize', 0.1,'FontUnits','normalized');
  
  set(handles.text_status,'string','Ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DD=get(handles.uitable1,'Data');
colname=[handles.h.colname,'prediction'];
savehdd(DD,colname,'Save data');
%{
[file,path] = uiputfile({'*.xlsx'},'save to excel');
if path==0
    return; 
else
 filename=fullfile(path,file);
 xlswrite(filename,colname,'sheet1','A1');
xlswrite(filename,DD,'sheet1','A2');
%}

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if get(handles.checkbox1,'value')
    set(handles.uitable1,'columneditable',true);
else
    set(handles.uitable1,'columneditable',false);
end
