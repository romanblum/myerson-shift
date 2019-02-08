function [pen] = multiplicative_alloc(pref,dist,max_d);
%MULTIPLICATIVE_VAL
%   Compute allocation matrix according to the multiplicative allocation function
%   pen = (1 - (d(s,s') + d(t,t'))/d). Rows are agents columns are source
%   sink pairs in the following order: (s1,t1),(s1,t2),...(s2,t1),...,(sn,tn)
%   pref - source and/or sink preferences
%   dist - distance matrix over stations
%   max_d - maximum distance allowed before negative valuations

n = length(dist);
if(size(pref,2) == 2)
    source_pen = repelem(dist(pref(:,1),:),1,n); 
    sink_pen = repmat(dist(pref(:,2),:),1,n);
    
    pen = ones(size(pref,1),n*n) - ((source_pen+sink_pen)/max_d);
else
    pen = ones(size(pref,1),n) - (dist(pref(:,1),:)/max_d);
end

end

