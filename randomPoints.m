%Create a pool of points to draw from
x = rand(1, 10000);
y = rand(1, 10000);
minAllowableDistance = 0.05;
maxAllowableDistance = 0.10;
numberOfPoints = 1000; %Try to place this much
%Note: box is 1x1, assuming densely packed grid.
theoreticalMaxPoints = 2*(1/minAllowableDistance);
% Initialize the first point.

keeperX = x(1);
keeperY = y(1);
counter = 2;

% Initialize the additional seeds (without max constraint).
numSeeds = 7;
seedGrowthDistance = 0.15;
for n = 1 : numSeeds
    thisX = x(n);
    thisY = y(n);
    distances = sqrt((thisX-keeperX).^2 + (thisY - keeperY).^2);
    minDistance = min(distances);
    if minDistance >= seedGrowthDistance
		keeperX(counter) = thisX;
		keeperY(counter) = thisY;
		counter = counter + 1;
	end
    
end
% Try dropping down more points
for k = counter : 1000
	% Get a trial point.
	thisX = x(k);
	thisY = y(k);
	% See how far is is away from existing keeper points.
	distances = sqrt((thisX-keeperX).^2 + (thisY - keeperY).^2);
	[minDistance,minIndex] = min(distances);
	if (minDistance >= minAllowableDistance) && (minDistance <= maxAllowableDistance)
		keeperX(counter) = thisX;
		keeperY(counter) = thisY;
		counter = counter + 1;
	end
end
plot(keeperX, keeperY, 'b*');
grid on;