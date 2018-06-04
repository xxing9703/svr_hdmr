function varargout = standalone(varargin)
% STANDALONE MATLAB code for standalone.fig
%      STANDALONE, by itself, creates a new STANDALONE or raises the existing
%      singleton*.
%
%      H = STANDALONE returns the handle to a new STANDALONE or the handle to
%      the existing singleton*.
%
%      STANDALONE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STANDALONE.M with the given input arguments.
%
%      STANDALONE('Property','Value',...) creates a new STANDALONE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before standalone_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to standalone_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help standalone

% Last Modified by GUIDE v2.5 13-Oct-2015 22:12:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @standalone_OpeningFcn, ...
                   'gui_OutputFcn',  @standalone_OutputFcn, ...
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


% --- Executes just before standalone is made visible.
function standalone_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to standalone (see VARARGIN)

% Choose default command line output for standalone
handles.output = hObject;
handles.colname='';
handles.D=[];  %total data
handles.D1=[]; %training data
handles.D2=[]; %validating data
handles.D3=[]; %testing data
handles.DM=[]; %modelling data

handles.Y=[]; %predicted output for total data
handles.Y1=[];%predicted output for training data
handles.Y2=[];%predicted output for validating data
handles.Y3=[];%predicted output for testing data

% kernel
%handles.ker='hdmra_rbf'; %kernel name
handles.ker=[]'; %kernel name
handles.para_str=[];  %name of the parameters, Rowname in uitable1
handles.lb=[];  %lower bound for parameters, column 1 in uitable1
handles.ub=[];  %upper bound for parameters, column 2 in uitable1
handles.para=[]; %parameters current value, column 3 in uitable1

handles.beta=[]; %key model coefficients

handles.y0=0;  % mean value of output for training data

set(handles.bt_run,'enable','off');
set(handles.bt_save,'enable','off');
set(handles.bt_load,'enable','on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes standalone wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = standalone_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname]=uigetfile({'*.txt'},'load data');

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
 
end

m2=min(fulldata(:,1:end-1));
if max(m2)>=0
  fulldata(:,1:end-1)=fulldata(:,1:end-1)*2-1;  %[0 1]to [-1 1]
end

handles.D=fulldata;
handles.colname=header';

 guidata(hObject, handles);
 set(handles.bt_run,'enable','on');
 hist(handles.axes1,fulldata(:,end),10);



% --- Executes on button press in bt_run.
function bt_run_Callback(hObject, eventdata, handles)
% hObject    handle to bt_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text1,'string','processing......');
set(handles.bt_run,'enable','off');
set(handles.bt_save,'enable','off');
set(handles.bt_load,'enable','off');

drawnow;
 str=get(handles.popupmenu2,'string')
 ker=str{get(handles.popupmenu2,'value')}
 [s1,s2]=size(handles.D);
 handles.y0=mean(handles.D(:,s2));
 guidata(hObject, handles);
 %ker='hdmra_rbf'
 order=get(handles.popupmenu1,'value');
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
  
    para=paradata(:,3);
  

XXDM=handles.D(:,1:s2-1);
YDM=handles.D(:,s2);

[nsv, beta]=svrsolver(XXDM,YDM-handles.y0,ker,para);
Ypred=svroutput(XXDM,XXDM,ker,para,beta)+handles.y0;  % predict Y of train data 
handles.beta=beta;
handles.Ypred=Ypred;
handles.para=para;
handles.ker=ker;
guidata(hObject, handles);

ymax=max(Ypred);
ymin=min(Ypred);
lb=ymin-(ymax-ymin)*0.1;
ub=ymax+(ymax-ymin)*0.1;
pcent=0;
plot(handles.axes1,YDM,Ypred,'o',[lb,ub],[lb,ub],'r.-',[lb,ub],[lb+pcent*(ub-lb),ub+pcent*(ub-lb)],'b-',[lb,ub],[lb-pcent*(ub-lb),ub-pcent*(ub-lb)],'b-','MarkerFaceColor','r','Markersize',3);
xlabel(handles.axes1,'Experiment data', 'FontSize', 0.1,'FontUnits','normalized');
ylabel(handles.axes1,'Model prediction', 'FontSize', 0.1,'FontUnits','normalized');
xlim(handles.axes1,[lb,ub]);
ylim(handles.axes1,[lb,ub]);
set(handles.text1,'string','Ready');
set(handles.bt_run,'enable','on');
set(handles.bt_save,'enable','on');
set(handles.bt_load,'enable','on');
drawnow;


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b.beta=handles.beta;
 b.para=handles.para;
 b.DM=handles.D;
 b.colname=handles.colname;
 b.y0=handles.y0;
 b.ker=handles.ker;
 b.pred=[handles.Ypred];
 [file,path] = uiputfile({'*.mat'},'save the model');
 save(file,'b');
 


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
