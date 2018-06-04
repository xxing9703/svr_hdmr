function plotting(handles,option,YMD1,YMD2,YMD3)
pcent=0.00;
[s1,s2]=size(handles.D1);
YD1=handles.D1(:,s2);
YD2=handles.D2(:,s2);
YD3=handles.D3(:,s2);
YDD=[YD1;YD2;YD3];
errD1=abs(YMD1-YD1);
RAAE1=mean(errD1)/std(YDD);

errD2=abs(YMD2-YD2);
RAAE2=mean(errD2)/std(YDD);

errD3=abs(YMD3-YD3);
RAAE3=mean(errD3)/std(YDD);

ymax=max([YD1; YD2; YD3]);
ymin=min([YD1; YD2; YD3]);
lb=ymin-(ymax-ymin)*0.1;
ub=ymax+(ymax-ymin)*0.1;

if option(1)==1
plot(handles.axes1,YD1,YMD1,'o',[lb,ub],[lb,ub],'r.-',[lb,ub],[lb+pcent*(ub-lb),ub+pcent*(ub-lb)],'b-',[lb,ub],[lb-pcent*(ub-lb),ub-pcent*(ub-lb)],'b-','MarkerFaceColor','r','Markersize',handles.marksz);

xlabel(handles.axes1,'Training data', 'FontSize', 0.1,'FontUnits','normalized');
ylabel(handles.axes1,'Model prediction', 'FontSize', 0.1,'FontUnits','normalized');
title(handles.axes1,strcat('RAAE = ',num2str(RAAE1,3)));
xlim(handles.axes1,[lb,ub]);
ylim(handles.axes1,[lb,ub]);
end

if option(2)==1
plot(handles.axes2,YD2,YMD2,'o',[lb,ub],[lb,ub],'r.-',[lb,ub],[lb+pcent*(ub-lb),ub+pcent*(ub-lb)],'b-',[lb,ub],[lb-pcent*(ub-lb),ub-pcent*(ub-lb)],'b-','MarkerFaceColor','r','Markersize',handles.marksz);
xlabel(handles.axes2,'Validating data', 'FontSize', 0.1,'FontUnits','normalized');
ylabel(handles.axes2,'Model prediction', 'FontSize', 0.1,'FontUnits','normalized');
title(handles.axes2,strcat('RAAE = ',num2str(RAAE2,3)));
xlim(handles.axes2,[lb,ub]);
ylim(handles.axes2,[lb,ub]);
end

if option(3)==1

plot(handles.axes3,YD3,YMD3,'o',[lb,ub],[lb,ub],'r.-',[lb,ub],[lb+pcent*(ub-lb),ub+pcent*(ub-lb)],'b-',[lb,ub],[lb-pcent*(ub-lb),ub-pcent*(ub-lb)],'b-','MarkerFaceColor','r','Markersize',handles.marksz);

xlabel(handles.axes3,'Testing data', 'FontSize', 0.1,'FontUnits','normalized');
ylabel(handles.axes3,'Model prediction', 'FontSize', 0.1,'FontUnits','normalized');
title(handles.axes3,strcat('RAAE = ',num2str(RAAE3,3)));
xlim(handles.axes3,[lb,ub]);
ylim(handles.axes3,[lb,ub]);
end
%{
if option(3)==1

plot(handles.axes3,YD3,YMD3,'bo',[-6,12],[-6,12],'r.-','Markersize',4);

xlabel(handles.axes3,'Testing data', 'FontSize', handles.fontsz);
ylabel(handles.axes3,'Model prediction', 'FontSize', handles.fontsz);
title(handles.axes3,'svr-HDMR, 30 points');
xlim(handles.axes3,[-4,12]);
ylim(handles.axes3,[-6,12]);
end
%}

set(handles.text_status,'string','Ready'); 
set(handles.text_status,'BackgroundColor','cyan'); %status
drawnow;