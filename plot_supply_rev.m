figure;
% LOAD
load('undersupplied_12_1.mat');
%%%%%%%%%
vcg_rev = cell2mat(arrayfun(@(S) sum(S.v_pay,2), res, 'uniformoutput', false));
shift_rev = cell2mat(arrayfun(@(S) sum(S.m_pay,2), res, 'uniformoutput',false));
mean_vcg_rev = mean(vcg_rev,1);
mean_shift_rev = mean(shift_rev,1);

x = repmat(exp.n_agent,2,1);
y = zeros(2,length(exp.n_agent));
y(1,:) = mean_vcg_rev;
y(2,:) = mean_shift_rev;
err = zeros(2,length(exp.n_agent));
err(1,:) = std(vcg_rev,1);
err(2,:) = std(shift_rev,1);

subplot(1,3,1);
hold on
errorbar(exp.n_agent,y(1,:),err(1,:));
errorbar(exp.n_agent,y(2,:),err(2,:));
title("Undersupplied");
ylabel("Average Total Revenue");
xlabel("Number of Agents");
hold off

% LOAD
load('supplied_12_1.mat');
%%%%%%%%%
vcg_rev = cell2mat(arrayfun(@(S) sum(S.v_pay,2), res, 'uniformoutput', false));
shift_rev = cell2mat(arrayfun(@(S) sum(S.m_pay,2), res, 'uniformoutput',false));
mean_vcg_rev = mean(vcg_rev,1);
mean_shift_rev = mean(shift_rev,1);

x = repmat(exp.n_agent,2,1);
y = zeros(2,length(exp.n_agent));
y(1,:) = mean_vcg_rev;
y(2,:) = mean_shift_rev;
err = zeros(2,length(exp.n_agent));
err(1,:) = std(vcg_rev,1);
err(2,:) = std(shift_rev,1);

subplot(1,3,2);
hold on
errorbar(exp.n_agent,y(1,:),err(1,:));
errorbar(exp.n_agent,y(2,:),err(2,:));
title("Supplied");
ylabel("Average Total Revenue");
xlabel("Number of Agents");
hold off


% LOAD
load('oversupplied_naan.mat');
%%%%%%%%%
vcg_rev = cell2mat(arrayfun(@(S) sum(S.v_pay,2), res, 'uniformoutput', false));
shift_rev = cell2mat(arrayfun(@(S) sum(S.m_pay,2), res, 'uniformoutput',false));
mean_vcg_rev = mean(vcg_rev,1);
mean_shift_rev = mean(shift_rev,1);

x = repmat(exp.n_agent,2,1);
y = zeros(2,length(exp.n_agent));
y(1,:) = mean_vcg_rev;
y(2,:) = mean_shift_rev;
err = zeros(2,length(exp.n_agent));
err(1,:) = std(vcg_rev,1);
err(2,:) = std(shift_rev,1);

subplot(1,3,3);
hold on
errorbar(exp.n_agent,y(1,:),err(1,:));
errorbar(exp.n_agent,y(2,:),err(2,:));
title("Oversupplied");
ylabel("Average Total Revenue");
xlabel("Number of Agents");
legend('VCG','Myerson Shift');
hold off

saveas(gcf,'supply_rev.fig');


