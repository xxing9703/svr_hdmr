function var=costfn(x,handles)
if handles.opt.speed==0  % speedmode?
    flag=1;
else
    flag=0;
end
boot=handles.opt.boot;
div=handles.opt.div;
cost=handles.opt.cost;

para=get(handles.uitable1,'data');
para(:,3)=x;
set(handles.uitable1,'data',para);

D12=[handles.D1;handles.D2];
[s1,s2]=size(D12);

segment=round(s1/div);
var=0;

    
    
if boot==1 && div>1
    for i=1:div
    handles.D1=D12(1:segment*(div-1),:);
    handles.D2=D12(segment*(div-1)+1:s1,:);
    handles.DM=handles.D1;

    [YMD1,YMD2,YMD3,handles]=sub_runonce(handles,[1,1,flag]);
    plotting(handles,[1,1,flag],YMD1,YMD2,YMD3);
 
    drawnow;
    D12=[handles.D2;handles.D1];
    YD1=handles.D1(:,s2);
    YD2=handles.D2(:,s2);
    YD3=handles.D3(:,s2);
    YDD=[YD1;YD2;YD3];
    
    err=-sort(-abs(YMD2-YD2));
    errD2=err(1:round(length(err)*cost));
    RAAE2=mean(errD2)/std(YDD);
    var=var+RAAE2;
    end
    var=var/div;
else
    handles.DM=handles.D1;
    [YMD1,YMD2,YMD3,handles]=sub_runonce(handles,[1,1,flag]);
    plotting(handles,[1,1,flag],YMD1,YMD2,YMD3);
    drawnow;
    YD1=handles.D1(:,s2);
    YD2=handles.D2(:,s2);
    YD3=handles.D3(:,s2);
    YDD=[YD1;YD2;YD3]; 
   
    %errD2=abs(YMD2-YD2);
     err=-sort(-abs(YMD2-YD2));
    errD2=err(1:round(length(err)*cost));
    
    RAAE2=mean(errD2)/std(YDD);
    var=RAAE2;
end

