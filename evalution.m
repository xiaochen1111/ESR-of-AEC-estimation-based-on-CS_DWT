function D=evalution(x1,x2)
N=length(x1(:));
X=[x1;x2];
D = pdist(X,'euclidean');
D=squareform(D);
D=D(:,1);
% D=D./sqrt((mean(x1).^2+(mean(x2)).^2));
% D=sqrt(sum((x1-x2).^2)./N);