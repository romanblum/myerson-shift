function [c] = generate_unif_goods(g,n_stations,problem)
%GENERATE_UNIF_GOODS Summary of this function goes here
%   Detailed explanation goes here
switch problem
    case "carpool"
        exp_goods = g(1);
        exp_sd = max(.25,exp_goods/10);
        %%% should it be a param to do 1 or exp_sd
        n_goods = round(normrnd(g(1),exp_sd));
        goods = randi(n_stations,n_goods,1);
        ind = unique(goods);
        c = zeros(n_stations,1);
        if ~isempty(goods)
            c(ind) = histcounts(goods,[unique(goods);n_stations+1]);
        end
    otherwise
        return
end

end

