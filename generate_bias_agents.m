function [v,pref] = generate_bias_agents(good,bias,max_v,n_stations,n_agents,problem);
%GENERATE BIAS AGENTS creates agents with preferences and types biased
%towards the given good
%   good - biased good
%   bias - probability of good
%   n_goods - number of total goods
%   n_agents - number of agents
%   problem - string containing the name of the problem (i.e. "carpool"
v = max_v*rand(n_agents,1);
switch problem
    case "carpool"
        first_draw = rand(n_agents,1);
        get_bias = first_draw < bias;
        pref = zeros(n_agents,1);
        pref(get_bias) = good;
        other_pref = datasample(1:n_stations-1,n_agents-sum(get_bias),'Replace',true);
        other_pref(other_pref == good) = n_stations;
        pref(~get_bias) = other_pref;
    otherwise
        return
end

