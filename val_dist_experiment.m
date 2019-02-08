%VAL_DIST_EXPERIMENT - experiment that varies the type of distance metric

param.metric = "grid";
param.metric_size = [5,5];
param.dist = "unif";
param.val_dist = "unif";
param.max_v = 10;
param.max_d = 1.5;

exp.iters = 200;
exp.max_d = 1.5;
exp.n_agent = 64;
exp.n_good = 64;

disp("uniform val")
unif_val = experiment("carpool",exp,param);
save('uniform_val_12_9.mat','unif_val','exp','param');

disp("exp val");
param.val_dist = "exp";
param.avg_val = 5;
exp_val = experiment("carpool",exp,param);
save('biased_val_12_9.mat','exp_val','exp','param');

disp("norm val");
param.val_dist = "norm";
norm_val = experiment("carpool",exp,param);
save('norm_val_12_9.mat','norm_val','exp','param');