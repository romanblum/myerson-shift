figure;
% LOAD
load('biased_val_12_9.mat');
exp_vcg_rev = sum(exp_val.vcg_pay,2);
exp_shift_rev = sum(exp_val.shift_pay,2);

load('norm_val_12_9.mat');
norm_vcg_rev = sum(norm_val.vcg_pay,2);
norm_shift_rev = sum(norm_val.shift_pay,2);

load('uniform_val_12_9.mat');
unif_vcg_rev = sum(unif_val.vcg_pay,2);
unif_shift_rev = sum(unif_val.shift_pay,2);
%%%%%%%%%

subplot(3,1,1);
boxplot([unif_vcg_rev,unif_shift_rev]);

subplot(3,1,2);
boxplot([exp_vcg_rev,exp_shift_rev]);

subplot(3,1,3);
boxplot([norm_vcg_rev,norm_shift_rev]);


