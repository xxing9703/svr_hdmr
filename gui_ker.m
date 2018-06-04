function varargout = gui_ker(varargin)
% GUI_KER MATLAB code for gui_ker.fig
%      GUI_KER, by itself, creates a new GUI_KER or raises the existing
%      singleton*.
%
%      H = GUI_KER returns the handle to a new GUI_KER or the handle to
%      the existing singleton*.
%
%      GUI_KER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_KER.M with the given input arguments.
%
%      GUI_KER('Property','Value',...) creates a new GUI_KER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_ker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_ker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_ker

% Last Modified by GUIDE v2.5 29-Aug-2014 14:06:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_ker_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_ker_OutputFcn, ...
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


% --- Executes just before gui_ker is made visible.
function gui_ker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_ker (see VARARGIN)

% Choose default command line output for gui_ker
h=varargin{1};
   handles.para_str=h.para_str;
   handles.ker=h.ker;
   handles.paradata=[h.lb,h.ub,h.para];

D=h.D;
handles.ker=lower(h.ker);
guidata(hObject, handles);

strarray=get(handles.list1,'string');
x=strmatch(handles.ker, strarray);

set(handles.list1,'value',x);
s2=size(D,2);
set(handles.text_var,'string',num2str(s2-1));
set(handles.list_order,'string',num2str([1:s2-1]'));
set(handles.list_order,'value',s2-1);

handles.s2=s2;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_ker wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_ker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.ker;
varargout{2} = handles.paradata;
varargout{3} = handles.para_str;

delete(handles.figure1);


% --- Executes on selection change in list1.
function list1_Callback(hObject, eventdata, handles)
% hObject    handle to list1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list1


% --- Executes during object creation, after setting all properties.
function list1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list2.
function list2_Callback(hObject, eventdata, handles)
% hObject    handle to list2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list2


% --- Executes during object creation, after setting all properties.
function list2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_order.
function list_order_Callback(hObject, eventdata, handles)
% hObject    handle to list_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_order contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_order


% --- Executes during object creation, after setting all properties.
function list_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
str1=get(handles.list1,'string');
n1=get(handles.list1,'value');
%str2=get(handles.list2,'string');
%n2=get(handles.list2,'value');
%ker=strcat(str1(n1),'_',str2(n2));

ker=str1{n1};
s2=handles.s2-1;

order=get(handles.list_order,'value');
switch lower(ker)
   case {'hdmra_rbf', 'hdmra_exp','additive_rbf', 'additive_exp'} 
       bd_C=[1,50,20];
       bd_e=[0,0.1,0.05];
       bd_p=[-1,1,0];
       bd_s=[0,2,1];
   case {'hdmra_poly','additive_poly'}
       bd_C=[1,50,20];
       bd_e=[0,0.1,0.05];
       bd_p=[0,4,2];
       bd_s=[0,2,1];
   case 'hdmra_fourier'   
       bd_C=[1,50,20];
       bd_e=[0,0.1,0.05];
       bd_s=[0,2,1];
   
end  

switch lower(ker)
   case {'hdmra_rbf', 'hdmra_poly','hdmra_exp','additive_rbf', 'additive_exp','additive_poly'}
    for i=1:s2
     a(i)={['P' num2str(i)]};  %parameter lables 'P1' 'P2'...
    end
    for i=1:order
    s(i)={['S' num2str(i)]};  %parameter lables 'S1' 'S2'...
    end 
    para_str=[{'Cval'},{'Loss'},a,s]; %complete list of parameter lables 
    pdata=repmat(bd_p,s2,1); % [lb,ub,current] parameters of Pi
    sdata=repmat(bd_s,order,1);  % [lb,ub,current] parameters of Si
    paradata=[bd_C;bd_e;pdata;sdata]; %complete list of parameter settings
  
     
   case 'hdmra_fourier'
     for i=1:order
      s(i)={['S' num2str(i)]};  %parameter lables 'S1' 'S2'...
    end 
    para_str=[{'Cval'},{'Loss'},s]; %complete list of parameter lables 
    sdata=repmat(bd_s,order,1);  % [lb,ub,current] parameters of Si
    paradata=[bd_C;bd_e;sdata]; %complete list of parameter settings
end

    handles.para_str=para_str;
    handles.ker=ker;
    handles.paradata=paradata;
   
    guidata(hObject, handles);
  figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
        


% --- Executes on button press in bt_cancel.
function bt_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to bt_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
