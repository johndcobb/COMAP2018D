function [xIndex,yIndex] = coordToIndex(R,longitude,latitude)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

POINT_TO_DEGREE = R.CellExtentInLongitude;
latStart = R.LatitudeLimits(1);
longStart = R.LongitudeLimits(1);

xIndex = ceil((longitude-longStart)/POINT_TO_DEGREE);
yIndex = R.RasterSize(1)+1-ceil((latitude-latStart)/POINT_TO_DEGREE);

end

