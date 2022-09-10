function [] = randomPointsOnGeotiff(areaMap, R,seedPoints, totalNumPoints, maxR, mod1fit)
% Takes an areaMap - a geotiff with negative values for nonpopulous areas.
% R is a geographicCellsReference with properties about the areas location
% on earth
% seedPoints contains n seeds in a 2xn matrix of latitude, longitude to
% initalize the model with
%totalNumPoints is the desired number of points to put down in total
%maxR is the radius in km to the outer boundary of the permissive region
%mod1fit contains the fitted surface for the modifier (population)


%Useful constants
latStart = R.LatitudeLimits(1);
longStart = R.LongitudeLimits(1);
POINT_TO_DEGREE = R.CellExtentInLatitude;
cushionPercent = .99;
minimumDistanceBetweenStations = 0.1; %km
maxPopulation = 1500; %throw out new york.
scalingFactor = 1-(minimumDistanceBetweenStations/(cushionPercent*maxR)); 
dConstant = scalingFactor * (maxR/maxPopulation); %Note: arbitrary 42024 is population maximum

%Create a pool of points to draw from
x = rand(1, 350000);
y = rand(1, 350000);

%scale pool to fit on index of uspop grids.

longs = (R.RasterSize(2)*x)*POINT_TO_DEGREE+longStart;
lats = (R.RasterSize(1)-R.RasterSize(1)*y)*POINT_TO_DEGREE+latStart;

keeperX = [];
keeperY = [];

counter = 1;
% Initialize the seeds - assumed to be within US
for seed = 1:length(seedPoints)
    if isInUs(areaMap,R,seedPoints(seed,2),seedPoints(seed,1))
        keeperX(counter) = seedPoints(seed,2);
        keeperY(counter) = seedPoints(seed,1);
        counter = counter+1;
    end
end

k=1;
% Try dropping down more points

while counter <= totalNumPoints && k <=length(x)
	% Get a trial point.
	thisX = longs(k);
	thisY = lats(k);
	% See how far is is away from existing keeper points.
	distances = haversineNorm(thisX,thisY,keeperX,keeperY);
    [minDistance,refPointIndex] = min(distances);
    minR = cushionPercent*(maxR - dConstant*mod1fit(keeperX(refPointIndex),keeperY(refPointIndex)));
    if minR < 0
        minR = minimumDistanceBetweenStations;
    end
	if ( isInUs(areaMap, R, thisX, thisY) && (minDistance >= minR) && (minDistance <= maxR )) 
		keeperX(counter) = thisX;
		keeperY(counter) = thisY;
		counter = counter + 1
    end
    k=k+1; %increment index
end
plot(keeperX, keeperY, 'r.', 'MarkerSize',10);
ylim([24.516666669087 49.3833333357539]);
xlim([-124.775000002209 -66.9416666688751]);
%axis off;
grid on;
end