function [longitude,latitude] = indexToCoord(R,xIndex,yIndex)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

latStart = R.LatitudeLimits(1);
longStart = R.LongitudeLimits(1);
POINT_TO_DEGREE = R.CellExtentInLatitude;

longitude = xIndex*POINT_TO_DEGREE+longStart;
latitude = (R.RasterSize(1)-yIndex)*POINT_TO_DEGREE+latStart;

end

