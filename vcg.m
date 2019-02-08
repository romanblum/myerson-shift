function [welf,pay,route] = vcg(alloc_fn,x,v,payers)
%VCG - compute externaility vcg payments according to allocation function

if (~exist('payers','var'))
    payers = 1:length(v);
end

[~,welf,route] = alloc_fn(x,v);

pay = zeros(length(v),1);

for agent = payers
    valid_agents = setdiff(1:length(v),agent);
    [~,welf_without,~] = alloc_fn(x(valid_agents,:),v(valid_agents));
    pay(agent) = sum(welf_without) - sum(welf(valid_agents));
end
end

