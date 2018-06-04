function [x,fval]=optimizeGA(handles)

x=handles.para;
lb=handles.lb;
ub=handles.ub;
sp=length(x);

ObjectiveFunction = @(x)costfn(x,handles);
popu=handles.opt.pop;
gene=handles.opt.gen;
stall=handles.opt.stall;
time=handles.opt.time;
fcns=handles.opt.plot;

opts = gaoptimset(@ga);
if fcns==[1,1]
opts = gaoptimset('PlotFcns',{@gaplotbestf,@gaplotstopping});
elseif fcns==[1,0]
opts = gaoptimset('PlotFcns',{@gaplotbestf});
elseif fcns==[0,1]
opts = gaoptimset('PlotFcns',{@gaplotstopping});
else
end

opts = gaoptimset(opts,'Generations',gene,'StallGenLimit', stall,'TimeLimit', time*3600);
opts = gaoptimset(opts,'PopulationSize',popu);

[x,fval] = ga(ObjectiveFunction,sp,[],[],[],[],lb',ub',[],opts);




