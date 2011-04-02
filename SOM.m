function [W H] = SOM(X,a,b,T,eta0,tau1,tau2,B,C)
%X....matice radkovych vektoru (vstup site)
%a,b..rozmery neuronove site a x b.
%T....pocet iteraci
%h....neighborhood function zavisla na t
%n....je dimenze problemu
%r....je pocet vstupnich vektoru x (tedy vstupů)
[r, n] = size(X);
m = a*b;
tmp = median(X);
TMP = zeros(m,n);
for k = 1:m
    TMP(k,:) = tmp;
end
W = TMP - 0.05*ones(m,n) + 0.1*rand(m,n);
%W = rand(m,n);
clear tmp TMP
W = [W (1/m).*ones(m,1)];
H = NEIGHBOUR_MATRIX(a,b,4);
% VYKRESLENI_2D(X,W,H);
% drawnow
%% Inicializace matice funkce h
net_size = max(max(H{1}));
sigma0 = ceil(net_size/2);
%eta0 = 0.1;
%tau2 = 1000;
tau1 = tau1/log(sigma0);
eta = eta0 * exp(-(1:T)/tau2);
sigma = sigma0 * exp(-(1:T)/tau1);
% GAUSS
h = inline('eta*exp(-k^2/(2*sigma^2))','k','eta','sigma'); 
% lateralni inhibice
%h = inline('eta*exp(-k^2/(2*sigma^2))*(1-2*k^2/(sigma^2))','k','eta','sigma'); 

h_mat = zeros(net_size+1,T);
for k = 1:net_size+1 % i-ty radek oznacuje vzdalenost od viteze kompetice
    for l = 1:T % s rostoucim indexem sloupce roste pocet iteraci
        if k-1 == 0 % 1.radek neni zatizen vzdalenosti od vyherce
            h_mat(k,l) = eta(l);
        elseif k-1 <= sigma(l) % radky, ktere jsou stale jeste v okoli viteze, takze se posunuji
            h_mat(k,l) = h(k-1,eta(l),sigma(l));
        else
            h_mat(k,l) = 0; %ty ktere se uz neposovaji
        end
    end
end
clear eta h net_size
plot (W')
%% Algoritmus
zmena = 1;
t = 1;
%% vitez
d = zeros(1,m);
for l=1:m
    d(l) = norm(X(1,:)-W(l,1:n));
end
[~, s] = min(d);
%%
while zmena > 0
    for k=1:r
        W_new = W(:,1:n);
        x = X(k,:);
        %% s = VITEZ(x,W,zeros(m,1));
        if 1
        d = zeros(1,m);
        for l=1:m
            d(l) = norm(x-W(l,1:n));
        end
        [~, s] = min(d);
        end
        %% Conscience
        for asdf=0
            % pokud se povoli Conscience tak se musi odkomentovat radek za
            % zmenou vah pro pridani p_old do W
            if 1
                y = zeros(m,1);
                y(s) = 1;
                p_old = W(:,n+1);
                p_new =  p_old+B*(y-p_old);
                b = C*(1/m - p_new);
                %% s = VITEZ(x,W,b);
                d = zeros(1,m);
                for l=1:m
                    d(l) = sum((x-W(l,1:length(x)).^2) - b(l));
                end
                [~, s] = min(d);
            end
        end
        
        %% WEIGHTS
        tmp = H{s}(:); % tmp je ted vektor vzdaenosti od viteze
        for q = 1:m
            if tmp(q)<=sigma(t) % weights change only if the neuron is in the neighbourhood. ta podminka by tam nemusela byt, ale je to tak rychlesji
                W_new(q,:) = W_new(q,:) + h_mat(tmp(q)+1,t)*(x - W_new(q,:));
            end
        end       
        W(:,n+1) = p_new;
        
    end
    %% testovani zmeny matice W (po sloupcich)
    
    tp = W(:,1:n);
    if 1
        for l = 1:n
            if sum(~isnan(W_new(:,l))) && sum(~isnan(tp(:,l)))
                if W_new(:,l) == tp(:,l)
                    zmena = 0;
                end
            end
        end
    end
    %% testovani, doby behu algoritmu
    if t == T
        disp(['t > T = ' num2str(T)])
        return
    end
    W(:,1:n) = W_new;
    
    plot((W(:,1:n))')
    title (['t = ' num2str(t)])
    drawnow
    t= t+1;
    
end
t

