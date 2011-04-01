function Y = NORM(R)
a = max(R,[],2);
b = min(R,[],2);
c = size(R, 2);
Y = zeros(size(R));
for k = 1:size(Y,1)
    Y(k,:) = (R(k,:) - b(k)*ones(1,c))/(a(k)-b(k));
end
