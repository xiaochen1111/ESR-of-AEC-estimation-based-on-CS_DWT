%% figure1
% axis([0 499 10.456 10.9])
% legend('state 1','state 2','state 3');
% ylabel('Ripple voltage(V)')
% xlabel('Time(s)')
% set(gca,'FontSize',12);
% set(gca,'FontName','Helvetica');%%设置所有字体大小为18号，字体为Helverica
% set(gca,'linewidth',1.5);%%设置图框的线宽
% set(gcf,'position',[0 0 650 450]);%%设置画幅大小为横650*纵450
% set(gca,'xtick',[0,50,50*2,50*3,50*4,50*5,50*6,50*7,50*8,50*9,50*10]);
% set(gca,'xticklabel',{'0','25','50','75','100','125','150','175','200','225','250'});

%% figure3
% t=buck100k(:,1);
% V=buck100k(:,2);
% I=buck100k(:,3);
% t=t(1:120);
% V=V(1:120);
% measurement=eye(5,40)*V;
% t=linspace(0.05,0.08,24)';
plt1=plot(x,y);
% plt1(1,1).FaceColor = [0.8500 0.3250 0.0980];
% plt1(1,2).FaceColor = [0.9290 0.6940 0.1250];% [0.4660 0.6740 0.1880] 0.6350 0.0780 0.1840[0 0.4470 0.7410]
% plt1.FaceColor = 'flat';
% plt1.CData(2,:) = [.5 0 .5];
plt1.Color=[0.6350 0.0780 0.1840];
% plt1.Color=[0 0 0];
plt1.LineWidth=1.5000;
plt1.MarkerSize=12;
grid on
% xlim=get(gca,'xlim'); % 获取当前图形的纵轴的范围
% hold on
% plt2=plot(xlim,[0.784,0.784],'--'); % 绘制x=1的直线
% plt2.Color=[0.4940 0.1840 0.5560];
% plt2.LineWidth=1.5000;
% hold on
% plt3=plot(xlim,[1.978,1.978],'--'); % 绘制x=1的直线
% plt3.Color=[0.4940 0.1840 0.5560];
% plt3.LineWidth=1.5000;
% plt1.MarkerEdgeColor=[0.6350 0.0780 0.1840];
% plt=bar(ERROR');
% plt2=plot(theta_V);
% plt2.Color=	[0 1 0];
% plt2.Marker='*';
% plt2.MarkerSize=6;
% plt2.LineWidth=1.0000;
legend('ESR');%,'Ic'
ylabel('Estimation(\Omega)')%Ripple voltage(V)Amplitude
xlabel('Time(s)','LineWidth',12)
set(gca,'FontSize',12);
set(gca,'FontName','Helvetica');%%设置所有字体大小为18号，字体为Helverica
set(gca,'linewidth',1.5);%%设置图框的线宽
set(gcf,'position',[0 0 650 450]);%%设置画幅大小为横650*纵450
% set(gca,'YLim',[-6,13])
% set(gca,'xticklabel',{'0.049','25','35','45','55','65','75','85'});
% set(gca,'yticklabel',{'1.0','1.5','2.0','2.5','3.0','3.5'});
% x=1:0.01:9.99;
% yy=pcaout(1)*(x>=1&x<2)+pcaout(2)*(x>=2&x<3)+pcaout(3)*(x>=3&x<4)+pcaout(4)*(x>=4&x<5)+pcaout(5)*(x>=5&x<6)+pcaout(6)*(x>=6&x<7)+pcaout(7)*(x>=7&x<8)+pcaout(8)*(x>=8&x<9)+pcaout(9)*(x>=9&x<10);
% yy3=pcaout1(1)*(x>=1&x<2)+pcaout1(2)*(x>=2&x<3)+pcaout1(3)*(x>=3&x<4)+pcaout1(4)*(x>=4&x<5)+pcaout1(5)*(x>=5&x<6)+pcaout1(6)*(x>=6&x<7)+pcaout1(7)*(x>=7&x<8)+pcaout1(8)*(x>=8&x<9)+pcaout1(9)*(x>=9&x<10);
% axes('position', [0.18 0.18, 0.4, 0.26])
% plot(x,yy,'-g','linewidth',1.2)
% hold on
% plot(x,yy3,'-b','linewidth',1.0)
% axis([6 9 9.370 9.415])
% hold on
% staris(x,pcaout2,'-m','linewidth',1.2)
% hold on
% staris(x,pcaout3,'-r','linewidth',0.8)
% hold on
% staris(x,pcaout4,'-k','linewidth',0.8)
% xlim([1 10 8.063 8.077])

% title('一个半周期')
%% 频谱图绘制
kw=y(1:92);
N=91;
yft=fftshift(fft(kw,N));
Fs=50;
w = linspace(0, Fs*2, N);%频率坐标，单位Hz
bar(w,abs(yft));
% title('信号的频谱');
xlabel('Frequency(KHz)');
ylabel('Amplitude')

%% 绘制Haar小波基的小波函数
% clc,close all,clear all;
% 第一种:haar小波函数
% 返回2^ITFR点上的尺度变换函数（phi）和小波函数（psi）.其中ITFR是指迭代次数
[phi_haar,gll_haar,xval_haar]=wavefun('haar',8);
figure(2)
subplot(211)
plot(xval_haar,gll_haar,'r');

[g41,xval]=morlet(d,h,n);
% title('haar小波函数时域波形')
% xlabel('时间t')

