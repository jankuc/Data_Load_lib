cele = [111:119, 121:124, 200:203, 207:210, 212:215, 221:223, 230:234];
for k = [232:234]
    num = num2str(k);
    RECORD = ['mitdb/' num];
    ANNOTATOR = 'atr';
    time1 = '00:00:00'; 
    time2 = '00:30:00';   
    data = rdsamp(RECORD, 'begin', time1, 'stop', time2);
    r = data(:,2);
    anns10 = rdann(RECORD, ANNOTATOR, 'start', time1,'stop',time2, 'concise');
    %pro dalsi krok se musi zacinat s nacitanim v case 0, jinak by se to
    %muselo nejak posunout
    susp = data(anns10(:,2));
    susp = susp(3:size(susp));
    
    if 0
        desc = wfdbdesc(RECORD, false);% Finding the frequency
        freq = desc.samplingFrequency;
        plot(data(:,1)/freq, data(:,2));
        hold on
        plot(anns10(:,2)/freq, data(anns10(:,2)+1, 2), 'r+');
        hold off
    end
    if 0
        average = zeros(size(anns10,1),1);
        for k = 2:size(anns10)
            average(k,1) = anns10(k,1) - anns10(k-1,1);
        end
        a = sum(average);
        b = size(average,1);
        avg = a/b
        odchylka = abs(average-avg);
        c = sum(odchylka)/size(odchylka,1)
        odchylka = odchylka(odchylka>c)
    end
    Y = CUTTER(r, susp);
    %figure (str2num(num)-99)
    %plot(1:size(Y,2),Y(1:size(Y,1),:))
    %% save file
       if 1
           fid = fopen(['MITann_data/' num '_' time2], 'w');
           fwrite(fid, [size(Y,1) size(Y,2)],'uint16');
           
           fwrite(fid, Y,'uint16');
           fclose(fid);
       end
       disp([num 'dodelano'])
end






















