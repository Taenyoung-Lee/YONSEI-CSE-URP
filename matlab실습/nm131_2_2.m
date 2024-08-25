%nm131_2_2: not nested structure
lam = 100; K = 155;
S = 0;
for k = 1:K
p = lam^k/factorial(k);
S = S + p;
end
S*exp(-lam)
