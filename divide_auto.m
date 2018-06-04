function varargout = divide_auto(varargin)
% DIVIDE_AUTO MATLAB code for divide_auto.fig
%      DIVIDE_AUTO, by itself, creates a new DIVIDE_AUTO or raises the existing
%      singleton*.
%
%      H = DIVIDE_AUTO returns the handle to a new DIVIDE_AUTO or the handle to
%      the existing singleton*.
%
%      DIVIDE_AUTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIVIDE_AUTO.M with the given input arguments.
%
%      DIVIDE_AUTO('Property','Value',...) creates a new DIVIDE_AUTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before divide_auto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to divide_auto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help divide_auto

% Last Modified by GUIDE v2.5 27-Aug-2014 14:04:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @divide_auto_OpeningFcn, ...
                   'gui_OutputFcn',  @divide_auto_OutputFcn, ...
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


% --- Executes just before divide_auto is made visible.
function divide_auto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to divide_auto (see VARARGIN)

% Choose default command line output for divide_auto
handles.output = hObject;

hListener=addlistener(handles.slider1, 'ContinuousValueChange', @slider1_Callback);
setappdata(handles.slider1,'myListener',hListener);
hListener=addlistener(handles.slider2, 'ContinuousValueChange', @slider2_Callback);
setappdata(handles.slider2,'myListener',hListener);
hListener=addlistener(handles.slider3, 'ContinuousValueChange', @slider3_Callback);
setappdata(handles.slider3,'myListener',hListener);

D=varargin{2};
handles.D=D;
handles.D1=[];
handles.D2=[];
handles.D3=[];
[s1,s2]=size(D);
handles.s_to=s1;
handles.s_mo=round(s1/2);
handles.s_re=s1-round(s1/2);
handles.s_tr=round(round(s1/2)/2);
handles.s_va=round(s1/2)-round(round(s1/2)/2);
handles.s_te=s1-round(s1/2);
handles.s_0=0;
guidata(hObject, handles);

set(handles.text_to,'string',num2str(handles.s_to));
set(handles.text_mo,'string',num2str(handles.s_mo));
set(handles.text_re,'string',num2str(handles.s_re));
set(handles.text_tr,'string',num2str(handles.s_tr));
set(handles.text_va,'string',num2str(handles.s_va));
set(handles.text_te,'string',num2str(handles.s_te));

set(handles.slider1,'sliderstep',[1/handles.s_to,10/handles.s_to]);
set(handles.slider1,'max',handles.s_to-1);
set(handles.slider1,'min',10);
set(handles.slider1,'value',handles.s_mo);

set(handles.slider2,'sliderstep',[1/handles.s_mo,10/handles.s_mo]);
set(handles.slider2,'max',handles.s_mo);
set(handles.slider2,'min',0);
set(handles.slider2,'value',handles.s_tr);

set(handles.slider3,'sliderstep',[1/handles.s_re,10/handles.s_re]);
set(handles.slider3,'max',handles.s_re);
set(handles.slider3,'min',1);
set(handles.slider3,'value',handles.s_te);




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes divide_auto wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = divide_auto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
varargout{1}=handles.D1;
varargout{2}=handles.D2;
varargout{3}=handles.D3;

delete(handles.figure1);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if ~(exist('handles','var'))
     handles=guidata(hObject);
end
handles.s_mo=round(get(handles.slider1,'value'));guidata(hObject, handles);
handles.s_re=handles.s_to-handles.s_mo;guidata(hObject, handles);
r1=get(handles.slider2,'value')/get(handles.slider2,'max');
r2=get(handles.slider3,'value')/get(handles.slider3,'max');
handles.s_tr=round(handles.s_mo*r1);guidata(hObject, handles);
handles.s_te=round(handles.s_re*r2);guidata(hObject, handles);
handles.s_va=handles.s_mo-handles.s_tr;guidata(hObject, handles);

set(handles.text_mo,'string',num2str(handles.s_mo));
set(handles.text_re,'string',num2str(handles.s_re));
set(handles.text_tr,'string',num2str(handles.s_tr));
set(handles.text_va,'string',num2str(handles.s_va));
set(handles.text_te,'string',num2str(handles.s_te));

set(handles.slider2,'sliderstep',[1/handles.s_mo,10/handles.s_mo]);
set(handles.slider2,'max',handles.s_mo);
set(handles.slider2,'value',handles.s_tr);

set(handles.slider3,'sliderstep',[1/handles.s_re,10/handles.s_re]);
set(handles.slider3,'max',handles.s_re);
set(handles.slider3,'value',handles.s_te);

r1=handles.s_mo/handles.s_to;
r2=handles.s_tr/handles.s_mo;
set(handles.text_pmo,'string',[num2str(round(r1*100)),char(37)]);
set(handles.text_pre,'string',[num2str(100-round(r1*100)),char(37)]);
set(handles.text_ptr,'string',[num2str(round(r2*100)),char(37)]);
set(handles.text_pva,'string',[num2str(100-round(r2*100)),char(37)]);


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
if ~(exist('handles','var'))
     handles=guidata(hObject);
end
handles.s_tr=round(get(handles.slider2,'value'));guidata(hObject, handles);
handles.s_va=handles.s_mo-handles.s_tr;guidata(hObject, handles);
set(handles.text_tr,'string',num2str(handles.s_tr));
set(handles.text_va,'string',num2str(handles.s_va));

r2=handles.s_tr/handles.s_mo;
set(handles.text_ptr,'string',[num2str(round(r2*100)),char(37)]);
set(handles.text_pva,'string',[num2str(100-round(r2*100)),char(37)]);




% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if ~(exist('handles','var'))
     handles=guidata(hObject);
end
handles.s_te=round(get(handles.slider3,'value'));guidata(hObject, handles);
set(handles.text_te,'string',num2str(handles.s_te));



% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on button press in bt_ok.
function bt_ok_Callback(hObject, eventdata, handles)
% hObject    handle to bt_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ss=handles.s_to;
s1=handles.s_tr;
s2=handles.s_va;
s3=handles.s_te;

if get(get(handles.uipanel1,'Selectedobject'),'Tag')=='r1'
   idx=randperm(ss);
else
   idx=1:ss;
end
idx1=idx(1:s1);
idx2=idx(s1+1:s1+s2);
idx3=idx(s1+s2+1:s1+s2+s3);
 
handles.D1=handles.D(idx1,:);
handles.D2=handles.D(idx2,:);
handles.D3=handles.D(idx3,:);
guidata(hObject, handles);
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
