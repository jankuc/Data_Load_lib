function Y = CUTTER(r,susp)
% Y = CUTTER(r,susp)
n_QRS = length(susp); % number of QRS
siglen = length(r);
%% vypocitani periody -> cycle, hcycle
RR = zeros(n_QRS,1); %vektor vzdalenosti R-peaku
for k =1:n_QRS-1
    RR(k) = susp(k+1)-susp(k);
end
cycle = ceil(sum(RR)/length(RR));
if (mod(cycle,2)==1)
    cycle = cycle-1;
end
clear RR
hcycle = cycle/2; 
%% vytvoreni matice jejiz radky jsou samostatne periody -> Y
Y = NaN(n_QRS,cycle);
b_first = susp(1)+ hcycle;
a_first = b_first - cycle + 1;
a_first = max(a_first,1);
Y(1,cycle-length(r(a_first:b_first))+1:cycle) = r(a_first:b_first);
a_last = susp(n_QRS) - hcycle + 1;
b_last = min(siglen,susp(n_QRS)+hcycle);
Y(n_QRS,1:b_last-susp(n_QRS)+hcycle) = r(a_last:b_last);
for k = 2:n_QRS-1
    a = susp(k)-hcycle+1;
    b = susp(k)+hcycle;
    Y(k,:) = r(a:b);
end