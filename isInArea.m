function output = isInArea(areaMap,R,longitude, latitude)
POINT_TO_DEGREE = R.CellExtentInLongitude;
latStart = R.LatitudeLimits(1);
longStart = R.LongitudeLimits(1);

xIndex = ceil((longitude-longStart)/POINT_TO_DEGREE);
yIndex = R.RasterSize(1)+1-ceil((latitude-latStart)/POINT_TO_DEGREE);
if (xIndex < 0 || yIndex < 0 || areaMap(yIndex, xIndex) <= 0 )
 output = false;
else 
 output = true;
end
