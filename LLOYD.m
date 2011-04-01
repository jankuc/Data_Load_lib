function [W E] = LLOYD(X,m,e)
[r, n] = size(X);
if 0
    tmp = median(X);
    TMP = zeros(m,n);
    for k = 1:m
        TMP(k,:) = tmp;
    end
    W = TMP - 0.05*ones(m,n) + 0.1*rand(m,n);
    clear tmp TMP
end
W = rand(m,n);
W = [W zeros(m,2)];
%% Algoritmus
t = 1;
E = inf;
while t<20
    W_new = zeros(size(W));
    for k=1:r
        x = X(k,:);
        %% s = VITEZ(x,W,zeros(m,1))
        d = zeros(1,m);
        for l=1:m
            d(l) = norm(x-W(l,1:n));
        end
        [~, s] = min(d);
        W_new(s,n+2) = W_new(s,n+2) + (d(s))^2;
        W_new(s,1:n) = W_new(s,1:n) + x;
        W_new(s,n+1) = W_new(s,n+1) + 1;
    end
    E = sum(W_new(:,n+2))/r;
    if E < e
        W = W(:,1:n);
        break
    end
    %% ZMENA
    for k = 1:m
        W_new(k,1:n) = W_new(k,1:n) / W_new(k,n+1);
    end
    W = W_new;
%     plot((W(:,1:n))')
%     title (['t = ' num2str(t)])
%     drawnow
    t = t+1;
end
t
    
    

