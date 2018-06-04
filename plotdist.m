function plotdist(handles)
%h=handles.axes4;
figure;
h=subplot(1,1,1);
ss=handles.marksz*2;
dd=get(handles.pop_d,'value');
switch dd
    case 1
        data=handles.D;
        yy=handles.Y;
    case 2
        data=[handles.D1;handles.D2];
        yy=[handles.Y1;handles.Y2];
    case 3
        data=handles.D1;
        yy=handles.Y1;
    case 4
        data=handles.D2;
        yy=handles.Y2;
    case 5
        data=handles.D3;
        yy=handles.Y3;
end
sz=size(handles.D,2);

axe1=get(handles.pop_x,'value');
axe2=get(handles.pop_y,'value');

header=get(handles.pop_x,'string');
header_x1=header(axe1);
header_x2=header(axe2);
header_y=header(sz);


x1=data(:,axe1);
x2=data(:,axe2);
y=data(:,sz);

x1=(x1+1)/2;
x2=(x2+1)/2;
if get(handles.check_3d,'value')
   hold off;
   scatter3(h,x1,x2,y,ss,'blue','filled');
   if get(handles.checkbox2,'value')
    hold on;
    scatter3(h,x1,x2,yy,ss,'red');
   end
   xlabel(h,header_x1, 'FontSize', handles.fontsz);
   ylabel(h,header_x2, 'FontSize', handles.fontsz);
   zlabel(h,header_y, 'FontSize', handles.fontsz);
    zlabel(h,'Output', 'FontSize', handles.fontsz);
   rotate3d on;
else
    hold off;
    scatter(h,x1,x2,handles.marksz);
xlabel(h,header_x1, 'FontSize', handles.fontsz);
ylabel(h,header_x2, 'FontSize', handles.fontsz);
end

%brush on;