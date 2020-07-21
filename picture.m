%% 作图 figure1
x=0:1:499;
figure
plot(yw,'g','linewidth',1.8)
hold on
plot(yw1,'b','linewidth',0.5)
hold on
plot(yw2,'m','linewidth',0.5)
hold on
plot(yw3,'r','linewidth',0.5)
hold on
plot(yw4,'k','linewidth',1.5)
% axis([0 499 10.456 10.9])
legend('state 1','state 2','state 3');
ylabel('Ripple voltage(V)')
xlabel('Time(us)')
set(gca,'FontSize',12);
set(gca,'FontName','Helvetica');%%设置所有字体大小为18号，字体为Helverica
set(gca,'linewidth',1.5);%%设置图框的线宽
set(gcf,'position',[0 0 650 450]);%%设置画幅大小为横650*纵450
set(gca,'xtick',[0,50,50*2,50*3,50*4,50*5,50*6,50*7,50*8,50*9,50*10]);
set(gca,'xticklabel',{'0','25','50','75','100','125','150','175','200','225','250'});

%% figure2
plot(y,'b','linewidth',1.0)
hold on
plot(sig,'r','linewidth',0.5)
 axis([0 1024 9.37 9.44])
legend('original value of capacitor',' reconsitution value of capacitor')
ylabel('Ripple voltage(V)')
xlabel('Sample number')
%% figure3
plt1=plot(boost(1:512,1),boost(1:512,3));
plt1.Color=[0.6350 0.0780 0.1840];
plt1.LineWidth=1.5000;
% plt1.Marker='_';
plt1.MarkerSize=6;
% plt=bar(ERROR');
% plt2=plot(theta_V);
% plt2.Color=	[0 1 0];
% plt2.Marker='.';
% plt2.MarkerSize=9;
% plt2.LineWidth=1.0000;
legend('Current');
ylabel('Amplitude')%Ripple voltage(V)
xlabel('Time(s)','LineWidth',12)
set(gca,'FontSize',12);
set(gca,'FontName','Helvetica');%%设置所有字体大小为18号，字体为Helverica
set(gca,'linewidth',1.5);%%设置图框的线宽
set(gcf,'position',[0 0 650 450]);%%设置画幅大小为横650*纵450
% set(gca,'xticklabel',{'70','60','50','40'});
% set(gca,'yticklabel',{'-10%','0','10%','30%','50%','70%','90%','110%','130%','150%'});
% 
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
%% 
kw=y(1:92);
N=91;
yft=fftshift(fft(kw,N));
Fs=50;
w = linspace(0, Fs*2, N);%频率坐标，单位Hz
bar(w,abs(yft));
% title('信号的频谱');
xlabel('Frequency(KHz)');
ylabel('Amplitude')
% plot(yft,'b','linewidth',1.0);
% hold on
% plot(ywft,'k','linewidth',0.8);
% hold on
% plot(sft,'r','linewidth',0.5);
%% 稀疏度K值与欧氏距离
% K=[40:2:160];
stairs(pca,'g','linewidth',1.5);
hold on
stairs(pca1,'b','linewidth',1.5);
hold on
stairs(pca2,'m','linewidth',1.5);
hold on
stairs(pca3,'r','linewidth',1.5);
hold on
stairs(pca4,'k','linewidth',1.5);
xlabel('K')
ylabel('Dist')
legend('CS-PCA','PCA')
% title('稀疏度K值与欧氏距离')