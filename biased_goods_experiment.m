

param.metric = "star";
param.metric_size = [4];
param.val_dist = "unif";
param.dist = "bias";
param.max_v = 10;
param.max_d = .5;
param.good = 1;

exp.bias = [.2, .4, .8, .9, .95, .99];
exp.n_agent = ones(length(exp.bias),1) * 64;
exp.n_good = ones(length(exp.bias),1) * 64;
exp.iters = 200;
exp.max_d = ones(length(exp.bias),1) * param.max_d;

disp("over")
res = experiment("carpool",exp,param);
save('biased_goods_12_17.mat','res','exp','param');