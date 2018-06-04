function [fulldata, header]=loadhdd(title)

[filename, pathname]=uigetfile({'*.hdd'},title)

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