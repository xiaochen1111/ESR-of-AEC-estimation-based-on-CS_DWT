function E = wavelet_energy_spectrum( wpt,n )
%% ����ÿһ��ÿһ���ڵ������
%  wpt-wavelet packet tree
%  n-��n������
% 
% Author hubery_zhang
% Date  20170714

%%
% ���n���i���ڵ��ϵ��
E(1:2^n )=0;
for i=1:2^n 
E(i) = norm(wpcoef(wpt,[n,i-1]),2)^2; %20180604���� ԭ���룺E(i) = norm(wpcoef(wpt,[n,i-1]),2)
end
%��ÿ���ڵ�ĸ���
E_total=sum(E); 
for i=1:2^n
p_node(i)= 100*E(i)/E_total;
end
% E = wenergy(wpt); only get the last layer
figure;
x=1:2^n;
bar(x,p_node);
title(['��',num2str(n),'��']);
axis([0 2^n 0 100]);
xlabel('���');
ylabel('�����ٷֱ�/%');
for j=1:2^n
text(x(j),p_node(i),num2str(p_node(j),'%0.2f'),...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
end

end
