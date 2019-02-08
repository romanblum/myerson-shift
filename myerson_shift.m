function [welf,pay,route,shift] = myerson_shift(alloc_fn,v,max_v)
%MYERSON SHIFT
%   Solve instance with allocation function and compute payments according
%   to myerson where we estimate allocation function and shift payments
%   such that individual rationality is preserved
%   returns welfare, payment, and assignment for each agent
%   alloc_fn - function handle that contains the allocation algorithm
%   v - single valuation parameter

%%%%% compute actual allocation %%%%%%
[alloc,welf,route] = alloc_fn(v);

if (size(max_v,1) == 1)
    max_v = max_v*ones(length(v),1);
end
tol = 1e-2;
util = zeros(length(v),length(v));
base_pay = zeros(length(v),1);
ind = -1*ones(length(v),1);

% for each agent
for agent = 1:length(v)
    agent_val = v(agent);
    
    % find discontinuities in allocation function (always step function)
    agent_change = @(x)change_ind_val(v,x,agent); 
    alloc_fn_all = @(x)alloc_fn(agent_change(x));
    agent_alloc = @(x)call_fn_get_alloc_ind(x,alloc_fn_all,agent);
    [vals,jumps] = find_jumps(agent_alloc,max_v(agent),length(v)+1,tol);
    
    % compute integral at each discontinuity (equivalent to unshifted util)
    int_ub = times(vals(1:end-1),jumps(2:end))-times(vals(1:end-1),jumps(1:end-1));
    util(agent,2:1+length(int_ub)) = cumsum(int_ub);
    
    v(agent) = agent_val;
    next = find(jumps > v(agent));
    base_pay(agent) = util(agent,next(1)) - alloc(agent)*(jumps(next(1))-v(agent));
end


%%%% find point where utility is minimized
[shift,~] = min(util,[],2);

%%%% shift payments such that minimal utility is 0
pay = welf-base_pay+shift;
            
end

