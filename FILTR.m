function r = FILTR(r,w)
siglen = length(r);
for k=2:siglen
    r(k) = r(k-1)*(1-w) + r(k)*w;
end