function varargout = gui_opt(varargin)
% GUI_OPT MATLAB code for gui_opt.fig
%      GUI_OPT, by itself, creates a new GUI_OPT or raises the existing
%      singleton*.
%
%      H = GUI_OPT returns the handle to a new GUI_OPT or the handle to
%      the existing singleton*.
%
%      GUI_OPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OPT.M with the given input arguments.
%
%      GUI_OPT('Property','Value',...) creates a new GUI_OPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_opt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_opt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_opt

% Last Modified by GUIDE v2.5 06-Nov-2014 14:32:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_opt_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_opt_OutputFcn, ...
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


% --- Executes just before gui_opt is made visible.
function gui_opt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_opt (see VARARGIN)

% Choose default command line output for gui_opt
handles.output = hObject;
handles.opt=struct('pop',90,'gen',20,'stall',10,'time',10000,'speed',0,'plot',[1,1],'cost',0,'boot',0,'div',5);
opt=varargin{2};
set(handles.edit_pop,'string',num2str(opt.pop));
set(handles.edit_gen,'string',num2str(opt.gen));
set(handles.edit_stall,'string',num2str(opt.stall));
set(handles.edit_time,'string',num2str(opt.time));
set(handles.cb_speed,'value',opt.speed);
set(handles.cb_his,'value',opt.plot(1));
set(handles.cb_pro,'value',opt.plot(2));
set(handles.slider1,'value',opt.cost);
set(handles.cb_boot,'value',opt.boot);
set(handles.pop_div,'value',opt.div);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_opt wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_opt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.opt;
delete(handles.figure1);



function edit_pop_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pop as text
%        str2double(get(hObject,'String')) returns contents of edit_pop as a double


% --- Executes during object creation, after setting all properties.
function edit_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_speed.
function cb_speed_Callback(hObject, eventdata, handles)
% hObject    handle to cb_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_speed



function edit_stall_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stall as text
%        str2double(get(hObject,'String')) returns contents of edit_stall as a double


% --- Executes during object creation, after setting all properties.
function edit_stall_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gen_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gen as text
%        str2double(get(hObject,'String')) returns contents of edit_gen as a double


% --- Executes during object creation, after setting all properties.
function edit_gen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_time as text
%        str2double(get(hObject,'String')) returns contents of edit_time as a double


% --- Executes during object creation, after setting all properties.
function edit_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_his.
function cb_his_Callback(hObject, eventdata, handles)
% hObject    handle to cb_his (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_his


% --- Executes on button press in cb_pro.
function cb_pro_Callback(hObject, eventdata, handles)
% hObject    handle to cb_pro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_pro


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.opt.pop=str2num(get(handles.edit_pop,'string'));
handles.opt.gen=str2num(get(handles.edit_gen,'string'));
handles.opt.stall=str2num(get(handles.edit_stall,'string'));
handles.opt.time=str2num(get(handles.edit_time,'string'));
handles.opt.speed=get(handles.cb_speed,'value');
handles.opt.plot=[get(handles.cb_his,'value'),get(handles.cb_pro,'value')];
handles.opt.cost=get(handles.slider1,'value');
handles.opt.boot=get(handles.cb_boot,'value');
handles.opt.div=get(handles.pop_div,'value');
guidata(hObject, handles);

figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


% --- Executes on button press in bt_cancel.
function bt_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to bt_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in cb_boot.
function cb_boot_Callback(hObject, eventdata, handles)
% hObject    handle to cb_boot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_boot


% --- Executes on selection change in pop_div.
function pop_div_Callback(hObject, eventdata, handles)
% hObject    handle to pop_div (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_div contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_div


% --- Executes during object creation, after setting all properties.
function pop_div_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_div (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
