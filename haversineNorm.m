function [distances] = haversineNorm(x1, y1, X, Y)
distances = zeros(1,length(X));
for i = 1:length(X)
    dlat = deg2rad(Y(i)-y1);
    dlon = deg2rad(X(i)-x1);
    lat1 = deg2rad(y1);
    lat2 = deg2rad(Y(i));
    a = (sin(dlat./2)).^2 + cos(lat1) .* cos(lat2) .* (sin(dlon./2)).^2;
    c = 2 .* asin(sqrt(a));
    distances(i) = 6372.8*c;
end
end
