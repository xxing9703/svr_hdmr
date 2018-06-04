function [varargout] = MultiSlider (varargin)
% MultiSlider Create multi slider control.
%    MultiSlider, by itself, creates a new multi slider control in the 
%    current figure, and returns its handle.
%  
%    MultiSlider(H, 'Results') returns an array of floats that represent
%    the ordered grip positions on the slider H.
%
%    MultiSlider(H, Property, Value) sets the Property to the specified
%    Value for slider H. Possible properties are:
%    - XLabel: String label for x-axis
%    - Position: Array(4) [xPos yPos width height] in pixels
%    - Domain: Array(2) [xMin xMax]
%    - NTicks: Integer, number of ticks on the x-axis
%    - TicksRoundDigits: Integer, number of digits to round the ticks
%    - UserFcn: String, User defined function triggered each time a grip is
%               slided
%
%    A multislider is an axis along which grips can be placed by clicking 
%    on empty axis spots. The position of each of the grips can be changed 
%    by drag/drop.
%    When finished, the positions/values represented by the grips can be
%    retrieved.
%
%    April 22, 2005 MultiSlider V1.01
%    Changed licence to BSD at request of Mathworks.
%
%    Copyright (C) 2005  Wilko de Jong
% 

try
    switch nargin
        case 0
            % Just instantiate a new (default) multi slider
            varargout{1} = initialize;
        case 2
            if ishandle(varargin{1}) && strcmp(varargin{2}, 'Results')
                varargout{1} = GetResults(varargin{1});
            end
        case 3
            if ishandle(varargin{1}) && ischar(varargin{2})
                varargout{1} = SetProperty(varargin{1}, varargin{2}, varargin{3});
            end
        case 4
            if ischar(varargin{1})
                % This may be a callback
                fhandle = str2func(varargin{1});
                fhandle(varargin{2}, varargin{3}, varargin{4});
            end
    end
end

%--------------------------------------------------------------------------
function [ms] = initialize
% Set up the axes
ms = axes;
pa = get(ms, 'Parent');
set(ms, 'Units',            'Pixels');
set(ms, 'Box',              'off');
set(ms, 'Color',            get(pa, 'Color'));
set(ms, 'XColor',           [0 0 0]);
set(ms, 'YColor',           get(pa, 'Color'));
set(ms, 'ZColor',           get(pa, 'Color'));
set(ms, 'YTick',            []);
set(ms, 'Position',         [20 20 300 10]);
set(ms, 'XLim',             [0 1]);
set(ms, 'ButtonDownFcn',    'MultiSlider(''MultiSliderButtonDownFcn'', gcbo, [], guidata(gcbo))');

% Create an empty collection for the grips
userdata        = struct();
userdata.grips  = [];
userdata.Domain = [0 1];
userdata.NTicks = 3;
userdata.Pointers.GripAddHotSpot = [8 8];
userdata.TicksRoundDigits = 2;
userdata.UserFcn = '';
userdata.Pointers.GripAdd = [ ...
    NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	NaN	1	1	1	1	1; ...
    NaN	NaN	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN	NaN	NaN	NaN	1	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	NaN	1	1	1	NaN	NaN	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	NaN	1	1	1	NaN	NaN	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	1	1	1	1	1	NaN	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	NaN	NaN	1	1	1	1	1	NaN	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	NaN	1	1	1	1	1	1	1	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	NaN	1	1	1	1	1	1	1	NaN	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	1	1	1	1	1	1	1	1	1	NaN	NaN	NaN	NaN; ...
    NaN	NaN	NaN	1	1	1	1	1	1	1	1	1	NaN	NaN	NaN	NaN; ...
    NaN	NaN	1	1	1	1	1	1	1	1	1	1	1	NaN	NaN	NaN; ...
    NaN	NaN	1	1	1	1	1	1	1	1	1	1	1	NaN	NaN	NaN; ...
    NaN	1	1	1	1	1	1	1	1	1	1	1	1	1	NaN	NaN];
userdata.Pointers.GripMoveHotSpot = [8 8];
userdata.Pointers.GripMove = [ ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN  1  NaN NaN NaN NaN NaN NaN  1  NaN NaN NaN NaN; ...
    NaN NaN NaN  1   1  NaN NaN NaN NaN NaN NaN  1   1  NaN NaN NaN; ...
    NaN NaN  1   2   1  NaN NaN NaN NaN NaN NaN  1   2   1  NaN NaN; ...
    NaN  1   2   2   1   1   1   1   1   1   1   1   2   2   1  NaN; ...
     1   2   2   2   1   1   1   1   1   1   1   1   2   2   2   1 ; ...
    NaN  1   2   2   1   1   1   1   1   1   1   1   2   2   1  NaN; ...
    NaN NaN  1   2   1  NaN NaN NaN NaN NaN NaN  1   2   1  NaN NaN; ...
    NaN NaN NaN  1   1  NaN NaN NaN NaN NaN NaN  1   1  NaN NaN NaN; ...
    NaN NaN NaN NaN  1  NaN NaN NaN NaN NaN NaN  1  NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN; ...
    NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

% Control mouseover events
RefreshOriginalMouseOver();

% Store the userdata
set(ms, 'UserData', userdata);

%--------------------------------------------------------------------------
function RefreshOriginalMouseOver()
myFigure = get(gcf);
myCallback = 'MultiSlider(''FigureMouseMoveFcn'', gcbo, [], guidata(gcbo))';
if ~strcmp(myFigure.WindowButtonMotionFcn, myCallback)
    userdata = get(gcf, 'UserData');
    userdata.OriginalWindowButtonMotionFcn = myFigure.WindowButtonMotionFcn;
    set(gcf, 'WindowButtonMotionFcn', myCallback);
    set(gcf, 'UserData', userdata);
end

%--------------------------------------------------------------------------
function [hGrip] = NewGrip(hMultiSlider, xPos)
hGrip = patch;
set(hGrip, 'YData',         [0;1;0]);
set(hGrip, 'FaceColor',     [0 0 0]);
set(hGrip, 'ButtonDownFcn', 'MultiSlider(''GripButtonDownFcn'', gcbo, [], guidata(gcbo))');
MoveGrip(hGrip, xPos);

% Add to collection
userdata = get(hMultiSlider, 'UserData');
userdata.grips(length(userdata.grips) + 1) = hGrip;
set(hMultiSlider, 'UserData', userdata);

%--------------------------------------------------------------------------
function DeleteGrip(hMultiSlider, hGrip)
myMultiSlider = get(hMultiSlider);
userdata = myMultiSlider.UserData;
for ii = 1 : length(userdata.grips)
    if userdata.grips(ii) == hGrip
        userdata.grips = [userdata.grips(1:ii-1) userdata.grips(ii+1:end)];
        delete(hGrip);
        set(hMultiSlider, 'UserData', userdata);
        return
    end
end

%--------------------------------------------------------------------------
function [hMultiSlider] = SetProperty(hMultiSlider, pName, pVal)
myMultiSlider = get(hMultiSlider);
userdata = myMultiSlider.UserData;
try
    switch(pName)
        case 'XLabel'
            set(myMultiSlider.XLabel, 'String', pVal);
        case 'Position'
            set(hMultiSlider, 'Position', pVal);
        case 'Domain'
            userdata.Domain = pVal;
        case 'NTicks'
            userdata.NTicks = pVal;
        case 'TicksRoundDigits'
            userdata.TicksRoundDigits = pVal;
        case 'UserFcn'
            userdata.UserFcn = pVal;
    end
end
set(hMultiSlider, 'UserData', userdata);
hMultiSlider = Refresh(hMultiSlider);

%--------------------------------------------------------------------------
function [hMultiSlider] = Refresh(hMultiSlider)
myMultiSlider = get(hMultiSlider);
userdata = myMultiSlider.UserData;
myTick = [0:userdata.NTicks-1] ./ (userdata.NTicks-1);
myTickLabel = num2str([myTick .* diff(userdata.Domain) + userdata.Domain(1)]', ['%0.' num2str(userdata.TicksRoundDigits) 'f']);
set(hMultiSlider, 'XTick', myTick);
set(hMultiSlider, 'XTickLabel', myTickLabel);

%--------------------------------------------------------------------------
function [results] = GetResults(hMultiSlider)
results = [];
xPos = [];
myMultiSlider = get(hMultiSlider);
for ii = 1 : length(myMultiSlider.UserData.grips)
    hGrip = myMultiSlider.UserData.grips(ii);
    myGrip = get(hGrip);
    xVal(ii) = myMultiSlider.UserData.Domain(1) + myGrip.XData(2) .* diff(myMultiSlider.UserData.Domain);
end
results = sort(xVal);

%--------------------------------------------------------------------------
function [textLabel] = NewTextLabel(hGrip)
myGrip = get(hGrip);
textLabel = text(myGrip.XData(2), 2.5 * myGrip.YData(2), num2str(myGrip.XData(2)));
set(textLabel, 'EdgeColor', [0 0 0]);
set(textLabel, 'BackgroundColor', [1 1 232/255]);

%--------------------------------------------------------------------------
function SetGripLabel(hGrip)
myGrip = get(hGrip);
myMultiSlider = get(myGrip.Parent);
tPos = get(myMultiSlider.UserData.GripText, 'Position');
tPos(1) = myGrip.XData(2) - 0.075;
set(myMultiSlider.UserData.GripText, 'Position', tPos);
set(myMultiSlider.UserData.GripText, 'String', sprintf('%0.5f', myMultiSlider.UserData.Domain(1) + myGrip.XData(2) .* diff(myMultiSlider.UserData.Domain)));

%--------------------------------------------------------------------------
function MoveGrip(hGrip, xPos)
set(hGrip, 'XData', [-0.02;0;0.02] + xPos);

%--------------------------------------------------------------------------
function [hMultiSlider] = IsMouseOnMultiSlider()
hMultiSlider = 0;
fPos = get(gcf, 'Position');
pPos = get(0, 'PointerLocation');
hObjs = findall(gcf, 'ButtonDownFcn', 'MultiSlider(''MultiSliderButtonDownFcn'', gcbo, [], guidata(gcbo))');
for ii = 1 : length(hObjs)
    oPos = get(hObjs(ii), 'Position');
    if  pPos(1) > fPos(1) + oPos(1) && pPos(1) < fPos(1) + oPos(1) + oPos(3) && ...
        pPos(2) > fPos(2) + oPos(2) && pPos(2) < fPos(2) + oPos(2) + oPos(4)
        % We are on a multislider
        hMultiSlider = hObjs(ii);
        return
    end
end

%--------------------------------------------------------------------------
function [hGrip] = IsMouseOnGrip(hMultiSlider)
hGrip = 0;
userdata = get(hMultiSlider, 'UserData');
fPos = get(gcf, 'Position');
pPos = get(0, 'PointerLocation');
oPos = get(hMultiSlider, 'Position');
for ii = 1 : length(userdata.grips)
    gPos = get(userdata.grips(ii), 'XData');
    xGrip(1) = gPos(1) * oPos(3);   % Position is given in Unity coords
    xGrip(3) = gPos(3) * oPos(3);
    if pPos(1) > fPos(1) + oPos(1) + xGrip(1) && pPos(1) < fPos(1) + oPos(1) + xGrip(3)
        hGrip = userdata.grips(ii);
        return
    end
end

%--------------------------------------------------------------------------
function FigureMouseMoveFcn(hObject, eventdata, handles)
% Execute the original callback
try
    userdata = get(gcf, 'UserData');
    eval(userdata.OriginalWindowButtonMotionFcn);
end

% See if the mouse is on a multislider
hMultiSlider = IsMouseOnMultiSlider();
if hMultiSlider ~= 0
    userdata = get(hMultiSlider, 'UserData');
    set(gcf, 'Pointer', 'custom');
    
    % See if mouse is on a grip
    hGrip = IsMouseOnGrip(hMultiSlider);
    if hGrip ~= 0
        % Show move Grip (mouse pointer)
        set(gcf, 'PointerShapeCData', userdata.Pointers.GripMove);
        set(gcf, 'PointerShapeHotSpot', userdata.Pointers.GripMoveHotSpot);
    else
        % Show add Grip (mouse pointer)
        set(gcf, 'PointerShapeCData', userdata.Pointers.GripAdd);
        set(gcf, 'PointerShapeHotSpot', userdata.Pointers.GripAddHotSpot);
    end
else
    set(gcf, 'Pointer', 'arrow');
end

%--------------------------------------------------------------------------
function MultiSliderButtonDownFcn (hMultiSlider, eventdata, handles)
% Get the click position
pos = get(hMultiSlider, 'CurrentPoint');

% Add a new grip to the collection
myGrip = NewGrip(hMultiSlider, pos(1));

% Forward to grip button down function
GripButtonDownFcn (myGrip, [], guidata(myGrip));

%--------------------------------------------------------------------------
function GripButtonDownFcn (hGrip, eventdata, handles)
% Make sure correct callbacks are set
RefreshOriginalMouseOver();

% Get all different layers
myGrip      = get(hGrip);
myAxes      = get(myGrip.Parent);
myFigure    = get(myAxes.Parent);

% Hang text label
myAxes.UserData.GripText = NewTextLabel(hGrip);

% Remember actual callbacks
myAxes.UserData.WindowButtonMotionFcn = myFigure.WindowButtonMotionFcn;
myAxes.UserData.WindowButtonUpFcn = myFigure.WindowButtonUpFcn;
set(myGrip.Parent, 'UserData', myAxes.UserData);

% Now set different customized callbacks
fGrip = sprintf('%0.14f', hGrip);
set(myAxes.Parent, 'WindowButtonMotionFcn', ['MultiSlider(''GripButtonDownMouseMoveFcn'', ' fGrip ', [], guidata(' fGrip '))']);
set(myAxes.Parent, 'WindowButtonUpFcn', ['MultiSlider(''GripButtonUpFcn'', ' fGrip ', [], guidata(' fGrip '))']);

%--------------------------------------------------------------------------
function GripButtonDownMouseMoveFcn (hGrip, eventdata, handles)
% Get current axes (= multi slider)
myGrip      = get(hGrip);
myAxes      = get(myGrip.Parent);

% Move grip
cp = myAxes.CurrentPoint;
MoveGrip(hGrip, cp(1,1));

% Update grip text
SetGripLabel(hGrip);

% Excecute user function
try
    eval(myAxes.UserData.UserFcn);
end

%--------------------------------------------------------------------------
function GripButtonUpFcn (hGrip, eventdata, handles)
% Get current axes (= multi slider)
myGrip      = get(hGrip);
myAxes      = get(myGrip.Parent);

% Reset the callbacks we are going to change temporarily
set(myAxes.Parent, 'WindowButtonMotionFcn', myAxes.UserData.WindowButtonMotionFcn);
set(myAxes.Parent, 'WindowButtonUpFcn', myAxes.UserData.WindowButtonUpFcn);
%
% Delete text label
delete(myAxes.UserData.GripText);

% Delete grip (if out of boundaries)
if myGrip.XData(2) < 0 || myGrip.XData(2) > 1
    DeleteGrip(myGrip.Parent, hGrip);
end