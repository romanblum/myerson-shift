function [c] = generate_bias_goods(good,bias,g,n_stations,problem)
%GENERATE BIAS GOODS generates n_goods goods from n_stations possibility
%which is biased towards good.
%   good - biased good
%   bias - probability of getting good
%   n_goods - number of goods to generate
%   n_stations - number of possible stations
%   problem - name of problem
switch problem
    case "carpool"
        %%%% this is copy and pasted!!!
        exp_goods = g(1);
        exp_sd = exp_goods/8;
        n_goods = round(normrnd(g(1),1));
        
        first_draw = rand(n_goods,1);
        get_bias = first_draw < bias;
        
        goods = zeros(n_goods,1);
        goods(get_bias) = good;
        
        other = randi(n_stations-1,n_goods-sum(get_bias),1);
        other(other == good) = n_stations;
        goods(~get_bias) = other;
        
        ind = unique(goods);
        c = zeros(n_stations,1);
        c(ind) = histcounts(goods,[unique(goods);n_stations+1]);
end

