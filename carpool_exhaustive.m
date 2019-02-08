function [max_alloc,max_welf,max_assign] = carpool_exhaustive(x,v,c)
%CARPOOL WELFARE MAXIMIZER EXHAUSTIVE - finds the welfare maximizing carpool 
%   assignment allocation by searching space exhaustively
%   x - allocation matrix where rows are indexed by agent and columns are
%   indexed by cars
%   v - valuation vector
%   c - capacity of each car
n_agents = length(v);

max_assign = zeros(n_agents,1);
max_alloc = zeros(n_agents,1);
max_welf = zeros(n_agents,1);

total_welf = 0;

seats = find(c)';
seats = repelem(seats,c(seats)');

if (length(seats) < n_agents)
    seats = [seats, zeros(1,n_agents-length(seats))];
end

seats = permn(seats,n_agents);

n = size(seats,1);
for alloc = 1:n
    agents = find(seats(alloc,:));
    assign = seats(alloc,agents);
    if ~isempty(agents)
        x_ind = sub2ind(size(x),agents,assign);
        welf = sum(v(agents)'.*x(x_ind));
        
        if (welf > total_welf)
            max_assign = zeros(n_agents,1);
            max_alloc = zeros(n_agents,1);
            max_welf = zeros(n_agents,1);
            
            max_assign(agents,1) = seats(alloc,agents);
            max_alloc(agents) = x(x_ind);
            max_welf(agents) = v(agents)'.*x(x_ind);
            
            total_welf = welf;
        end
    end
end
end





