function [alloc,welf,assign] = carpool(x,v,c)
%CARPOOL MAX FLOW REDUCTION - finds the welfare carpool assignment
%   through max flow linear program reduction
%   x - allocation matrix where rows are indexed by agent and columns are
%   indexed by cars
%   v - valuation vector
%   c - capacity of each car
n_agent = length(v);
n_cars = length(c);
n_var = n_agent * n_cars;

f = x .* v;
f = reshape(f',n_var,1);

min_val = min(f);
f = f - ones(n_var,1)*min_val;
f = -1*f;

A_cap = zeros(n_cars,n_var);
for i = 1:n_cars
    A_cap(i,i:n_cars:n_var) = 1;
end

b_cap = reshape(c,n_cars,1);

A_agent = zeros(length(v),n_var);
for i = 1:n_agent
    start = (i-1)*n_cars+1;
    A_agent(i,start:1:(start+n_cars-1)) = 1;
end

b_agent = ones(n_agent,1);

A = vertcat(A_cap,A_agent);
b = vertcat(b_cap,b_agent);

sol = linprog(f,A,b,[],[],zeros(n_var,1),ones(n_var,1),optimoptions('linprog','Display','none'));
[row,col,val] = find(sol);

agent = idivide(int32(row),int32(n_cars),'ceil');

assign = zeros(n_agent,1);
assign(agent) = mod(row-1,n_cars)+1;

ind = sub2ind(size(x),agent,assign(agent));

alloc = zeros(n_agent,1);
alloc(agent) = x(ind);  
welf = alloc.*v;
end

