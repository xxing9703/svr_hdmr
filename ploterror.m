filename='experror_agg.txt';
a=importdata(filename);
m1=min(a);
m2=max(a);
lb=m1-(m2-m1)*0.05;
ub=m2+(m2-m1)*0.05;
pcent=0.00;

plot(a(:,1),a(:,2),'o',[lb,ub],[lb,ub],'r.-',[lb,ub],[lb+pcent*(ub-lb),ub+pcent*(ub-lb)],'b-',[lb,ub],[lb-pcent*(ub-lb),ub-pcent*(ub-lb)],'b-','MarkerFaceColor','r','Markersize',3);
xlabel('averaged exp data');
ylabel('selected exp data');
%title(strcat('RAAE = ',num2str(RAAE2,3)));
xlim([lb,ub]);
ylim([lb,ub]);
