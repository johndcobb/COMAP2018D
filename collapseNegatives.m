function A = collapseNegatives(A)
%Take out anomalous insanely negative values.
for i=1:numel(A)
    if A(i) <= -3.0e+38
        A(i) = 0;
    end
end