%RUN_DEMAND_EXP - vary ratio of goods to agent

param.metric = "grid";
param.metric_size = [5,5];
param.dist = "unif";
param.val_dist = "unif";
param.max_v = 10;
param.max_d = 1.5;

exp.n_agent = [8];
exp.iters = 10;
exp.bias = zeros(length(exp.n_agent),1);
exp.max_d = 1.5*ones(length(exp.n_agent),1);

%%%%%%%%%%%%%%%%%
% undersupplied %
%%%%%%%%%%%%%%%%%
% disp("under")
% exp.n_good = exp.n_agent/2;
% res = experiment("carpool",exp,param);
% save('undersupplied_12_1.mat','res','exp','param');

%%%%%%%%%%%%%%%%%
% even %
%%%%%%%%%%%%%%%%%
% disp("even")
% exp.n_good = exp.n_agent;
% res = experiment("bike",exp,param);
% save('supplied_12_1.mat','res','exp','param');

%%%%%%%%%%%%%%%%%
% oversupplied %
%%%%%%%%%%%%%%%%%
disp("over")
exp.n_good = exp.n_agent * 2;
res = experiment("carpool",exp,param);
save('oversupplied_naan.mat','res','exp','param');