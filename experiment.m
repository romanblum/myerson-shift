function [res] = experiment(problem,exp,param)
%EXPERIMENT - runs a series of tests for the certain problem and the given
% parameters

switch problem
    case "carpool"
        fire = @(d,param,n,g,max_d)run_carpool_exp(d,param,n,g,max_d);
    case "bike"
        fire = @(d,n,g)run_bike_exp(d,param,n,g);
    otherwise
        return
end

res = struct('vcg_pay',{},'vcg_util',{},'shift_pay',{},'shift_util',{});
    
for i = 1:length(exp.n_good)
    d = build_metric(param.metric,param.metric_size);
    disp(exp.n_good(i));
    v_pay = zeros(exp.iters,exp.n_agent(i));
    v_util = zeros(exp.iters,exp.n_agent(i));
    v_shift = zeros(exp.iters,exp.n_agent(i));
    m_pay = zeros(exp.iters,exp.n_agent(i));
    m_util = zeros(exp.iters,exp.n_agent(i));
    m_shift = zeros(exp.iters,exp.n_agent(i));
    param.bias = exp.bias(i);
    
    parfor j = 1:exp.iters
        tmp_res = fire(d,param,exp.n_agent(i),exp.n_good(i),exp.max_d(i));
        v_pay(j,:) = tmp_res.v_pay;
        v_util(j,:) = tmp_res.v_util;
        v_shift(j,:) = tmp_res.v_shift;
        m_pay(j,:) = tmp_res.m_pay;
        m_util(j,:) = tmp_res.m_util;
        m_shift(j,:) = tmp_res.m_shift;
    end
    
    res(i).v_pay = v_pay;
    res(i).v_util = v_util;
    res(i).v_shift = v_shift;
    res(i).m_pay = m_pay;
    res(i).m_util = m_util;
    res(i).m_shift = m_shift;
    
end

