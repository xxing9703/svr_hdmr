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