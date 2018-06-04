function varargout = gui_search(varargin)
% GUI_SEARCH MATLAB code for gui_search.fig
%      GUI_SEARCH, by itself, creates a new GUI_SEARCH or raises the existing
%      singleton*.
%
%      H = GUI_SEARCH returns the handle to a new GUI_SEARCH or the handle to
%      the existing singleton*.
%
%      GUI_SEARCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SEARCH.M with the given input arguments.
%
%      GUI_SEARCH('Property','Value',...) creates a new GUI_SEARCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_search_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_search_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_search

% Last Modified by GUIDE v2.5 05-Feb-2016 14:37:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_search_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_search_OutputFcn, ...
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


% --- Executes just before gui_search is made visible.
function gui_search_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no text_value args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_search (see VARARGIN)

% Choose default command line text_value for gui_search
handles.output = hObject;
if nargin>3 
  handles.h=varargin{1};
  set(handles.text_md,'string','ext');
else
  handles.h='';
end

%handles.text_value = hObject;
guidata(hObject, handles);

if ~isempty(handles.h);
    %handles.model=varargin{1};
   
    [s1,s2]=size(handles.h.DM);
set(handles.uitable1,'RowName',[handles.h.colname(1:s2-1)]);
set(handles.uitable1,'ColumnName',[{'lower'}, {'upper'}, {'current'}]);
set(handles.uitable1,'data',[ones(s2-1,1)*0,ones(s2-1,1)*1,ones(s2-1,1)*0.5]); 

end  

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_search wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_search_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning text_value args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line text_value from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_optimize.
function bt_optimize_Callback(hObject, eventdata, handles)
% hObject    handle to bt_optimize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
para=get(handles.uitable1,'data');
x=para(:,3)*2-1;
lb=para(:,1)*2-1;
ub=para(:,2)*2-1;
sp=length(x);


popu=str2num(get(handles.edit_pop,'string'));
gene=str2num(get(handles.edit_gen,'string'));
stall=str2num(get(handles.edit_stall,'string'));
time=str2num(get(handles.edit_time,'string'));
%--------------------------------------------------single objective

ObjectiveFunction = @(x)costfn2(x,handles);
opts = gaoptimset('PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',gene,'StallGenLimit', stall,'TimeLimit', time);
opts = gaoptimset(opts,'PopulationSize',popu);

[x,fval] = ga(ObjectiveFunction,sp,[],[],[],[],lb',ub',[],opts);
%--------------------------------------------------single objective end
%{
%-------------multi objective
ObjectiveFunction = @(x)costfn_multi(x,handles);
opts = gaoptimset('PlotFcns',{@gaplotpareto,@gaplotscorediversity});
[x,fval] = gamultiobj(ObjectiveFunction,sp,[],[],[],[],lb',ub',opts);
assignin('base', 'multiout',[x,fval]);
%--------------------multi objective end
 %}
para(:,3)=(x+1)/2;
set(handles.uitable1,'data',para);
m=get(handles.radiobutton_min,'value');
if m==0
    fval=-fval;
end
set(handles.text_out,'string',num2str(fval));

function [C,Ceq]=nl(x)
z=(x+1)/2;
count = length(find(z>=0.001));
C=[count-3];
Ceq=[];





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


% --- Executes on button press in bt_run.
function bt_run_Callback(hObject, eventdata, handles)
% hObject    handle to bt_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
para=get(handles.uitable1,'data');
x=para(:,3)*2-1;
s2=size(handles.h.DM,2);
value=svr_output(handles.h.DM(:,1:s2-1),x',handles.h.ker,handles.h.para(3:end),handles.h.beta)+handles.h.y0; %prediction
set(handles.text_out,'string',num2str(value));


% --- Executes on button press in negative.
function negative_Callback(hObject, eventdata, handles)
% hObject    handle to negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of negative



function edit_fitness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fitness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fitness as text
%        str2double(get(hObject,'String')) returns contents of edit_fitness as a double


% --- Executes during object creation, after setting all properties.
function edit_fitness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fitness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat','Load the model file');
M=load(fullfile(pathname, filename));
handles.h=M.b;
set(handles.text_md,'string',filename);
guidata(hObject, handles);
if ~isempty(handles.h);
    %handles.model=varargin{1};
   
    [s1,s2]=size(handles.h.DM);
set(handles.uitable1,'RowName',[handles.h.colname(1:s2-1)]);
set(handles.uitable1,'ColumnName',[{'lower'}, {'upper'}, {'current'}]);
set(handles.uitable1,'data',[ones(s2-1,1)*0,ones(s2-1,1)*1,ones(s2-1,1)*0.5]); 

end  


% --- Executes on button press in bt_sample.
function bt_sample_Callback(hObject, eventdata, handles)
% hObject    handle to bt_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter sampling size(200):','Enter bins for exp. data:','Enter bins for sampling data:'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'200','15','10'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
num=str2num(answer{1});
b1=str2num(answer{2});
b2=str2num(answer{3});


para=get(handles.uitable1,'data');
lb=para(:,1)*2-1;
ub=para(:,2)*2-1;
%num=100;
sp=rand(length(lb),num);
for i=1:num
  x(:,i)=lb+(ub-lb).*sp(:,i);
end

s2=size(handles.h.DM,2);
value=svr_output(handles.h.DM(:,1:s2-1),x',handles.h.ker,handles.h.para(3:end),handles.h.beta)+handles.h.y0; %prediction
y=handles.h.DM(:,end);

figure;
hist(y,b1);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','k','EdgeColor','w','facealpha',0.75);
hold on
[n1,x1]=hist(value,b2);
 h1 = bar(x1,n1);
set(h1,'facecolor','r','facealpha',0.75);
%h = findobj(gca,'Type','patch');
%set(h,'FaceColor','g','EdgeColor','w','facealpha',0.75)
hold off
legend('full region','selected region');
xlabel('output value');
ylabel('count');
title(['mean=',num2str(mean(value)),',  std=',num2str(std(value))]);
set(handles.text_out,'string',num2str(mean(value)));
