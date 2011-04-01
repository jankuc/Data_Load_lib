ro = 0:0.1:10;
h =  exp(-ro.^2 ./2.*0.95.^2);
subplot(131);
plot (ro,h);
h=exp((ro.^2)./-0.95^2).*(1-(2./0.95.^2).*ro.^2);

subplot(132);
plot (ro,h);

a = 9;
for ro = 1:100
    if ro <= a
        h(ro) = 1;
    elseif ro > 3*a
        h(ro) = 0;
    else
        h(ro) = -1/3;
    end
end

subplot(133);
plot (0:100,h);