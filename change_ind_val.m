function [v] = change_ind_val(v,x,i)
%CHANGE_IND_VAL - sets index i of v to x
% used as an aonymous function to only change a single agent's valuation
v(i) = x;
end

