function [v,pref] = generate_unif_agents(max_v,n_stations,n_agents,problem)
%GENERATE_UNIF_AGENTS 
%   generate n_agents random agents with uniform valuations from [0,max_v]
%   their preferences are chosen uniformlyn at random from 1:n_stations
%       such that the source and sink are unique
%   
v = max_v*rand(n_agents,1);

switch problem
    case "bike"   
        pref = zeros(n_agents,2);
        for i = 1:n_agents
            pref(i,:) = datasample(1:n_stations,2,'Replace',false);
        end
    case "carpool"
        pref = datasample(1:n_stations,n_agents,'Replace',true);
        pref = pref';
end
end

