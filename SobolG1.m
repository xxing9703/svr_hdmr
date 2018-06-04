
%% ===================================================================
%
%                           SobolG1.m
%
%  This is a code to generate thebdata for Sobol g-function.
%  The theoretical sensitivity indexes were calculated.
%
%
%   This code was written in April, 2015.
%
%% ===================================================================


   clear;

%%--setting parameters a_i

ninput=15;
%a=[1,99,0.3,1.5,3,9,1.8,8,0,0,4.5,0.5,0.2,0.01,0];
a=[0,0.2,0.5,1,2,2,4,9,9,99,99,99,99,99,99]
Ndata=3000;

X=rand(Ndata,ninput);

for i=1:Ndata
  Y(i,1)=1;
  for j=1:ninput
    Y(i,1)=Y(i,1)*(abs(4*X(i,j)-2)+a(j))/(1+a(j));
  end
end

%%--- Variances

for i=1:ninput
 v(i)=1/(3*(1+a(i))*(1+a(i)));
end
  
Vtotal=1;
for i=1:ninput
  Vtotal=Vtotal*(1+v(i));
end
Vtotal=Vtotal-1;

for i=1:ninput
  S1(i)=v(i)/Vtotal;
end

S1sum=0;
for i=1:ninput
  S1sum=S1sum+S1(i);
end
S1sum

S2sum=0;
for i=1:ninput-1
for j=i+1:ninput
  v2(i,j)=v(i)*v(j);
  S2(i,j)=v2(i,j)/Vtotal;
  S2sum=S2sum+S2(i,j);
end
end
S2sum

S3sum=0;
for i=1:ninput-2
for j=i+1:ninput-1
for k=j+1:ninput
  v3(i,j,k)=v(i)*v(j)*v(k);
  S3(i,j,k)=v3(i,j,k)/Vtotal;
  S3sum=S3sum+S3(i,j,k);
end
end
end
S3sum

S4sum=0;
for i=1:ninput-3
for j=i+1:ninput-2
for k=j+1:ninput-1
for l=k+1:ninput
  v4(i,j,k,l)=v(i)*v(j)*v(k)*v(l);
  S4(i,j,k,l)=v4(i,j,k,l)/Vtotal;
  S4sum=S4sum+S4(i,j,k,l);
end
end
end
end
S4sum

S5sum=0;
for i=1:ninput-4
for j=i+1:ninput-3
for k=j+1:ninput-2
for l=k+1:ninput-1
for m=l+1:ninput
  v5(i,j,k,l,m)=v(i)*v(j)*v(k)*v(l)*v(m);
  S5(i,j,k,l,m)=v5(i,j,k,l,m)/Vtotal;
  S5sum=S5sum+S5(i,j,k,l,m);
end
end
end
end
end
S5sum

S1sum+S2sum+S3sum+S4sum+S5sum

fid=fopen('g15.txt', 'w');
for i=1:Ndata
  fprintf(fid, '%8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %10.4f\n', X(i,:),Y(i,1));
end
fclose(fid);
%{
fid=fopen('Si.txt', 'w');
  fprintf(fid, '%8.4e %8.4e %8.4f %8.4f %8.4e %8.4e %8.4e %8.4f %8.4f %8.4e %8.4e %8.4e %8.4e %8.4e %8.4e\n', S1);
fclose(fid);
fid=fopen('Sij.txt', 'w');
for i=1:ninput-1
for j=i+1:ninput
  fprintf(fid, '%4d %4d %12.4e\n', i,j,S2(i,j));
end
end
fclose(fid);

fid=fopen('dataSobol/Sijk.txt', 'w');
for i=1:ninput-2
for j=i+1:ninput-1
for k=j+1:ninput
  fprintf(fid, '%4d %4d %4d %12.4e\n', i,j,k,S3(i,j,k));
end
end
end
fclose(fid);


fid=fopen('dataSobol/Sijkltxt', 'w');
for i=1:ninput-3
for j=i+1:ninput-2
for k=j+1:ninput-1
for l=k+1:ninput
  fprintf(fid, '%4d %4d %4d %4d %12.4e\n', i,j,k,l,S4(i,j,k,l));
end
end
end
end
fclose(fid);


fid=fopen('dataSobol/Sijklmtxt', 'w');
for i=1:ninput-4
for j=i+1:ninput-4
for k=j+1:ninput-2
for l=k+1:ninput-1
for m=l+1:ninput
  fprintf(fid, '%4d %4d  %4d %4d %4d %12.4e\n', i,j,k,l,m,S5(i,j,k,l,m));
end
end
end
end
end
fclose(fid);
%}
break;
