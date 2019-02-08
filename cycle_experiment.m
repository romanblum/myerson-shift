[d,b,c,pref,v] = cycle_instance();

n = 10;

v_prime = 1:10;

myerson_welf = zeros(n,4);
myerson_pay = zeros(n,4);
vcg_welf = zeros(n,4);
vcg_pay = zeros(n,4);

x = multiplicative_alloc(pref,d,3);

for i = 1:n
    v(4) = v_prime(i);
    myerson_alloc_fn = @(v) welfare_maximizer(x,v,b,c);
    [myerson_welf(i,:),myerson_pay(i,:),route] = myerson(myerson_alloc_fn,v,30,false);
    vcg_alloc_fn = @(x,v) welfare_maximizer(x,v,b,c);
    [vcg_welf(i,:),vcg_pay(i,:),~] = vcg(vcg_alloc_fn,x,v);
end
