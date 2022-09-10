function [] = viewTraitSurface(A,R)
    figure
    h = geoshow(A,R,'DisplayType','surface');
    light
    material(0.6*[ 1 1 1])
    view(3)
    axis normal
end