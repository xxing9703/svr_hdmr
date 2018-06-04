function varargout = SVR_HDMR_main(varargin)
% SVR_HDMR_MAIN MATLAB code for SVR_HDMR_main.fig
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
%      applied to the GUI before SVR_HDMR_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SVR_HDMR_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SVR_HDMR_main

% Last Modified by GUIDE v2.5 14-Oct-2016 13:28:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SVR_HDMR_main_OpeningFcn, ...
                   'gui_OutputFcn',  @SVR_HDMR_main_OutputFcn, ...
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
%%%%%%%%%%%%%%%%%% End initialization code - DO NOT EDIT


function handles=init(hObject, handles)
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
handles.ker='hdmra_rbf'; %kernel name
handles.para_str=[];  %name of the parameters, Rowname in uitable1
handles.lb=[];  %lower bound for parameters, column 1 in uitable1
handles.ub=[];  %upper bound for parameters, column 2 in uitable1
handles.para=[]; %parameters current value, column 3 in uitable1

handles.beta=[]; %key model coefficients

handles.fontsz=15; % font size
handles.marksz=5;  % marker size
handles.opt=struct('pop',20,'gen',20,'stall',10,'time',100000,'speed',0,'plot',[1,1],'cost',1,'boot',0,'div',5); % optimization para
handles.opt2=struct('pop',20,'gen',20,'stall',10,'time',100000);% model search opt para

handles.y0=0;  % mean value of output for training data
 set(handles.text_to,'string',strcat('Loaded:  ','0'));
 set(handles.text_tr,'string',strcat('Train:  ','0'));
 set(handles.text_va,'string',strcat('Valid:  ','0'));
 set(handles.text_te,'string',strcat('Test:  ','0'));
 %set(handles.uitable1,'visible','off'); 
 cla(handles.axes1);
 cla(handles.axes2);
 cla(handles.axes3);
 I=imread('logo3.jpg');
 axes(handles.axes4);
 imshow(I);
 handles.b=[];  % saved model
guidata(hObject, handles);

% --- Executes on button press in bt_reset.
function bt_reset_Callback(hObject, eventdata, handles)
% hObject    handle to bt_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=init(hObject, handles);

% --- Executes just before SVR_HDMR_main is made visible.
function SVR_HDMR_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SVR_HDMR_main (see VARARGIN)

% Choose default command line output for SVR_HDMR_main

%handles.output = hObject;
%%%%% initialize globle variable, can be retrieved by "handles.varname"


set(handles.uitable1,'ColumnEditable',true);
%locate the main window
scrsz = get(0,'ScreenSize');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'normalized');
set(gcf, 'PaperPosition', [scrsz(3)*0.1 scrsz(4)*0.1 scrsz(3)*0.75 scrsz(4)*0.75]);

%display logo.
H=imread('logo1.jpg');
axes(handles.axeslogo);
imshow(H);
 


%display button pics.
rt=40;
pic_button(handles.bt_prep,'bt_prep.jpg',rt);
pic_button(handles.bt_reset,'bt_reset.jpg',rt);
pic_button(handles.bt_shuf,'bt_shuffle.jpg',rt);
pic_button(handles.bt_surf,'bt_surf.jpg',rt);
pic_button(handles.bt_search,'bt_search.jpg',rt);
pic_button(handles.bt_view,'bt_view.jpg',rt);
pic_button(handles.bt_exit,'bt_close.jpg',rt);
pic_button(handles.bt_open,'bt_load.jpg',rt);
pic_button(handles.bt_hdmr,'bt_run.jpg',rt);
pic_button(handles.bt_optimize,'bt_dbrun.jpg',rt);
pic_button(handles.bt_kernel,'bt_kernel.jpg',rt);
pic_button(handles.bt_sens,'bt_sens.jpg',rt);
pic_button(handles.bt_error,'bt_stat.jpg',rt);
pic_button(handles.bt_savemd,'bt_savemd.jpg',rt);
pic_button(handles.bt_savehdd,'bt_savehdd.jpg',rt);
pic_button(handles.bt_option,'bt_tool.jpg',rt);

p=gcp('nocreate');
if isempty(p)
    set(handles.Pool,'string','N')
else
    set(handles.Pool,'string',num2str(p.NumWorkers));
end
% Update handles structure
guidata(hObject, handles);
handles=init(hObject,handles);

% UIWAIT makes SVR_HDMR_main wait for user response (see UIRESUME)
 %uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SVR_HDMR_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
%close all;


% --- Executes on button press in bt_pre.
function bt_pre_Callback(hObject, eventdata, handles)
% hObject    handle to bt_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[tabledata,colname]=proc_data;
 
 set(handles.text_to,'string',strcat('Loaded: ',num2str(size(tabledata,1))));
 handles.D=tabledata;
 handles.colname=colname;
 
guidata(hObject, handles);


% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[D,D1,D2,D3,colname]=gui_load(handles.D,handles.D1,handles.D2,handles.D3,handles.colname);
assignin('base', 'D',D);
assignin('base', 'D1',D1);
assignin('base', 'D2',D2);
assignin('base', 'D3',D3);
assignin('base', 'colname',colname);
handles.D=D;
handles.D1=D1;
handles.D2=D2;
handles.D3=D3;
handles.DM=[D1;D2];
handles.colname=colname;

guidata(hObject, handles);
 [s1,s2]=size(D);
 handles.y0=mean(handles.DM(:,s2)); %%%  find offset of y.  ----------f0
 guidata(hObject, handles);
 
   set(handles.text_to,'string',strcat('Loaded: ',num2str(size(D,1))));     
   set(handles.pop_x,'enable','on');
   set(handles.pop_x,'string',colname(1:s2));
   set(handles.pop_x,'value',1);
   set(handles.pop_y,'enable','on');
   set(handles.pop_y,'string',colname(1:s2));
   set(handles.pop_y,'value',2);
 set(handles.text_tr,'string',strcat('Train:  ',num2str(size(D1,1))));
 set(handles.text_va,'string',strcat('Valid:  ',num2str(size(D2,1))));
 set(handles.text_te,'string',strcat('Test:  ',num2str(size(D3,1))));
 
 hist(handles.axes1,D1(:,s2));
 hist(handles.axes2,D2(:,s2));
 hist(handles.axes3,D3(:,s2));
 xlabel(handles.axes1,'Training data', 'FontSize', 0.1,'FontUnits','normalized');
 xlabel(handles.axes2,'Validating data', 'FontSize', 0.1,'FontUnits','normalized');
 xlabel(handles.axes3,'Testing data', 'FontSize', 0.1,'FontUnits','normalized');
   set(handles.pop_d,'enable','on');
   set(handles.pop_x,'value',1);
   plotdist(handles);
   
   if isempty(handles.para)
   %set the default kernel: hdmra_rbf and the default parameters
    set(handles.uitable1,'visible','on'); 
   order=3; %defalt max order
   if s2<3
       order=s2;
   end
   bd_C=[1,50,20];
   bd_e=[0,0.1,0.05];
   bd_p=[-1,1,0];
   bd_s=[0,2,1];
   for i=1:s2-1
     a(i)={['P' num2str(i)]};  %parameter lables 'P1' 'P2'...
   end
    for i=1:order
    s(i)={['S' num2str(i)]};  %parameter lables 'S1' 'S2'...
    end 
    para_str=[{'Cval'},{'Loss'},a,s]; %complete list of parameter lables 
      pdata=repmat(bd_p,s2-1,1); % [lb,ub,current] parameters of Pi
      sdata=repmat(bd_s,order,1);  % [lb,ub,current] parameters of Si
    paradata=[bd_C;bd_e;pdata;sdata]; %complete list of parameter settings
    
    handles.ker='hdmra_rbf';
    handles.lb=paradata(:,1);
    handles.ub=paradata(:,2);
    handles.para=paradata(:,3);
    handles.para_str=para_str;
    guidata(hObject, handles);
   
    
    
    set(handles.uitable1,'RowName',handles.para_str);  %write to uitable3
    set(handles.uitable1,'ColumnName',[{'lower bound'}, {'upper bound'}, {'current value'}]);
    set(handles.uitable1,'data',[handles.lb,handles.ub,handles.para]);
    set(handles.text_ker,'string',handles.ker);
    end


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_save(handles);
%if ~isempty(handles.D1)
% savehdd(handles.D1,handles.colname,'save training data');
%end
%if ~isempty(handles.D2)
%savehdd(handles.D2,handles.colname,'save validating data');
%end


 


% --- Executes on button press in bt_ker.
function bt_ker_Callback(hObject, eventdata, handles)
% hObject    handle to bt_ker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ker,paradata,para_str]=gui_ker(handles);
handles.ker=ker;
handles.lb=paradata(:,1);
handles.ub=paradata(:,2);
handles.para=paradata(:,3);
handles.para_str=para_str;
guidata(hObject, handles);
if ~isempty(handles.para)
 set(handles.uitable1,'visible','on'); 
end
set(handles.uitable1,'RowName',handles.para_str);  %write to uitable3
set(handles.uitable1,'ColumnName',[{'lower bound'}, {'upper bound'}, {'current value'}]);
set(handles.uitable1,'data',[handles.lb,handles.ub,handles.para]);
set(handles.text_ker,'string',lower(ker));



% --- Executes on button press in bt_run.
function bt_run_Callback(hObject, eventdata, handles)
% hObject    handle to bt_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  paradata=get(handles.uitable1,'data');
  para=paradata(:,3);
  handles.para=para;
  guidata(hObject, handles);
  handles.DM=[handles.D1;handles.D2];
  
  [YMD1,YMD2,YMD3,handles]=sub_runonce(handles,[1,1,1]);
  
  assignin('base', 'beta',handles.beta);
  assignin('base', 'paradata',paradata);
  assignin('base', 'b',handles.b);
  plotting(handles,[1,1,1],YMD1,YMD2,YMD3);
  handles.Y1=YMD1;
  handles.Y2=YMD2;
  handles.Y3=YMD3;
  handles.Y=[YMD1; YMD2; YMD3];
  set(handles.checkbox2,'Enable','on');
  
  assignin('base', 'Y1',YMD1);
  assignin('base', 'Y2',YMD2);
  assignin('base', 'Y3',YMD3);
  assignin('base', 'Y3',YMD3);
  assignin('base', 'Y',handles.D3(:,end));
guidata(hObject, handles);
   

% --- Executes on button press in bt_opt.
function bt_opt_Callback(hObject, eventdata, handles)
% hObject    handle to bt_opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.opt=gui_opt(gcf,handles.opt);
paradata=get(handles.uitable1,'data');
handles.lb=paradata(:,1);
handles.ub=paradata(:,2);
handles.para=paradata(:,3);
guidata(hObject, handles);
button=questdlg('Proceed with optimization?','Question','Yes','No','Yes');

if strcmp(button,'Yes')
[para,Y]=optimizeGA(handles);

paradata=get(handles.uitable1,'data');
paradata(:,3)=para';
set(handles.uitable1,'data',paradata);

guidata(hObject, handles);

handles.DM=[handles.D1;handles.D2];
bt_run_Callback(hObject, eventdata, handles);

end


% --- Executes on button press in bt_sensi.
function bt_sensi_Callback(hObject, eventdata, handles)
% hObject    handle to bt_sensi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%{
set(handles.text_status,'string','Sensitivity analy...'); 
set(handles.text_status,'BackgroundColor','red'); %status
drawnow;
s2=size(handles.D1,2);
XXD1=handles.D1(:,1:s2-1);
XXD2=handles.D2(:,1:s2-1);
XXD3=handles.D3(:,1:s2-1);
XXDM=[XXD1;XXD2];
YD1=handles.D1(:,s2);
YD2=handles.D2(:,s2);
YD3=handles.D3(:,s2);

YDM=[YD1;YD2]; %modeling data outputY

XXDD=[XXD1;XXD2;XXD3];
YDD=[YD1;YD2;YD3];
XXDD=XXDM;
YDD=YDM;
s1=size(XXDD,1);
YD1=handles.D1(:,s2);
YD2=handles.D2(:,s2);
YD3=handles.D3(:,s2);
y0=handles.y0;

if isempty(handles.beta)
[nsv, beta]=svrsolver(XXDM,YDM-y0,handles.ker,handles.para);
handles.beta=beta;
guidata(hObject, handles);
end
YMDD=svroutput(XXDM,XXDD,handles.ker,handles.para,handles.beta)+y0;  % predict Y of train data  

s2=s2-1;
S=zeros(s2);Sa=zeros(s2);Sb=zeros(s2);Yff=zeros(s1,s2,s2);
%outY=[YDD,YMDD,y0*ones(size(YDD,1),1)];
outY=[YDD,YMDD,YMDD-YDD];

Yff=svroutput(XXDM,XXDD,handles.ker,handles.para,handles.beta,s2);

for i=1:s2
    for j=(i-1):s2
          if (j>0) 
            S(i,j)=mean((YDD-y0).*Yff(:,i,j))/mean((YDD-y0).*(YDD-y0));
            Sa(i,j)=mean(Yff(:,i,j).*Yff(:,i,j))/mean((YDD-y0).*(YDD-y0));
          end    
    end
end
Sb=S-Sa;

idx=1:s2;
tb1=[idx',diag(Sa),diag(Sb),diag(S)];
[Y,ind]=sort(-abs(tb1(:,2)));
table1=tb1(ind,:);
%table1=-sortrows(-tb1,4);

k=1;
 for i=1:s2
    for j=(i+1):s2
        tb2(k,:)=[i,j,Sa(i,j),Sb(i,j),S(i,j)];
        k=k+1;
    end
 end
[Y,ind]=sort(-abs(tb2(:,3)));
table2=tb2(ind,:);
%table2=-sortrows(-tb2,5);

for i=1:s2
         if i==1
           tb3(i,:)=[i,sum(diag(Sa)),sum(diag(Sb)),sum(diag(S))];
         elseif i==2
             sa2=sum(sum(triu(Sa,1)));
             sb2=sum(sum(triu(Sb,1)));
            tb3(i,:)=[i,sa2,sb2,S(i,i-1)];  
         else    
           tb3(i,:)=[i,0,0,S(i,i-1)];
         end
end
 sum_s=sum(sum(S))-S(2,1);
 tb3(s2+1,:)=[0,0,0,sum_s];
table3=tb3;

  scrsz = get(0,'ScreenSize');
  ftbs = figure('Position',[scrsz(3)*0.1 scrsz(4)*0.7 scrsz(3)*0.75 scrsz(4)/4],'name','Sensitivity Analysis','NumberTitle','off');
  htable1= uitable('units','normalized','Position',[0,0,0.3,1]);
  set(htable1,'data',table1);
  set(htable1,'ColumnName',[{'order'},{'Sa'},{'Sb'},{'S'}]);
  
  htable2= uitable('units','normalized','Position',[0.3,0,0.4,1] );
  set(htable2,'data',table2);
  set(htable2,'ColumnName',[{'index1'},{'index2'},{'Sa'},{'Sb'},{'S'}]);
  
  htable3= uitable('units','normalized','Position',[0.7,0,0.3,1]);
  set(htable3,'data',table3);
  set(htable3,'ColumnName',[{'order'},{'Sa'},{'Sb'},{'S'}]);
  
  assignin('base', 'table1',table1);
  assignin('base', 'table2',table2);
  assignin('base', 'table3',table3);
  

f1=figure('Position',[scrsz(3)/8 scrsz(4)*0.15 scrsz(3)/3 scrsz(4)/2],'name','1st order component function','NumberTitle','off');
np=size(table1,1);
if np>9 
    np=9;
end
a=round(sqrt(np));
b=ceil(np/a);
%-------------find ylimit
i=table1(1,1);
YY=Yff(:,i,i);
ylimit=max(abs(min(YY)), abs(max(YY)))*1.1;
%------------------------
for n=1:np 
subplot(a,b,n)
i=table1(n,1);
 XX=XXDD(:,i);
 YY=Yff(:,i,i);
 T=sortrows([XX,YY],1);
 T=unique(T,'rows');
 XX=T(:,1);YY=T(:,2);
 x=[min(XX):(max(XX)-min(XX))/100:max(XX)];
 y=interp1(XX',YY',x,'spline');
 plot(x,y,[min(XX),max(XX)],[0,0]);
 xlabel(strcat('X',num2str(i)));
 ylabel(strcat('f(x',num2str(i),')'));
 %title(strcat('X',num2str(i)));
 ylim([-ylimit,ylimit]);
 
 
end

f2=figure('Position',[scrsz(3)/2 scrsz(4)*0.15 scrsz(3)/3 scrsz(4)/2],'name','2nd order component function','NumberTitle','off');


np=size(table2,1);
if np>9 
    np=9;
end
a=round(sqrt(np));
b=ceil(np/a);
%-------------find ylimit
i=table2(1,1);j=table2(1,2);
z=Yff(:,i,j);
zlimit=max(abs(min(z)), abs(max(z)))*1.1;
%------------------------

for n=1:np 
subplot(a,b,n) %------------------subplot
 i=table2(n,1);j=table2(n,2);
 x=XXDD(:,i);
 y=XXDD(:,j);
 z=Yff(:,i,j);
 tri = delaunay(x,y);
 h = trisurf(tri, x, y, z);
 xlabel(strcat('x',num2str(i)),'FontSize', 0.05,'FontUnits','normalized');
 ylabel(strcat('x',num2str(j)),'FontSize', 0.05,'FontUnits','normalized');
 zlabel(strcat('f(x',num2str(i),',x',num2str(j),')'),'FontSize', 0.05,'FontUnits','normalized');
 zlim([-zlimit,zlimit]);
axis vis3d
shading interp
%colorbar EastOutside

end

set(handles.text_status,'string','ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;

%}
if ~isempty(handles.b)
  gui_sens(handles.b);
else
    gui_sens();
end


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


% --- Executes on button press in bt_stat.
function bt_stat_Callback(hObject, eventdata, handles)
% hObject    handle to bt_stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_tr.
 scrsz = get(0,'ScreenSize');
D12=[handles.D1; handles.D2];
D3=handles.D3;
handles.DM=handles.D1;
guidata(hObject, handles);
answer = inputdlg('input the number of iterations');
repeat=str2num(cell2mat(answer));
YMDD=zeros(size(D12,1),repeat);
YMDT=zeros(size(D3,1),repeat);
[s1,s2]=size(D12);
YDD=D12(:,s2);
YDT=D3(:,s2);
idx=1:s1;

for i=1:repeat
 [YMD1,YMD2,YMD3]=runonce(handles,[1,1,1]);
 plotting(handles,[1,1,1],YMD1,YMD2,YMD3);
 YDD=YDD(idx);
 YMDT(:,i)=YMD3;
 YMDD(:,i)=[YMD1;YMD2];
  if i>1
  for j=1:i-1
   YMDD(:,j)=YMDD(idx,j);
  end
  end
  
%[D1,D2,idx]=redist(D12,size(handles.D1,1),size(handles.D2,1),'rand');
[D1,D2,idx]=redist(D12,size(handles.D1,1),size(handles.D2,1),'rand');
handles.D1=D1;handles.D2=D2;handles.DM=D1;
guidata(hObject, handles);
 D12=[D1; D2];
 
end

YMDDave=mean(YMDD'); 
YMDDstd=std(YMDD');
outY=[YDD,YMDDave',YMDDstd'];


handles.DM=D12;
guidata(hObject, handles);
[YMD1,YMD2,YMD3]=runonce(handles,[0,0,1]);
%outY=[YDD,YMDD];
f1=figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/3 scrsz(4)*0.4],'name','Modelling Statistics','NumberTitle','off');
errorbar(YDD,YMDDave,YMDDstd,YMDDstd,'bo','MarkerSize',handles.marksz,'MarkerFaceColor','r');
hold on;
d=[YDD;YDT];
lb=min(d)-(max(d)-min(d))*0.1;
ub=max(d)+(max(d)-min(d))*0.1;
plot([lb ub],[lb ub],'r');
xlim([lb,ub]);
ylim([lb,ub]);

YMDTave=mean(YMDT'); 
YMDTstd=std(YMDT');
outY2=[YDT,YMDTave',YMDTstd'];
f2=figure('Position',[scrsz(3)/2 scrsz(4)/6 scrsz(3)/3 scrsz(4)*0.4],'name','Testing Statistics','NumberTitle','off');
errorbar(YDT,YMDTave,YMDTstd,YMDTstd,'bo','MarkerSize',handles.marksz,'MarkerFaceColor','r');
hold on;
plot([lb ub],[lb ub],'r');
xlim([lb,ub]);
ylim([lb,ub]);
%{
 f3 = figure('Position',[scrsz(3)/6 scrsz(4)/2 scrsz(3)/6 scrsz(4)/3],'name','Statistics table','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',outY);
 f4 = figure('Position',[scrsz(3)/6 scrsz(4)/6 scrsz(3)/6 scrsz(4)/3],'name','Statistics table','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',outY2);
%}

function text_tr_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D1)
    hh=findobj('type','figure','name','Training data');
    if isempty(hh)  
 scrsz = get(0,'ScreenSize');
 f1 = figure('Position',[scrsz(3)*0.01 scrsz(4)*0.5 scrsz(3)*0.2 scrsz(4)*0.2],'name','Training data','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',handles.D1);
    end
    else
    figure(hh);
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_va.
function text_va_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_va (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D2)
    hh=findobj('type','figure','name','Validating data');
    if isempty(hh)  
 scrsz = get(0,'ScreenSize');
 f2 = figure('Position',[scrsz(3)*0.01 scrsz(4)*0.3 scrsz(3)*0.2 scrsz(4)*0.2],'name','Validating data','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',handles.D2);
    end
    else
    figure(hh);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_te.
function text_te_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_te (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D3) 
    hh=findobj('type','figure','name','Testing data');
    if isempty(hh)  
 scrsz = get(0,'ScreenSize');
 f3 = figure('Position',[scrsz(3)*0.01 scrsz(4)*0.1 scrsz(3)*0.2 scrsz(4)*0.2],'name','Testing data','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',handles.D3);
    end
    else
    figure(hh);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_to.
function text_to_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_to (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D) 
     hh=findobj('type','figure','name','Loaded data');
    if isempty(hh) 
 scrsz = get(0,'ScreenSize');
 f3 = figure('Position',[scrsz(3)*0.01 scrsz(4)*0.7 scrsz(3)*0.2 scrsz(4)*0.2],'name','Loaded data','NumberTitle','off');
 htable= uitable('units','normalized','Position',[0,0,1,1]);
 set(htable,'data',handles.D);
    end
else
    figure(hh);
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_zoom1.
function text_zoom1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_zoom1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  isempty(findobj('type','figure','name','Plot for training data'))
 scrsz = get(0,'ScreenSize');
 f1 = figure('Position',[scrsz(3)*0.09 scrsz(4)*0.50 scrsz(3)*0.25 scrsz(4)*0.35],'name','Plot for training data','NumberTitle','off');
fnew=copyobj(handles.axes1,f1);
set(fnew,'units','normal');
set(fnew,'position',[0.13 0.13 0.8 0.75]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_zoom2.
function text_zoom2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_zoom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  isempty(findobj('type','figure','name','Plot for validating data'))
scrsz = get(0,'ScreenSize');
 f1 = figure('Position',[scrsz(3)*0.35 scrsz(4)*0.50 scrsz(3)*0.25 scrsz(4)*0.35],'name','Plot for validating data','NumberTitle','off');
fnew=copyobj(handles.axes2,f1);
set(fnew,'units','normal');
set(fnew,'position',[0.13 0.13 0.8 0.75]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text_zoom3.
function text_zoom3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text_zoom3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  isempty(findobj('type','figure','name','Plot for testing data'))
scrsz = get(0,'ScreenSize');
 f1 = figure('Position',[scrsz(3)*0.61 scrsz(4)*0.50 scrsz(3)*0.25 scrsz(4)*0.35],'name','Plot for testing data','NumberTitle','off');
fnew=copyobj(handles.axes3,f1);
set(fnew,'units','normal');
set(fnew,'position',[0.13 0.13 0.8 0.75]);
end


% --- Executes on button press in bt_train.
function bt_train_Callback(hObject, eventdata, handles)
% hObject    handle to bt_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_valid.
function bt_valid_Callback(hObject, eventdata, handles)
% hObject    handle to bt_valid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in pop_x.
function pop_x_Callback(hObject, eventdata, handles)
% hObject    handle to pop_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_x contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_x
plotdist(handles);


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
plotdist(handles);


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


% --- Executes on selection change in pop_d.
function pop_d_Callback(hObject, eventdata, handles)
% hObject    handle to pop_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_d contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_d
plotdist(handles);


% --- Executes during object creation, after setting all properties.
function pop_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_3d.
function check_3d_Callback(hObject, eventdata, handles)
% hObject    handle to check_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_3d
plotdist(handles);
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
plotdist(handles);


% --- Executes on button press in bt_savepara.
function bt_savepara_Callback(hObject, eventdata, handles)
% hObject    handle to bt_savepara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile({'*.txt';'*.dat'},'Save optimization parameters');
if path==0, 
    return;
else
filename=fullfile(path,file);
ff=get(handles.uitable1,'data')
dlmwrite(filename,get(handles.uitable1,'data'),'delimiter','\t','newline','pc');
end

% --- Executes on button press in bt_loadpara.
function bt_loadpara_Callback(hObject, eventdata, handles)
% hObject    handle to bt_loadpara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile({'*.txt; *.dat'},'File Selector');
fullname=strcat(pathname,filename);
if pathname==0, 
    return;
else
loaddata=importdata(fullname);
set(handles.uitable1,'data',loaddata);
end


% --------------------------------------------------------------------
function mn_about_Callback(hObject, eventdata, handles)
% hObject    handle to mn_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_about;


% --------------------------------------------------------------------
function mn_sens_Callback(hObject, eventdata, handles)
% hObject    handle to mn_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_sensi_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_stat_Callback(hObject, eventdata, handles)
% hObject    handle to mn_stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_stat_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function mn_kernel_Callback(hObject, eventdata, handles)
% hObject    handle to mn_kernel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_ker_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_run_Callback(hObject, eventdata, handles)
% hObject    handle to mn_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_run_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_opt_Callback(hObject, eventdata, handles)
% hObject    handle to mn_opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_opt_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_prep_Callback(hObject, eventdata, handles)
% hObject    handle to mn_prep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_pre_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_load_Callback(hObject, eventdata, handles)
% hObject    handle to mn_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_load_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_save_Callback(hObject, eventdata, handles)
% hObject    handle to mn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_save_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mn_exit_Callback(hObject, ~, handles)
% hObject    handle to mn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 close all


% --- Executes on button press in bt_surf.
function bt_surf_Callback(hObject, eventdata, handles)
% hObject    handle to bt_surf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.b)
  gui_surf(handles.b);
else
   gui_surf();
end



% --- Executes on button press in bt_search.
function bt_search_Callback(hObject, eventdata, handles)
% hObject    handle to bt_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.b)
 gui_search(handles.b);
else    
  gui_search();
end


% --- Executes on button press in bt_shuf.
function bt_shuf_Callback(hObject, eventdata, handles)
% hObject    handle to bt_shuf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
ss=size(handles.D,1);
s1=size(handles.D1,1);
s2=size(handles.D2,1);
s3=size(handles.D3,1);

idx=randperm(ss);
idx1=idx(1:s1);
idx2=idx(s1+1:s1+s2);
idx3=idx(s1+s2+1:s1+s2+s3);
 
handles.D1=handles.D(idx1,:);
handles.D2=handles.D(idx2,:);
handles.D3=handles.D(idx3,:);
guidata(hObject, handles);
plotdist(handles);

last=size(handles.D,2);
 hist(handles.axes1,handles.D1(:,last));
 hist(handles.axes2,handles.D2(:,last));
 hist(handles.axes3,handles.D3(:,last));
else
    msgbox('Please load data first!','Alert');
end


% --- Executes on button press in bt_exit.
function bt_exit_Callback(hObject, eventdata, handles)
% hObject    handle to bt_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in bt_open.
function bt_open_Callback(hObject, eventdata, handles)
% hObject    handle to bt_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bt_load_Callback(hObject, eventdata, handles)


% --- Executes on button press in bt_hdmr.
function bt_hdmr_Callback(hObject, eventdata, handles)
% hObject    handle to bt_hdmr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
 bt_run_Callback(hObject, eventdata, handles)
else
    msgbox('Please load data first!','Alert');
end

    


% --- Executes on button press in bt_optimize.
function bt_optimize_Callback(hObject, eventdata, handles)
% hObject    handle to bt_optimize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
 bt_opt_Callback(hObject, eventdata, handles)
else
    msgbox('Please load data first!','Alert');
end



% --- Executes on button press in bt_kernel.
function bt_kernel_Callback(hObject, eventdata, handles)
% hObject    handle to bt_kernel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
 bt_ker_Callback(hObject, eventdata, handles)
else
    msgbox('Please load data first!','Alert');
end


% --- Executes on button press in bt_sens.
function bt_sens_Callback(hObject, eventdata, handles)
% hObject    handle to bt_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 bt_sensi_Callback(hObject, eventdata, handles)



% --- Executes on button press in bt_error.
function bt_error_Callback(hObject, eventdata, handles)
% hObject    handle to bt_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
 bt_stat_Callback(hObject, eventdata, handles)
else
    msgbox('Please load data first!','Alert');
end


% --- Executes on button press in bt_savemd.
function bt_savemd_Callback(hObject, eventdata, handles)
% hObject    handle to bt_savemd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b=handles.b;
 [file,path] = uiputfile({'*.mat'},'save the model');
 save(fullfile(path,file),'b');
 handles.b=b;
 guidata(hObject, handles);
  set(handles.text_status,'string','Ready'); %status
     set(handles.text_status,'BackgroundColor','cyan'); %status
     drawnow;



% --- Executes on button press in bt_savehdd.
function bt_savehdd_Callback(hObject, eventdata, handles)
% hObject    handle to bt_savehdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.D)
    bt_save_Callback(hObject, eventdata, handles);
else
    msgbox('No model constructed!','Alert');
end



% --- Executes on button press in bt_option.
function bt_option_Callback(hObject, eventdata, handles)
% hObject    handle to bt_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_view.
function bt_view_Callback(hObject, eventdata, handles)
% hObject    handle to bt_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.b)
 gui_view(handles.b);
else    
    gui_view();
end


% --- Executes on button press in bt_prep.
function bt_prep_Callback(hObject, eventdata, handles)
% hObject    handle to bt_prep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_prep();


% --- Executes on button press in Pool.
function Pool_Callback(hObject, eventdata, handles)
% hObject    handle to Pool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Pool
p = gcp('nocreate'); % If no pool, do not create new one.
if isempty(p)
    poolsize = 0;
    set(handles.Pool,'string','...')
    drawnow();
    parpool; 
    p = gcp('nocreate');
    set(handles.Pool,'string',num2str(p.NumWorkers))
else
    poolsize = p.NumWorkers;
    set(handles.Pool,'string','...')
    delete(gcp);
    set(handles.Pool,'string','N')
end


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
