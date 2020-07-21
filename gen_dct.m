%% DCT 
function C = gen_dct(n)
alp = [sqrt(1/n) sqrt(2/n)*ones(1,n-1)];
ind = (1:2:(2*n-1))*pi/(2*n);
C = zeros(n,n);
for k = 1:n
C(k,:) = alp(k)*cos((k-1)*ind);
end
end
% %% DCT SCDN
% function C=gen_dct(n)
% [cc,rr]=meshgrid(0:n-1);
% C=sqrt(2/n)*cos(pi*(2*cc+1).*rr/(2*n));
% C(1,:)=C(1,:)./sqrt(2);
% end