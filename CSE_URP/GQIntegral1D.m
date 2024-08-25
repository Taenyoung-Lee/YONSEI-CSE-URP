function approximate = GQIntegral1D(f,a,b,nGQ,n) % f is function; a,b is bound; n is mesh number

%GQ를 계산하는 부분
[points, weights] = GQref1D(nGQ);

%mesh number를 결정하는 부분
interval = linspace(a,b,n+2);

%for문을 활용하여 적분범위 앞에서 부터 순차계산

approximate = 0;
for i = 1:length(interval)-1

    approx_values = ( (interval(i+1)-interval(i))/2 ) * sum(weights .* f( ( (interval(i+1) - interval(i)) / 2 * points ) + ( (interval(i) + interval(i+1)) / 2) ) );
    approximate = approximate + approx_values;

end

end