function [E]=wavelet_feaext(yin)

y=yin;
% y=abs(fft(yin,1024));
% PCA
N=3;
k=1:1:920;
pcain=y(k);
x=reshape(pcain,92,10);   % 将10组值写为矩阵，每一列代表一个周期
for ii=1:1:10
wpt=wpdec(x(:,ii),N,'db1'); %进行3层小波包分解
nodes=[7;8;9;10;11;12;13;14]; %第3层的节点号
ord=wpfrqord(nodes);  %小波包系数重排，ord是重排后小波包系数索引构成的矩阵　如3层分解的[1;2;4;3;7;8;6;5]
nodes_ord=nodes(ord); %重排后的小波系数 
cfs3_0=wpcoef(wpt,nodes_ord(1));
E(ii)=norm(cfs3_0,2)^2;
end
