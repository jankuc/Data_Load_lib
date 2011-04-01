function VYKRESLENI_SIGNALU(y,name,susp,treshold,n_sig,p,q,r)
%VYKRESLENI_SIGNALU(y,name,susp,treshold,n_sig,p,q,r)
%plot(x,y)  x=1:length(y), suspicious, treshold
%name - nadpis obrazku
%n_sig je jen cislo (nacita se z toho pak i prislusny soubor)
%(p,q,r) -> subplot (p,q,r)
%% vytvoreni jmena -> mitdb/###
figure(n_sig);
sig= num2str(n_sig);
sig = ['mitdb/' sig];
%% graf signalu
h = subplot(p,q,r);
siglen = length(y);
x = 1:siglen;
plot(x,y);
hold on
%% body podezrele z R-peaku
plot(susp,max(y),'r+')
%% prah
plot(1:siglen,treshold); 
%% popis
axis(h, [min(x) max(x) min(y) 1.2*max(y)])
xlabel('x')
ylabel(sig)
title(name)
hold off