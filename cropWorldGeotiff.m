function [cropArea,cropR] = cropWorldGeotiff(World,WorldR,xSplice,ySplice)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cropArea = World(ySplice,xSplice);

cropR = WorldR;
xLength = xSplice(length(xSplice))-xSplice(1);
yLength = ySplice(length(ySplice))-ySplice(1);
cropR.RasterSize = [ yLength, xLength];
[xupperLeft, yupperLeft] = indexToCoord(WorldR,xSplice(1),ySplice(1));
[xlowerRight, ylowerRight] = indexToCoord(WorldR,xSplice(length(xSplice)),ySplice(length(ySplice)));
cropR.LatitudeLimits = [ylowerRight yupperLeft];
cropR.LongitudeLimits = [xupperLeft xlowerRight];

end

