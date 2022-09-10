function [X,Y,Z] = discretizegeotiff(A,R)
%Takes in a geotiffread object A and geographic cells reference R, and unpacks
%the raster grid data into (longitude,latitude,height) points. (to be
%fitted)
latStart = R.LatitudeLimits(1);
longStart = R.LongitudeLimits(1);
POINT_TO_DEGREE = R.CellExtentInLatitude;
Y_LENGTH = R.RasterSize(1);
X_LENGTH = R.RasterSize(2);
TOTAL_POINTS = X_LENGTH * Y_LENGTH;

[X,Y,Z] = deal(zeros(1, TOTAL_POINTS));

curr = 1;
% Create points that are in the middle of the cell delimiters.
for ycord = 0:Y_LENGTH-1
    for xcord = 0: (X_LENGTH-1)
        X(curr) = 0.5+xcord;
        Y(curr) = Y_LENGTH-(0.5+ycord);
        Z(curr) = A(ycord+1,xcord+1);
        curr = curr + 1;
    end
end

%Transform results to coordinates
X = X*POINT_TO_DEGREE+longStart;
Y = Y*POINT_TO_DEGREE+latStart;

%Added after realizing that fit([x,y],z,'poly23') needs column vectors
X=transpose(X);
Y=transpose(Y);
Z=transpose(Z);

end

