function [E]=wavelet_feaext(yin)

y=yin;
% y=abs(fft(yin,1024));
% PCA
N=3;
k=1:1:920;
pcain=y(k);
x=reshape(pcain,92,10);   % ��10��ֵдΪ����ÿһ�д���һ������
for ii=1:1:10
wpt=wpdec(x(:,ii),N,'db1'); %����3��С�����ֽ�
nodes=[7;8;9;10;11;12;13;14]; %��3��Ľڵ��
ord=wpfrqord(nodes);  %С����ϵ�����ţ�ord�����ź�С����ϵ���������ɵľ�����3��ֽ��[1;2;4;3;7;8;6;5]
nodes_ord=nodes(ord); %���ź��С��ϵ�� 
cfs3_0=wpcoef(wpt,nodes_ord(1));
E(ii)=norm(cfs3_0,2)^2;
end
