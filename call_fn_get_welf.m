function [welf] = call_fn_get_welf(alloc_fn,x,agent)
%CALL_FN_GET_WELF - Calls the allocation function with the allocation
%matrix x, returns result for agent
[~,welf,~] = alloc_fn(x);
welf = sum(welf) - welf(agent);
end