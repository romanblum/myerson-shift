%VARY_NEGATIVITY - experiment where goods become more and more penalized 

param.metric = "grid";
param.metric_size = [5,5];
param.dist = "unif";
param.max_v = 10;
param.max_d = 1.5;

exp.iters = 100;
exp.max_d = .5:1:8.5;
exp.n_agent = ones(length(exp.max_d),1)*64;
exp.n_good = ones(length(exp.max_d),1)*64;

disp("varying negativity")
res = experiment("carpool",exp,param);
save('vary_neg_12_9.mat','res','exp','param');