figure;
% LOAD
load('biased_goods_12_6.mat');
vcg_rev = cell2mat(arrayfun(@(S) sum(S.vcg_pay,2), res, 'uniformoutput', false));
shift_rev = cell2mat(arrayfun(@(S) sum(S.shift_pay,2), res, 'uniformoutput',false));
mean_vcg_rev = mean(vcg_rev,1);
mean_shift_rev = mean(shift_rev,1);


y = zeros(2,length(exp.n_agent));
y(1,:) = mean_vcg_rev;
y(2,:) = mean_shift_rev;
err = zeros(2,length(exp.n_agent));
err(1,:) = std(vcg_rev,1);
err(2,:) = std(shift_rev,1);

hold on
errorbar(exp.bias,y(1,:),err(1,:));
errorbar(exp.bias,y(2,:),err(2,:));
title("Biased Goods and Preferences");
ylabel("Average Revenue");
xlabel("Bias towards center of star");
legend('VCG','Myerson Shift');
hold off

