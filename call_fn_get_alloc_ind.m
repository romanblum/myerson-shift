function [r] = call_fn_get_alloc_ind(v,x,i)
%CALL_FN_GET_ALLOC_IND - Calls the allocation function with the value
%vector v, returns result for agent i
[alloc,~,~] = x(v);
r = alloc(i);
end

