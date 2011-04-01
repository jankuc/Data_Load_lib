function SAVE_CUT_DATA(Y,file)
% function SAVE_CUT_DATA(Y,file)
%
% Saves matrix Y containing separated QRS cycles into binary file 

fid = fopen(file, 'w');
fwrite(fid, [size(Y,1) size(Y,2)],'uint16');
fwrite(fid, Y,'uint16');
fclose(fid);