function varargout = gui_surf(varargin)
% GUI_SURF MATLAB code for gui_surf.fig
%      GUI_SURF, by itself, creates a new GUI_SURF or raises the existing
%      singleton*.
%
%      H = GUI_SURF returns the handle to a new GUI_SURF or the handle to
%      the existing singleton*.
%
%      GUI_SURF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SURF.M with the given input arguments.
%
%      GUI_SURF('Property','Value',...) creates a new GUI_SURF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_surf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_surf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_surf

% Last Modified by GUIDE v2.5 03-Feb-2016 11:24:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_surf_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_surf_OutputFcn, ...
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


% --- Executes just before gui_surf is made visible.
function gui_surf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_surf (see VARARGIN)

% Choose default command line output for gui_surf
handles.output = hObject;
%handles.vary=struct('grid',20,'lbx',-1,'ubx',1,'lby',-1,'uby',1,'x_axis',1,'y_axis',2);
if nargin>3 
 handles.h=varargin{1};
else
  handles.h='';
end
guidata(hObject, handles);

if ~isempty(handles.h)
s2=size(handles.h.DM,2);
set(handles.uitable1,'RowName',[handles.h.colname(1:s2-1)]);
%set(handles.uitable1,'ColumnName',[{'1st'}, {'2nd'}, {'3rd'}]);
set(handles.uitable1,'data',[ones(s2-1,4)*0]); 

   set(handles.pop_x,'string',handles.h.colname(1:s2-1));
   set(handles.pop_x,'value',1);
   set(handles.pop_y,'string',handles.h.colname(1:s2-1));
   set(handles.pop_y,'value',2);
   set(handles.pop_z,'string',handles.h.colname(1:s2-1));
   set(handles.pop_z,'value',3);
   
  handles.clr(:,:,1)=jet;
  handles.clr(:,:,2)=hsv;
  handles.clr(:,:,3)=hot;
  handles.clr(:,:,4)=cool;
  handles.clr(:,:,5)=spring;
  handles.clr(:,:,6)=summer;
  handles.clr(:,:,7)=autumn;
  handles.clr(:,:,8)=winter;
  handles.clr(:,:,9)=gray;
  handles.fig=zeros(1,4);
  handles.dot=zeros(1,4);
%colorbar;
% Update handles structure
guidata(hObject, handles);
for k=1:4
set(eval(['handles.bt_',num2str(k)]),'enable','off');
end
bt_surf_Callback(hObject, eventdata, handles);
end



% --- Outputs from this function are returned to the command line.
function varargout = gui_surf_OutputFcn(hObject, eventdata, handles) 
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



function edit_grid_Callback(hObject, eventdata, handles)
% hObject    handle to edit_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_grid as text
%        str2double(get(hObject,'String')) returns contents of edit_grid as a double


% --- Executes during object creation, after setting all properties.
function edit_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_x.
function pop_x_Callback(hObject, eventdata, handles)
% hObject    handle to pop_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_x contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_x


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



function edit_lbx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lbx as text
%        str2double(get(hObject,'String')) returns contents of edit_lbx as a double


% --- Executes during object creation, after setting all properties.
function edit_lbx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ubx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ubx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ubx as text
%        str2double(get(hObject,'String')) returns contents of edit_ubx as a double


% --- Executes during object creation, after setting all properties.
function edit_ubx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ubx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lby_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lby as text
%        str2double(get(hObject,'String')) returns contents of edit_lby as a double


% --- Executes during object creation, after setting all properties.
function edit_lby_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_uby_Callback(hObject, eventdata, handles)
% hObject    handle to edit_uby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_uby as text
%        str2double(get(hObject,'String')) returns contents of edit_uby as a double


% --- Executes during object creation, after setting all properties.
function edit_uby_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_uby (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_surf.
function bt_surf_Callback(hObject, eventdata, handles)
% hObject    handle to bt_surf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.text_status,'string','surface plotting...'); 
set(handles.text_status,'BackgroundColor','red'); %status
drawnow;

grid=str2num(get(handles.edit_grid,'string'));

ax1=get(handles.pop_x,'value');
ax2=get(handles.pop_y,'value');
guidata(hObject, handles);
ax_str=get(handles.pop_x,'string');
ax1_str=ax_str(ax1);
ax2_str=ax_str(ax2);
ss=get(handles.uitable1,'data'); %table data
layers=size(ss,2);

ubx=str2num(get(handles.edit_ubx,'string'))*2-1;
uby=str2num(get(handles.edit_uby,'string'))*2-1;
lbx=str2num(get(handles.edit_lbx,'string'))*2-1;
lby=str2num(get(handles.edit_lby,'string'))*2-1;


%calculate 3D layers

%set(handles.h.text_status,'string','calculating surface'); %status
%set(handles.h.text_status,'BackgroundColor','yellow');
%drawnow();

s2=size(handles.h.DM,2);
interp=100/grid; %interpolation
%[nsv, beta]=svrsolver(handles.h.DM(:,1:s2-1),handles.h.DM(:,s2)-handles.h.y0,handles.h.ker,handles.h.para);


X1_3D=[lbx:(ubx-lbx)/grid:ubx];  %mesh array 1st axes
X2_3D=[lby:(uby-lby)/grid:uby];   %mesh array 2nd axes

XX1_3D=[lbx:(ubx-lbx)/grid/interp:ubx]; %fine mesh array 1st axes
XX2_3D=[lby:(uby-lby)/grid/interp:uby]; %fine mesh array 2nd axes

  [c1,c2] = meshgrid([lbx:(ubx-lbx)/grid:ubx], [lby:(uby-lby)/grid:uby]);   %grid 
  [cc1,cc2] = meshgrid([lbx:(ubx-lbx)/grid/interp:ubx], [lby:(uby-lby)/grid/interp:uby]); %fine grid 
  
  
  hold (handles.axes1,'off');
 
%f=figure;
  
for k=1:layers
    set(eval(['handles.bt_',num2str(k)]),'enable','on');
  if get(eval(['handles.cb_',num2str(k)]),'value')~=0  % if plot? flag =1
     set(eval(['handles.bt_',num2str(k)]),'enable','on');
     set(eval(['handles.bt_',num2str(k)]),'value',1);
    default=-1;    
    Xvector=ones((grid+1)^2,s2-1)*default;  % X to be used in original svroutput
   for i=1:s2-1
    % Xvector(:,i)=ss(i,k);  %-1 to 1 
     Xvector(:,i)=ss(i,k)*2-1;  % 0 to 1 --> -1 to 1
   end
  Xvector(:,ax1)=c1(:); 
  Xvector(:,ax2)=c2(:);
   
 YMD3=p_svr_output(handles.h.DM(:,1:s2-1),Xvector,handles.h.ker,handles.h.para(3:end),handles.h.beta)+handles.h.y0; %prediction in an array
 %YMD3=myANN(Xvector');
 Ymax=max(handles.h.DM(:,s2));
 Ymin=min(handles.h.DM(:,s2));
 
 
  Y_3D=reshape(YMD3,grid+1,grid+1); %prediction in grid matrix
  YY_3D=interp2(c1,c2,Y_3D,cc1,cc2,'spline'); %prediction in grid matrix
   assignin('caller', 'Y3D',YMD3);
   assignin('caller', 'X3',Xvector);
   
   clr_index=get(handles.pop_color,'value');
  colormap(handles.clr(:,:,clr_index)); 
 
  
  handles.fig(k)=surf (handles.axes1,(cc1+1)/2,(cc2+1)/2,YY_3D,'LineStyle','none');
  hold on;
  
  guidata(hObject, handles);
  if ~get(handles.checkbox1,'value')
   caxis(handles.axes1,[Ymin,Ymax]);
  end
 %{
  pp(k)=surf((cc1+1)/2,(cc2+1)/2,YY_3D,'LineStyle','none');
  %pp(k).CDataMapping = 'scaled';
  if ~get(handles.checkbox1,'value')
   caxis([Ymin,Ymax]);
  end
  %}
  %shading interp;
  hold (handles.axes1,'on');
  handles.dot(k)=scatter3(handles.axes1,(Xvector(:,ax1)+1)/2,(Xvector(:,ax2)+1)/2,YMD3,'r.');
  guidata(hObject, handles);
  set(handles.bt_scatter,'value',0);
 set(handles.dot(k),'visible','off');
  hold (handles.axes1,'on');
  else 
      set(eval(['handles.bt_',num2str(k)]),'enable','off');
      %handles.fig(k)=[];
      %handles.dot(k)=[];
 end
end



xlabel(handles.axes1, ax1_str, 'FontSize', 10);
ylabel(handles.axes1,ax2_str, 'FontSize', 10);
zlabel(handles.axes1,handles.h.colname(s2), 'FontSize', 10);
xlabel(ax1_str, 'FontSize', 10);
ylabel(ax2_str, 'FontSize', 10);
zlabel(handles.h.colname(s2), 'FontSize', 10);


rotate3d (handles.axes1,'on');

set(handles.text_status,'string','ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;
if get(handles.bt_colorbar,'value')
  colorbar;
end

%set(handles.h.text_status,'string','Ready'); %status
%set(handles.h.text_status,'BackgroundColor','cyan');


% --- Executes on selection change in pop_color.
function pop_color_Callback(hObject, eventdata, handles)
% hObject    handle to pop_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_color

  
  clr_index=get(handles.pop_color,'value');
  colormap(handles.clr(:,:,clr_index));






% --- Executes during object creation, after setting all properties.
function pop_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
 Ymax=max(handles.h.DM(:,end));
 Ymin=min(handles.h.DM(:,end));
if ~get(handles.checkbox1,'value')
   caxis (handles.axes1,'manual');
   caxis([Ymin,Ymax]);
   
else
    caxis (handles.axes1,'auto');
    
end


% --- Executes on button press in bt_colorbar.
function bt_colorbar_Callback(hObject, eventdata, handles)
% hObject    handle to bt_colorbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_colorbar
if get(handles.bt_colorbar,'value')
    colorbar
else
    colorbar('off')
end


% --- Executes on button press in bt_1.
function bt_1_Callback(hObject, eventdata, handles)
% hObject    handle to bt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%if  isempty(findobj('type','figure','name','Plot for training data'))
% scrsz = get(0,'ScreenSize');
% f1 = figure('Position',[scrsz(3)*0.09 scrsz(4)*0.50 scrsz(3)*0.25 scrsz(4)*0.35],'name','Plot for training data','NumberTitle','off');
if get(handles.bt_1,'value')
    alpha(handles.fig(1),1);
   if get(handles.bt_scatter,'value')
     set(handles.dot(1),'visible','on');
   end
else
    alpha(handles.fig(1),0.2);
    set(handles.dot(1),'visible','off');
end

%{
f1=figure;
%c=colorbar;
fnew=copyobj(handles.axes1,f1);
set(fnew,'units','normal');
set(fnew,'position',[0.13 0.13 0.8 0.75]);
%}


% --- Executes on button press in bt_2.
function bt_2_Callback(hObject, eventdata, handles)
% hObject    handle to bt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_2
if get(handles.bt_2,'value')
    alpha(handles.fig(2),1);
    if get(handles.bt_scatter,'value')
     set(handles.dot(2),'visible','on');
   end
else
    alpha(handles.fig(2),0.2);
    set(handles.dot(2),'visible','off');
end

% --- Executes on button press in bt_3.
function bt_3_Callback(hObject, eventdata, handles)
% hObject    handle to bt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_3
if get(handles.bt_3,'value')
    alpha(handles.fig(3),1);
    if get(handles.bt_scatter,'value')
     set(handles.dot(3),'visible','on');
   end
else
    alpha(handles.fig(3),0.2);
    set(handles.dot(3),'visible','off');
end

% --- Executes on button press in bt_4.
function bt_4_Callback(hObject, eventdata, handles)
% hObject    handle to bt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_4
if get(handles.bt_4,'value')
    alpha(handles.fig(4),1);
    if get(handles.bt_scatter,'value')
     set(handles.dot(4),'visible','on');
   end
else
    alpha(handles.fig(4),0.2);
    set(handles.dot(4),'visible','off');
end


% --- Executes on button press in cb_1.
function cb_1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_1


% --- Executes on button press in cb_2.
function cb_2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_2


% --- Executes on button press in cb_3.
function cb_3_Callback(hObject, eventdata, handles)
% hObject    handle to cb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_3


% --- Executes on button press in cb_4.
function cb_4_Callback(hObject, eventdata, handles)
% hObject    handle to cb_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_4


% --- Executes on button press in bt_scatter.
function bt_scatter_Callback(hObject, eventdata, handles)
% hObject    handle to bt_scatter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_scatter
for i=1:4
   if ~isempty (handles.dot(i))
       
    if get(handles.bt_scatter,'value') && get(eval(['handles.bt_',num2str(i)]),'value')
      set(handles.dot(i),'visible','on');
    else
    set(handles.dot(i),'visible','off');
    end
    
   end
end


% --- Executes on button press in bt_plot.
function bt_plot_Callback(hObject, eventdata, handles)
% hObject    handle to bt_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%H1 = findobj(gcf,'type','axes','-not','tag','legend')
f1=figure;
colormap(jet);
d1=copyobj(handles.axes1,f1);
set(d1,'units','normal');
set(d1,'position',[0.13 0.13 0.75 0.75]);
colorbar

% --- Executes on button press in bt_iso.
function bt_iso_Callback(hObject, eventdata, handles)
% hObject    handle to bt_iso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.text_status,'string','isosurface plotting...'); 
set(handles.text_status,'BackgroundColor','red'); %status
drawnow;

grid=str2num(get(handles.edit_grid,'string'));
layer=str2num(get(handles.edit_layer,'string'));

%[c1,c2,c3] = meshgrid(0:1/grid:1,0:1/grid:1,0:1/grid:1);
s2=size(handles.h.DM,2);
ax1=get(handles.pop_x,'value');
ax2=get(handles.pop_y,'value');
ax3=get(handles.pop_z,'value');
ax_str=get(handles.pop_x,'string');
ax1_str=ax_str(ax1);
ax2_str=ax_str(ax2);
ax3_str=ax_str(ax3);
ss=get(handles.uitable1,'data'); %table data

ubx=str2num(get(handles.edit_ubx,'string'))*2-1;
uby=str2num(get(handles.edit_uby,'string'))*2-1;
ubz=str2num(get(handles.edit_ubz,'string'))*2-1;
lbx=str2num(get(handles.edit_lbx,'string'))*2-1;
lby=str2num(get(handles.edit_lby,'string'))*2-1;
lbz=str2num(get(handles.edit_lbz,'string'))*2-1;

[c1,c2,c3] = meshgrid([lbx:(ubx-lbx)/grid:ubx], [lby:(uby-lby)/grid:uby],[lbz:(ubz-lbz)/grid:ubz]);
[cc1,cc2,cc3] = meshgrid([lbx:(ubx-lbx)/100:ubx], [lby:(uby-lby)/100:uby],[lbz:(ubz-lbz)/100:ubz]); %fine grid
default=-1;
   Xvector=ones((grid+1)^3,s2-1)*default;  % X to be used in original svroutput
   for i=1:s2-1
      Xvector(:,i)=ss(i,1)*2-1;  % 0 to 1 --> -1 to 1
   end
  Xvector(:,ax1)=c1(:); 
  Xvector(:,ax2)=c2(:);
  Xvector(:,ax3)=c3(:);
  
 YMD3=p_svr_output(handles.h.DM(:,1:s2-1),Xvector,handles.h.ker,handles.h.para(3:end),handles.h.beta)+handles.h.y0; %prediction in an array
a=handles.h.DM(:,s2);
 Ymax=max(a);
 Ymin=min(a);
 ymax=max(YMD3);
 ymin=min(YMD3);
 
  Y_3D=reshape(YMD3,grid+1,grid+1,grid+1); %prediction in grid matrix
  
   

  YY_3D=interp3(c1,c2,c3,Y_3D,cc1,cc2,cc3,'spline'); %prediction in grid matrix
  iso=figure;
  colormap(jet)
  colorbar
  rotate3d
  view(3)
   caxis manual;
   caxis([Ymin,Ymax]);
   
%# create the isosurface by thresholding at a iso-value of 10
for i=0:1/layer:1
isosurface((cc1+1)/2,(cc2+1)/2,(cc3+1)/2,YY_3D,ymin+(ymax-ymin)*i);
end
alpha 0.6;

xlabel(ax1_str, 'FontSize', 10);
ylabel(ax2_str, 'FontSize', 10);
zlabel(ax3_str, 'FontSize', 10);

set(handles.text_status,'string','ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;

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



function edit_lbz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lbz as text
%        str2double(get(hObject,'String')) returns contents of edit_lbz as a double


% --- Executes during object creation, after setting all properties.
function edit_lbz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lbz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ubz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ubz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ubz as text
%        str2double(get(hObject,'String')) returns contents of edit_ubz as a double


% --- Executes during object creation, after setting all properties.
function edit_ubz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ubz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_layer_Callback(hObject, eventdata, handles)
% hObject    handle to edit_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_layer as text
%        str2double(get(hObject,'String')) returns contents of edit_layer as a double


% --- Executes during object creation, after setting all properties.
function edit_layer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_slice.
function bt_slice_Callback(hObject, eventdata, handles)
% hObject    handle to bt_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'string','3D-slice plotting...'); 
set(handles.text_status,'BackgroundColor','red'); %status
drawnow;

grid=str2num(get(handles.edit_grid,'string'));
layer=str2num(get(handles.edit_layer,'string'));

%[c1,c2,c3] = meshgrid(0:1/grid:1,0:1/grid:1,0:1/grid:1);
s2=size(handles.h.DM,2);
ax1=get(handles.pop_x,'value');
ax2=get(handles.pop_y,'value');
ax3=get(handles.pop_z,'value');
ax_str=get(handles.pop_x,'string');
ax1_str=ax_str(ax1);
ax2_str=ax_str(ax2);
ax3_str=ax_str(ax3);
ss=get(handles.uitable1,'data'); %table data

ubx=str2num(get(handles.edit_ubx,'string'))*2-1;
uby=str2num(get(handles.edit_uby,'string'))*2-1;
ubz=str2num(get(handles.edit_ubz,'string'))*2-1;
lbx=str2num(get(handles.edit_lbx,'string'))*2-1;
lby=str2num(get(handles.edit_lby,'string'))*2-1;
lbz=str2num(get(handles.edit_lbz,'string'))*2-1;

[c1,c2,c3] = meshgrid([lbx:(ubx-lbx)/grid:ubx], [lby:(uby-lby)/grid:uby],[lbz:(ubz-lbz)/grid:ubz]);
[cc1,cc2,cc3] = meshgrid([lbx:(ubx-lbx)/100:ubx], [lby:(uby-lby)/100:uby],[lbz:(ubz-lbz)/100:ubz]); %fine grid
default=-1;
   Xvector=ones((grid+1)^3,s2-1)*default;  % X to be used in original svroutput
   for i=1:s2-1
      Xvector(:,i)=ss(i,1)*2-1;  % 0 to 1 --> -1 to 1
   end
  Xvector(:,ax1)=c1(:); 
  Xvector(:,ax2)=c2(:);
  Xvector(:,ax3)=c3(:);
  
 YMD3=p_svr_output(handles.h.DM(:,1:s2-1),Xvector,handles.h.ker,handles.h.para(3:end),handles.h.beta)+handles.h.y0; %prediction in an array
a=handles.h.DM(:,s2);
Ymax=max(a);
 Ymin=min(a);
 ymax=max(YMD3);
 ymin=min(YMD3);
 
  Y_3D=reshape(YMD3,grid+1,grid+1,grid+1); %prediction in grid matrix
  YY_3D=interp3(c1,c2,c3,Y_3D,cc1,cc2,cc3,'spline'); %prediction in grid matrix
figure;
  slice((cc1+1)/2,(cc2+1)/2,(cc3+1)/2,YY_3D,[],[],[0:1/layer:1]);
set(findobj(gca,'Type','Surface'),'EdgeColor','none')
  colormap(jet)
  colorbar
  rotate3d
  view(3)
   caxis manual;
   caxis([Ymin,Ymax]);
%# create the isosurface by thresholding at a iso-value of 10


xlabel(ax1_str, 'FontSize', 10);
ylabel(ax2_str, 'FontSize', 10);
zlabel(ax3_str, 'FontSize', 10);

set(handles.text_status,'string','ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;


% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat','Load the model file');
M=load(fullfile(pathname, filename));
handles.h=M.b;
guidata(hObject, handles);

s2=size(handles.h.DM,2);
set(handles.uitable1,'RowName',[handles.h.colname(1:s2-1)]);
%set(handles.uitable1,'ColumnName',[{'1st'}, {'2nd'}, {'3rd'}]);
set(handles.uitable1,'data',[ones(s2-1,4)*0]); 

   set(handles.pop_x,'string',handles.h.colname(1:s2-1));
   set(handles.pop_x,'value',1);
   set(handles.pop_y,'string',handles.h.colname(1:s2-1));
   set(handles.pop_y,'value',2);
   set(handles.pop_z,'string',handles.h.colname(1:s2-1));
   set(handles.pop_z,'value',3);
   
  handles.clr(:,:,1)=jet;
  handles.clr(:,:,2)=hsv;
  handles.clr(:,:,3)=hot;
  handles.clr(:,:,4)=cool;
  handles.clr(:,:,5)=spring;
  handles.clr(:,:,6)=summer;
  handles.clr(:,:,7)=autumn;
  handles.clr(:,:,8)=winter;
  handles.clr(:,:,9)=gray;
  handles.fig=zeros(1,4);
  handles.dot=zeros(1,4);
%colorbar;
% Update handles structure
guidata(hObject, handles);
for k=1:4
set(eval(['handles.bt_',num2str(k)]),'enable','off');
end
