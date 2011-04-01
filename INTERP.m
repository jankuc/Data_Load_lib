function Y = INTERP(X,n)
%Y = INTER(X,n)
%
% Takes matrix X as a matrix which has y-coordinates of signal in it's rows
% and downsamples it so it has only n.
% If n = 0, then signal is not downsampled

if n==0
    Y = X;
else
    nos = size(X,1);    %Number Of Signals
    Y = zeros(nos,n);
    
    zlomek = length(X(1,:))/n;
    [q p] = rat(zlomek);
    for k = 1:nos
        x = X(k,:);     
        y = resample(x',p,q);
        y_extension = NaN(1,n);
        y_extension(1:length(y)) = y;     
        Y(k,:) = y_extension;
    end
end