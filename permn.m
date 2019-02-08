function [P] = permn(arr,n)
%PERMN 
%   generates all permutations of length n from elements of arr without
%   replacement. Computationally iniefficient for the sake of reserving
%   memory.

C = combnk(arr,n);
P = perms(C(1,:));

if (size(C,1) ~= 1)
    for i = 2:size(C,1)
        next_P = perms(C(i,:));
        P = vertcat(P,next_P);
        P = unique(P,'rows');
    end
end
end
