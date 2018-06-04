function varargout = Main(varargin)
% SVR_HDMR_MAIN MATLAB code for SVR_HDMR_Main.fig
%      SVR_HDMR_MAIN, by itself, creates a new SVR_HDMR_MAIN or raises the existing
%      singleton*.
%
%      H = SVR_HDMR_MAIN returns the handle to a new SVR_HDMR_MAIN or the handle to
%      the existing singleton*.
%
%      SVR_HDMR_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVR_HDMR_MAIN.M with the given input arguments.
%
%      SVR_HDMR_MAIN('Property','Value',...) creates a new SVR_HDMR_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SVR_HDMR_Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVR_HDMR_Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVR_HDMR_Main

% Last Modified by GUIDE v2.5 23-Feb-2016 23:05:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before SVR_HDMR_Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVR_HDMR_Main (see VARARGIN)

% Choose default command line output for SVR_HDMR_Main
handles.output = hObject;
handles.md='';
handles.dt='';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SVR_HDMR_Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_prep.
function bt_prep_Callback(hObject, eventdata, handles)
% hObject    handle to bt_prep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_prep();

% --- Executes on button press in bt_solver.
function bt_solver_Callback(hObject, eventdata, handles)
% hObject    handle to bt_solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_modeling();

% --- Executes on button press in bt_viewer.
function bt_viewer_Callback(hObject, eventdata, handles)
% hObject    handle to bt_viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.md)
    gui_surf(handles.md);
else 
    gui_surf();
end



% --- Executes on button press in bt_sensi.
function bt_sensi_Callback(hObject, eventdata, handles)
% hObject    handle to bt_sensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.md)
    gui_sens(handles.md);
else 
    gui_sens();
end

% --- Executes on button press in bt_optim.
function bt_optim_Callback(hObject, eventdata, handles)
% hObject    handle to bt_optim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.md)
    gui_search(handles.md);
else 
    gui_search();
end


% --- Executes on button press in bt_report.
function bt_report_Callback(hObject, eventdata, handles)
% hObject    handle to bt_report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_dataview.
function bt_dataview_Callback(hObject, eventdata, handles)
% hObject    handle to bt_dataview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.md)
    gui_view(handles.md)
else 
    gui_view();
end


% --------------------------------------------------------------------
function load_md_Callback(hObject, eventdata, handles)
% hObject    handle to load_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat','Load the model file');
M=load(fullfile(pathname, filename));
handles.md=M.b;
set(handles.text_md,'string',filename);
guidata(hObject, handles);


% --------------------------------------------------------------------
function load_dt_Callback(hObject, eventdata, handles)
% hObject    handle to load_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_pred.
function bt_pred_Callback(hObject, eventdata, handles)
% hObject    handle to bt_pred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.md)
    gui_pred(handles.md);
else 
    gui_pred();
end

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
