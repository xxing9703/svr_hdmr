function varargout = gui_view(varargin)
% GUI_VIEW MATLAB code for gui_view.fig
%      GUI_VIEW, by itself, creates a new GUI_VIEW or raises the existing
%      singleton*.
%
%      H = GUI_VIEW returns the handle to a new GUI_VIEW or the handle to
%      the existing singleton*.
%
%      GUI_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_VIEW.M with the given input arguments.
%
%      GUI_VIEW('Property','Value',...) creates a new GUI_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_view

% Last Modified by GUIDE v2.5 02-Feb-2016 11:18:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_view_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_view_OutputFcn, ...
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


% --- Executes just before gui_view is made visible.
function gui_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_view (see VARARGIN)

% Choose default command line output for gui_view
handles.output = hObject;
handles.sz=5;
handles.bins=31;
% Update handles structure
handles.filename='';
guidata(hObject, handles);
if nargin>3 
 handles.h=varargin{1};
 handles.filename='N/A';
 guidata(hObject, handles);
 bt_loadmodel_Callback(hObject, eventdata, handles);
end
    



% UIWAIT makes gui_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pop_x.
function pop_x_Callback(hObject, eventdata, handles)
% hObject    handle to pop_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_x contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_x
 plotdist(handles);

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


% --- Executes on selection change in pop_y.
function pop_y_Callback(hObject, eventdata, handles)
% hObject    handle to pop_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_y contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_y
 plotdist(handles);

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
 

% --- Executes on selection change in pop_z.
function pop_z_Callback(hObject, eventdata, handles)
% hObject    handle to pop_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_z contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_z
plotdist(handles);

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


% --- Executes on button press in bt_loaddata.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to bt_loaddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function bt_loaddata_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname]=uigetfile({'*.hdd'},'load data file');
if pathname==0
     fulldata=0;
     header='';  
else
 fullname=strcat(pathname,filename);
 loaddata=importdata(fullname);
 if (class(loaddata)=='struct')  %if column headers are there
   fulldata=loaddata.data;      %get data-> fulldata
   [s1, s2]=size(fulldata);   %s1=rows, s2=cols
  % handles.colname=loaddata.textdata;  %get column headers
   header=loaddata.textdata;
 else
   fulldata=loaddata;
   [s1, s2]=size(fulldata);
   header = cell(s2,1);   % header stores a row of cells, each contains a string of lable
    for i=1:s2        % if header is lacking assign X1 X2..Xn Y to 
      header{i}=['Col',int2str(i)];
    end
  
 end
 set(handles.text_data,'string',filename);
 handles.DM=fulldata;
 handles.pred=fulldata(:,end);
 handles.colname=header;
 guidata(hObject, handles);
 
    set(handles.pop_x,'enable','on');
   set(handles.pop_x,'string',handles.colname(1:end));
   set(handles.pop_x,'value',1);
   set(handles.pop_y,'enable','on');
   set(handles.pop_y,'string',handles.colname(1:end));
   set(handles.pop_y,'value',2);
   set(handles.pop_z,'enable','on');
   set(handles.pop_z,'string',handles.colname(1:end));
   set(handles.pop_z,'value',s2);

  
 plotdist(handles);
 
set(handles.text_model,'string','');
guidata(hObject, handles);

end


% --- Executes on button press in bt_loadmodel.
function bt_loadmodel_Callback(hObject, eventdata, handles)
% hObject    handle to bt_loadmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~strcmp(handles.filename,'N/A')
  [filename, pathname] = uigetfile('*.mat','Load the model file');
  M=load(fullfile(pathname, filename));
  handles.h=M.b;
  handles.filename=filename;
else
  handles.filename='Ext'; 
  guidata(hObject, handles);
end

if ~isempty(handles.h)
  handles.DM=handles.h.DM;
  handles.pred=handles.h.pred;
  handles.colname=handles.h.colname;
 set(handles.text_model,'string',handles.filename);
guidata(hObject, handles);
   set(handles.pop_x,'enable','on');
   set(handles.pop_x,'string',handles.colname(1:end));
   set(handles.pop_x,'value',1);
   set(handles.pop_y,'enable','on');
   set(handles.pop_y,'string',handles.colname(1:end));
   set(handles.pop_y,'value',2);
   set(handles.pop_z,'enable','on');
   set(handles.pop_z,'string',handles.colname(1:end));
   set(handles.pop_z,'value',size(handles.DM,2));
plotdist(handles);
set(handles.text_data,'string','');
end

function plotdist(handles)
[s1,s2]=size(handles.DM);
data=handles.DM;

%------------------------------------
l=min(handles.DM(:,end));
u=max(handles.DM(:,end));
lb=l-(u-l)*0.1;
ub=u+(u-l)*0.1;
scatter(handles.axes4,handles.DM(:,end),handles.pred,handles.sz*2,'red','filled');
xlabel(handles.axes4,'Exp. data');
ylabel(handles.axes4,'Model prediction');
hold (handles.axes4, 'on');
plot(handles.axes4,[lb,ub],[lb,ub])
xlim(handles.axes4,[lb,ub]);
ylim(handles.axes4,[lb,ub]);
hold (handles.axes4, 'off');
title(handles.axes4,'Truth plot');
axe1=get(handles.pop_x,'value');
axe2=get(handles.pop_y,'value');
axe3=get(handles.pop_z,'value');

header=get(handles.pop_x,'string');
header_x=header(axe1);
header_y=header(axe2);
header_z=header(axe3);

x=data(:,axe1);
y=data(:,axe2);
z=data(:,axe3);
%-------------------
hist(handles.axes3,z,handles.bins); %histgram
xlabel(handles.axes3,header_z);
ylabel(handles.axes3,'count');
title(handles.axes3,'Histgram (Z-axis)');
%---------------

x=(x+1)/2;
y=(y+1)/2;

scatter(handles.axes1,x,y,handles.sz);
xlabel(handles.axes1,header_x);
ylabel(handles.axes1,header_y);
title(handles.axes1,'Sampling (X-Y)');

scatter3(handles.axes2,x,y,z,handles.sz,'blue','filled');
xlabel(handles.axes2,header_x);
ylabel(handles.axes2,header_y);
zlabel(handles.axes2,header_z);
rotate3d(handles.axes2,'on');
title(handles.axes2,'3D scatter view');
if axe3==s2
hold (handles.axes2, 'on');
scatter3(handles.axes2,x,y,handles.pred,handles.sz*2,'red');
hold (handles.axes2, 'off');
end
%--------------------------ordering
[~,I]=sort(data(:,axe1));
B=data(I,:);
pY=handles.pred(I);
scatter(handles.axes5,[1:s1],B(:,end),handles.sz,'blue','filled');
xlabel(handles.axes5,strcat('Ordering: X=',header_x));
ylabel(handles.axes5,'Output');
title(handles.axes5,'Correlation');

if axe3==s2
hold (handles.axes5, 'on');
scatter(handles.axes5,[1:s1],pY,handles.sz*2,'red');
hold (handles.axes5, 'off');
end
   


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.sz=floor(get(handles.slider1,'value'));
guidata(hObject, handles);
plotdist(handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
bin=get(handles.slider2,'value');
handles.bins=floor(10^bin);
guidata(hObject, handles);
hist(handles.axes3,handles.DM(:,end),handles.bins);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
