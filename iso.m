[xx,yy,zz] = meshgrid(-15:15,-15:15,-15:15);
%# calculate distance from center of the cube
rr = sqrt(xx.^2 + yy.^2 + zz.^2);
figure
%# create the isosurface by thresholding at a iso-value of 10
isosurface(xx,yy,zz,rr,5);
isosurface(xx,yy,zz,rr,10);

%# make sure it will look like a sphere
axis equal 
alpha(0.2)
colorbar
