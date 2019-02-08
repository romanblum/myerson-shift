function [d,b,c,pref,v] = cycle_instance()
%CYLCE_ISNTANCE - generates a small instance where a single agent recieves
%   negative welfare to ensure overall welfare maximization

grid = zeros(4,2);
grid(1:4,1) = repelem([0:10:10],1,2);
grid(1:4,2) = repmat([0:10:10],1,2);

d = zeros(6,6);
d(1:4,1:4) = squareform(pdist(grid,'cityblock'));
d(5:6,:) = 20;
d(:,5:6) = 20;
d(5,5) = 0;
d(6,6) = 0;
d(5,6) = 1;
d(6,5) = 1;

b = ones(6,1);
b(6) = 0;
c = ones(6,1);


pref = [1,2;
        2,4;
        4,3;
        5,6];
    
v = 10 * ones(4,1);
v(4) = 2;
end

