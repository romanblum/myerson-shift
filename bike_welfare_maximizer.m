function [max_alloc,max_welf,max_route] = bike_welfare_maximizer(x,v,c)
%WELFARE_MAXIMIZER - finds the welfare maximizing bike sharing allocation
%   by searching space exhaustively
%   x - allocation matrix where rows are indexed by agent and columns are
%   indexed by source sink pairs (s1,t1),(s1,t2),...,(sn,tn)
%   v - valuation vector
%   b - number of bikes at each station
%   c - capacity at each station


n_agents = length(v);

max_route = zeros(n_agents,2);
max_alloc = zeros(n_agents,1);
max_welf = zeros(n_agents,1);

total_welf = 0;

bikes = find(c(:,1))';
bikes = repelem(bikes,c(bikes,1)');
bikes = [bikes, zeros(1,n_agents)];

max_bikes = min(length(bikes),n_agents);

bikes = permn(bikes,max_bikes);
empty = c(:,2) - c(:,1);

n = size(bikes,1);
for alloc = 1:n
    agents = find(bikes(alloc,:));
    
    if ~isempty(agents)

        for i = agents
            empty(bikes(alloc,i)) = empty(bikes(alloc,i)) + 1;
        end 

        stations = find(empty);
        stations = repelem(stations,empty(stations));

        stations = permn(stations,length(agents));

        for station_alloc = 1:size(stations,1)

            x_col = (size(c,1) * (bikes(alloc,agents)-1)) + stations(station_alloc,:);
            x_ind = sub2ind(size(x),agents,x_col);
            welf = sum(v(agents)'.*x(x_ind));

            if (welf > total_welf)
                max_route = zeros(n_agents,2);
                max_alloc = zeros(n_agents,1);
                max_welf = zeros(n_agents,1);

                max_route(agents,1) = bikes(alloc,agents);
                max_route(agents,2) = stations(station_alloc,:);
                max_alloc(agents) = x(x_ind);
                max_welf(agents) = v(agents)'.*x(x_ind);
                
                total_welf = welf;
            end
        end

        for i = agents
            empty(bikes(alloc,i)) = empty(bikes(alloc,i)) - 1;
        end 
    end
end        
        
end

