function [d] = generate_grid(n,m)
%GENERATE_GRID 
% builds grid of size nxn
% initializes bike locations and station capacity
% param contains parameters which determine probability of bikes and empty
% spaces

% d - distance matrix
% b - bike vector
% c - capacity vector (c >= b)

grid = zeros(n*m,2);
grid(:,1) = repelem([1:1:n],1,m);
grid(:,2) = repmat([1:1:m],1,n);

d = squareform(pdist(grid,'cityblock'));


