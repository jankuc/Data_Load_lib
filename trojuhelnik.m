nA = 0;
for k = 1:1E6
   
    a = rand(1);
    b = rand(1);
    x = min(a,b);
    y = max(a,b);
    if y > 1-y && 1-x > x && x + 1 - y > y-x
        nA= nA + 1;
    end
end
P = nA/k