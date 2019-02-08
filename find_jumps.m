function [v,j] = find_jumps(x,max_v,max_j,tol)
%find_jumps given step function x, defined over [0,max_v], finds 
%   all discontinuities within tol. queue based binary search.
%   maintains regions with differences on boundaries in queue. 
%   x - function
%   max_v - max domain value
%   max_j - optional max number of jumps
%   tol - optional tolerance

%   returns v = x(j) and j where j are jumps, both sorted by jumps

tail = 0;
head = max_v;

tail_val = x(tail);
head_val = x(head);

queue = zeros(max_j,2);
queue_val = zeros(max_j,2);
queue_ind = 1;
queue(queue_ind,:) = [tail,head];
queue_val(queue_ind,:) = [tail_val,head_val];
q = 2;
ind = 2;

res = zeros(max_j,2);
%col 1 is function value, col 2 is jump value
res(1,1) = tail_val;
res(1,2) = tail;

if (tail_val == head_val)
    res(2,1) = head_val;
    res(2,2) = head;
    v = res(1:2,1);
    j = res(1:2,2);
    return
end

while queue(queue_ind,2) ~= 0
    
    if (head-tail) < tol
        res(ind,1) = head_val;
        res(ind,2) = tail;
        ind = ind + 1;
        
        tail = queue(queue_ind+1,1);
        head = queue(queue_ind+1,2);
        tail_val = queue_val(queue_ind+1,1);
        head_val = queue_val(queue_ind+1,2);
        queue_ind = queue_ind + 1;
    end
    
    mid = (head+tail)/2;
    mid_val = x(mid);
    
    if (abs(mid_val - tail_val) > tol)
        if (abs(mid_val - head_val) > tol)
            queue(q,:) = [mid,head];
            queue_val(q,:) = [mid_val,head_val];
            q = q+1;
        end
        head = mid;
        head_val = mid_val;
    else
        tail = mid;
        tail_val = mid_val;
    end
end


res(ind,1) = res(ind-1,1);
res(ind,2) = max_v;
res = res(1:ind,:);

res = sortrows(res,[2,1]);
v = res(:,1);
j = res(:,2);



