%% DST SCDN
function C=gen_dst(n)
[cc,rr]=meshgrid(0:n-1);
C=sqrt(2/n+1)*sin(pi*(cc+1).*(rr+1)/(n+1));
end