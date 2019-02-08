function [welf,pay,route] = myerson_monte_carlo(alloc_fn,v,n_samples)
%MYERSON - compute payments where allocation integral is computed by monte
%      carlo sampling
%   Solve instance with allocation function and compute payments according
%   to myerson
%   returns welfare payment for each agent
%   alloc_fn - function handle that contains the allocation algorithm
%   v - single valuation parameter
%   n_samples - number of monte carlo samples per agent

%%%%% compute actual allocation %%%%%%
[~,welf,route] = alloc_fn(v);
int = zeros(length(v),1);
v_prime = v;

%%%%% for each agent run monte carlo to find payments %%%%%
for agent = 1:length(v)
    
    if (route(agent,1) ~= 0)
    
        agent_alloc = zeros(n_samples,1);
        %%%%% sample new values %%%%%
        samples = v(agent)*rand(n_samples,1);
        
        for i = 1:n_samples
            %%%%% update valuation for this agent %%%%%
            v_prime(agent) = samples(i);
            %%%%% compute allocation %%%%% 
            [alloc_p,~,~] = alloc_fn(v_prime);
            agent_alloc(i) = alloc_p(agent);
        end
        v_prime = v;
        int(agent) = sum(agent_alloc);
    end
end

int = v.*int/(n_samples);
pay = welf - int;
end

