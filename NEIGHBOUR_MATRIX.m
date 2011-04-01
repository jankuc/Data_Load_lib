function H = NEIGHBOUR_MATRIX(a,b,tvar)
%H = je 
%H je cell ktery  ma  
%a,b... rozmery site
%n.. pocet vektoru v siti
%tvar.. pocet sousedu kazdeho neuronu (ctvecova sit/ hexova sit)
tvar = 4;
%% Pro site se ctyrmi sousedy
n = a*b; 
N = reshape(1:n,[a,b]);
enda = 2*a-1;
endb = 2*b-1;
%% EYE -> EYE(enda,endb)
EYE = zeros(enda,endb);
for k=1:a
    EYE(k+a-1,(b:endb)) = (k-1):(k+b-2);
end
PART = EYE(a:end,b:end);
EYE(1:a,b:end) = PART(end:-1:1,:);
EYE(a:end,1:b) = PART(:,end:-1:1);
EYE(1:a,1:b) = PART(end:-1:1,end:-1:1);
%% H -> H{a,b} = H{n} 
% je mnozina indexu pricemz kazdy prvek H{i} je matice indexu 
% sousedu x-teho radu pro neuron i 
H = cell(a,b);
for k = 1:a
    for l=1:b
        TMP = -ones(a,b);
        TMP = EYE(a-(k-1):enda-(k-1),b-(l-1):endb-(l-1));
        H{k,l} = EYE(a-(k-1):enda-(k-1),b-(l-1):endb-(l-1));
    end
end

%       EXAMPLE
%
%       1   2   3
%       4   5   6
%       7   8   9
% 
% 
% H{1} :  0 1 2
%         1 2 3
%         2 3 4
%         
% H{6} :  3 2 1
%         2 1 0
%         3 2 1
