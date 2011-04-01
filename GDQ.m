function [p, q] = GDQ(n)
%[p, q] = GDQ(n)
%Greatest divisor and quocient
%pro n vrati k nejvetsi mozna cela p, q takova, ze p*q=n

b = ceil(sqrt(n));
if (b*(b-1) > n)
    p = b-1;
    q = b;
else
    p = b;
    q = b;
end