function y = RESAMPLE(x) %x-
x = x'; %x|
xlength = size(x,1);
nparts = 3;
xpart = ceil(xlength/nparts);
X = ones(xpart, nparts);
for k = 1:nparts
    if k < nparts
        X(:,k) = x((k-1)*xpart + 1:k*xpart,1);
    else
       X(1:size(x,1)-(nparts-1)*xpart,k) = x((k-1)*xpart + 1:size(x,1),1); 
    end
end
y = [downsample(X(:,1),5); downsample(X(:,2),2); downsample(X(:,3),5) ];
