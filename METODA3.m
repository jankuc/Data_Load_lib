function [y, susp, slope_treshold] =  METODA3(r,f)
%[y, susp, slope_treshold] =  METODA3(r,frekvence)
%r...funkcni hodnota signalu
%f...frequency
%
%y(k) = r(k+1) - r(k-1) ...differentiation of r
%susp...positions of R-peaks
%slope_treshold... 0.65*average_max_of_R-peaks

%% vypocet derivace -> y
siglen = length(r);
y = zeros(siglen,1);
for k=2:(siglen-1)
    y(k) = r(k+1) - r(k-1);
end
siglen = length(y);
%% TRESHOLD -> slope_treshold
n_max = siglen/f; %spocita se postupne n_max maxim a ty se pak zprumeruji
maxima = zeros(n_max,1);
for k = 1:n_max
    maxima(k) = max(y(floor((k-1)*siglen/n_max)+1:((k)*siglen/n_max)));
end
slope_treshold = 0.9*sum(maxima)/length(maxima);
%% SUSPICIOUS max -> susp
susp = zeros(siglen,1);
jumped = 50;
l = 2;
susp(l-1) = susp(l-1) - jumped;
k = 1;
while k <= siglen
    tmp = y(k:siglen,1);
    k = susp(l-1) + jumped + find(tmp>=slope_treshold,1,'first');
    if k > 1
    susp(l) = k;
    l = l+1;
    k = k+jumped;
    else    
        break
    end
end
susp(1) = 0;
susp = susp(susp~=0);
%% Redukce susp
% k = 1;
% while k <= length(susp)
%     l = 1;
%     while ((k+l<=length(susp)) && (l<10))
%         if (susp(k+l)-susp(k)<40)
%             susp(k+l) = 0;
%         else
%             break
%         end
%         l = l+1;
%     end
%     k = k+1;
% end
% k = 1;
% while (k <= length(susp))
%     susp(susp<susp(k)+40) = 0;
%     k = find(susp~=0,1)
% end
%susp = susp(susp~=0);
















