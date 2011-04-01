function Y = OPEN_CUT_DATA(file)
% function Y = openCutData(file)
%
% openCutData loads matrix Y from binary file containing separated QRS
% cycles of one signal.

fid = fopen(file, 'r');
Y_size = fread(fid, [1 2],'uint16');
Y = fread(fid, Y_size, 'uint16');
tmp = Y(1,:);
tmp(tmp==0) = NaN;
Y(1,:) = tmp;
tmp = Y(Y_size(1),:);
tmp(tmp==0) = NaN;
Y(Y_size(1),:) = tmp;
fclose(fid);
