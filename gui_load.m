function varargout = gui_load(varargin)
% GUI_LOAD MATLAB code for gui_load.fig
%      GUI_LOAD, by itself, creates a new GUI_LOAD or raises the existing
%      singleton*.
%
%      H = GUI_LOAD returns the handle to a new GUI_LOAD or the handle to
%      the existing singleton*.
%
%      GUI_LOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LOAD.M with the given input arguments.
%
%      GUI_LOAD('Property','Value',...) creates a new GUI_LOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_load_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_load_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_load

% Last Modified by GUIDE v2.5 04-Sep-2014 01:53:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_load_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_load_OutputFcn, ...
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


% --- Executes just before gui_load is made visible.
function gui_load_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_load (see VARARGIN)

% Choose default command line output for gui_load
%handles.output = hObject;
handles.D=varargin {1};
handles.D1=varargin {2};
handles.D2=varargin {3};
handles.D3=varargin {4};
handles.colname=varargin{5};
% Update handles structure
guidata(hObject, handles);
set(handles.text1,'string',num2str(size(handles.D1,1)));
set(handles.text2,'string',num2str(size(handles.D2,1)));
set(handles.text3,'string',num2str(size(handles.D3,1)));
% UIWAIT makes gui_load wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_load_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.D;
varargout{2} = handles.D1;
varargout{3} = handles.D2;
varargout{4} = handles.D3;
varargout{5} = handles.colname;
delete(handles.figure1);



% --- Executes on button press in bt_train.
function bt_train_Callback(hObject, eventdata, handles)
% hObject    handle to bt_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[D1,colname]=loadhdd('training data');
if D1==0
else
    if isempty(handles.colname)
       handles.colname=colname;
    end
handles.D1=D1;
[s1,s2]=size(D1);
set(handles.text1,'string',num2str(s1));
guidata(hObject, handles);
end


% --- Executes on button press in bt_valid.
function bt_valid_Callback(hObject, eventdata, handles)
% hObject    handle to bt_valid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[D2,colname]=loadhdd('Validating data');
if D2 ==0
else
 if isempty(handles.colname)
       handles.colname=colname;
    end
handles.D2=D2;
[s1,s2]=size(D2);
set(handles.text2,'string',num2str(s1));
guidata(hObject, handles);
end

% --- Executes on button press in bt_test.
function bt_test_Callback(hObject, eventdata, handles)
% hObject    handle to bt_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[D3,colname]=loadhdd('testing data');
if D3==0
else
   if isempty(handles.colname)
       handles.colname=colname;
    end
handles.D3=D3;
[s1,s2]=size(D3);
set(handles.text3,'string',num2str(s1));
guidata(hObject, handles);
end

% --- Executes on button press in bt_all.
function bt_all_Callback(hObject, eventdata, handles)
% hObject    handle to bt_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[D,colname]=loadhdd('All data');
if D==0
else
handles.colname=colname;
[s1, s2]=size(D); 
[D1,D2,D3]=divide(D,'auto');
handles.D1=D1;
handles.D2=D2;
handles.D3=D3;
set(handles.text1,'string',num2str(size(D1,1)));
set(handles.text2,'string',num2str(size(D2,1)));
set(handles.text3,'string',num2str(size(D3,1)));
guidata(hObject, handles);
end

% --- Executes on button press in bt_ok.
function bt_ok_Callback(hObject, eventdata, handles)
% hObject    handle to bt_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.D=[handles.D1;handles.D2;handles.D3];
guidata(hObject, handles);
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


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
