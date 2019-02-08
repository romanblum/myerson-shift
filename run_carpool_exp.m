function [res] = run_carpool_exp(d,param,n,g,max_d)
%RUN_CARPOOL_EXP - run instance of carpool problem for both myerson and vcg

switch param.val_dist
    case "unif"
        [v,~] = generate_unif_agents(param.max_v,size(d,1),n,"carpool");
        max_v_vec = param.max_v* ones(n,1);
    case "exp"
        v = exprnd(param.avg_val,[n,1]);
        max_v_vec = ones(n,1) * (max(v) + 1e-3);
    case "norm"
        v = normrnd(param.avg_val, param.avg_val/3,[n,1]);
        v(v<0) = 1e-3;
        max_v_vec = ones(n,1) * (max(v) + 1e-3);
    otherwise
        return
end
switch param.dist
    case "unif"
        [~,pref] = generate_unif_agents(param.max_v,size(d,1),n,"carpool");
        c = generate_unif_goods(g,size(d,1),"carpool");
    case "bias"
        [v,pref] = generate_bias_agents(param.good,param.bias,param.max_v,size(d,1),n,"carpool");
        c = generate_bias_goods(param.good,param.bias,g,size(d,1),"carpool");
        max_v_vec = param.max_v * ones(n,1);
    otherwise
        return
end    

cd ..

x = multiplicative_alloc(pref,d,max_d);

vcg_alloc_fn = @(x,v) carpool(x,v,c);
[welf,pay,~,shift] = vcg_shift(vcg_alloc_fn,x,v,max_v_vec);
    
res.v_pay = pay;
res.v_util = welf-pay;
res.v_shift = shift;
    
myerson_alloc_fn = @(v) carpool(x,v,c);

[welf,pay,~,shift] = myerson_shift(myerson_alloc_fn,v,max_v_vec);
    
res.m_pay = pay;
res.m_util = welf-pay;
res.m_shift = shift;
  
end

