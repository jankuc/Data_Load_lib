
delka = 100;
N = 20;
p = zeros(delka,1);
p(1) = 1/N;
B = 0.0005;
C = 10;
y = 1;
for t=2:delka
    p(t) =  p(t-1)+B*(y-p(t-1));
end
plot(p)
hold on

b = C * (1/N - p);
plot(b,'k')
hold off