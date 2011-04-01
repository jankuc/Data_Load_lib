frekvence = 360;
signals = 100:1:100; %vektor cisel krivek, ktere chci vykreslit
signals = signals(signals ~=110);
%%%% cyklus vykreslujici ruzne krivky
sig_name = ('mitdb/###');
for n_sig = signals 
    
    %% tvorba jmena 'mitdb/n_sig' a jeji nacteni -> r(1,2,3)
    sig_num= num2str(n_sig);
    sig_name = ['mitdb/' sig_num];%sig_name je string obsahujici jmeno souboru signalu
    time = '00:30:00';
    if 1
        r = rdsamp(sig_name,'maxt',time);
        
        %% vektor pro vykreslovani -> r,siglen
        
        r = r(:,2);
        siglen = length(r); % signal_length
    end
    %% filtrace -> z
    if 0
        z = FILTR(r,0.05);
        z = r-z;
    end
    
    %% Vykreslovani signalu
    [y,susp,treshold] = METODA3(r,frekvence);
    
    if 0
        n = 2;
        VYKRESLENI_SIGNALU(r,'puvodni signal',NaN,NaN,n_sig,n,1,1);
        n_QRS = length(susp);
        VYKRESLENI_SIGNALU(z,'derivace filtrovaneho',susp,treshold,n_sig,n,1,2);
    end
    
    %% Obtaining single cycles -> Y
    Y = CUTTER(r,susp);
    SAVE_CUT_DATA(Y,['cutData/' sig_num '_' time]);
    continue
    Y = OPEN_CUT_DATA(['cutData/' sig_num '_' time]);
    
    %% kouskovani a vykres jednotlivych period
    n_QRS = size(Y,1);
    [p, q] = GDQ(n_QRS);
    figure(n_sig-99)
    hold on
    for k=1:n_QRS
        h = subplot(p,q,k);
        plot(1:size(Y,2),Y(k,:));
        axis([1 size(Y,2) min(min(Y)) max(max(Y))])
    end
    hold off
end
