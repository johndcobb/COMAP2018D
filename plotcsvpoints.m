function []  = plotcsvpoints(csvfilename)
%Input a csvfile (no header) with latitude, longitude as the first two c
%columns, and this function will plot them with the options I chose
M = csvread(csvfilename);
plot(M(:,2),M(:,1),'r.','MarkerSize',10)
ylim([24.516666669087 49.3833333357539])
xlim([-124.775000002209 -66.9416666688751])
axis off
end

