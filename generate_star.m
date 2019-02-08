function [d] = generate_star(n_leaves)
%GENERATE STAR - builds a star metric with n_leaves

d = zeros((n_leaves+1)*n_leaves/2,1);
d(1:n_leaves) = 1;
d(n_leaves+1:end) = 2;

d = squareform(d);

end

