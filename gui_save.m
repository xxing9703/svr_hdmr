function varargout = gui_save(varargin)
% GUI_SAVE MATLAB code for gui_save.fig
%      GUI_SAVE, by itself, creates a new GUI_SAVE or raises the existing
%      singleton*.
%
%      H = GUI_SAVE returns the handle to a new GUI_SAVE or the handle to
%      the existing singleton*.
%
%      GUI_SAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SAVE.M with the given input arguments.
%
%      GUI_SAVE('Property','Value',...) creates a new GUI_SAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_save_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_save_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_save

% Last Modified by GUIDE v2.5 03-Nov-2014 21:57:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_save_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_save_OutputFcn, ...
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


% --- Executes just before gui_save is made visible.
function gui_save_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_save (see VARARGIN)

% Choose default command line output for gui_save
handles.output = hObject;

h=varargin{1};
handles.D1=h.D1;
handles.D2=h.D2;
handles.D3=h.D3;
handles.colname=h.colname;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes gui_save wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_save_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);


% --- Executes on button press in bt_done.
function bt_done_Callback(hObject, eventdata, handles)
% hObject    handle to bt_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


% --- Executes on button press in bt_save1.
function bt_save1_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D1)
 savehdd(handles.D1,handles.colname,'save training data');
end


% --- Executes on button press in bt_save2.
function bt_save2_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D2)
savehdd(handles.D2,handles.colname,'save validating data');
end


% --- Executes on button press in bt_save3.
function bt_save3_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D3)
savehdd(handles.D3,handles.colname,'save validating data');
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
