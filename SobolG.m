
%% ===================================================================
%
%                           SobolG.m
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

ninput=10;
a=[0,1,4.5,9,99,99,99,99,99,99];
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
D=1;
for i=1:ninput
  D=D*(v(i)+1);
end
D=D-1;
  
for i=1:ninput
    S(i)=1;
 for j=i:i
    S(i)=S(i)*v(j);
 end
 S(i)=S(i)/D;
end

%{
fid=fopen('dataSobol/g.txt', 'w');
for i=1:Ndata
  fprintf(fid, '%8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %10.4f\n', X(i,:),Y(i,1));
end
fclose(fid);

fid=fopen('S.txt', 'w');
  fprintf(fid, '%8.4e %8.4e %8.4e %8.4e %8.4e %8.4e %8.4e %8.4e %8.4e %8.4e %10.4f\n', S, Vtotal);
fclose(fid);
%}
S
break;
