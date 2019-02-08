function [welf,pay,route,shift] = vcg_shift(alloc_fn,x,v,max_v,payers)
%VCG - compute externaility vcg payments according to allocation function

if (size(max_v,1) == 1)
    max_v = max_v*ones(length(v),1);
end

if (~exist('payers','var'))
    payers = 1:length(v);
end

[~,welf,route] = alloc_fn(x,v);

pivot = zeros(length(v),1);
shift = zeros(length(v),1);
tol = 1e-2;

for agent = payers
    valid_agents = setdiff(1:length(v),agent);
    [~,welf_without,~] = alloc_fn(x(valid_agents,:),v(valid_agents));
    pivot(agent) = sum(welf_without) - sum(welf(valid_agents));
    
    agent_val = v(agent);
    
    agent_change = @(input)change_ind_val(v,input,agent); 
    alloc_fn_all = @(input)alloc_fn(x,agent_change(input));
    total_welf = @(input)sum(call_fn_get_welf(alloc_fn_all,input,agent));
    [vals,jumps] = find_jumps(total_welf,max_v(agent),length(v)+1,tol);
    
    ag_welf = zeros(length(jumps),1);
    for i = 1:length(jumps)-1
        v(agent) = jumps(i)+tol;
        [jump_alloc,~,~] = alloc_fn(x,v);
        if (jump_alloc(agent) < 0)
            ag_welf(i) = jump_alloc(agent) * jumps(i+1);
        else
            ag_welf(i) = jump_alloc(agent) * jumps(i);
        end
    end
    
    v(agent) = jumps(end);
    [jump_alloc,~,~] = alloc_fn(x,v);
    ag_welf(end) = jump_alloc(agent) * jumps(end);
    
    pay = sum(welf_without) - vals;
    util = ag_welf - pay;
    shift(agent) = min(util);
    
    v(agent) = agent_val;
end
pay = pivot + shift;
end

