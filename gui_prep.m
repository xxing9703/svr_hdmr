function varargout = gui_prep(varargin)
% GUI_PREP MATLAB code for gui_prep.fig
%      GUI_PREP, by itself, creates a new GUI_PREP or raises the existing
%      singleton*.
%
%      H = GUI_PREP returns the handle to a new GUI_PREP or the handle to
%      the existing singleton*.
%
%      GUI_PREP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PREP.M with the given input arguments.
%
%      GUI_PREP('Property','Value',...) creates a new GUI_PREP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_prep_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_prep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_prep

% Last Modified by GUIDE v2.5 03-Feb-2016 16:17:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_prep_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_prep_OutputFcn, ...
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


% --- Executes just before gui_prep is made visible.
function gui_prep_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<DEFNU>
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_prep (see VARARGIN)

% Choose default command line output for gui_prep
handles.output = hObject;
handles.deselect=[];
handles.data=[];
% Update handles structure
guidata(hObject, handles);





% --- Outputs from this function are returned to the command line.
function varargout = gui_prep_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
if isempty(get(handles.listbox1,'value'))
  set(handles.listbox1,'value',1);
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2

if isempty(get(handles.listbox2,'value'))
set(handles.listbox2,'value',1);
end


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_xx.
function bt_xx_Callback(hObject, eventdata, handles)
% hObject    handle to bt_xx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
XX = get(handles.listbox1,'string');
if length(XX)<1; uiwait(msgbox('No items selected','hint','modal')); return; end;
XXval=get(handles.listbox1,'value');

XX2 = get(handles.listbox2,'string');
set(handles.listbox2,'String',[XX2;XX(XXval)]) ;
ind=find(ismember(handles.col,XX(XXval)));
handles.val=[handles.val,ind];
guidata(hObject, handles);
XX(XXval)=[];

set(handles.listbox1,'Value',1);
set(handles.listbox1,'string',XX);





% --- Executes on button press in bt_y.
function bt_y_Callback(hObject, eventdata, handles)
% hObject    handle to bt_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Y = get(handles.listbox1,'string');
Yval=get(handles.listbox1,'value');
if length(Yval)>1;uiwait(msgbox('Select a single item for Y','hint','modal')); return; end;
if length(Y)<1; uiwait(msgbox('No item selected','hint','modal'));return; end;
edit=get(handles.edit1,'string');
if isempty(edit)==0;uiwait(msgbox('Y already selected','hint','modal')); return; end;
set(handles.edit1,'string',Y{Yval});
Y(Yval)=[];
set(handles.listbox1,'Value',1);
set(handles.listbox1,'string',Y);


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  tabledata = get(handles.uitable1,'data');
  header = get(handles.uitable1,'ColumnName');
  savehdd(tabledata,header','save data');





% --- Executes on button press in bt_reset.
function bt_reset_Callback(hObject, eventdata, handles)
% hObject    handle to bt_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_reset
set(handles.listbox1,'string',handles.col);
set(handles.listbox2,'string','');
set(handles.edit1,'string','');
set(handles.edit1,'value',1);
handles.val=[];
handles.selected=handles.data;
 Xmax=max(handles.data);
 Xmin=min(handles.data);
 Xavg=mean(handles.data);
 Xstd=std(handles.data);
 set(handles.uitable2,'data',[Xmax;Xmin;Xavg;Xstd]);
 set(handles.uitable1,'data',handles.data);
 set(handles.uitable1,'ColumnName',handles.col);
 set(handles.uitable2,'ColumnName',handles.col);
 set(handles.text_1,'string',size(handles.data,1));
 set(handles.text_2,'string',size(handles.data,2));
guidata(hObject, handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_log.
function bt_log_Callback(hObject, eventdata, handles)
% hObject    handle to bt_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bt_log


% --- Executes on button press in bt_OK.
function bt_OK_Callback(hObject, eventdata, handles)
% hObject    handle to bt_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

yname=get(handles.edit1,'string');
ind=find(ismember(handles.col,yname));
if length(handles.val)<1 uiwait(msgbox('Please select X','hint','modal'));return;end
if isempty(ind) uiwait(msgbox('Please select Y','hint','modal'));return;end
   
cols=[handles.val,ind];
handles.selected=handles.data(:,cols);
guidata(hObject, handles);
 set(handles.uitable1,'ColumnName',handles.col(cols));
 set(handles.uitable1,'data',handles.data(:,cols));
 set(handles.uitable2,'ColumnName',handles.col(cols));
 Xmax=max(handles.data(:,cols));
 Xmin=min(handles.data(:,cols));
 Xavg=mean(handles.data(:,cols));
 Xstd=std(handles.data(:,cols));
 set(handles.uitable2,'data',[Xmax;Xmin;Xavg;Xstd]);
 set(handles.text_1,'string',size(handles.data,1));
 set(handles.text_2,'string',length(cols)-1);
 
 
% --- Executes on button press in cbox1.
function cbox1_Callback(hObject, eventdata, handles)
% hObject    handle to cbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbox1

% --- Executes on button press in cbox2.
function cbox2_Callback(hObject, eventdata, handles)
% hObject    handle to cbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbox2


% --- Executes on button press in cbox3.
function cbox3_Callback(hObject, eventdata, handles)
% hObject    handle to cbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbox3


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
n=get(handles.slider1,'value');
set(handles.cbox3,'string',strcat('*10^',num2str(floor(n))));




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in bt_norm.
function bt_norm_Callback(hObject, eventdata, handles)
% hObject    handle to bt_norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%if isempty(handles.selected)
%  tabledata=get(handles.uitable1,'data');
%else 
%    tabledata=handles.selected;
%end
tabledata=get(handles.uitable1,'data');
handles.selected=tabledata;
guidata(hObject, handles);

  mms=get(handles.uitable2,'data');
  xmax=mms(1,1:size(mms,2)-1);
  xmin=mms(2,1:size(mms,2)-1);
[s1,s2]=size(tabledata);
switch get(get(handles.rbox1,'SelectedObject'),'Tag')
    case 'r1',
        for i=1:s2-1
        xxnorm(:,i)=dnorm(tabledata(:,i),xmin(i),xmax(i),-1,1);
        end
    case 'r2',
        for i=1:s2-1
        xxnorm(:,i)=dnorm(tabledata(:,i),xmin(i),xmax(i),0,1);
        end
    case 'r3',
        for i=1:s2-1
        xxnorm(:,i)=dnorm(tabledata(:,i),xmin(i),xmax(i),0,2*pi);
        end
        
    otherwise,
       for i=1:s2-1
        xxnorm(:,i)=tabledata(:,i);
        end
end

ynorm=tabledata(:,s2);
if get(handles.cbox1,'Value')       
        ynorm=log(abs(ynorm));
end
if get(handles.cbox2,'Value')       
        ynorm=dnorm(ynorm,-1,1);
end
if get(handles.cbox3,'Value')       
    n=get(handles.slider1,'value');    
    ynorm=ynorm*10^floor(n);
end
set(handles.uitable1,'data',[xxnorm, ynorm]);
tabledata=[xxnorm, ynorm];
 Xmax=max(tabledata);
 Xmin=min(tabledata);
 Xavg=mean(tabledata);
 Xstd=std(tabledata);
set(handles.uitable2,'data',[Xmax;Xmin;Xavg;Xstd]);


% --- Executes on button press in bt_restore.
function bt_restore_Callback(hObject, eventdata, handles)
% hObject    handle to bt_restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.uitable1,'data',handles.selected);



% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname]=uigetfile({'*.txt; *.dat'},'File Selector');
if pathname==0
     fulldata=0;
     header='';  
else
set(handles.listbox1,'string','');
set(handles.listbox2,'string',''); 
set(handles.edit1,'string','');
fullname=strcat(pathname,filename);
guidata(hObject, handles);
loaddata=importdata(fullname);

if (class(loaddata)=='struct')  %if column headers are there
   fulldata=loaddata.data;      %get data-> fulldata
   [s1, s2]=size(fulldata);   %s1=rows, s2=cols
   colnames=loaddata.textdata;  %get column headers
else
   fulldata=loaddata;
   [s1, s2]=size(fulldata);
   header = cell(s2,1);   % header stores a row of cells, each contains a string of lable
    for i=1:s2        % if header is lacking assign X1 X2..Xn Y to 
      header{i}=['Col' int2str(i)];
    end
    
   colnames=header';
end
handles.col=colnames;
handles.data=fulldata;
handles.selected=fulldata;
handles.val=[];

set(handles.uitable2,'ColumnEditable',true);
set(handles.slider1, 'SliderStep', [1/20, 4/20]);
%set(0,'defaultuicontrolunits','normalized') ;

Xmax=max(fulldata);
Xmin=min(fulldata);
Xavg=mean(fulldata);
Xstd=std(fulldata);

guidata(hObject, handles);

 set(handles.uitable1,'ColumnName',colnames);
 set(handles.uitable1,'data',fulldata);
 set(handles.uitable2,'ColumnName',colnames);
 set(handles.uitable2,'data',[Xmax;Xmin;Xavg;Xstd]);
 set(handles.listbox1,'string',colnames);
 set(handles.listbox1,'Max',20,'Min',0);
 set(handles.text_1,'string',num2str(s1));
 set(handles.text_2,'string',num2str(s2-1));
end
 
 function output=dnorm(varargin)
%this function normlize a column vector or multiple from range [min,max] to range [ub,lb]
% Xn=dnorm(X,min,max,lb,ub) or Xn=dnorm(X,lb,ub)
if (nargin==3) 
    X=varargin{1};
    lb=varargin{2};ub=varargin{3};
    vmin=min(X); vmax=max(X);
  
elseif (nargin==5)
    X=varargin{1};
    lb=varargin{4};ub=varargin{5};
    vmin=varargin{2};vmax=varargin{3};
else
    help dnorm;  
    return
end

[s1,s2]=size(X);
 b=(ub*vmin-lb*vmax)/(vmax-vmin);
 a=(ub-lb)/(vmax-vmin);
 output=a*X-b;

 function savehdd(D,colname,title)
[file,path] = uiputfile({'*.hdd'},title);
if path==0
    return; 
else
 filename=fullfile(path,file);
  tabledata = D;
  fid=fopen(filename,'wt');
  
for i=1:size(colname,2)
      fprintf(fid,'%s\t',colname{i});
end
  fprintf(fid,'\r\n');
for i=1:size(tabledata,1)
  for j=1:size(tabledata,2)
   fprintf(fid,'%3.4f\t',tabledata(i,j));   
  end
  fprintf(fid,'\r\n');
end
fclose(fid);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in bt_split.
function bt_split_Callback(hObject, eventdata, handles)
% hObject    handle to bt_split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  D = get(handles.uitable1,'data');
  header = get(handles.uitable1,'ColumnName');
  [s1,s2]=size(D);
  ind=randperm(s1);
  
  prompt = {'Enter options(1:percentage, 2: absolute)','Enter 1st dataset:','Enter 2nd set:'};
  dlg_title = 'Input';
  num_lines = 1;
  defaultans = {'1','70','30'};
  
  answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
  
  option=str2num(answer{1});
  d1=str2num(answer{2});
  d2=str2num(answer{3});
  
  if option==1
    d1=floor(s1*d1/100);
    d2=floor(s1*d2/100);
  end
  
  Da=D(ind(1:d1),:);
  Db=D(ind(d1+1:d1+d2),:);

  savehdd(Da,header','save dataset 1');
  savehdd(Db,header','save dataset 2');
  


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.deselect=eventdata.Indices;
guidata(hObject, handles);


% --- Executes on button press in bt_delete.
function bt_delete_Callback(hObject, eventdata, handles)
% hObject    handle to bt_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.deselect)
D=get(handles.uitable1,'data');
ind=handles.deselect(:,1);
D(ind,:)=[];
set(handles.uitable1,'data',D);
 Xmax=max(D);
Xmin=min(D);
Xavg=mean(D);
Xstd=std(D);
 set(handles.uitable2,'data',[Xmax;Xmin;Xavg;Xstd]);
 set(handles.text_1,'string',size(D,1));
end
