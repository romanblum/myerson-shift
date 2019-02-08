figure;
% LOAD
load('vary_neg_12_4.mat');
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
errorbar(exp.max_d,y(1,:),err(1,:));
errorbar(exp.max_d,y(2,:),err(2,:));
title("Negativity of Valuations");
ylabel("Average Revenue");
xlabel("Max Distance (Very Negative to Strictly Positive)");
legend('VCG','Myerson Shift');
hold off

